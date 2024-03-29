
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pwdflutter/helper/image.helper.dart';
import 'package:pwdflutter/router/gallery.routes.dart';

import 'package:extended_image/extended_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

import './image.model.dart';

class GalleryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GalleryPage();
  }
}

class _GalleryPage extends State<GalleryPage>
    with AutomaticKeepAliveClientMixin {
  // List<File> pics = [];
  List<String> pics = [];
  ScrollController _scrollController = new ScrollController();
  bool showTitle = false;
  Icon _icon = Icon(Icons.access_alarm);
  double _expandedHeight = 250;

  @override
  bool get wantKeepAlive => false;

  getBattery() async {
    try {
      const platform = MethodChannel('cy.samples.flutter/battery');
      int res = await platform.invokeMethod('getBatteryLevel');
    } catch (e) {}
  }

  getPick() async {
    // pics = await GalleryService().getPictrues();
    pics = picImages;
    setState(() {});
  }

  @override
  void initState() {
    checkPermission().then((res) {
      if (res) {
        getPick();
      }
    });
    _scrollController.addListener(() {
      bool hasClients = _scrollController.hasClients;
      if (hasClients &&
          _scrollController.offset >= _expandedHeight - kToolbarHeight) {
        if (!showTitle) {
          showTitle = true;
          if (mounted) {
            setState(() {});
          }
        }
      } else {
        if (showTitle) {
          showTitle = false;
          setState(() {});
        }
      }
    });

    super.initState();
  }

  checkPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    // bool isOpened = await PermissionHandler().openAppSettings();
    if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
              //  float：向下滑动时，即使当前CustomScrollView不在顶部，SliverAppBar也会跟着一起向下出现；
              // snap：当手指放开时，SliverAppBar会根据当前的位置进行调整，始终保持展开或收起的状态；
              // pinned：不同于float效果，当SliverAppBar内容滑出屏幕时，将始终渲染一个固定在顶部的收起状态组件。
              pinned: true,
              title: showTitle ? Text('游廊') : SizedBox(),
              centerTitle: true,
              expandedHeight: _expandedHeight,
              flexibleSpace: FlexibleSpaceBar(
                background: pics.isNotEmpty ?
                //  Image.file(pics[0]) 
                 Image.network(pics[0]) 
                 : Container(),
              )),
          SliverGrid.count(
            crossAxisCount: 3,
            children: List.generate(pics.length, (i) {
              return Container(
                decoration: BoxDecoration(
                    border: (i + 2) % 3 == 0
                        ? Border.all(width: 1, color: Colors.white)
                        : Border(
                            top: BorderSide(width: 1, color: Colors.white),
                            bottom: BorderSide(width: 1, color: Colors.white))),
                child: Hero(
                  // tag: pics[i].path,
                  tag: pics[i],
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(GalleryRoutes.previewImage,
                          arguments: {'initialIndex': i, 'images': pics});
                    },
                    child: ExtendedImage.network(
                       pics[i], 
                      cache: true,
                      loadStateChanged: (ExtendedImageState state) {
                        switch (state.extendedImageLoadState) {
                          case LoadState.loading:
                            return ImageHeler.placeHoder();
                            break;
                          case LoadState.failed:
                            return ImageHeler.error();
                            break;
                          case LoadState.completed:
                            return ExtendedRawImage(image: state.extendedImageInfo?.image,);
                          default: 
                            return ImageHeler.error();
                        }
                      }
                    ),
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}

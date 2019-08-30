import 'package:flutter/material.dart';

class CySearch extends StatefulWidget {
  Function submit = () {};
  CySearch({this.submit});
  @override
  State<StatefulWidget> createState() {
    return _CySearch();
  }
}

class _CySearch extends State<CySearch> {
  TextEditingController _controller = new TextEditingController();
  bool showSuffix = false;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        showSuffix = false;
        setState(() {});
      } else {
        if (!showSuffix) {
          showSuffix = true;
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            constraints: BoxConstraints(maxHeight: 40),
            child: TextFormField(
              controller: _controller,
              style: TextStyle(),
              // autofocus: true,
              onFieldSubmitted: (val) {
                widget.submit(val);
              },
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: showSuffix
                        ? Icon(Icons.highlight_off)
                        : SizedBox(),
                  ),
                  onTap: () {
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) => _controller.clear());
                  },
                ),
                filled: true,
                fillColor: Color(0xfff6f6f6),
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 4.0, top: 4.0),
                hintText: '网站名或账号',
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            widget.submit(_controller.text);
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

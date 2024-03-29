import 'package:dio/dio.dart';
  BaseOptions baseOptions = BaseOptions(
    baseUrl: '', connectTimeout: 10000);


class Http {


  Dio _dio = Dio(baseOptions);


  factory Http() {
    return _getInstence();
  }

  static Http _instence;
  static _getInstence() {
    if (_instence != null) {
      return _instence;
    }
    _instence = Http._internal();
    return _instence;
  }

    Http._internal() {
    print('Http实例化');
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      // 在请求被发送之前做一些事情
      return options; //continue
      // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
      //
      // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onResponse: (Response response) {
      // 在返回响应数据之前做一些预处理
      return response; 
    }, onError: (DioError e) {
      // 当请求失败时做一些预处理
      return e; //continue
    }));
  }

  get(String url, { queryParameters}) async {
    Response response = await _dio.get(url, queryParameters: queryParameters);
     return response.data;
  }

  post(String url, Map<String, dynamic> data) async {
    Response response = await _dio.post(url, data: data);
    return response.data;
  }

  put() {

  }
}
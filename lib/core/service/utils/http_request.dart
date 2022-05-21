import 'package:dio/dio.dart';
import 'config.dart';

class HttpRequest {
  static final BaseOptions baseOption = BaseOptions(
      baseUrl: HttpConfig.baseURL, connectTimeout: HttpConfig.timeout);
  static final Dio dio = Dio(baseOption);

  static Future<T> request<T>(String url, {method, params, inter}) async {
    //创建单独配置
    final options = Options(method: method);

    //全局拦截器
    //创建默认的拦截器
    Interceptor dInter = InterceptorsWrapper(onRequest: (options, handler) {
      print("请求拦截");
      return handler.next(options);
    }, onError: (error, handle) {
      print("错误拦截");
      return handle.next(error);
    }, onResponse: (response, handler) {
      print("响应拦截");
      handler.next(response);
    });
    List<Interceptor> inters = [dInter];

    //请求单独拦截器
    if(inter != null){
      inters.add(inter);
    }

    //统一添加
    dio.interceptors.addAll(inters);

    //发送网络请求
    try {
      Response response =
      await dio.request(url, queryParameters: params, options: options);
      //返回数据
      return response.data;
    } on DioError catch (e) {
      //返回错误
      return Future.error(e);
    }
  }
}

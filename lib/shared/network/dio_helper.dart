import 'package:dio/dio.dart';

class DioHelper {

  static Dio dio;

  DioHelper()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://2code.info/',
      ),
    );
  }

  static Future<Response> getData({String path, Map<String, dynamic> query}) async
  {
    return await dio.get(path, queryParameters: query);
  }
}

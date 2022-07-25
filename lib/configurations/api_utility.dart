import 'package:dio/dio.dart';
import 'package:my_projects/configurations/config_file.dart';

class APIProvider {
  static Dio? dio = Dio(options);

  static BaseOptions? options = BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
      baseUrl: ApiConfig.baseURL,
      // ignore: missing_return
      validateStatus: (code) {
        if (code! >= 200) {
          return true;
        }
        return false;
      });

  static Dio getDio() {
    // DISABLE_PROXY_START true
    // if (kDebugMode) {
    //   (dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //       (HttpClient client) {
    //     client.findProxy = (uri) {
    //       return ApiConfig.IP_ADDRESS;
    //     };
    //     client.badCertificateCallback =
    //         (X509Certificate cert, String host, int port) => true;
    //   };
    // }
// DISABLE_PROXY_END true
    return dio!;
  }
}

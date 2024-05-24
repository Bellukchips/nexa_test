import 'package:dio/dio.dart';
import 'package:nexa_test/shared/config.dart';
import 'package:nexa_test/shared/preference_manager.dart';

class DioClient {
  static final Dio _dio = Dio(BaseOptions(baseUrl: Config.server));

  DioClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? token = await PreferenceManager.getToken();
        if (token != null) {
          options.headers['token'] = token; // Set token in the header
        }
        return handler.next(options); // Continue
      },
    ));
  }

  Dio get dio => _dio;
}

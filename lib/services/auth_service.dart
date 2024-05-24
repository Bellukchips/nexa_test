import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nexa_test/models/meta_data/response_data.dart';
import 'package:nexa_test/services/dio_client.dart';
import 'package:nexa_test/shared/config.dart';
import 'package:nexa_test/shared/preference_manager.dart';

class AuthService {
  static Future<bool> authenticate(String username, String password) async {
    final DioClient _dioClient = DioClient();

    try {
      Response response = await _dioClient.dio.post(
        Config.login,
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.data);

        if (apiResponse.metadata.status == 200) {
          String token = apiResponse.response['token'];
          await PreferenceManager.saveToken(token);
          debugPrint('Token: $token');
          return true;
        } else if (apiResponse.metadata.status == 401) {
          debugPrint('Login failed: ${apiResponse.metadata.message}');
          return false;
        }
      } else {
        debugPrint('Failed to authenticate: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      // Handle Dio errors
      if (e.response != null) {
        debugPrint('Dio error: ${e.response?.data}');
      } else {
        debugPrint('Dio error: ${e.message}');
      }
    } catch (e) {
      // Handle any other errors
      debugPrint('Error: $e');
    }
    return false;
  }
}

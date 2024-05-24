import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nexa_test/models/doctor/doctor_model.dart';
import 'package:nexa_test/models/meta_data/response_data.dart';
import 'package:nexa_test/services/dio_client.dart';
import 'package:nexa_test/shared/config.dart';

class DoctorService {
  static Future<List<DoctorModel>> getNearbyDoctor() async {
    final DioClient _dioClient = DioClient();

    try {
      Response response = await _dioClient.dio
          .post(Config.doctorNearby, data: {'lat': "", 'long': ""});
      if (response.statusCode == 200) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.data);
        if (apiResponse.metadata.status == 200) {
          dynamic responseData = apiResponse.response['dataResponse'];
          if (responseData is List) {
            // If responseData is a list, map each item to DoctorModel
            List<DoctorModel> doctors =
                responseData.map((json) => DoctorModel.fromJson(json)).toList();
            return doctors;
          } else if (responseData is Map<String, dynamic>) {
            // If responseData is a single object, convert it to a list containing a single DoctorModel
            DoctorModel doctor = DoctorModel.fromJson(responseData);
            return [doctor];
          } else {
            throw Exception("Invalid response data");
          }
        } else if (apiResponse.metadata.status == 401) {
          throw Exception("Unauthorized"); // Handle unauthorized error
        } else {
          throw Exception(apiResponse.metadata.message); // Handle other errors
        }
      } else {
        throw Exception(
            "Failed to fetch data: ${response.statusCode}"); // Handle other status codes
      }
    } on DioException catch (e) {
      // Handle Dio errors
      if (e.response != null) {
        debugPrint('Dio error: ${e.response?.data}');
        throw Exception(
            "Error: ${e.response?.data}"); // Handle any other errors
      } else {
        debugPrint('Dio error: ${e.message}');
        throw Exception("Error: ${e.message}"); // Handle any other errors
      }
    } catch (e) {
      throw Exception("Error: $e"); // Handle any other errors
    }
  }

  static Future<List<DoctorModel>> getAllDoctor() async {
    final DioClient _dioClient = DioClient();

    try {
      Response response = await _dioClient.dio.post(Config.doctorAll);
      if (response.statusCode == 200) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.data);
        if (apiResponse.metadata.status == 200) {
          dynamic responseData = apiResponse.response['data'];
          if (responseData != null) {
            if (responseData is List) {
              List<DoctorModel> doctors = responseData
                  .map<DoctorModel>((json) => DoctorModel.fromJson(json))
                  .toList();

              print(doctors);
              return doctors;
            } else {
              throw Exception("Invalid response data: Expected a list");
            }
          } else {
            throw Exception("Response data is null");
          }
        } else if (apiResponse.metadata.status == 401) {
          throw Exception("Unauthorized");
        } else {
          throw Exception(apiResponse.metadata.message);
        }
      } else {
        throw Exception("Failed to fetch data: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint('Dio error: ${e.response?.data}');
        throw Exception("Error: ${e.response?.data}");
      } else {
        debugPrint('Dio error: ${e.message}');
        throw Exception("Error: ${e.message}");
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception("Error: $e");
    }
  }
}

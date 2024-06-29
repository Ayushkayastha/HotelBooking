import 'package:dio/dio.dart';
import 'package:hotel_app/config/HotelModel.dart';

import 'api_endpoints.dart';

class NetworkRequest {
  final dio = Dio();

  Future<List<HotelModel>?> hotelmodel() async {
    try {
      final response = await dio.get(ApiEndpoints.details);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        print('joke');
        print(response);
        List<HotelModel> hotels = (response.data as List)
            .map((json) => HotelModel.fromJson(json))
            .toList();
        return hotels;
      } else {
        // Failure
        print('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle any other errors, like network issues
      print('Error occurred catch bhitra: $e');
      return null;
    }
  }
}
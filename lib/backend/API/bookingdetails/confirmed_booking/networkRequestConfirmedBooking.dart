import 'package:dio/dio.dart';
import 'package:hotel_app/backend/API/bookingdetails/confirmed_booking/ConfirmedBookingModel.dart';
import 'package:hotel_app/backend/shared_preference.dart';

class NetworkRequestConfirmedBooking {
  final dio = Dio();
  static const String baseUrl = 'http://localhost:8800/api/bookings/users/';
  final SharedPreferencesService _prefsService = SharedPreferencesService();

  Future<List<ConfirmedBookingModel>?> getConfirmedBookings(String userId) async {
    print('Booking confirmed page reached');
    String? accessToken;

    bool isLoggedIn = await _prefsService.isLoggedIn();
    if (isLoggedIn) {
      var userInfo = await _prefsService.loadUserInfo();
      accessToken = userInfo['access_token'];
      print(accessToken);
      if (accessToken == null) {
        print('Access token is null');
        return null;
      }
    } else {
      print('User is not logged in');
      return null;
    }

    try {
      final url = baseUrl + userId;
      print('Requesting URL: $url');
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        print('Confirmed booking API called successfully');
        print(response);

        List<ConfirmedBookingModel> bookings = (response.data as List)
            .map((json) => ConfirmedBookingModel.fromJson(json))
            .toList();

        return bookings;
      } else {
        // Failure
        print('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle any other errors, like network issues
      print('Error occurred req garda: $e');
      return null;
    }
  }
}

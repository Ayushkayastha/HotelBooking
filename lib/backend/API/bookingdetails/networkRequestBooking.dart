
import 'dart:convert';
import 'package:hotel_app/backend/API/bookingdetails/BookingModel.dart';
import 'package:http/http.dart' as http;

class NetworkRequestBooking{
  static const String baseUrl = 'http://localhost:8800/api/bookings';

  static Future<BookingModel?> booking(String hotel_id ,String room_id,String user_id,String check_in,String check_out) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'hotel': hotel_id,
        'room': room_id,
        'user':user_id,
        'check_in':check_in,
        'check_out':check_out,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {

      return BookingModel.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to login. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return null;
    }
  }
}
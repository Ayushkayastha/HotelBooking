import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hotel_app/backend/API/bookingdetails/BookingModel.dart';
import 'package:hotel_app/backend/API/bookingdetails/networkRequestBooking.dart';
import 'package:hotel_app/backend/provider/date_range_notifier.dart';
import 'package:hotel_app/backend/shared_preference.dart';
import 'package:hotel_app/bottom_nav_bar.dart';
import 'package:hotel_app/stripe/payment.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookingConfirmation extends StatefulWidget {
  final String hotelName;
  final String hotel_id;
  final String roomType;
  final int roomPrice;
  final String roomDescription;
  final String roomImage;

  const BookingConfirmation({
    Key? key,
    required this.hotelName,
    required this.hotel_id,
    required this.roomType,
    required this.roomPrice,
    required this.roomDescription,
    required this.roomImage,
  }) : super(key: key);

  @override
  State<BookingConfirmation> createState() => _BookingConformationState();

}

class _BookingConformationState extends State<BookingConfirmation> {

  bool _isLoggedIn = false;
  String user_id='';
  String room_id='6662f1a0fa856de96a6ba704';
  String start_date='';
  String end_date='';
  final SharedPreferencesService _prefsService = SharedPreferencesService();


  void initState() {
    super.initState();
    _checkLoginState();

  }

  String dateConverter(String inputDateStr) {
    try {
      // Define the input date format
      DateFormat inputFormat = DateFormat('MMMM d, yyyy');

      // Parse the input date string to a DateTime object
      DateTime date = inputFormat.parse(inputDateStr);

      // Define the output date format
      DateFormat outputFormat = DateFormat('yyyy-MM-dd');

      // Format the DateTime object to the desired format
      String outputDateStr = outputFormat.format(date);

      return outputDateStr; // Return the formatted date string
    } catch (e) {
      print('Error parsing date: $e');
      return ''; // Return an empty string or handle the error as needed
    }
  }

  Future<void> _checkLoginState() async
  {
    bool isLoggedIn = await _prefsService.isLoggedIn();
    if (isLoggedIn) {
      var userInfo = await _prefsService.loadUserInfo();
      setState(() {
        _isLoggedIn = true;
        user_id= userInfo['id']!;
        print(user_id);
      });
    }
  }

  Future<void> initPaymentSheet(BuildContext context) async {
    try {
      // 1. create payment intent on the client by calling stripe API
      final data = await createPaymentIntent
        (
          amount: (widget.roomPrice*100).toString(),
          currency: 'USD'
      );

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          // Main params
          merchantDisplayName: 'test Merchant',
          paymentIntentClientSecret: data['client_secret'],
          // Customer keys
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['id'],
          // Extra options

          style: ThemeMode.dark,
        ),
      );

    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }

  Future<void> _booking(String hotel_id, String room_id, String user_id, String check_in, String check_out) async {
    try {
      BookingModel? bookingResponse = await NetworkRequestBooking.booking(hotel_id, room_id, user_id, check_in, check_out);

      if (bookingResponse != null) {
        print('Successful booking with status: ${bookingResponse.status}');
      } else {
        print('Failed to book. Response is null.');
      }
    } catch (e) {
      print('Error during booking: $e');
    }
  }

    @override
  Widget build(BuildContext context) {
    final dateRangeNotifier = Provider.of<DateRangeNotifier>(context);
    final dateRange = dateRangeNotifier.formatDateRange();

    print(dateRange['startDate']);
    print(dateRange['endDate']);
    start_date=dateConverter(dateRange['startDate']!);
    end_date=dateConverter(dateRange['endDate']!);

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                widget.roomImage,
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              widget.hotelName,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              widget.roomType,
              style: TextStyle(fontSize: 20.0, color: Colors.grey[700]),
            ),
            SizedBox(height: 8.0),
            Text(
              'Price: \$${widget.roomPrice}',
              style: TextStyle(fontSize: 20.0, color: Colors.grey[700]),
            ),
            SizedBox(height: 8.0),
            Text(
              widget.roomDescription,
              style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [Color(0xFF51D4C2),
                            Color(0xFF84FFF5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {

                          if (_isLoggedIn==true)
                          {
                            await initPaymentSheet(context);
                            try{
                              await Stripe.instance.presentPaymentSheet();
                              _booking(widget.hotel_id,room_id,user_id,start_date,end_date);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:Text(
                                  "payment done",
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor:Colors.green,
                              ));
                            }
                            catch(e){
                              print(e);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:Text(
                                  "payment failed",
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor:Colors.redAccent,
                              ));
                            }
                          }

                          else
                          {
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) => Bottomnavbar(indexno:3),
                              ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:Text(
                                  "Need to login for Booking",
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor:Colors.black,
                              ));

                          }

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'Paynow',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

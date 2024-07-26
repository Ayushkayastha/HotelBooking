import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hotel_app/stripe/payment.dart';

import '../widget/button.dart';

class BookingConfirmation extends StatelessWidget {
  final String hotelName;
  final String roomType;
  final int roomPrice;
  final String roomDescription;
  final String roomImage;

  const BookingConfirmation({
    Key? key,
    required this.hotelName,
    required this.roomType,
    required this.roomPrice,
    required this.roomDescription,
    required this.roomImage,
  }) : super(key: key);


  Future<void> initPaymentSheet(BuildContext context) async {
    try {
      // 1. create payment intent on the client by calling stripe API
      final data = await createPaymentIntent
        (
          amount: (roomPrice*100).toString(),
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



  void _payNow(BuildContext context) {
    // Handle pay now logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pay now clicked')),
    );
  }

  void _payLater(BuildContext context) {
    // Handle pay later logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pay later clicked')),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                roomImage,
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              hotelName,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              roomType,
              style: TextStyle(fontSize: 20.0, color: Colors.grey[700]),
            ),
            SizedBox(height: 8.0),
            Text(
              'Price: \$${roomPrice}',
              style: TextStyle(fontSize: 20.0, color: Colors.grey[700]),
            ),
            SizedBox(height: 8.0),
            Text(
              roomDescription,
              style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                children: [
              Expanded(
              child: button(
              'Pay Later', ()=>_payLater(context)
              ),
            ),
                  SizedBox(width: 16.0),

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
                          await initPaymentSheet(context);
                          try{
                            await Stripe.instance.presentPaymentSheet();
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

import 'package:flutter/material.dart';

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
                    child: button(
                      'Pay Now', () =>_payNow(context)
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

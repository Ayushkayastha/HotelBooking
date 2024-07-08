import 'package:flutter/material.dart';
import 'package:hotel_app/backend/API/HotelDetails.dart';
import 'package:hotel_app/features/widget/button.dart';

import '../../backend/API/hotel_details/HotelModel.dart';

class HotelProfile extends StatefulWidget {
  final HotelModel hotelModel;
  const HotelProfile({Key? key,required this.hotelModel}) : super(key: key);

  @override
  State<HotelProfile> createState() => _HotelProfileState();
}

class _HotelProfileState extends State<HotelProfile> {
  @override
  Widget build(BuildContext context) {
    Color mycolor =Color.fromARGB(255, 81, 212, 194);

    return Scaffold(

    body: Stack(
      children: [
        Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(32.0),
              child: Image.network(
                'https://via.placeholder.com/400', // Dummy image URL
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   widget.hotelModel.name??'',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(widget.hotelModel.address??'',
                    style: TextStyle(fontSize: 20.0, color: Colors.grey[700]),),
                  SizedBox(height: 8.0),
                  Text('Starts form \$'+widget.hotelModel.cheapestPrice.toString(),
                    style: TextStyle(fontSize: 20.0, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Distance: ${widget.hotelModel.distance ?? 'N/A'} km from capital',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                     widget.hotelModel.title ?? 'N/A',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16.0),

                  Divider(
                      color: Colors.grey[600], // The color of the line
                    thickness: 2, // The thickness of the line
                  ),

                  SizedBox(height: 16.0),
                  Row(children: [
                    Text('Description'),
                  ],),
                  Text(widget.hotelModel.desc??''),


                ],
              ),
            ),
          ],
        ),
      ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: button('Select room',(){}),
                  ),
                ),
              ],
            ),
          ],
        ),

      ],
    ),
    );
  }
}

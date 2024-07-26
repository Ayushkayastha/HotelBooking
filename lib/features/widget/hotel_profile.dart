import 'package:flutter/material.dart';
import 'package:hotel_app/backend/API/HotelDetails.dart';
import 'package:hotel_app/features/sub_route/booking_conformation.dart';
import 'package:hotel_app/features/widget/button.dart';

import '../../backend/API/hotel_details/HotelModel.dart';

class HotelProfile extends StatefulWidget {
  final HotelModel hotelModel;
  const HotelProfile({Key? key,required this.hotelModel}) : super(key: key);

  @override
  State<HotelProfile> createState() => _HotelProfileState();
}

class _HotelProfileState extends State<HotelProfile> {
  Color mycolor = Color.fromARGB(255, 81, 212, 194);
  int? selectedRoomIndex;

  final List<Map<String, dynamic>> roomTypes = [
    {
      'type': 'Single Room',
      'price': 100,
      'description': 'A comfortable room for one person.',
      'image' :'https://via.placeholder.com/50'
    },
    {
      'type': 'Double Room',
      'price': 150,
      'description': 'A spacious room for two people.',
      'image' :'https://via.placeholder.com/50'

    },
    {
      'type': 'Suite',
      'price': 250,
      'description': 'A luxurious suite with extra amenities.',
      'image' :'https://via.placeholder.com/50'

    },
  ];

  void _selectRoom(int index) {
    setState(() {
      selectedRoomIndex = index;
    });
  }



  void _confirmSelection() {
    if (selectedRoomIndex != null) {
      final selectedRoom = roomTypes[selectedRoomIndex!];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingConfirmation(
            hotelName: widget.hotelModel.name ?? '',
            roomType: selectedRoom['type'],
            roomPrice: selectedRoom['price'],
            roomDescription: selectedRoom['description'],
            roomImage: selectedRoom['image'],
          ),
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.hotelModel.name??''),),
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
                        widget.hotelModel.name ?? '',
                        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        widget.hotelModel.address ?? '',
                        style: TextStyle(fontSize: 20.0, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Starts form \$${widget.hotelModel.cheapestPrice}',
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
                      Row(
                        children: [
                          Text('Description'),
                        ],
                      ),
                      Text(widget.hotelModel.desc ?? ''),
                      SizedBox(height: 16.0),
                      Divider(
                        color: Colors.grey[600], // The color of the line
                        thickness: 2, // The thickness of the line
                      ),

                      Text('Room Types', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8.0),

                      Column(
                        children:roomTypes.asMap().entries.map((entry) {
                          int index = entry.key;
                          var room = entry.value;
                          return GestureDetector(
                            onTap: () => _selectRoom(index),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                                side: BorderSide(
                                  color: selectedRoomIndex == index ? mycolor : Colors.grey,
                                  width: 2.0,
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(24.0),
                                      topRight: Radius.circular(24.0),
                                    ),
                                    child: Image.network(
                                      room['image'] ?? 'https://via.placeholder.com/150',
                                      height: 150.0,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  ListTile(
                                  title: Text(room['type']),
                                  subtitle: Text(room['description']),
                                  trailing: Text('\$${room['price']}'),
                                ),
                                ]
                              ),
                            ),
                          );
                        }).toList(),

                      ),
                      SizedBox(height: 16.0),

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
                      child: button('Select room', _confirmSelection),
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





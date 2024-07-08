import 'package:flutter/material.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*body: FutureBuilder<List<HotelModel>?>(
        future: NetworkRequest().hotelmodel(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show loading indicator while waiting for data
            return Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasError) {
            // Handle errors
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          else if (snapshot.hasData && snapshot.data!= null) {
            // When data is available
            final hotels = snapshot.data!;
            return ListView.builder(
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                final hotel = hotels[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: ${hotel.name?? 'N/A'}'),
                        Text('Type: ${hotel.type?? 'N/A'}'),
                        Text('City: ${hotel.city?? 'N/A'}'),
                        Text('Address: ${hotel.address?? 'N/A'}'),
                        Text('Distance: ${hotel.distance?? 'N/A'}'),
                        Text('Title: ${hotel.title?? 'N/A'}'),
                        Text('Description: ${hotel.desc?? 'N/A'}'),
                        Text('Cheapest Price: ${hotel.cheapestPrice?? 'N/A'}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          else {
            // Handle the case when the data is null
            return Center(child: Text('Data is null'));
          }
        },
      ),*/
    );
  }
}

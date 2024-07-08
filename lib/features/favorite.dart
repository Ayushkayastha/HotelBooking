import 'package:flutter/material.dart';
import 'package:hotel_app/backend/API/HotelDetails.dart';
import 'package:hotel_app/backend/API/hotel_details/HotelModel.dart';
import 'package:hotel_app/backend/API/hotel_details/network_request.dart';
import 'package:hotel_app/features/widget/hotel_card.dart';
import 'package:provider/provider.dart';

import '../backend/shared_preference.dart';

import 'datas.dart';


class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  HotelDetails hotelDetails = HotelDetails();
  final SharedPreferencesService _prefsService = SharedPreferencesService();
  List<int> favoriteHotelIndices = [];



  void initState() {
    super.initState();
    _loadFavoriteHotels();
  }

  Future<void> _loadFavoriteHotels() async {
    List<String> favoriteList = await _prefsService.loadList();
    setState(() {
      favoriteHotelIndices = favoriteList.map((e) => int.parse(e)).toList();
    });
  }



  @override
  Widget build(BuildContext context) {

    List<int> FavHotel=[];
    print("Hotel Count: ${hotelDetails.count}");
    for(int i=0;i<hotelDetails.count.length;i++)
    {
      if(hotelDetails.count[i])
        {FavHotel.add(i);
        }
    }
    print(FavHotel);
    return Scaffold(

      appBar: AppBar(
    title: Row(
    mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('Favorites',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),),
      ],
    ),
    ),
   body:
   Padding(
     padding: const EdgeInsets.all(12.0),
     child: FutureBuilder<List<HotelModel>?>(
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
             shrinkWrap: true,
             itemCount: favoriteHotelIndices.length,
             itemBuilder: (context, index) {
               final hotel = hotels[favoriteHotelIndices[index]];
               return HotelCard(
                 hotel: hotel,
                 imageUrl: 'https://via.placeholder.com/50',
                 reviews: '80 Reviews',
                 rating: hotelDetails.hotelRatings[hotels.indexOf(hotel)],
                 index: hotels.indexOf(hotel),
               );

             },
           );
         }
         else {
           // Handle the case when the data is null
           return Center(child: Text('Data is null'));
         }
       },
     ),
   ),
    );
  }
}









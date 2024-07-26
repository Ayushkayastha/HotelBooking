import 'package:flutter/material.dart';
import 'package:hotel_app/backend/API/HotelDetails.dart';
import 'package:hotel_app/backend/API/hotel_details/HotelModel.dart';
import 'package:hotel_app/features/favorite.dart';
import 'package:hotel_app/features/widget/hotel_profile.dart';
import 'package:provider/provider.dart';

import '../../backend/shared_preference.dart';


class HotelCard extends StatefulWidget {
  final HotelModel hotel;
  final String hotel_id;
  final String imageUrl;
  final String reviews;
  final int rating;
  final int index;


  const HotelCard({
    Key? key,
    required this.hotel,
    required this.hotel_id,
    required this.imageUrl,
    required this.reviews,
    required this.rating,
    required this.index,


  }) : super(key: key);

  @override
  _HotelCardState createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
  Color mycolor = Color.fromARGB(255, 81, 212, 194);
  bool isFavourite = false;
  final SharedPreferencesService _prefsService = SharedPreferencesService();

  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    List<String> favoriteList = await _prefsService.loadList();
    setState(() {
      isFavourite = favoriteList.contains(widget.index.toString());
    });
  }

  Future<void> _toggleFavoriteStatus() async {
    List<String> favoriteList = await _prefsService.loadList();
    setState(() {
      if (isFavourite) {
        favoriteList.remove(widget.index.toString());
      } else {
        favoriteList.add(widget.index.toString());
      }
      isFavourite = !isFavourite;
      _prefsService.saveList(favoriteList);
      print(favoriteList);
    });
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HotelProfile(
                hotelModel: widget.hotel,
                hotel_id :widget.hotel_id,
            ),
          ),
        );
      },
      child: Card(
        color: Color.fromARGB(255, 243, 243, 243),
        margin: EdgeInsets.only(bottom: 16.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.imageUrl,
                  width: 120.0,
                  height: 120.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.hotel.name??'',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          onPressed: _toggleFavoriteStatus,
                          icon: Icon(
                            isFavourite ? Icons.favorite : Icons.favorite_border,
                            color: isFavourite ? Colors.red : null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(widget.hotel.address??''),
                    Text('${widget.hotel.distance??''} Km from the city'),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: List.generate(
                            widget.rating,
                                (index) => Icon(Icons.star, color: mycolor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Text(widget.reviews),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '${'\$'}${widget.hotel.cheapestPrice}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hotel_app/backend/API/hotel_details/HotelModel.dart';
import 'package:hotel_app/backend/API/hotel_details/network_request.dart';
import 'package:hotel_app/backend/provider/date_range_notifier.dart';
import 'package:intl/intl.dart';
import 'package:hotel_app/features/sub_route/filter.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:hotel_app/features/widget/button.dart';
import 'package:hotel_app/features/widget/hotel_card.dart';
import 'package:hotel_app/backend/API/HotelDetails.dart';
import 'package:provider/provider.dart'; // Import provider

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _isDatePickerVisible = false;
  HotelDetails hotelDetails = HotelDetails();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    Color mycolor = Color.fromARGB(255, 81, 212, 194);
    print("Homepage: ${hotelDetails.count}");

    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: ListView(
              children: [
                if (_isDatePickerVisible)
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.transparent.withOpacity(0.1),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Card(
                    color: Color.fromARGB(255, 243, 243, 243),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  height: 48,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: TextField(
                                      onChanged: (value) {
                                        setState(() {
                                          _searchQuery = value;
                                          print(_searchQuery);
                                        });
                                      },
                                      cursorColor: Colors.transparent,
                                      style: TextStyle(fontSize: 17),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Search',
                                        hintStyle: TextStyle(
                                            fontSize: 17, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: mycolor,
                                ),
                                height: 48,
                                child: IconButton(
                                  icon: Image.asset(
                                    'assets/icons/search_icon.png',
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                        Consumer<DateRangeNotifier>(
                          builder: (context, dateRangeNotifier, child) {
                            final dateRange = dateRangeNotifier.formatDateRange();
                            return Container(
                              height: 64,
                              margin: EdgeInsets.only(bottom: 16.0),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _isDatePickerVisible =
                                        !_isDatePickerVisible;
                                      });
                                    },
                                    child: Text(
                                      '${dateRange['startDate']}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text('|', style: TextStyle(fontSize: 24)),
                                  TextButton(
                                    onPressed: () => setState(() {
                                      _isDatePickerVisible =
                                      !_isDatePickerVisible;
                                    }),
                                    child: Text(
                                      '${dateRange['endDate']}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FutureBuilder<List<HotelModel>?>(
                    future: NetworkRequest().hotelmodel(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData && snapshot.data != null) {
                        final hotels = snapshot.data!;
                        final filteredHotels = hotels.where((hotel) {
                          return hotel.name!
                              .toLowerCase()
                              .contains(_searchQuery.toLowerCase());
                        }).toList();
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: filteredHotels.length,
                          itemBuilder: (context, index) {
                            final hotel = filteredHotels[index];
                            String imageUrl = hotel.photos!.isNotEmpty &&
                                hotel.photos![0] != null
                                ? hotel.photos![0]
                                : 'https://via.placeholder.com/50';
                            return HotelCard(
                              hotel: hotel,
                              hotel_id: hotel.id!,
                              imageUrl: imageUrl,
                              reviews: '80 Reviews',
                              rating: hotelDetails.hotelRatings[index],
                              index: index,
                            );
                          },
                        );
                      } else {
                        return Center(child: Text('Data is null'));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: mycolor,
                      ),
                      height: 44,
                      child: IconButton(
                          icon: Image.asset(
                            'assets/icons/filter_icon.png',
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Filter(),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_isDatePickerVisible)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Consumer<DateRangeNotifier>(
                      builder: (context, dateRangeNotifier, child) {
                        return CalendarDatePicker2(
                          config: CalendarDatePicker2Config(
                            calendarType: CalendarDatePicker2Type.range,
                            selectedDayHighlightColor: mycolor,
                            selectableDayPredicate: (DateTime day) =>
                                day.isAfter(
                                    DateTime.now().subtract(Duration(days: 1))),
                          ),
                          value: dateRangeNotifier.selectedDates,
                          onValueChanged: (dates) {
                            dateRangeNotifier.updateSelectedDates(
                                dates ?? [DateTime.now()]);
                          },
                        );
                      },
                    ),
                  ),
                ),
              if (_isDatePickerVisible)
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: button(
                          'Apply',
                              () {
                            setState(() {
                              _isDatePickerVisible = !_isDatePickerVisible;
                              _searchQuery = '';
                            });
                          },
                        ),
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

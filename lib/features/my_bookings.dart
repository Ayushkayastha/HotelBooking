import 'package:flutter/material.dart';
import 'package:hotel_app/backend/API/bookingdetails/confirmed_booking/ConfirmedBookingModel.dart';
import 'package:hotel_app/backend/API/bookingdetails/confirmed_booking/NetworkRequestConfirmedBooking.dart';
import 'package:hotel_app/backend/shared_preference.dart';
import 'package:hotel_app/backend/API/hotel_details/HotelModel.dart';
import 'package:hotel_app/backend/API/hotel_details/network_request.dart';
import 'package:intl/intl.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({super.key});

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  final SharedPreferencesService _prefsService = SharedPreferencesService();
  final NetworkRequestConfirmedBooking _networkRequestConfirmedBooking = NetworkRequestConfirmedBooking();
  final NetworkRequest _networkRequest = NetworkRequest();

  List<Booking> _bookings = [];
  String userId = '';
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  Future<void> _checkLoginState() async {
    bool isLoggedIn = await _prefsService.isLoggedIn();
    if (isLoggedIn) {
      var userInfo = await _prefsService.loadUserInfo();
      setState(() {
        _isLoggedIn = true;
        userId = userInfo['id']!;
        _fetchBookings();
      });
    }
  }

  Future<void> _fetchBookings() async {
    if (!_isLoggedIn) return;

    try {
      List<ConfirmedBookingModel>? confirmedBookings = await _networkRequestConfirmedBooking.getConfirmedBookings(userId);

      if (confirmedBookings != null) {
        List<Booking> bookings = [];

        for (var booking in confirmedBookings) {
          HotelModel? hotelDetails = await _networkRequest.hotelmodel().then((hotels) {
            return hotels?.firstWhere((hotel) => hotel.id == booking.hotel);
          });

          if (hotelDetails != null) {
            bookings.add(Booking(
              hotelName: hotelDetails.name ?? '',
              location: hotelDetails.city ?? '',
              price: '\$${hotelDetails.cheapestPrice ?? 0}',
              arrivalDate: DateTime.parse(booking.checkIn!),
              departureDate: DateTime.parse(booking.checkOut!),
              numberOfPeople: 1, // This should be updated as per your requirement
              additionalInfo: 'Some additional info about the booking',
              photoUrl: hotelDetails.photos?.first ?? 'https://via.placeholder.com/50',
            ));
          }
        }

        setState(() {
          _bookings = bookings;
        });
      }
    } catch (e) {
      print('Error fetching bookings: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookings'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: _bookings.length,
        itemBuilder: (context, index) {
          final booking = _bookings[index];
          return BookingCard(booking: booking);
        },
      ),
    );
  }
}

class Booking {
  final String hotelName;
  final String location;
  final String price;
  final DateTime arrivalDate;
  final DateTime departureDate;
  final int numberOfPeople;
  final String additionalInfo;
  final String photoUrl;

  Booking({
    required this.hotelName,
    required this.location,
    required this.price,
    required this.arrivalDate,
    required this.departureDate,
    required this.numberOfPeople,
    required this.additionalInfo,
    required this.photoUrl,
  });
}

class BookingCard extends StatefulWidget {
  final Booking booking;

  const BookingCard({super.key, required this.booking});

  @override
  _BookingCardState createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.booking.hotelName,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text('Location: ${widget.booking.location}'),
                        Text('Price: ${widget.booking.price}'),
                        Text('Arrival: ${DateFormat.yMMMMd().format(widget.booking.arrivalDate)}'),
                        Text('Departure: ${DateFormat.yMMMMd().format(widget.booking.departureDate)}'),
                        Text('Number of People: ${widget.booking.numberOfPeople}'),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.booking.photoUrl,
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              if (_isExpanded) ...[
                SizedBox(height: 8.0),
                Text('Additional Info: ${widget.booking.additionalInfo}'),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

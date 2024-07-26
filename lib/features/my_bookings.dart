import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({super.key});

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  List<Booking> _bookings = [
    Booking(
      hotelName: 'Hotel California',
      location: 'Los Angeles, CA',
      price: '\$200',
      arrivalDate: DateTime(2024, 8, 1),
      departureDate: DateTime(2024, 8, 5),
      numberOfPeople: 2,
      additionalInfo: 'Some additional info about the booking',
    ),
    Booking(
      hotelName: 'Grand Hotel',
      location: 'Paris, France',
      price: '\$300',
      arrivalDate: DateTime(2024, 9, 10),
      departureDate: DateTime(2024, 9, 15),
      numberOfPeople: 3,
      additionalInfo: 'Some additional info about the booking',
    ),
  ]; // This should be fetched from your backend

  @override
  Widget build(BuildContext context) {
    Color mycolor = Color.fromARGB(255, 81, 212, 194);

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

  Booking({
    required this.hotelName,
    required this.location,
    required this.price,
    required this.arrivalDate,
    required this.departureDate,
    required this.numberOfPeople,
    required this.additionalInfo,
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
          padding: const EdgeInsets.all(16.0),
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

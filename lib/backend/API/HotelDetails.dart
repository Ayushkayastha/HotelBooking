class HotelDetails {

 List<String> name=[
   "The Ritz-Carlton",
   "Four Seasons Hotel",
   "Marriott International",
   "Hilton Hotels & Resorts",
   "Hyatt Hotels Corporation",
   "InterContinental Hotels & Resorts",
   "Sheraton Hotels and Resorts",
   "Wyndham Hotels & Resorts",
   "AccorHotels",
   "Mandarin Oriental Hotel Group",
 ];

 List<String> address = [
   " Washington, DC",
   " Toronto, Ontario",
   " Bethesda, MD",
   " McLean, VA",
   " Chicago, IL",
   " Nassau, The Bahamas",
   " Arlington, TX",
   " Parsippany, NJ",
   " Paris, France",
   " Central, Hong Kong",
 ];
 List<int> hotelRatings = [
   3, // The Ritz-Carlton
   4, // Four Seasons Hotel
   2, // Marriott International
   2, // Hilton Hotels & Resorts
   1, // Hyatt Hotels Corporation
   2, // InterContinental Hotels & Resorts
   3, // Sheraton Hotels and Resorts
   2, // Wyndham Hotels & Resorts
   1, // AccorHotels
   4, // Mandarin Oriental Hotel Group
 ];

 List<double> price = [
   400, // The Ritz-Carlton
   350, // Four Seasons Hotel
   200, // Marriott International
   250, // Hilton Hotels & Resorts
   220, // Hyatt Hotels Corporation
   280, // InterContinental Hotels & Resorts
   180, // Sheraton Hotels and Resorts
   150, // Wyndham Hotels & Resorts
   170, // AccorHotels
   450, // Mandarin Oriental Hotel Group
 ];
 List<bool> count = [];

 // Constructor
 HotelDetails() {
   count = List<bool>.filled(name.length, false);
 }
}
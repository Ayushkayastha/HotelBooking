import { useContext, useEffect, useState } from 'react';
import useFetch from '../../hooks/useFetch';
import './myBooking.css';
import { AUTHContext } from '../../context/AuthContext';

const MyBooking = () => {
  const { user } = useContext(AUTHContext);
  const { data: bookings, loading, error } = useFetch(`/bookings/users/${user._id}`);
  const [hotels, setHotels] = useState({});

  useEffect(() => {
    const fetchHotelData = async (hotelId) => {
      const response = await fetch(`/hotels/find/${hotelId}`);
      const hotelData = await response.json();
      setHotels(prevHotels => ({ ...prevHotels, [hotelId]: hotelData }));
    };

    if (bookings && bookings.length > 0) {
      const hotelIds = new Set(bookings.map(booking => booking.hotel));
      hotelIds.forEach(hotelId => {
        if (!hotels[hotelId]) {
          fetchHotelData(hotelId);
        }
      });
    }
  }, [bookings, hotels]);

  return (
    <div className="myBooking">
      {loading ? (
        "Loading"
      ) : error ? (
        <div>Error: {error.message}</div>
      ) : (
        <>
          {bookings && bookings.map((item) => (
            <div className="fpItem" key={item._id}>
              <span className="fpName">Hotel: {hotels[item.hotel]?.name || "Loading..."}</span>
              <span className="fpCity">Check in: {item.check_in}</span>
              <span className="fpCity">Check out: {item.check_out}</span>
              <span className="fpCity">Status: {item.status}</span>
            </div>
          ))}
        </>
      )}
    </div>
  );
};

export default MyBooking;

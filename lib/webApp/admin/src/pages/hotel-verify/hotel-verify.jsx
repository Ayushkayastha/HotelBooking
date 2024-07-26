import React, { useEffect, useState } from 'react';
import axios from 'axios';

const HotelVerify = () => {
    const [hotels, setHotels] = useState([]);

    useEffect(() => {
        const fetchHotels = async () => {
            try {
                const response = await axios.get('http://localhost:8800/api/hotels/not-verified');
                setHotels(response.data);
            } catch (error) {
                console.error('Error fetching hotels:', error);
            }
        };

        fetchHotels();
    }, []);

    const handleVerify = async (hotelId) => {
        try {
            await axios.put(`http://localhost:8800/api/hotels/${hotelId}/verify`,  { withCredentials: true });
            setHotels(hotels.filter(hotel => hotel._id !== hotelId)); // Remove verified hotel from list
        } catch (error) {
            console.error('Error verifying hotel:', error);
        }
    };

    const handleReject = async (hotelId) => {
        try {
            await axios.delete(`http://localhost:8800/api/hotels/${hotelId}`,  { withCredentials: true });
            setHotels(hotels.filter(hotel => hotel._id !== hotelId)); // Remove rejected hotel from list
        } catch (error) {
            console.error('Error rejecting hotel:', error);
        }
    };

    return (
        <div className="admin-panel">
            <h1>Pending Hotels</h1>
            <table>
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>City</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    {hotels.map(hotel => (
                        <tr key={hotel._id}>
                            <td>{hotel.name}</td>
                            <td>{hotel.city}</td>
                            <td>
                                <button onClick={() => handleVerify(hotel._id)}>Verify</button>
                                <button onClick={() => handleReject(hotel._id)}>Reject</button>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default HotelVerify;

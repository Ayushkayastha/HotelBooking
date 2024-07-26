import React, { useState } from 'react';
import axios from 'axios';
import './hotelForm.css'; // Import the CSS file

const HotelForm = () => {
    const [formData, setFormData] = useState({
        name: '',
        type: '',
        city: '',
        address: '',
        distance: '',
        title: '',
        desc: '',
        rooms: '',
        cheapestPrice: 0, // Initialize with 0 or any default value
    });
    const [photoFiles, setPhotoFiles] = useState([]); // State for handling file inputs

    const handleChange = (e) => {
        const { name, value, type, checked } = e.target;
        setFormData({
            ...formData,
            [name]: type === 'checkbox' ? checked : value
        });
    };

    const handleFileChange = (e) => {
        const files = Array.from(e.target.files);
        setPhotoFiles(prevFiles => [...prevFiles, ...files]);
    };

    const handleRemoveFile = (fileName) => {
        setPhotoFiles(prevFiles => prevFiles.filter(file => file.name !== fileName));
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
    
        // Upload photos to Cloudinary and get URLs
        let photoUrls = [];
        try {
            photoUrls = await Promise.all(
                photoFiles.map(async (file) => {
                    const data = new FormData();
                    data.append('file', file);
                    data.append('upload_preset', 'upload'); // Replace with your Cloudinary upload preset
    
                    const uploadRes = await axios.post('https://api.cloudinary.com/v1_1/rajatkhadka/image/upload', data);
                    return uploadRes.data.url; // Get the URL from the response
                })
            );
        } catch (error) {
            console.error('Error uploading photos:', error);
            return; // Stop further execution if photo upload fails
        }
    
        // Prepare form data with photo URLs
        const newHotel = {
            ...formData,
            photos: photoUrls, // Include photo URLs in form data
            rooms: formData.rooms.split(',').map(room => room.trim()) // Optionally process room names
        };
    
        try {
            await axios.post('http://localhost:8800/api/hotels', newHotel, {
                headers: {
                    'Content-Type': 'application/json'
                }
            });
            alert('Hotel submitted for review!');
        } catch (error) {
            console.error('Error submitting hotel:', error);
        }
    };
    

    return (
        <div className="form-container">
            <h1>List Your Property</h1>
            <form onSubmit={handleSubmit} className="hotel-form">
                <label>
                    Hotel Name:
                    <input type="text" name="name" value={formData.name} onChange={handleChange} required />
                </label>
                <label>
                    Type:
                    <select name="type" value={formData.type} onChange={handleChange} required>
                        <option value="">Select Type</option>
                        <option value="Hotel">Hotel</option>
                        <option value="Apartment">Apartment</option>
                        <option value="Villa">Villa</option>
                        <option value="Resort">Resort</option>
                        <option value="Cabin">Cabin</option>
                    </select>
                </label>
                <label>
                    City:
                    <input type="text" name="city" value={formData.city} onChange={handleChange} required />
                </label>
                <label>
                    Address:
                    <input type="text" name="address" value={formData.address} onChange={handleChange} required />
                </label>
                <label>
                    Distance from City Center:
                    <input type="text" name="distance" value={formData.distance} onChange={handleChange} required />
                </label>
                <label>
                    Photos:
                    <input type="file" name="photos" multiple onChange={handleFileChange} />
                    <div className="file-preview">
                        {photoFiles.map(file => (
                            <div key={file.name} className="file-item">
                                {file.name}
                                <span className="remove-file" onClick={() => handleRemoveFile(file.name)}>×</span>
                            </div>
                        ))}
                    </div>
                </label>
                <label>
                    Title:
                    <input type="text" name="title" value={formData.title} onChange={handleChange} required />
                </label>
                <label>
                    Description:
                    <textarea name="desc" value={formData.desc} onChange={handleChange} required />
                </label>
                <label>
                    Rooms (comma-separated names):
                    <input type="text" name="rooms" value={formData.rooms} onChange={handleChange} />
                </label>
                <label>
                    Cheapest Price:
                    <input type="number" name="cheapestPrice" value={formData.cheapestPrice} onChange={handleChange} required />
                </label>
                <button type="submit">Submit</button>
            </form>
        </div>
    );
};

export default HotelForm;

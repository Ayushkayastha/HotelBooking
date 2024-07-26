import "./updateHotel.css";
import Sidebar from "../../components/sidebar/Sidebar";
import DriveFolderUploadOutlinedIcon from "@mui/icons-material/DriveFolderUploadOutlined";
import { useState, useEffect } from "react";
import { hotelInputs } from "../../formSource";
import axios from "axios";
import { useParams } from "react-router-dom";

const UpdateHotel = () => {
  const { hotelId } = useParams(); // Get hotelId from URL parameters
  //console.log(hotelId)
  const [files, setFiles] = useState([]);
  const [info, setInfo] = useState({});
  const [rooms, setRooms] = useState([]);
  const [hotelData, setHotelData] = useState(null);

  useEffect(() => {
    const fetchHotelData = async () => {
      try {
        const res = await axios.get(`http://localhost:8800/api/hotels/find/${hotelId}`);
        setHotelData(res.data);
        setInfo(res.data);
        setRooms(res.data.rooms);
      } catch (err) {
        console.error(err);
      }
    };

    fetchHotelData();
  }, [hotelId]);

  const handleChange = (e) => {
    setInfo((prev) => ({ ...prev, [e.target.id]: e.target.value }));
  };

  const handleSelect = (e) => {
    const value = Array.from(
      e.target.selectedOptions,
      (option) => option.value
    );
    setRooms(value);
  };

  const handleClick = async (e) => {
    e.preventDefault();
    try {
      const list = await Promise.all(
        Object.values(files).map(async (file) => {
          const data = new FormData();
          data.append("file", file);
          data.append("upload_preset", "upload");

          const uploadRes = await axios.post(
            "https://api.cloudinary.com/v1_1/rajatkhadka/image/upload",
            data
          );

          const { url } = uploadRes.data;
          return url;
        })
      );

      const updatedHotel = {
        ...info,
        rooms,
        photos: list.length > 0 ? list : hotelData.photos, // Keep old photos if no new photos are uploaded
      };

      await axios.put(`http://localhost:8800/api/hotels/${hotelId}`, updatedHotel, { withCredentials: true });
      alert('Hotel updated successfully');
    } catch (err) {
      console.error(err);
      alert('Error updating hotel');
    }
  };

  if (!hotelData) return <div>Loading...</div>;

  return (
    <div className="update">
      <Sidebar />
      <div className="updateContainer">
        <div className="top">
          <h1>Update Hotel</h1>
        </div>
        <div className="bottom">
          <div className="left">
            <img
              src={
                files.length > 0
                  ? URL.createObjectURL(files[0])
                  : hotelData.photos[0] || "https://icon-library.com/images/no-image-icon/no-image-icon-0.jpg"
              }
              alt=""
            />
          </div>
          <div className="right">
            <form>
              <div className="formInput">
                <label htmlFor="file">
                  Image: <DriveFolderUploadOutlinedIcon className="icon" />
                </label>
                <input
                  type="file"
                  id="file"
                  multiple
                  onChange={(e) => setFiles(e.target.files)}
                  style={{ display: "none" }}
                />
              </div>

              {hotelInputs.map((input) => (
                <div className="formInput" key={input.id}>
                  <label>{input.label}</label>
                  <input
                    id={input.id}
                    onChange={handleChange}
                    type={input.type}
                    placeholder={input.placeholder}
                    value={info[input.id] || ''}
                  />
                </div>
              ))}

              <div className="formInput">
                <label>Featured</label>
                <select onChange={handleChange} id="featured" value={info.featured || false}>
                  <option value={false}>No</option>
                  <option value={true}>Yes</option>
                </select>
              </div>

              <div className="selectRooms">
                <label>Rooms</label>
                <select onChange={handleSelect} multiple id="rooms" value={rooms}>
                  {hotelData.rooms.map((room) => (
                    <option key={room._id} value={room._id}>{room.title}</option>
                  ))}
                </select>
              </div>

              <button onClick={handleClick}>Update</button>
            </form>
          </div>
        </div>
      </div>
    </div>
  );
};

export default UpdateHotel;

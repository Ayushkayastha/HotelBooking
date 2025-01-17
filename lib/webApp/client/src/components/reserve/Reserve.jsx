import { faCircleXmark } from "@fortawesome/free-solid-svg-icons"
import "./reserve.css"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import useFetch from "../../hooks/useFetch"
import { useContext, useState } from "react"
import { SearchContext } from "../../context/SearchContext"
import axios from "axios"
import { useNavigate } from 'react-router-dom'

const Reserve = ({setOpen, hotelId}) => {
  const [selectedRooms, setSelectedRooms] = useState([])
  const {data, loading, error } = useFetch(`/hotels/room/${hotelId}`);
  const {dates} = useContext(SearchContext)

  const navigate = useNavigate()
  
  const getDatesInRange = (startDate, endDate) => {
    const start = new Date(startDate);
    const end = new Date(endDate);
    const date = new Date(start.getTime());



    let list = []

    while (date <= end){
      list.push(new Date(date).getTime())
      date.setDate(date.getDate() + 1)
    }

    return list;
  }

 const allDates = getDatesInRange(dates[0].startDate, dates[0].endDate)

 const isAvailable = (roomNumber) => {
   const unavailableDates = roomNumber.unvailableDates || []; // Ensure unavailableDates is an array
  const isFound = unavailableDates.some( (date) => 
  allDates.includes(new Date(date).getTime())
  );

  return !isFound

 }

  const handleSelect = (e) => {
    const checked = e.target.checked
    const value = e.target.value
    setSelectedRooms(checked ? [...selectedRooms, value] 
      : selectedRooms.filter((item) => (item !== value)))
  };

  // const handleClick = async () => {
  //   try {
  //     await Promise.all(selectedRooms.map(roomId => {
  //       const res = axios.put(`/rooms/availability/${roomId}`,{dates:allDates})
  //       return res.data;
  //     })
  //   );
  //   setOpen(false);
  //   navigate('/booking')
  //   } catch (error) {
      
  //   }
  // }

  const handleClick = async () => {
    try {
      // await Promise.all(selectedRooms.map(roomId => {
      //   const res = axios.put(`/rooms/availability/${roomId}`, { dates: allDates });
      //   return res.data;
      // }));
      setOpen(false);
      navigate('/booking', { state: {hotelId, selectedRooms, dates: allDates } });
      console.log(selectedRooms,allDates)
    } catch (error) {
      console.error(error);
    }
  };

  return (
    
    <div className="reserve">
        <div className="rContainer">
            <FontAwesomeIcon
            icon={faCircleXmark}
            className="rClose"
            onClick={() => setOpen(false)}
            />
            <span>Select your rooms:</span>
            {data.map((item) => (
              <div className="rItem" >
                <div className="rItemInfo">
                  <div className="rTitle">{item.title}</div>
                  <div className="rDesc">{item.desc}</div>
                  <div className="rMax">
                    Max people: <b>{item.maxPeople}</b>
                  </div>
                  <div className="rPrice">{item.price}</div>
                </div>
                <div className="rSelectRooms">
                  {item.roomNumbers.map((roomNumber) => (
                    <div className="room">
                  <label>{roomNumber.number}</label>
                  <input 
                  type="checkbox" 
                  value={item._id} 
                  onChange={handleSelect}
                  disabled = {!isAvailable(roomNumber)}
                  />
                </div>
            ))}
          </div>
              </div>
            ))}
            <button onClick={handleClick} className="rButton">Reserve Now!</button>
        </div>
    </div>
  )
}

export default Reserve
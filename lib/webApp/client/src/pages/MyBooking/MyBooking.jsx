import { useContext } from 'react';
import useFetch from '../../hooks/useFetch';
import './myBooking.css'
import { AUTHContext } from '../../context/AuthContext';

const MyBooking = () => {

  const { user } = useContext(AUTHContext);
  const { data, loading, error } = useFetch(`/bookings/users/${user._id}`);
  console.log(data);
  return (
    <div className="myBooking">
      {loading ? (
        "Loading"
      ) : error ? (
        <div>Error: {error.message}</div>
      ) : (<>
          {data && data.map((item) => (
            <div className="fpItem" key={item._id} > 
            {/* onClick={handleClick(item._id)} */}
              <span className="fpName">User : {item.user}</span>
              <span className="fpCity">Hotel : {item.hotel}</span>
              <span className="fpCity">Check in : {item.check_in}</span>
              <span className="fpCity">Check out : {item.check_out}</span>
              <span className="fpCity">Status : {item.status}</span>
            </div>
          ))}
          </>
      )}
    </div>

  )
}

export default MyBooking


import useFetch from "../../hooks/useFetch";
import { useNavigate } from 'react-router-dom';
import "./featured.css";
import { useContext } from "react";
import { SearchContext } from "../../context/SearchContext";

const Featured = () => {
  const { data, loading, error } = useFetch(
    "/hotels/City"
  );

  const { dispatch } = useContext(SearchContext);

  const navigate = useNavigate();

  const handleNavigate = (city) => {
    const defaultDates = [
      {
        startDate: new Date(),
        endDate: new Date(),
        key: "selection",
      },
    ];
    const defaultOptions = {
      adult: 1,
      children: 0,
      room: 1,
    };
    
    dispatch({ type: "NEW_SEARCH", payload: { destination: city, dates: defaultDates, options: defaultOptions } });
    navigate("/hotels", { state: { destination: city, dates: defaultDates, options: defaultOptions } });
  };

  return (
    <div className="featured">
      {loading ? (
        "Loading please wait"
      ) : (
        <>
        {data && data.map((item) => (
          <div className="featuredItem" onClick={() => handleNavigate(item.city)}>
            <img
              src="https://cf.bstatic.com/xdata/images/city/max500/957801.webp?k=a969e39bcd40cdcc21786ba92826063e3cb09bf307bcfeac2aa392b838e9b7a5&o="
              alt=""
              className="featuredImg"
            />
            <div className="featuredTitles">
              <h1>{item.city}</h1>
              <h2>{item.count} properties</h2>
            </div>
          </div>
        ))}
        </>
      )}
    </div>
  );
};

export default Featured;

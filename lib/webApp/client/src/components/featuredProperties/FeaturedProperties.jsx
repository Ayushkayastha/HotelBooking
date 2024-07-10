import React from 'react';
import useFetch from "../../hooks/useFetch";
import "./featuredProperties.css";
import Carousel from 'react-multi-carousel';
import 'react-multi-carousel/lib/styles.css';
import { useNavigate } from 'react-router-dom';

const FeaturedProperties = () => {
  const navigate = useNavigate();
  const { data, loading, error } = useFetch("/hotels?featured=true");

 
  const responsive = {
    superLargeDesktop: {
      // the naming can be any, depends on you.
      breakpoint: { max: 4000, min: 3000 },
      items: 5
    },
    desktop: {
      breakpoint: { max: 3000, min: 800},
      items: 3
    },
    tablet: {
      breakpoint: { max: 800, min: 464 },
      items: 2
    },
    mobile: {
      breakpoint: { max: 464, min: 0 },
      items: 2
    }
  };

  const handleClick = (id) => {
    navigate(`/hotels/${id}`);
  }

  return (
    <div className="featuredProperties">
      {loading ? (
        "Loading"
      ) : error ? (
        <div>Error: {error.message}</div>
      ) : (
        <Carousel infinite={true} responsive={responsive}>
          {data && data.map((item) => (
            <div className="fpItem" key={item._id} onClick={() => handleClick(item._id)}> 
            {/* onClick={handleClick(item._id)} */}
              <img src={item.photos[0]} alt="" className="fpImg" />
              <span className="fpName">{item.name}</span>
              <span className="fpCity">{item.city}</span>
              <span className="fpPrice">Starting from ${item.cheapestPrice}</span>
              {item.rating && (
                <div className="fpRating">
                  <button>{item.rating}</button>
                  <span>Excellent</span>
                </div>
              )}
            </div>
          ))}
        </Carousel>
      )}
    </div>
  );
};

export default FeaturedProperties;
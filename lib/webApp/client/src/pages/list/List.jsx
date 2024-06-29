import "./list.css";
import Navbar from "../../components/navbar/Navbar";
import Header from "../../components/header/Header";
import { useLocation } from "react-router-dom";
import { useContext, useEffect, useState } from "react";
import { format } from "date-fns";
import { DateRange } from "react-date-range";
import SearchItem from "../../components/searchItem/SearchItem";
import useFetch from "../../hooks/useFetch";
import { SearchContext } from "../../context/SearchContext";

const List = () => {
  const location = useLocation();
  const defaultDates = location.state.dates || [
    {
      startDate: new Date(),
      endDate: new Date(),
      key: "selection",
    },
  ];
  const defaultOptions = location.state.options || {
    adult: 1,
    children: 0,
    room: 1,
  };

  const [destination, setDestination] = useState(location.state.destination || "");
  const [dates, setDates] = useState(defaultDates);
  const [openDate, setOpenDate] = useState(false);
  const [options, setOptions] = useState(defaultOptions);
  const [min, setMin] = useState(undefined);
  const [max, setMax] = useState(undefined);
  const { dispatch } = useContext(SearchContext);
  const [isSearchEnabled, setIsSearchEnabled] = useState(true);

  const { data, loading, error, reFetch } = useFetch(
    `/hotels?city=${destination}&min=${min || 0}&max=${max || 999}`
  );

  useEffect(() => {
    // Check if either dates or options have changed
 if (dates !== defaultDates || options !== defaultOptions) {
   // If either has changed, enable search
   setIsSearchEnabled(true);
 } else {
   // Otherwise, disable search
   setIsSearchEnabled(false);
 }
 },[dates, options]);

  const handleClick = () => {
    reFetch();
    handleSearch();
  };

  const handleSearch = () => {
    dispatch({ type: "NEW_SEARCH", payload: { destination, dates, options }});
    setIsSearchEnabled(false);
  };

  const handleOptionsChange = (optionName, value) => {
    setOptions({ ...options, [optionName]: value});
    setIsSearchEnabled("true");
  }

  const handleDatesChange = (ranges) => {
    setDates([ranges.selection]);
    setIsSearchEnabled(true);
  }

  return (
    <div>
      <Navbar />
      <Header type="list" />
      <div className="listContainer">
        <div className="listWrapper">
          <div className="listSearch">
            <h1 className="lsTitle">Search</h1>
            <div className="lsItem">
              <label>Destination</label>
              <input
                placeholder={destination}
                onChange={(e) => setDestination(e.target.value)}
                type="text"
              />
            </div>
            <div className="lsItem">
              <label>Check-in Date</label>
              <span onClick={() => setOpenDate(!openDate)}>{`${format(
                dates[0].startDate,
                "MM/dd/yyyy"
              )} to ${format(dates[0].endDate, "MM/dd/yyyy")}`}</span>
              {openDate && (
                <DateRange
                  onChange={(item) => handleDatesChange(item)}
                  minDate={new Date()}
                  ranges={dates}
                />
              )}
            </div>
            <div className="lsItem">
              <label>Options</label>
              <div className="lsOptions">
                <div className="lsOptionItem">
                  <span className="lsOptionText">
                    Min price <small>per night</small>
                  </span>
                  <input
                    type="number"
                    onChange={(e) => setMin(e.target.value)}
                    className="lsOptionInput"
                  />
                </div>
                <div className="lsOptionItem">
                  <span className="lsOptionText">
                    Max price <small>per night</small>
                  </span>
                  <input
                    type="number"
                    onChange={(e) => setMax(e.target.value)}
                    className="lsOptionInput"
                  />
                </div>
                <div className="lsOptionItem">
                  <span className="lsOptionText">Adult</span>
                  <input
                    type="number"
                    min={1}
                    className="lsOptionInput"
                    value={options.adult}
                    onChange={(e) => handleOptionsChange('adult', e.target.value)}
                  />
                </div>
                <div className="lsOptionItem">
                  <span className="lsOptionText">Children</span>
                  <input
                    type="number"
                    min={0}
                    className="lsOptionInput"
                    value={options.children}
                    onChange={(e) => handleOptionsChange('children',e.target.value)}
                  />
                </div>
                <div className="lsOptionItem">
                  <span className="lsOptionText">Room</span>
                  <input
                    type="number"
                    min={1}
                    className="lsOptionInput"
                    value={options.room}
                    onChange={(e) => handleOptionsChange('room', e.target.value )}
                  />
                </div>
              </div>
            </div>
            {isSearchEnabled && (
              <div className="searchPrompt">
                Please press the search button to update results.
              </div>
            )}
            <button onClick={handleClick} disabled = {!isSearchEnabled}>Search</button>
          </div>
          <div className="listResult">
            {loading ? (
              "Loading"
            ) : (
              <>
                {data.map((item) => (
                  <SearchItem item={item} key={item._id} />
                ))}
              </>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default List;

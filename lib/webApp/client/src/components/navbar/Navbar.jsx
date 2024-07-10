import { useContext, useState } from "react";
import "./navbar.css";
import { AUTHContext } from "../../context/AuthContext";
import { useNavigate } from "react-router-dom";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faUser } from "@fortawesome/free-solid-svg-icons";

const Navbar = () => {
  const { user } = useContext(AUTHContext);
  const navigate = useNavigate();
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  

  const handleLogin = () => {
    setIsAuthenticated(true);
  };

  //console.log("user",user);
  // console.log("username",user.username);
  // console.log("details",user.details.username);
  
  const deleteCookie = (name) => {
    document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/';
}
  const handleLogout = () => {
    setIsAuthenticated(false);
    localStorage.removeItem('user');
    deleteCookie('accessToken');
    window.location.reload();
  };

  

  const handleClick = () => {
    navigate('/');
  };

  const loginClick = () => {
    navigate("/login")
  }
  const registerClick = () => {
    navigate("/register")
  }

  const handleBooking = (e) => {
  e.preventDefault();
  navigate("/MyBooking")
  }

  return (
    <div className="navbar">
      <div className="navContainer">
        <span className="logo" onClick={handleClick}><h2>FIZZY</h2></span>
        {user ? (
          <UserMenu onLogout={handleLogout} onBooking={handleBooking} user={user} />
        ) : (
          <div className="navItems">
            <button className="navButton" onClick={registerClick}>Register</button>
            <button className="navButton" onClick={loginClick}>Login</button>
          </div>
        )}
      </div>
    </div>
  );
};

const UserMenu = ({ user, onLogout, onBooking }) => {
  const [dropdownOpen, setDropdownOpen] = useState(false);

  const toggleDropdown = () => {
    setDropdownOpen(!dropdownOpen);
  };

  return (
    <div className="user-menu">
      <div onClick={toggleDropdown} className="user-icon">
        <FontAwesomeIcon icon={faUser} />
        <span>{user.username}</span>
      </div>
      {dropdownOpen && <DropDownProfile onBooking={onBooking} onLogout={onLogout} />}
    </div>
  );
};

const DropDownProfile = ({ onBooking, onLogout }) => {
  return (
    <div className="dropDownProfile">
      <ul className="dropDownProfileul">
        <li>Profile</li>
        <li onClick={onBooking}>Bookings</li>
        <li>Reviews</li>
        <li>Settings</li>
        <li onClick={onLogout}>Logout</li>
      </ul>
    </div>
  );
};

export default Navbar;

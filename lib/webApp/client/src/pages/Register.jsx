import { useContext, useState } from "react";
import "./Register.css";
import { AUTHContext } from "../context/AuthContext";
import axios from "axios";
import { useNavigate } from "react-router-dom";

const Register = () => {
  const [credentials, setCredentials] = useState({
    username: "",
    email: "",
    password: "",
    confirmPassword: "",
    country: "",
    city: "",
    phone: "",
  });

  const [errors, setErrors] = useState({});
  const { loading, error, dispatch } = useContext(AUTHContext);
  const navigate = useNavigate();

  const validateEmail = (email) => {
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailPattern.test(email);
  };

  const validatePassword = (password) => {
    return password.length >= 8; 
  };

  const validatePhone = (phone) => {
    const phonePattern = /^\+?\d{10,15}$/;
    return phonePattern.test(phone);
  };

  const handleChange = (e) => {
    const { id, value } = e.target;
    setCredentials((prev) => ({ ...prev, [id]: value }));

    let newErrors = { ...errors };

    switch (id) {
      case "email":
        newErrors.email = validateEmail(value) ? "" : "Invalid email address.";
        break;
      case "password":
        newErrors.password = validatePassword(value) ? "" : "Password must be at least 6 characters long.";
        break;
      case "confirmPassword":
        newErrors.confirmPassword = value === credentials.password ? "" : "Passwords do not match.";
        break;
      case "phone":
        newErrors.phone = validatePhone(value) ? "" : "Invalid phone number.";
        break;
      default:
        break;
    }

    setErrors(newErrors);
  };

  const handleClick = async (e) => {
    e.preventDefault();

    const finalErrors = {
      ...errors,
      confirmPassword: credentials.confirmPassword === credentials.password ? "" : "Passwords do not match.",
    };

    if (Object.values(finalErrors).some((error) => error)) {
      setErrors(finalErrors);
      alert("Please correct the errors in the form.");
      return;
    }

    dispatch({ type: "REGISTER_START" });
    try {
      console.log(credentials);
      const res = await axios.post("/auth/register", credentials);
      dispatch({ type: "REGISTER_SUCCESS", payload: res.data });
      navigate("/");
    } catch (error) {
      dispatch({ type: "REGISTER_FAILURE", payload: error.response.data });
    }
  };

  return (
    <>
      <div className="login-container">
        <div className="login">
          <div className="lContainer">
            <input
              type="text"
              placeholder="Username"
              id="username"
              onChange={handleChange}
              className="lInput"
            />
            <input
              type="email"
              placeholder="Email"
              id="email"
              onChange={handleChange}
              className="lInput"
            />
            {errors.email && <span className="error">{errors.email}</span>}
            <input
              type="password"
              placeholder="Password"
              id="password"
              onChange={handleChange}
              className="lInput"
            />
            {errors.password && <span className="error">{errors.password}</span>}
            <input
              type="password"
              placeholder="Confirm Password"
              id="confirmPassword"
              onChange={handleChange}
              className="lInput"
            />
            {errors.confirmPassword && <span className="error">{errors.confirmPassword}</span>}
            <input
              type="text"
              placeholder="Country"
              id="country"
              onChange={handleChange}
              className="lInput"
            />
            <input
              type="text"
              placeholder="City"
              id="city"
              onChange={handleChange}
              className="lInput"
            />
            <input
              type="text"
              placeholder="Phone"
              id="phone"
              onChange={handleChange}
              className="lInput"
            />
            {errors.phone && <span className="error">{errors.phone}</span>}
            <button disabled={loading} onClick={handleClick} className="lButton">
              Register
            </button>
            {error && <span className="error">{error.message}</span>}
          </div>
        </div>
      </div>
    </>
  );
};

export default Register;

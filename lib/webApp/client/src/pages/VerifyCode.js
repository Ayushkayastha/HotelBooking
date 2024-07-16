import { useContext, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import { AUTHContext } from "../context/AuthContext";
import axios from "axios";
//import "./VerifyCode.css";

const VerifyCode = () => {
  const [verificationCode, setVerificationCode] = useState('');
  const { state } = useLocation();
  const { credentials } = state || {};
  const { dispatch } = useContext(AUTHContext);
  const navigate = useNavigate();

  const handleVerifyCode = async (e) => {
    e.preventDefault();
    console.log("verifycode.js")
    console.log(credentials)
    try {
      await axios.post("/auth/verifyCode", { email: credentials.email, code: verificationCode });
      await axios.post("/auth/register", credentials);
      alert('Verification successful. You can now login.');
      navigate("/login");
    } catch (error) {
      alert('Invalid verification code.');
    }
  };

  return (
    <div className="verify-container">
      <div className="verify">
        <div className="vContainer">
          <input
            type="text"
            placeholder="Verification Code"
            value={verificationCode}
            onChange={(e) => setVerificationCode(e.target.value)}
            className="vInput"
          />
          <button onClick={handleVerifyCode} className="vButton">
            Verify Code
          </button>
        </div>
      </div>
    </div>
  );
};

export default VerifyCode;

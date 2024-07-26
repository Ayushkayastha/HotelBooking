import Home from "./pages/home/Home";
import Login from "./pages/login/Login";
import List from "./pages/list/List";
import New from "./pages/new/New";
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import { userInputs } from "./formSource";
import { useContext } from "react";
import { AUTHContext } from "./context/AuthContext";
import { hotelColumns, roomColumns, userColumns, bookingColumns } from "./datatablesource";
import NewHotel from "./pages/newHotel/NewHotel";
import NewRoom from "./pages/newRoom/NewRoom";
import UpdateHotel from "./pages/updateHotel/UpdateHotel.jsx";
import UpdateUser from "./pages/updateUser/UpdateUser.jsx";
import UpdateRoom from "./pages/updateRoom/UpdateRoom.jsx"

function App() {

  const ProtectedRoute = ({children}) => {
    const {user} = useContext(AUTHContext)

    if(!user) {
      return <Navigate to="/login" />
    }

    return children;
  }

  return (
    <div>
      <BrowserRouter>
        <Routes>
          <Route path="/">
          <Route path="login" element={<Login />} />
            <Route 
            index element={
            <ProtectedRoute>
              <Home />
              </ProtectedRoute>
              } />
            <Route path="users">
              <Route 
              index 
              element={<ProtectedRoute>
              <List columns={userColumns}/>
              </ProtectedRoute>} />

              <Route
                path="update/:userId"
                element={<ProtectedRoute>
                  <UpdateUser />
                  </ProtectedRoute>
                }
              />

              <Route
                path="new"
                element={<ProtectedRoute>
                  
                  <New inputs={userInputs} title="Add New User" />
                  </ProtectedRoute>
                }
              />
            </Route>
            <Route path="hotels">
              <Route index element={<ProtectedRoute>
              <List columns={hotelColumns}/>
              </ProtectedRoute>} />
              
              <Route
                path="update/:hotelId"
                element={<ProtectedRoute>
                  <UpdateHotel />
                  </ProtectedRoute>
                }
              />

              <Route
                path="new"
                element={<ProtectedRoute>
                  <NewHotel />
                  </ProtectedRoute>
                }
              />
            </Route>
            <Route path="rooms">
              <Route index element={<ProtectedRoute>
              <List columns={roomColumns}/>
              </ProtectedRoute>} />

              <Route
                path="update/:roomId"
                element={<ProtectedRoute>
                  <UpdateRoom />
                  </ProtectedRoute>
                }
              />
             
              <Route
                path="new"
                element={<ProtectedRoute>
                  <NewRoom />
                  </ProtectedRoute>
                }
              />
            </Route>

            <Route path="bookings">
              <Route index element={<ProtectedRoute>
              <List columns={bookingColumns}/>
              </ProtectedRoute>} />
              </Route>

          </Route>
        </Routes>
      </BrowserRouter>
    </div>
  );
}

export default App;

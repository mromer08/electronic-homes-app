import { Routes, Route, HashRouter } from "react-router-dom";
import Login from "./pages/auth/Login";
import Home from "./pages/Home";
import Logout from "./pages/auth/Logout";
import Profile from "./pages/user/Profile";
import { Menu } from "./pages/user/Menu";
import { AuthProvider, AuthRoute } from "./pages/auth/auth";
import ControlUsuarios from "./pages/user/admin/ControlUsuarios";

const App = () => {
  return (
    <div className="App">
      <HashRouter>
        <AuthProvider>
          <Menu />
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/login" element={<Login/>} />
            <Route path="/logout" element={<AuthRoute><Logout/></AuthRoute>} />
            <Route path="/profile" element={<AuthRoute><Profile/></AuthRoute>} />
            <Route path="/usuarios" element={<AuthRoute><ControlUsuarios/></AuthRoute>} />
            <Route path="*" element={<p>Not found</p>} />
          </Routes>
        </AuthProvider>
      </HashRouter>
    </div>
  );
};

export default App;
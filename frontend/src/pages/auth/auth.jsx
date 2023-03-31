import axios from 'axios'
import React, { useContext } from 'react';
import { Navigate, useNavigate } from 'react-router-dom';


const url = 'http://localhost:8080/api/login'
const AuthContext = React.createContext();

function AuthProvider({ children }) {
  const navigate = useNavigate();
  const [empleado, setEmpleado] = React.useState(null);

  const login = async (user) => {
    const response = await axios.post(url,user);
    if (response.data.token === 'FAIL') {
        alert("Credenciales incorrectas!");
    }else{
        localStorage.token = response.data.token;
        localStorage.idEmpleado = response.data.empleado.id;
        setEmpleado(response.data.empleado);
        navigate('/profile');
    }

};
  
  const logout = () => {
    setEmpleado(null);
    navigate('/');
  };
  
  const auth = { empleado, login, logout };

  return (
    <AuthContext.Provider value={auth}>
      {children}
    </AuthContext.Provider>
  );
}

function useAuth() {
  const auth = React.useContext(AuthContext);
  return auth;
}

function AuthRoute(props) {
  const auth = useAuth();

  if (!auth.empleado) {
    return <Navigate to="/login" />;
  }

  return props.children;
}

export {
  AuthProvider,
  AuthRoute,
  useAuth,
};
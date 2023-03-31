import React from 'react'
import ListGroup from 'react-bootstrap/ListGroup';
import { NavLink } from 'react-router-dom';
import { useAuth } from '../auth/auth'


const Profile = () => {
    const auth = useAuth();
    return (
    <>
    <h1>Bienvenido</h1>
    <div>
    <p><b>Empleado: </b> {auth.empleado.nombre} </p>
    <p><b>Cargo: </b> {auth.empleado.rol.nombre} </p>
    <p><b>Sucursal: </b> {auth.empleado.sucursal.nombre} </p>
    </div>
    <h2>Acciones</h2>

    <ListGroup>
    {routes.map(route => {
        if (route.rol !== auth.empleado.rol.id) return null;
        return <ListGroup.Item>
            <NavLink key={route.text} to={route.to}>
                {route.text}
            </NavLink>
        </ListGroup.Item>;
    })}
    </ListGroup>

    </>
  );
}


const routes = [];
routes.push({
  to: '/usuarios',
  text: 'Control Usuarios',
  rol: 1,
});

export default Profile
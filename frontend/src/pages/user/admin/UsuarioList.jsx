import React from "react";
import Table from "react-bootstrap/Table";
import Button from 'react-bootstrap/Button';

const UsuarioList = ({usuarios, removeUsuario}) => {
  return (
    <Table striped bordered hover>
      <thead>
        <tr>
          <th>#</th>
          <th>Nombre</th>
          <th>Apellido</th>
          <th>Username</th>
          <th>Rol</th>
          <th>Sucursal</th>
          <th>Acciones</th>
        </tr>
      </thead>
      <tbody>
        {usuarios.map((usuario) => {
          const empleado = usuario.empleado;

          return (
            <tr key={empleado.id}>
              <th>{empleado.id}</th>
              <th>{empleado.nombre}</th>
              <th>{empleado.apellido}</th>
              <th>{usuario.nombre}</th>
              <th>{empleado.rol.nombre}</th>
              <th>{empleado.sucursal.nombre}</th>
              <th>
              <Button variant="primary">Modificar</Button>
              <Button variant="danger" onClick={() => removeUsuario(usuario.id, empleado.id)}>Eliminar</Button>
              </th>
            </tr>
          );
        })}
      </tbody>
    </Table>
  );
};

export default UsuarioList;

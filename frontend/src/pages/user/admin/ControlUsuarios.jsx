import React, { useEffect, useState } from "react";
import { deleteEmpleado, newEmpleado } from "./EmpleadoAPI";
import { deleteUsuario, getUsuarios, newUsuario } from "./UsuarioAPI";
import UsuarioForm from "./UsuarioForm";
import UsuarioList from "./UsuarioList";

const ControlUsuarios = () => {
  const [usuarios, setUsuarios] = useState([]);

  const addUsuario = async (usuarioData) => {
    const empleado = await newEmpleado({
      "nombre": usuarioData.nombre,
      "apellido": usuarioData.apellido,
      "fecha_contratacion": usuarioData.fechaContrato,
      "fecha_nacimiento": usuarioData.fechaNacimiento,
      "salario": usuarioData.salario,
      "rol": await getRol(usuarioData.rol),
      "sucursal": await getSucursal(usuarioData.sucursal),
    });

    newUsuario({
      "nombre": usuarioData.username,
      "password": usuarioData.password,
      "empleado": empleado
    });

    getUsuarios(setUsuarios);

  }

  const removeUsuario = async (idUsuario, idEmpleado) => {
    await deleteUsuario(idUsuario)
    const response = await deleteEmpleado(idEmpleado);
    alert(response);
    console.log('estoy haciendo desmadre')
    getUsuarios(setUsuarios);
  }

  useEffect(() => {
    getUsuarios(setUsuarios);
  }, []);

  return (
    <>
      <UsuarioForm
      onSubmit={addUsuario}
      />

      <UsuarioList usuarios={usuarios} removeUsuario={removeUsuario}/>
    </>
  );
};

export default ControlUsuarios;

import React, { useState } from "react";
import Button from "react-bootstrap/Button";
import Form from "react-bootstrap/Form";
import { Navigate } from "react-router-dom";
import { useAuth } from "./auth";

const Login = () => {
  const auth = useAuth();
  const [nombre, setNombre] = useState("");
  const [password, setPassword] = useState("");

  const handleSubmit = (e) => {
    e.preventDefault();

    auth.login({
      nombre: nombre,
      password: password,
    });
    setNombre("");
    setPassword("");
  };

  if (auth.empleado) {
    return <Navigate to="/profile" />
  }

  return (
    <Form onSubmit={handleSubmit}>
      <h1>INCIO DE SESION</h1>
      <Form.Group className="mb-3" controlId="formBasicEmail">
        <Form.Label>Username</Form.Label>
        <Form.Control
          name="nombre"
          value={nombre}
          type="text"
          placeholder="Ingresa tu username"
          onChange={(e) => setNombre(e.target.value)}
        />
      </Form.Group>
      <Form.Group className="mb-3" controlId="formBasicPassword">
        <Form.Label>Password</Form.Label>
        <Form.Control
          name="password"
          type="password"
          value={password}
          placeholder="Contrasena"
          onChange={(e) => setPassword(e.target.value)}
        />
      </Form.Group>
      <Button variant="primary" type="submit">
        Iniciar Sesion
      </Button>
    </Form>
  );
};

export default Login;

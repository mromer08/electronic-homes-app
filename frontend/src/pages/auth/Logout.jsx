import React from 'react'
import Button from "react-bootstrap/Button";
import Form from "react-bootstrap/Form";
import { useAuth } from './auth';

const Logout = () => {

    const auth = useAuth();

    const handleSubmit = (e) => {
        e.preventDefault();
        auth.logout();
    }
    return (
        <Form onSubmit={handleSubmit}>
          <h1>CERRAR SESION</h1>
          <Form.Group className="mb-3" controlId="formBasicEmail">
            <Form.Label>Seguro que quieres salir?</Form.Label>
          </Form.Group>
          <Button variant="danger" type="submit">
            Cerrar Sesion
          </Button>
        </Form>
      );
}

export default Logout
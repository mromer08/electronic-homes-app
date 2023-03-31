import React, { useState } from "react";
import Container from "react-bootstrap/Container";
import Row from "react-bootstrap/Row";
import Col from "react-bootstrap/Col";
import InputGroup from "react-bootstrap/InputGroup";
import Button from "react-bootstrap/Button";
import Form from "react-bootstrap/Form";
import { newEmpleado } from "./EmpleadoAPI";
import { newUsuario } from "./UsuarioAPI";
import { getRol } from "./RolApi";
import { getSucursal } from "./SucursalAPI";

const UsuarioForm = ({onSubmit, edit}) => {
  const [nombre, setNombre] = useState(edit?.nombre || "");
  const [apellido, setApellido] = useState(edit?.apellido || "");
  const [fechaContrato, setFechaContrato] = useState(edit?.fecha_contratacion || "");
  const [fechaNacimiento, setFechaNacimiento] = useState(edit?.fecha_nacimiento || "");
  const [salario, setSalario] = useState(edit?.salario || "");
  const [rol, setRol] = useState(edit?.rol.id || "");
  const [sucursal, setSucursal] = useState(edit?.sucursal.id || "");
  const [username, setUsername] = useState(edit?.username || "");
  const [password, setPassword] = useState("");


  const handleSubmit = async (e) => {
    e.preventDefault();

    onSubmit({
      "id": edit.id || null,
      "nombre": nombre,
      "apellido": apellido,
      "fecha_contratacion": fechaContrato,
      "fecha_nacimiento": fechaNacimiento,
      "salario": salario,
      "rol": rol,
      "sucursal": sucursal,
      "username": username,
      "password": password,
    });

    setNombre('');
    setApellido('');
    setFechaContrato('');
    setFechaNacimiento('');
    setSalario('');
    setRol('');
    setSucursal('');
    setUsername('');
    setPassword('');
  };

  return (
    <Form>
      <h2>Registrar Empleado</h2>
      <Container>
        <Row>
          <Col xs lg="4">
            <Form.Group className="mb-3" controlId="formBasicEmail">
              <Form.Label>Nombre</Form.Label>
              <Form.Control
                type="text"
                placeholder="Nombre"
                value={nombre}
                onChange={(e) => setNombre(e.target.value)}
              />
            </Form.Group>
          </Col>
          <Col xs lg="4">
            <Form.Group className="mb-3" controlId="formBasicEmail">
              <Form.Label>Apellido</Form.Label>
              <Form.Control
                type="text"
                placeholder="Apellido"
                value={apellido}
                onChange={(e) => setApellido(e.target.value)}
              />
            </Form.Group>
          </Col>
          <Col xs lg="2">
            <Form.Group className="mb-3" controlId="formBasicEmail">
              <Form.Label>Salario</Form.Label>

              <InputGroup>
                <InputGroup.Text id="inputGroupPrepend">Q.</InputGroup.Text>
                <Form.Control
                  type="number"
                  placeholder="1000.00"
                  step="0.01"
                  min="0"
                  value={salario}
                  onChange={(e) => setSalario(e.target.value)}
                />
              </InputGroup>
            </Form.Group>
          </Col>
        </Row>
        <Row>
          <Col xs lg="2">
            <Form.Group className="mb-2" controlId="formBasicEmail">
              <Form.Label>Fecha Contratacion</Form.Label>
              <Form.Control
              type="date"
              placeholder="yyyy-mm-dd"
              value={fechaContrato}
              onChange={(e) => setFechaContrato(e.target.value)}
              />
            </Form.Group>
          </Col>
          <Col xs lg="2">
            <Form.Group className="mb-2" controlId="formBasicEmail">
              <Form.Label>Fecha Nacimiento</Form.Label>
              <Form.Control
              type="date"
              placeholder="yyyy-mm-dd"
              value={fechaNacimiento}
              onChange={(e) => setFechaNacimiento(e.target.value)}
              />
            </Form.Group>
          </Col>
          <Col xs lg="3">
            <Form.Group className="mb-3" controlId="formBasicEmail">
              <Form.Label>Sucursal</Form.Label>
              <select
                className="form-select"
                aria-label="Default select example"
                value={sucursal}
                onChange={(e) => setSucursal(e.target.value)}
              >
                <option value="1">Sucursal Central</option>
                <option value="2">Sucursal Norte</option>
                <option value="3">Sucursal Sur</option>
              </select>
            </Form.Group>
          </Col>
          <Col xs lg="3">
            <Form.Group className="mb-3" controlId="formBasicEmail">
              <Form.Label>Rol</Form.Label>
              <select
                className="form-select"
                aria-label="Default select example"
                value={rol}
                onChange={(e) => setRol(e.target.value)}
              >
                <option value="1">ADMIN</option>
                <option value="2">BODEGUERO</option>
                <option value="3">INVENTARIO</option>
                <option value="3">VENDEDOR</option>
              </select>
            </Form.Group>
          </Col>
        </Row>
        <Row>
          <Col xs lg="2">
            <Form.Group className="mb-2" controlId="formBasicEmail">
              <Form.Label>Username</Form.Label>
              <Form.Control
              type="text"
              placeholder="username"
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              />
            </Form.Group>
          </Col>
          <Col xs lg="2">
            <Form.Group className="mb-2" controlId="formBasicEmail">
              <Form.Label>Contraseña</Form.Label>
              <Form.Control
              type="password"
              placeholder="****"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              />
            </Form.Group>
          </Col>
        </Row>
        <Button variant="success" onClick={handleSubmit}>
          Registrar
        </Button>
      </Container>
    </Form>
  );
};

export default UsuarioForm;

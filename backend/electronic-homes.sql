-- 202030799 MANUEL ANTONIO ROJAS PAXTOR
-- CREACION DE LA BASE DE DATOS, ESQUEMAS Y TABLAS
CREATE DATABASE electronic_homes;
-- \c electronic_homes
CREATE SCHEMA Ventas;
CREATE SCHEMA Inventarios;
CREATE SCHEMA Usuarios;
CREATE SCHEMA Empleados;
CREATE SCHEMA Sucursales;
CREATE SCHEMA Clientes;

CREATE TABLE Marca(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
);

CREATE TABLE Producto(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    precio DECIMAL(8,2) NOT NULL,
    nit VARCHAR(10) NOT NULL,
    id_marca INTEGER NOT NULL,
    FOREIGN KEY (id_marca) REFERENCES Marca (id)
);

CREATE TABLE Direccion(
    id SERIAL PRIMARY KEY,
    direccion VARCHAR(50) DEFAULT NULL,
    municipio VARCHAR(50) NOT NULL,
    departamento VARCHAR(50) NOT NULL,
);

CREATE TABLE Clientes.Cliente(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    nit VARCHAR(10) UNIQUE NOT NULL
);

CREATE TABLE Sucursales.Sucursal(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    id_direccion INTEGER NOT NULL,
    FOREIGN KEY (id_direccion) REFERENCES Direccion (id)
);

CREATE TABLE Empleados.Rol(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Empleados.Empleado(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_contratacion DATE NOT NULL DEFAULT CURRENT_DATE,
    fecha_nacimiento DATE NOT NULL,
    salario DECIMAL(5,2) NOT NULL DEFAULT 3500.00,
    id_rol INTEGER NOT NULL,
    id_sucursal INTEGER NOT NULL,
    FOREIGN KEY (id_rol) REFERENCES Empleados.Rol (id),
    FOREIGN KEY (id_sucursal) REFERENCES Sucursales.Sucursal (id)
);

CREATE TABLE Usuarios.Usuario(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    id_empleado INTEGER NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES Empleados.Empleado (id)
);

CREATE TABLE Inventarios.Bodega(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    id_direccion INTEGER NOT NULL,
    FOREIGN KEY (id_direccion) REFERENCES Direccion (id)
);

CREATE TABLE Inventarios.InventarioBodega(
    id SERIAL PRIMARY KEY,
    id_bodega INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (id_bodega) REFERENCES Inventarios.Bodega (id),
    FOREIGN KEY (id_producto) REFERENCES Producto (id)
);

CREATE TABLE Inventarios.InventarioSucursal(
    id SERIAL PRIMARY KEY,
    id_sucursal INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (id_sucursal) REFERENCES Sucursales.Sucursal (id),
    FOREIGN KEY (id_producto) REFERENCES Producto (id)
);

CREATE TABLE Ventas.Venta(
    id SERIAL PRIMARY KEY,
    id_empleado INTEGER NOT NULL,
    id_cliente INTEGER NOT NULL,
    fecha DATE NOT NULL DEFAULT CURRENT_DATE,
    FOREIGN KEY (id_empleado) REFERENCES Empleados.Empleado (id),
    FOREIGN KEY (id_cliente) REFERENCES Clientes.Cliente (id)
);

CREATE TABLE Ventas.DetalleVenta(
    id SERIAL PRIMARY KEY,
    id_venta INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (id_venta) REFERENCES Ventas.Venta (id),
    FOREIGN KEY (id_producto) REFERENCES Producto (id)
);

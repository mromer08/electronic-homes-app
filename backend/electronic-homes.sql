-- 202030799 MANUEL ANTONIO ROJAS PAXTOR
-- CREACION DE LA BASE DE DATOS, ESQUEMAS Y TABLAS
CREATE DATABASE ElectronicHomes;
-- \c ElectronicHomes
CREATE SCHEMA ControlVentas;
CREATE SCHEMA ControlInventario;
CREATE SCHEMA ControlUsuarios;
CREATE SCHEMA ControlPersonal;
CREATE SCHEMA ControlSucursales;
CREATE SCHEMA ControlClientes;

CREATE TABLE ControlInventario.Marca(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE ControlInventario.Producto(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    precio DECIMAL(8,2) NOT NULL,
    id_marca INTEGER NOT NULL,
    FOREIGN KEY (id_marca) REFERENCES ControlInventario.Marca (id)
);

CREATE TABLE ControlSucursales.Direccion(
    id SERIAL PRIMARY KEY,
    direccion VARCHAR(50) DEFAULT NULL,
    municipio VARCHAR(50) NOT NULL,
    departamento VARCHAR(50) NOT NULL
);

CREATE TABLE ControlClientes.Cliente(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    nit VARCHAR(10) UNIQUE NOT NULL
);

CREATE TABLE ControlSucursales.Sucursal(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    id_direccion INTEGER NOT NULL,
    FOREIGN KEY (id_direccion) REFERENCES ControlSucursales.Direccion (id)
);

CREATE TABLE ControlPersonal.Rol(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE ControlPersonal.Empleado(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_contratacion DATE NOT NULL DEFAULT CURRENT_DATE,
    fecha_nacimiento DATE NOT NULL,
    salario DECIMAL(5,2) NOT NULL DEFAULT 3500.00,
    id_rol INTEGER NOT NULL,
    id_sucursal INTEGER NOT NULL,
    FOREIGN KEY (id_rol) REFERENCES ControlPersonal.Rol (id),
    FOREIGN KEY (id_sucursal) REFERENCES ControlSucursales.Sucursal (id)
);

CREATE TABLE ControlUsuarios.Usuario(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    id_empleado INTEGER NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES ControlPersonal.Empleado (id)
);

CREATE TABLE ControlInventario.Bodega(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    id_direccion INTEGER NOT NULL,
    FOREIGN KEY (id_direccion) REFERENCES ControlSucursales.Direccion (id)
);

CREATE TABLE ControlInventario.InventarioBodega(
    id SERIAL PRIMARY KEY,
    id_bodega INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (id_bodega) REFERENCES ControlInventario.Bodega (id),
    FOREIGN KEY (id_producto) REFERENCES ControlInventario.Producto (id)
);

CREATE TABLE ControlInventario.InventarioSucursal(
    id SERIAL PRIMARY KEY,
    id_sucursal INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (id_sucursal) REFERENCES ControlSucursales.Sucursal (id),
    FOREIGN KEY (id_producto) REFERENCES ControlInventario.Producto (id)
);

CREATE TABLE ControlVentas.Venta(
    id SERIAL PRIMARY KEY,
    id_empleado INTEGER NOT NULL,
    id_cliente INTEGER NOT NULL,
    fecha DATE NOT NULL DEFAULT CURRENT_DATE,
    FOREIGN KEY (id_empleado) REFERENCES ControlPersonal.Empleado (id),
    FOREIGN KEY (id_cliente) REFERENCES ControlClientes.Cliente (id)
);

CREATE TABLE ControlVentas.DetalleVenta(
    id SERIAL PRIMARY KEY,
    id_venta INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (id_venta) REFERENCES ControlVentas.Venta (id),
    FOREIGN KEY (id_producto) REFERENCES ControlInventario.Producto (id)
);

-- CREACION DE ROL ADMINISTRADOR (salir de la base de datos)
CREATE ROLE AdminEH;
GRANT CONNECT ON DATABASE ElectronicHomes TO AdminEH;

-- DANDO PERMISOS, TRABAJANDO EN LA BASE DE DATOS
-- \c ElectronicHomes
GRANT USAGE ON ALL SCHEMAS IN DATABASE ElectronicHomes TO AdminEH;


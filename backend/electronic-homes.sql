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
GRANT ALL ON SCHEMA ControlVentas, ControlInventario, ControlUsuarios, ControlPersonal, ControlSucursales, ControlClientes TO AdminEH;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON ALL TABLES IN SCHEMA ControlVentas, ControlInventario, ControlUsuarios, ControlPersonal, ControlSucursales, ControlClientes TO AdminEH;
CREATE USER SAminEH WITH PASSWORD 'admin1234';
-- ASIGNANDO ROL A USUARIO CREADO
GRANT AdminEH TO SAminEH;

-- Cambiar de usuario

/*
psql -U samineh electronichomes
*/

-- INSERSIONES DE MARCAS
insert into ControlInventario.Marca (nombre) values ('Toshiba');
insert into ControlInventario.Marca (nombre) values ('Samsung');
insert into ControlInventario.Marca (nombre) values ('Siemens');
insert into ControlInventario.Marca (nombre) values ('Whirlpool');
insert into ControlInventario.Marca (nombre) values ('General Electric');
insert into ControlInventario.Marca (nombre) values ('Sony');
insert into ControlInventario.Marca (nombre) values ('Panasonic');
insert into ControlInventario.Marca (nombre) values ('General Electric');
insert into ControlInventario.Marca (nombre) values ('Bosch');
insert into ControlInventario.Marca (nombre) values ('LG');

-- INSERSIONES DE PRODUCTOS
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Refrigerador', 2212.75, 1);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Lavadora', 2918.5, 2);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Secadora', 4677.38, 1);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Horno', 2263.92, 1);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Microondas', 2723.75, 1);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Estufa', 3900.13, 9);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Campana extractora', 1787.78, 7);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Cafetera de filtro', 3467.41, 5);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Cafetera de capsulas', 802.79, 7);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Tostador', 1590.12, 7);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Licuadora', 4294.94, 7);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Batidora', 2865.53, 9);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Procesador de alimentos', 3659.88, 10);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Freidora electrica', 1744.02, 8);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Plancha de ropa', 4582.72, 7);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Aspiradora', 1939.52, 9);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Ventilador', 1606.0, 8);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Aire acondicionado', 2546.06, 5);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Calentador de agua', 2470.49, 7);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Purificador de aire', 4566.62, 3);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Hervidor electrico', 4701.67, 4);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Molinillo de cafe', 3329.13, 10);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Parrilla electrica', 1041.21, 8);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Arrocera electrica', 2882.17, 9);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Maquina de hacer pan', 508.06, 5);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Deshidratador de alimentos', 2183.01, 2);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Maquina de hacer helados', 1901.7, 7);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Robot de cocina', 4803.27, 8);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Batidora de mano', 4467.71, 8);
insert into ControlInventario.Producto (nombre, precio, id_marca) values ('Envasadora al vacio', 2975.64, 1);
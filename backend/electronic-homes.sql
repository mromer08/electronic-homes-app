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
    precio DECIMAL(10,2) NOT NULL,
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
    salario DECIMAL(10,2) NOT NULL DEFAULT 3500.00,
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

-- INSERSIONES DE DIRECCIONES
insert into ControlSucursales.Direccion (direccion, municipio, departamento) values ('6ta Avenida 5-10 Zona 2', 'Guatemala', 'Guatemala');
insert into ControlSucursales.Direccion (direccion, municipio, departamento) values ('7ma Calle 7-23 Zona 8', 'Flores', 'Peten');
insert into ControlSucursales.Direccion (direccion, municipio, departamento) values ('5ta Avenida 1-21 Zona 3', 'Tiquisate', 'Escuintla');

-- INSERSIONES DE CLIENTES
insert into ControlClientes.Cliente (nombre, apellido, nit) values ('C', 'F', 0);
insert into ControlClientes.Cliente (nombre, apellido, nit) values ('Allx', 'Stirley', 3738123193);
insert into ControlClientes.Cliente (nombre, apellido, nit) values ('Ema', 'Enterle', 3828947953);
insert into ControlClientes.Cliente (nombre, apellido, nit) values ('Bern', 'Alsina', 3475972292);
insert into ControlClientes.Cliente (nombre, apellido, nit) values ('Ollie', 'Cullon', 3263711263);
insert into ControlClientes.Cliente (nombre, apellido, nit) values ('Rossy', 'Hyde-Chambers', 3475446898);
insert into ControlClientes.Cliente (nombre, apellido, nit) values ('Ardyth', 'Parkhouse', 3946072500);
insert into ControlClientes.Cliente (nombre, apellido, nit) values ('Maryann', 'Ashplant', 3947883561);
insert into ControlClientes.Cliente (nombre, apellido, nit) values ('Delainey', 'Hendriks', 3303853849);
insert into ControlClientes.Cliente (nombre, apellido, nit) values ('Antony', 'Melross', 3559670229);
insert into ControlClientes.Cliente (nombre, apellido, nit) values ('Dalenna', 'Dadson', 3729357179);

-- INSERCIONES DE SUCURSALES
insert into ControlSucursales.Sucursal (nombre, id_direccion) values ('Sucursal Central', 1);
insert into ControlSucursales.Sucursal (nombre, id_direccion) values ('Sucursal Norte', 2);
insert into ControlSucursales.Sucursal (nombre, id_direccion) values ('Sucursal Sur', 3);

-- INSERSION DE ROLES
insert into ControlPersonal.Rol (nombre) values ('Administrador');
insert into ControlPersonal.Rol (nombre) values ('Bodeguero');
insert into ControlPersonal.Rol (nombre) values ('Encargado Inventario');
insert into ControlPersonal.Rol (nombre) values ('Vendedor');

-- INSERSION DE EMPLEADOS
insert into ControlPersonal.Empleado (nombre, apellido, fecha_contratacion, fecha_nacimiento, salario, id_rol, id_sucursal) values ('Zarla', 'Britland', '2022-04-03', '1996-03-15', 6015.79, 3, 1);
insert into ControlPersonal.Empleado (nombre, apellido, fecha_contratacion, fecha_nacimiento, salario, id_rol, id_sucursal) values ('Casey', 'Magnay', '2022-08-11', '2001-07-26', 6661.56, 3, 1);
insert into ControlPersonal.Empleado (nombre, apellido, fecha_contratacion, fecha_nacimiento, salario, id_rol, id_sucursal) values ('Roddie', 'Timperley', '2022-10-13', '2001-10-26', 7155.65, 3, 1);
insert into ControlPersonal.Empleado (nombre, apellido, fecha_contratacion, fecha_nacimiento, salario, id_rol, id_sucursal) values ('Peirce', 'Backes', '2022-11-10', '1992-03-15', 5017.43, 4, 1);
insert into ControlPersonal.Empleado (nombre, apellido, fecha_contratacion, fecha_nacimiento, salario, id_rol, id_sucursal) values ('Andres', 'Caplin', '2022-11-21', '1997-11-15', 5639.45, 4, 1);
insert into ControlPersonal.Empleado (nombre, apellido, fecha_contratacion, fecha_nacimiento, salario, id_rol, id_sucursal) values ('Kayley', 'Jerrard', '2022-10-12', '2002-01-31', 4935.47, 4, 2);
insert into ControlPersonal.Empleado (nombre, apellido, fecha_contratacion, fecha_nacimiento, salario, id_rol, id_sucursal) values ('Grata', 'Spickett', '2022-12-13', '1997-03-20', 6620.41, 4, 2);
insert into ControlPersonal.Empleado (nombre, apellido, fecha_contratacion, fecha_nacimiento, salario, id_rol, id_sucursal) values ('Marguerite', 'Bewley', '2022-10-29', '1994-04-24', 4460.14, 3, 2);
insert into ControlPersonal.Empleado (nombre, apellido, fecha_contratacion, fecha_nacimiento, salario, id_rol, id_sucursal) values ('Shaun', 'Cawt', '2022-05-29', '1995-10-20', 4606.32, 3, 2);
insert into ControlPersonal.Empleado (nombre, apellido, fecha_contratacion, fecha_nacimiento, salario, id_rol, id_sucursal) values ('Jarrett', 'Swinburne', '2023-03-10', '1992-12-10', 8281.08, 3, 2);
insert into ControlPersonal.Empleado (nombre, apellido, fecha_contratacion, fecha_nacimiento, salario, id_rol, id_sucursal) values ('Aimee', 'Jervis', '2022-05-10', '1995-11-11', 8230.83, 3, 3);
insert into ControlPersonal.Empleado (nombre, apellido, fecha_contratacion, fecha_nacimiento, salario, id_rol, id_sucursal) values ('Gare', 'Libreros', '2022-06-03', '1994-04-21', 7897.2, 3, 3);
insert into ControlPersonal.Empleado (nombre, apellido, fecha_contratacion, fecha_nacimiento, salario, id_rol, id_sucursal) values ('Caye', 'Wabe', '2022-06-20', '1993-06-25', 4692.89, 3, 3);
insert into ControlPersonal.Empleado (nombre, apellido, fecha_contratacion, fecha_nacimiento, salario, id_rol, id_sucursal) values ('Farr', 'Crossan', '2022-09-27', '1999-03-10', 7692.77, 4, 3);
insert into ControlPersonal.Empleado (nombre, apellido, fecha_contratacion, fecha_nacimiento, salario, id_rol, id_sucursal) values ('Jobyna', 'Charpin', '2022-11-19', '1993-10-19', 8781.99, 4, 3);
-- BODEGUEROS Y ADMIN

insert into ControlPersonal.Empleado (nombre, apellido, fecha_contratacion, fecha_nacimiento, salario, id_rol, id_sucursal) values ('Cobbie', 'Basant', '2022-10-15', '1999-11-23', 8001.99, 1, 1);
insert into ControlPersonal.Empleado (nombre, apellido, fecha_contratacion, fecha_nacimiento, salario, id_rol, id_sucursal) values ('Ahmad', 'Janusik', '2022-10-27', '1998-12-11', 7000.99, 2, 1);
insert into ControlPersonal.Empleado (nombre, apellido, fecha_contratacion, fecha_nacimiento, salario, id_rol, id_sucursal) values ('Tally', 'Kingman', '2022-10-27', '1998-12-11', 7000.99, 2, 1);
insert into ControlPersonal.Empleado (nombre, apellido, fecha_contratacion, fecha_nacimiento, salario, id_rol, id_sucursal) values ('Bev', 'Hun', '2022-10-27', '1998-12-11', 7000.99, 2, 1);
insert into ControlPersonal.Empleado (nombre, apellido, fecha_contratacion, fecha_nacimiento, salario, id_rol, id_sucursal) values ('Stefania', 'Wortman', '2022-10-27', '1998-12-11', 7000.99, 2, 1);

-- USUARIOS PENDIENTES POR TEMAS DE ENCRIPTACION


-- INSERTANDO BODEGA GENERAL
insert into ControlInventario.Bodega (nombre, id_direccion) values ('Bodega Central', 1);

-- INSERTANDO INVENTARIO BODEGA GENERAL
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 1, 16);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 2, 23);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 3, 20);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 4, 21);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 5, 20);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 6, 18);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 7, 30);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 8, 15);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 9, 24);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 10, 25);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 11, 27);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 12, 13);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 13, 12);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 14, 26);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 15, 15);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 16, 12);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 17, 15);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 18, 26);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 19, 20);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 20, 15);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 21, 22);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 22, 28);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 23, 17);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 24, 12);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 25, 11);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 26, 22);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 27, 26);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 28, 21);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 29, 11);
insert into ControlInventario.InventarioBodega (id_bodega, id_producto, cantidad) values (1, 30, 13);

-- INSERTANDO INVENTARIOS
-- SUCURSAL CENTRAL
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 1, 4);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 2, 4);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 3, 4);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 4, 2);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 5, 2);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 6, 10);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 7, 5);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 8, 6);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 9, 2);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 10, 7);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 11, 8);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 12, 1);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 13, 1);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 14, 6);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 15, 5);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 16, 5);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 17, 7);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 18, 8);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 19, 5);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 20, 4);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 21, 10);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 22, 1);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 23, 1);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 24, 3);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 25, 10);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 26, 6);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 27, 10);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 28, 1);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 29, 9);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 30, 5);

-- SUCURSAL DEL NORTE
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 1, 5);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 2, 10);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 3, 1);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 4, 3);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 5, 9);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 6, 5);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 7, 9);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 8, 10);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 9, 8);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 10, 5);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 11, 10);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 12, 8);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 13, 2);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 14, 1);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 15, 6);

-- SUCURSAL DEL SUR
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 1, 6);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 2, 8);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 3, 4);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 4, 2);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 5, 1);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 6, 7);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 7, 2);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 8, 1);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 9, 3);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 10, 3);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 11, 7);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 12, 9);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 13, 8);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 14, 7);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 15, 2);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 16, 9);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 17, 10);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 18, 8);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 19, 6);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 20, 6);
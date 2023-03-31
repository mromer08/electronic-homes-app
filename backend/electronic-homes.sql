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
    nombre VARCHAR(50) UNIQUE NOT NULL
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
    fecha_contratacion DATE DEFAULT CURRENT_DATE,
    fecha_nacimiento DATE NOT NULL,
    salario DECIMAL(10,2) NOT NULL DEFAULT 3500.00,
    id_rol INTEGER NOT NULL,
    id_sucursal INTEGER NOT NULL,
    FOREIGN KEY (id_rol) REFERENCES ControlPersonal.Rol (id),
    FOREIGN KEY (id_sucursal) REFERENCES ControlSucursales.Sucursal (id)
);

CREATE TABLE ControlUsuarios.Usuario(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(30) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    id_empleado INTEGER UNIQUE NOT NULL,
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
    descuento DECIMAL(5,2) DEFAULT 0.0,
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

-- -- CREACION DE ROL ADMINISTRADOR (salir de la base de datos)
-- CREATE ROLE AdminEH;
-- GRANT CONNECT ON DATABASE ElectronicHomes TO AdminEH;

-- -- DANDO PERMISOS, TRABAJANDO EN LA BASE DE DATOS
-- -- \c ElectronicHomes
-- GRANT ALL ON SCHEMA ControlVentas, ControlInventario, ControlUsuarios, ControlPersonal, ControlSucursales, ControlClientes TO AdminEH;

-- GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON ALL TABLES IN SCHEMA ControlVentas, ControlInventario, ControlUsuarios, ControlPersonal, ControlSucursales, ControlClientes TO AdminEH;
-- CREATE USER SAminEH WITH PASSWORD 'admin1234';
-- -- ASIGNANDO ROL A USUARIO CREADO
-- GRANT AdminEH TO SAminEH;

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
insert into ControlInventario.Marca (nombre) values ('Bosch');
insert into ControlInventario.Marca (nombre) values ('LG');
insert into ControlInventario.Marca (nombre) values ('Logitech');

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
insert into ControlClientes.Cliente (nombre, apellido, nit) values ('Consumidor', 'Final', 'C/F');
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
insert into ControlPersonal.Rol (nombre) values ('ADMIN');
insert into ControlPersonal.Rol (nombre) values ('BODEGUERO');
insert into ControlPersonal.Rol (nombre) values ('INVENTARIO');
insert into ControlPersonal.Rol (nombre) values ('VENDEDOR');

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
-- EMPLEADOS COMUNES
insert into ControlUsuarios.Usuario (nombre, password, id_empleado) values ('dclohessy0', '$argon2id$v=19$m=1024,t=1,p=1$kcRmMUQX1xGFyFNMcMj+ew$jOk9O0aqWwOhPZmpPDnIz8q2Djqf2Q0cMl83g3u41uQ', 1);
insert into ControlUsuarios.Usuario (nombre, password, id_empleado) values ('akinsman1', '$argon2id$v=19$m=1024,t=1,p=1$kcRmMUQX1xGFyFNMcMj+ew$jOk9O0aqWwOhPZmpPDnIz8q2Djqf2Q0cMl83g3u41uQ', 2);
insert into ControlUsuarios.Usuario (nombre, password, id_empleado) values ('qberthel2', '$argon2id$v=19$m=1024,t=1,p=1$kcRmMUQX1xGFyFNMcMj+ew$jOk9O0aqWwOhPZmpPDnIz8q2Djqf2Q0cMl83g3u41uQ', 3);
insert into ControlUsuarios.Usuario (nombre, password, id_empleado) values ('eingman3', '$argon2id$v=19$m=1024,t=1,p=1$kcRmMUQX1xGFyFNMcMj+ew$jOk9O0aqWwOhPZmpPDnIz8q2Djqf2Q0cMl83g3u41uQ', 4);
insert into ControlUsuarios.Usuario (nombre, password, id_empleado) values ('egrube4', '$argon2id$v=19$m=1024,t=1,p=1$kcRmMUQX1xGFyFNMcMj+ew$jOk9O0aqWwOhPZmpPDnIz8q2Djqf2Q0cMl83g3u41uQ', 5);
insert into ControlUsuarios.Usuario (nombre, password, id_empleado) values ('fsaffle5', '$argon2id$v=19$m=1024,t=1,p=1$kcRmMUQX1xGFyFNMcMj+ew$jOk9O0aqWwOhPZmpPDnIz8q2Djqf2Q0cMl83g3u41uQ', 6);
insert into ControlUsuarios.Usuario (nombre, password, id_empleado) values ('jjardein6', '$argon2id$v=19$m=1024,t=1,p=1$kcRmMUQX1xGFyFNMcMj+ew$jOk9O0aqWwOhPZmpPDnIz8q2Djqf2Q0cMl83g3u41uQ', 7);
insert into ControlUsuarios.Usuario (nombre, password, id_empleado) values ('bglasscock7', '$argon2id$v=19$m=1024,t=1,p=1$kcRmMUQX1xGFyFNMcMj+ew$jOk9O0aqWwOhPZmpPDnIz8q2Djqf2Q0cMl83g3u41uQ', 8);
insert into ControlUsuarios.Usuario (nombre, password, id_empleado) values ('bkorneluk8', '$argon2id$v=19$m=1024,t=1,p=1$kcRmMUQX1xGFyFNMcMj+ew$jOk9O0aqWwOhPZmpPDnIz8q2Djqf2Q0cMl83g3u41uQ', 9);
insert into ControlUsuarios.Usuario (nombre, password, id_empleado) values ('fledington9', '$argon2id$v=19$m=1024,t=1,p=1$kcRmMUQX1xGFyFNMcMj+ew$jOk9O0aqWwOhPZmpPDnIz8q2Djqf2Q0cMl83g3u41uQ', 10);
insert into ControlUsuarios.Usuario (nombre, password, id_empleado) values ('rmalcolmsona', '$argon2id$v=19$m=1024,t=1,p=1$kcRmMUQX1xGFyFNMcMj+ew$jOk9O0aqWwOhPZmpPDnIz8q2Djqf2Q0cMl83g3u41uQ', 11);
insert into ControlUsuarios.Usuario (nombre, password, id_empleado) values ('tlittrickb', '$argon2id$v=19$m=1024,t=1,p=1$kcRmMUQX1xGFyFNMcMj+ew$jOk9O0aqWwOhPZmpPDnIz8q2Djqf2Q0cMl83g3u41uQ', 12);
insert into ControlUsuarios.Usuario (nombre, password, id_empleado) values ('hblaisc', '$argon2id$v=19$m=1024,t=1,p=1$kcRmMUQX1xGFyFNMcMj+ew$jOk9O0aqWwOhPZmpPDnIz8q2Djqf2Q0cMl83g3u41uQ', 13);
insert into ControlUsuarios.Usuario (nombre, password, id_empleado) values ('mraithd', '$argon2id$v=19$m=1024,t=1,p=1$kcRmMUQX1xGFyFNMcMj+ew$jOk9O0aqWwOhPZmpPDnIz8q2Djqf2Q0cMl83g3u41uQ', 14);
insert into ControlUsuarios.Usuario (nombre, password, id_empleado) values ('jsheade', '$argon2id$v=19$m=1024,t=1,p=1$kcRmMUQX1xGFyFNMcMj+ew$jOk9O0aqWwOhPZmpPDnIz8q2Djqf2Q0cMl83g3u41uQ', 15);

-- ADMIN
insert into ControlUsuarios.Usuario (nombre, password, id_empleado) values ('admin', '$argon2id$v=19$m=1024,t=1,p=1$kcRmMUQX1xGFyFNMcMj+ew$jOk9O0aqWwOhPZmpPDnIz8q2Djqf2Q0cMl83g3u41uQ', 16);

-- BODEGUEROS
insert into ControlUsuarios.Usuario (nombre, password, id_empleado) values ('wgusneyg', '$argon2id$v=19$m=1024,t=1,p=1$kcRmMUQX1xGFyFNMcMj+ew$jOk9O0aqWwOhPZmpPDnIz8q2Djqf2Q0cMl83g3u41uQ', 17);
insert into ControlUsuarios.Usuario (nombre, password, id_empleado) values ('dretterh', '$argon2id$v=19$m=1024,t=1,p=1$kcRmMUQX1xGFyFNMcMj+ew$jOk9O0aqWwOhPZmpPDnIz8q2Djqf2Q0cMl83g3u41uQ', 18);
insert into ControlUsuarios.Usuario (nombre, password, id_empleado) values ('snixoni', '$argon2id$v=19$m=1024,t=1,p=1$kcRmMUQX1xGFyFNMcMj+ew$jOk9O0aqWwOhPZmpPDnIz8q2Djqf2Q0cMl83g3u41uQ', 19);
insert into ControlUsuarios.Usuario (nombre, password, id_empleado) values ('acaldowj', '$argon2id$v=19$m=1024,t=1,p=1$kcRmMUQX1xGFyFNMcMj+ew$jOk9O0aqWwOhPZmpPDnIz8q2Djqf2Q0cMl83g3u41uQ', 20);


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
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 1, 1);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 2, 10);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 3, 5);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 4, 7);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 5, 5);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 6, 3);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 7, 8);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 8, 8);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 9, 6);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 10, 1);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 11, 5);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 12, 10);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 13, 7);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 14, 2);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 15, 7);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 16, 10);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 17, 10);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 18, 6);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 19, 2);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 20, 2);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 21, 8);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 22, 8);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 23, 2);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 24, 3);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 25, 9);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 26, 1);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 27, 6);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 28, 3);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 29, 7);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (1, 30, 7);

-- SUCURSAL DEL NORTE
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 1, 8);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 2, 8);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 3, 10);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 4, 8);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 5, 8);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 6, 5);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 7, 1);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 8, 1);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 9, 4);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 10, 1);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 11, 2);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 12, 5);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 13, 3);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 14, 5);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 15, 6);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 16, 1);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 17, 4);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 18, 5);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 19, 2);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 20, 5);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 21, 6);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 22, 8);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 23, 8);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 24, 5);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (2, 25, 7);

-- SUCURSAL DEL SUR
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 1, 10);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 2, 10);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 3, 1);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 4, 8);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 5, 3);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 6, 8);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 7, 9);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 8, 5);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 9, 7);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 10, 5);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 11, 7);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 12, 8);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 13, 5);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 14, 6);
insert into ControlInventario.InventarioSucursal (id_sucursal, id_producto, cantidad) values (3, 15, 3);

-- INSERTANDO VENTAS
-- SUCURSAL CENTRAL
insert into ControlVentas.Venta (id_empleado, id_cliente, fecha, descuento) values (5, 1, '2022-04-10', 0.1);
-- DETALLE V1
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (1, 12, 4);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (1, 8, 4);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (1, 9, 3);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (1, 1, 2);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (1, 4, 4);

insert into ControlVentas.Venta (id_empleado, id_cliente, fecha, descuento) values (5, 2, '2022-10-31', 0.1);
-- DETALLE V2
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (2, 4, 4);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (2, 6, 5);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (2, 3, 5);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (2, 11, 2);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (2, 13, 3);

insert into ControlVentas.Venta (id_empleado, id_cliente, fecha, descuento) values (4, 4, '2022-12-03', 0.1);
-- DETALLE V3
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (3, 12, 4);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (3, 4, 2);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (3, 8, 2);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (3, 5, 3);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (3, 9, 5);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (3, 15, 5);

insert into ControlVentas.Venta (id_empleado, id_cliente, fecha, descuento) values (4, 6, '2023-01-08', 0.1);
-- DETALLE V4
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (4, 14, 3);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (4, 8, 1);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (4, 7, 2);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (4, 12, 2);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (4, 5, 3);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (4, 24, 5);

insert into ControlVentas.Venta (id_empleado, id_cliente, fecha, descuento) values (4, 11, '2022-05-09', 0.0);
-- DETALLE V5
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (5, 6, 3);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (5, 3, 3);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (5, 2, 4);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (5, 9, 2);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (5, 10, 1);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (5, 22, 4);

-- SUCURSAL NORTE
insert into ControlVentas.Venta (id_empleado, id_cliente, fecha, descuento) values (6, 4, '2022-05-04', 0.05);
-- DETALLE V1
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (6, 3, 2);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (6, 12, 3);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (6, 7, 2);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (6, 13, 4);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (6, 10, 1);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (6, 8, 5);

insert into ControlVentas.Venta (id_empleado, id_cliente, fecha, descuento) values (7, 3, '2023-02-24', 0.02);
-- DETALLE V2
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (7, 2, 2);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (7, 1, 2);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (7, 7, 1);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (7, 3, 5);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (7, 8, 3);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (7, 14, 1);

insert into ControlVentas.Venta (id_empleado, id_cliente, fecha, descuento) values (6, 10, '2022-10-24', 0.02);
-- DETALLE V3
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (8, 8, 5);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (8, 13, 3);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (8, 6, 5);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (8, 19, 1);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (8, 1, 5);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (8, 3, 1);

insert into ControlVentas.Venta (id_empleado, id_cliente, fecha, descuento) values (7, 7, '2023-02-01', 0.0);
-- DETALLE V4
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (9, 15, 2);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (9, 10, 2);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (9, 9, 4);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (9, 13, 3);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (9, 19, 5);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (9, 12, 2);

insert into ControlVentas.Venta (id_empleado, id_cliente, fecha, descuento) values (7, 6, '2023-02-15', 0.05);
-- DETALLE V5
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (10, 1, 1);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (10, 14, 1);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (10, 8, 2);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (10, 13, 5);

-- SUCURSAL SUR
insert into ControlVentas.Venta (id_empleado, id_cliente, fecha, descuento) values (14, 3, '2022-05-29', 0.05);
-- DETALLE V1
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (11, 13, 4);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (11, 14, 4);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (11, 1, 5);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (11, 3, 3);

insert into ControlVentas.Venta (id_empleado, id_cliente, fecha, descuento) values (14, 9, '2022-07-12', 0.1);
-- DETALLE V2
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (12, 7, 5);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (12, 1, 3);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (12, 9, 5);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (12, 5, 2);

insert into ControlVentas.Venta (id_empleado, id_cliente, fecha, descuento) values (14, 6, '2022-09-15', 0.1);
-- DETALLE V3
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (13, 12, 4);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (13, 4, 1);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (13, 3, 5);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (13, 1, 2);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (13, 13, 4);

insert into ControlVentas.Venta (id_empleado, id_cliente, fecha, descuento) values (15, 11, '2022-08-18', 0.02);
-- DETALLE V4
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (14, 11, 1);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (14, 9, 2);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (14, 14, 5);

insert into ControlVentas.Venta (id_empleado, id_cliente, fecha, descuento) values (15, 11, '2022-06-07', 0.05);
-- DETALLE V5
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (15, 4, 1);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (15, 9, 1);
insert into ControlVentas.DetalleVenta (id_venta, id_producto, cantidad) values (15, 1, 5);
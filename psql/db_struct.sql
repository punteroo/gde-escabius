DROP DATABASE escabius_db;
CREATE DATABASE escabius_db;

\c escabius_db

CREATE TABLE persona (
    nro_dni INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    apellido TEXT NOT NULL,
    telefono INTEGER NULL
);

CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    dni INTEGER REFERENCES Persona
);

CREATE TABLE cadete (
    id_cadete SERIAL PRIMARY KEY,
    dni INTEGER REFERENCES Persona
);

CREATE TABLE direccion (
    id_direccion SERIAL PRIMARY KEY,
    calle TEXT NOT NULL,
    numero INTEGER NOT NULL,
    departamento VARCHAR(6) NULL,
    piso SMALLINT NULL,
    descripcion TEXT NULL
);

CREATE TABLE direccion_cliente (
    id_direccion_cliente SERIAL PRIMARY KEY,
    id_direccion INTEGER REFERENCES Direccion,
    id_cliente INTEGER REFERENCES Cliente
);

CREATE TAbLE trago (
    id_trago SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    precio_unitario DECIMAL NOT NULL CHECK (precio_unitario > 0.0),
    descripcion TEXT NULL
);

CREATE TABLE pedido (
    id_pedido SERIAL PRIMARY KEY,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_direccion_cliente INTEGER REFERENCES DireccionCliente
);

CREATE TABLE detalle_pedido (
    id_pedido INTEGER REFERENCES Pedido,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    sub_total DECIMAL NOT NULL CHECK (sub_total > 0),
    id_trago INTEGER REFERENCES Trago
);

CREATE TABLE estado_delivery (
    id_estado SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL
);

CREATE TABLE delivery (
    id_delivery SERIAL PRIMARY KEY,
    estado INTEGER REFERENCES estado_delivery,
    id_cadete INTEGER REFERENCES cadete,
    id_pedido INTEGER REFERENCES pedido
);

CREATE TABLE venta (
    id_venta SERIAL PRIMARY KEY,
    id_pedido INTEGER REFERENCES pedido,
    total DECIMAL NOT NULL CHECK (total > 0.0)
);


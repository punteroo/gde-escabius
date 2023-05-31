DROP DATABASE escabius_db;
CREATE DATABASE escabius_db;

\c escabius_db

CREATE TABLE persona (
    nro_dni BIGINT PRIMARY KEY,
    nombre TEXT NOT NULL,
    apellido TEXT NOT NULL,
    telefono BIGINT NULL
);

INSERT INTO persona (nro_dni, nombre, apellido, telefono) VALUES
(42889232, 'Lucas', 'Maza', 3537669229),
(41929342, 'Santiago', 'Pedraza', 3534123322),
(42929332, 'Álvaro', 'Ibarra', 3534589232),
(44283923, 'Lucas', 'Palacios', 3534923211),
(44828332, 'Leopoldo', 'Martini', 3534668822),
(32982132, 'Luciano Pindu', 'Parruccia', 3534992123);

CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    dni BIGINT REFERENCES Persona
);

INSERT INTO cliente (dni) VALUES
(42889232), (41929342), (44283923), (44828332);

CREATE TABLE cadete (
    id_cadete SERIAL PRIMARY KEY,
    dni BIGINT REFERENCES Persona
);

INSERT INTO cadete (dni) VALUES
(42929332), (32982132);


CREATE TABLE direccion (
    id_direccion SERIAL PRIMARY KEY,
    calle TEXT NOT NULL,
    numero INTEGER NOT NULL,
    departamento VARCHAR(6) NULL,
    piso SMALLINT NULL,
    descripcion TEXT NULL
);

INSERT INTO direccion (calle, numero, departamento, piso, descripcion) VALUES
('San Juan', 1572, 'Z', 12, 'Departamento de 12 pisos'),
('Mendoza', 1232, NULL, NULL, 'Rejas negras y garage grande'),
('Mexico', 989, NULL, NULL, NULL),
('Mendoza', 1898, 'B', 5, 'Portón blanco con rejas negras');

CREATE TABLE direccion_cliente (
    id_direccion_cliente SERIAL PRIMARY KEY,
    id_direccion INTEGER REFERENCES Direccion,
    id_cliente INTEGER REFERENCES Cliente
);

INSERT INTO direccion_cliente (id_direccion, id_cliente) VALUES
(1, 1), (2, 2), (3, 3), (4, 4);

CREATE TAbLE trago (
    id_trago SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    precio_unitario DECIMAL NOT NULL,
    descripcion TEXT NULL
);

INSERT INTO trago (nombre, precio_unitario, descripcion) VALUES
('Fernet', 150.0, 'Fernet con coca'),
('Cerveza', 100.0, 'Cerveza rubia'),
('Vino', 200.0, 'Vino tinto'),
('Coca Cola', 50.0, 'Coca Cola'),
('Sprite', 50.0, 'Sprite'),
('Agua', 30.0, 'Agua mineral');

CREATE TABLE pedido (
    id_pedido SERIAL PRIMARY KEY,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_direccion_cliente INTEGER REFERENCES Direccion_Cliente
);

INSERT INTO pedido (id_direccion_cliente) VALUES
(1), (1),
(2), (2), (2), (2), (2),
(3),
(4), (4);

CREATE TABLE detalle_pedido (
    id_detalle_pedido SERIAL PRIMARY KEY,
    id_pedido INTEGER REFERENCES Pedido,
    cantidad INTEGER NOT NULL,
    sub_total DECIMAL NOT NULL,
    id_trago INTEGER REFERENCES Trago
);

INSERT INTO detalle_pedido (id_pedido, cantidad, sub_total, id_trago) VALUES
(1, 2, 300.0, 1),
(2, 1, 100.0, 2),
(3, 1, 200.0, 3),
(4, 1, 50.0, 4),
(5, 1, 50.0, 5),
(6, 1, 30.0, 6),
(7, 1, 100.0, 2),
(8, 1, 200.0, 3),
(9, 1, 50.0, 4),
(10, 1, 50.0, 5);

CREATE TABLE estado_delivery (
    id_estado SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL
);

INSERT INTO estado_delivery (nombre) VALUES
('En preparación'), ('En camino'), ('Entregado');

CREATE TABLE delivery (
    id_delivery SERIAL PRIMARY KEY,
    estado INTEGER REFERENCES Estado_Delivery,
    id_cadete INTEGER REFERENCES Cadete,
    id_pedido INTEGER REFERENCES Pedido
);

INSERT INTO delivery (estado, id_cadete, id_pedido) VALUES
(1, 2, 1),
(2, 2, 2),
(3, 2, 3),
(1, 2, 4),
(2, 2, 5),
(3, 2, 6),
(1, 2, 7),
(2, 2, 8),
(3, 2, 9),
(1, 2, 10);

CREATE TABLE venta (
    id_venta SERIAL PRIMARY KEY,
    id_pedido INTEGER REFERENCES Pedido,
    total DECIMAL NOT NULL
);

-- Insert 1 venta per pedido, with the total amount being calculated based on the detalle_pedido that a pedido has linked
INSERT INTO venta (id_pedido, total) VALUES
(1, (SELECT SUM(sub_total) FROM detalle_pedido WHERE id_pedido = 1)),
(2, (SELECT SUM(sub_total) FROM detalle_pedido WHERE id_pedido = 2)),
(3, (SELECT SUM(sub_total) FROM detalle_pedido WHERE id_pedido = 3)),
(4, (SELECT SUM(sub_total) FROM detalle_pedido WHERE id_pedido = 4)),
(5, (SELECT SUM(sub_total) FROM detalle_pedido WHERE id_pedido = 5)),
(6, (SELECT SUM(sub_total) FROM detalle_pedido WHERE id_pedido = 6)),
(7, (SELECT SUM(sub_total) FROM detalle_pedido WHERE id_pedido = 7)),
(8, (SELECT SUM(sub_total) FROM detalle_pedido WHERE id_pedido = 8)),
(9, (SELECT SUM(sub_total) FROM detalle_pedido WHERE id_pedido = 9)),
(10, (SELECT SUM(sub_total) FROM detalle_pedido WHERE id_pedido = 10));
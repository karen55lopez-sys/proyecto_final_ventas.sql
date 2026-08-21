-- =========================================================
-- PROYECTO FINAL - DATA ANALYST
-- MODELO DE VENTAS DE TECNOLOGÍA
-- =========================================================


-- =========================================================
-- 1. DEFINICIÓN DEL ESQUEMA (DDL)
-- =========================================================

-- Elimina las tablas si ya existen.
-- Esto permite volver a ejecutar el script desde cero.

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;


-- =========================================================
-- TABLA DE CATEGORÍAS
-- =========================================================

CREATE TABLE categorias (
    categoria_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);


-- =========================================================
-- TABLA DE PRODUCTOS
-- =========================================================

CREATE TABLE productos (
    producto_id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    precio NUMERIC(10,2) NOT NULL,
    categoria_id INTEGER NOT NULL,

    CONSTRAINT fk_producto_categoria
        FOREIGN KEY (categoria_id)
        REFERENCES categorias(categoria_id)
);


-- =========================================================
-- TABLA DE CLIENTES
-- =========================================================

CREATE TABLE clientes (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL,
    ciudad VARCHAR(100) NOT NULL
);


-- =========================================================
-- TABLA DE VENTAS
-- =========================================================

CREATE TABLE ventas (
    venta_id SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    cliente_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,

    CONSTRAINT fk_venta_cliente
        FOREIGN KEY (cliente_id)
        REFERENCES clientes(cliente_id),

    CONSTRAINT fk_venta_producto
        FOREIGN KEY (producto_id)
        REFERENCES productos(producto_id),

    CONSTRAINT chk_cantidad_positiva
        CHECK (cantidad > 0)
);


-- =========================================================
-- 2. CARGA INICIAL DE DATOS (DML)
-- =========================================================


-- =========================================================
-- CATEGORÍAS
-- =========================================================

INSERT INTO categorias (nombre)
VALUES
    ('Computación'),
    ('Celulares'),
    ('Accesorios');


-- =========================================================
-- PRODUCTOS
-- =========================================================

INSERT INTO productos (nombre, precio, categoria_id)
VALUES
    ('Notebook Lenovo IdeaPad', 850000.00, 1),
    ('Notebook HP 15', 920000.00, 1),
    ('PC Gamer Ryzen 5', 1250000.00, 1),
    ('Samsung Galaxy A55', 650000.00, 2),
    ('Xiaomi Redmi Note 13', 480000.00, 2),
    ('Auriculares Bluetooth', 85000.00, 3),
    ('Mouse inalámbrico Logitech', 45000.00, 3);


-- =========================================================
-- CLIENTES
-- =========================================================

INSERT INTO clientes (nombre, email, ciudad)
VALUES
    ('María López', 'maria.lopez@email.com', 'Santa Fe'),
    ('Juan Pérez', 'juan.perez@email.com', 'Ceres'),
    ('Lucía Gómez', 'lucia.gomez@email.com', 'Rosario'),
    ('Carlos Fernández', 'carlos.fernandez@email.com', 'Rafaela');


-- =========================================================
-- VENTAS
-- =========================================================

INSERT INTO ventas (fecha, cliente_id, producto_id, cantidad)
VALUES
    ('2026-08-01', 1, 1, 1),
    ('2026-08-02', 2, 4, 2),
    ('2026-08-03', 3, 6, 1),
    ('2026-08-04', 1, 5, 1),
    ('2026-08-05', 4, 2, 1),
    ('2026-08-06', 2, 7, 2),
    ('2026-08-07', 3, 3, 1),
    ('2026-08-08', 4, 4, 1),
    ('202
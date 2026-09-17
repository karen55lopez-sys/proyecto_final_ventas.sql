-- =========================================================
-- PROYECTO FINAL - DATA ANALYST
-- MODELO DE VENTAS DE TECNOLOGÍA
-- MÓDULO 3 - BASE DE DATOS
-- =========================================================


-- =========================================================
-- 1. ELIMINAR TABLAS SI YA EXISTEN
-- =========================================================

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS territorios;
DROP TABLE IF EXISTS categorias;


-- =========================================================
-- 2. TABLA DE CATEGORÍAS
-- =========================================================

CREATE TABLE categorias (
    categoria_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);


-- =========================================================
-- 3. TABLA DE TERRITORIOS
-- =========================================================

CREATE TABLE territorios (
    territorio_id SERIAL PRIMARY KEY,
    region VARCHAR(100) NOT NULL
);


-- =========================================================
-- 4. TABLA DE PRODUCTOS
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
-- 5. TABLA DE CLIENTES
-- =========================================================

CREATE TABLE clientes (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    segmento VARCHAR(50) NOT NULL,
    territorio_id INTEGER NOT NULL,
    fecha_registro DATE NOT NULL,

    CONSTRAINT fk_cliente_territorio
        FOREIGN KEY (territorio_id)
        REFERENCES territorios(territorio_id)
);


-- =========================================================
-- 6. TABLA DE VENTAS
-- =========================================================

CREATE TABLE ventas (
    venta_id SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    cliente_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    precio_unitario NUMERIC(10,2) NOT NULL,

    CONSTRAINT fk_venta_cliente
        FOREIGN KEY (cliente_id)
        REFERENCES clientes(cliente_id),

    CONSTRAINT fk_venta_producto
        FOREIGN KEY (producto_id)
        REFERENCES productos(producto_id),

    CONSTRAINT chk_cantidad_positiva
        CHECK (cantidad > 0),

    CONSTRAINT chk_precio_unitario_positivo
        CHECK (precio_unitario > 0)
);


-- =========================================================
-- 7. CARGA DE CATEGORÍAS
-- =========================================================

INSERT INTO categorias (nombre)
VALUES
    ('Computación'),
    ('Celulares'),
    ('Accesorios');


-- =========================================================
-- 8. CARGA DE TERRITORIOS
-- =========================================================

INSERT INTO territorios (region)
VALUES
    ('Centro'),
    ('Litoral'),
    ('Noroeste');


-- =========================================================
-- 9. CARGA DE PRODUCTOS
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
-- 10. CARGA DE CLIENTES
-- =========================================================

INSERT INTO clientes
    (nombre, email, ciudad, segmento, territorio_id, fecha_registro)
VALUES
    ('María López', 'maria.lopez@email.com', 'Santa Fe', 'Premium', 2, '2026-07-01'),
    ('Juan Pérez', 'juan.perez@email.com', 'Ceres', 'Minorista', 1, '2026-07-03'),
    ('Lucía Gómez', 'lucia.gomez@email.com', 'Rosario', 'Premium', 2, '2026-07-05'),
    ('Carlos Fernández', 'carlos.fernandez@email.com', 'Rafaela', 'Minorista', 1, '2026-07-08'),
    ('Ana Martínez', 'ana.martinez@email.com', 'Reconquista', 'Mayorista', 2, '2026-07-10');


-- =========================================================
-- 11. CARGA DE VENTAS
-- =========================================================

INSERT INTO ventas
    (fecha, cliente_id, producto_id, cantidad, precio_unitario)
VALUES
    ('2026-08-01', 1, 1, 1, 850000.00),
    ('2026-08-02', 2, 4, 2, 650000.00),
    ('2026-08-03', 3, 6, 1, 85000.00),
    ('2026-08-04', 1, 5, 1, 480000.00),
    ('2026-08-05', 4, 2, 1, 920000.00),
    ('2026-08-06', 2, 7, 2, 45000.00),
    ('2026-08-07', 3, 3, 1, 1250000.00),
    ('2026-08-08', 4, 4, 1, 650000.00);


-- =========================================================
-- FIN DEL SCRIPT
-- =========================================================

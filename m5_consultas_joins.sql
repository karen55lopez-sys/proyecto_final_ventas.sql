-- =========================================================
-- MÓDULO 5 - CONSULTAS CON JOINS
-- Cruzando tablas para enriquecer el análisis
-- =========================================================


-- =========================================================
-- CONSULTA 1 — VISTA BASE DEL PROYECTO
-- INNER JOIN entre ventas, clientes, productos,
-- categorías y territorios.
-- =========================================================

SELECT
    v.fecha,
    c.cliente_id,
    c.nombre AS nombre_cliente,
    c.segmento,
    t.region,
    p.producto_id,
    p.nombre AS nombre_producto,
    cat.nombre AS categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
FROM ventas v
INNER JOIN clientes c
    ON v.cliente_id = c.cliente_id
INNER JOIN productos p
    ON v.producto_id = p.producto_id
INNER JOIN categorias cat
    ON p.categoria_id = cat.categoria_id
INNER JOIN territorios t
    ON c.territorio_id = t.territorio_id;


-- =========================================================
-- CONSULTA 2 — CLIENTES SIN VENTAS
-- Identifica clientes registrados que nunca realizaron
-- una compra.
-- =========================================================

SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v
    ON c.cliente_id = v.cliente_id
WHERE v.cliente_id IS NULL;


-- =========================================================
-- CONSULTA 3 — PRODUCTOS SIN VENTAS
-- Identifica productos del catálogo que no tienen
-- ninguna venta registrada.
-- =========================================================

SELECT
    p.nombre AS nombre_producto,
    cat.nombre AS categoria,
    p.precio
FROM productos p
INNER JOIN categorias cat
    ON p.categoria_id = cat.categoria_id
LEFT JOIN ventas v
    ON p.producto_id = v.producto_id
WHERE v.producto_id IS NULL;


-- ============================================
-- CONSULTA 4: CONSOLIDADO POR CANAL
-- ============================================

SELECT
    canal,
    SUM(total_venta) AS total_facturado
FROM (
    SELECT
        v.fecha_venta,
        v.cantidad * v.precio_unitario AS total_venta,
        'Online' AS canal
    FROM ventas v
    WHERE v.fecha_venta BETWEEN '2024-03-05' AND '2024-03-09'

    UNION ALL

    SELECT
        v.fecha_venta,
        v.cantidad * v.precio_unitario AS total_venta,
        'Presencial' AS canal
    FROM ventas v
    WHERE v.fecha_venta BETWEEN '2024-03-10' AND '2024-03-15'
) AS ventas_por_canal
GROUP BY canal
ORDER BY canal;

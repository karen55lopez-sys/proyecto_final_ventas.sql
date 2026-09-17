-- ============================================
-- M5 - CONSULTAS CON JOIN
-- ============================================


-- ============================================
-- CONSULTA 1: VISTA ENRIQUECIDA DE VENTAS
-- ============================================

SELECT
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    t.region,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
FROM ventas v
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos p
    ON v.id_producto = p.id_producto
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria
INNER JOIN territorios t
    ON c.territorio_id = t.territorio_id;


-- ============================================
-- CONSULTA 2: CLIENTES SIN VENTAS
-- ============================================

SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v
    ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;


-- ============================================
-- CONSULTA 3: PRODUCTOS SIN VENTAS
-- ============================================

SELECT
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos p
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v
    ON p.id_producto = v.id_producto
WHERE v.id_producto IS NULL;


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

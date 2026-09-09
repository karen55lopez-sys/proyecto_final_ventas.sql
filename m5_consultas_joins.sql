SELECT
    v.fecha_venta,
    v.id_cliente,
    c.nombre AS nombre_cliente,
    p.nombre_producto,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
FROM ventas AS v
INNER JOIN clientes AS c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos AS p
    ON v.id_producto = p.id_producto
ORDER BY v.fecha_venta;
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v
    ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL
ORDER BY c.nombre;
SELECT
    p.nombre_producto,
    p.precio
FROM productos AS p
LEFT JOIN ventas AS v
    ON p.id_producto = v.id_producto
WHERE v.id_producto IS NULL
ORDER BY p.nombre_producto;
SELECT
    origen,
    SUM(total_venta) AS total_ventas
FROM
(
    SELECT
        cantidad * precio_unitario AS total_venta,
        'Primer semestre' AS origen
    FROM ventas
    WHERE EXTRACT(MONTH FROM fecha_venta) BETWEEN 1 AND 6

    UNION ALL

    SELECT
        cantidad * precio_unitario AS total_venta,
        'Segundo semestre' AS origen
    FROM ventas
    WHERE EXTRACT(MONTH FROM fecha_venta) BETWEEN 7 AND 12
) AS ventas_por_periodo
GROUP BY origen
ORDER BY origen;
SELECT
    origen,
    SUM(total_venta) AS total_ventas
FROM
(
    SELECT
        cantidad * precio_unitario AS total_venta,
        'Primer semestre' AS origen
    FROM ventas
    WHERE EXTRACT(MONTH FROM fecha_venta) BETWEEN 1 AND 6

    UNION ALL

    SELECT
        cantidad * precio_unitario AS total_venta,
        'Segundo semestre' AS origen
    FROM ventas
    WHERE EXTRACT(MONTH FROM fecha_venta) BETWEEN 7 AND 12
) AS ventas_por_periodo
GROUP BY origen
ORDER BY origen;
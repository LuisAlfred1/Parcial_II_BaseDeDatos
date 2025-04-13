--Script de preguntas practicas

--1.¿Cuál es el producto más vendido en nuestra clínica?
SELECT TOP 
1 p.nombre, 
SUM(fd.cantidad) AS total_vendidos
FROM parcialii.facturas_detalle fd
JOIN parcialii.producto as p ON fd.id_producto = p.id_producto
WHERE fd.naturaleza = 'B'
GROUP BY p.nombre
ORDER BY total_vendidos DESC;


--2.¿Cuál es el producto que ha generado la mayor ganancia en ventas?
SELECT TOP 1 
p.nombre, 
SUM((fd.precio - p.costo) * fd.cantidad) AS ganancia
FROM parcialii.facturas_detalle as fd
JOIN parcialii.producto as p ON fd.id_producto = p.id_producto
WHERE fd.naturaleza = 'B'
GROUP BY p.nombre
ORDER BY ganancia DESC;


--3.¿Cuál es el producto que ha generado la menor ganancia en ventas?
SELECT TOP 1 
p.nombre, 
SUM((fd.precio - p.costo) * fd.cantidad) AS ganancia
FROM parcialii.facturas_detalle as fd
JOIN parcialii.producto as p ON fd.id_producto = p.id_producto
WHERE fd.naturaleza = 'B'
GROUP BY p.nombre
ORDER BY ganancia ASC;


--4.¿Cuál es la cantidad total de productos que hemos vendido hasta la fecha?
SELECT 
SUM(fd.cantidad) AS total_productos
FROM parcialii.facturas_detalle fd
WHERE fd.naturaleza = 'B';


--5.¿Cuál es el cliente que ha provocado el mayor gasto en nuestros servicios?
SELECT TOP 1 
CONCAT(c.nombres,' ',c.apellidos) cliente, 
SUM(fd.total) AS gasto_total
FROM parcialii.factura_encabezado as fe
JOIN parcialii.facturas_detalle as fd ON fe.id_factura_encabezado = fd.id_factura_encabezado
JOIN parcialii.cliente as c ON fe.id_cliente = c.id_cliente
WHERE fd.naturaleza = 'S'
GROUP BY c.nombres, c.apellidos
ORDER BY gasto_total DESC;


--6. ¿Cuál es el cliente que nos ha generado mayor monto de compra?
SELECT TOP 1 
CONCAT(c.nombres,' ',c.apellidos) AS cliente,
SUM(fe.total) AS monto_total
FROM parcialii.factura_encabezado fe
JOIN parcialii.cliente c ON fe.id_cliente = c.id_cliente
GROUP BY c.nombres, c.apellidos
ORDER BY monto_total DESC;


/*
7. ¿Podrías proporcionarme un listado de nuestros clientes junto con sus edades, y además un reporte de cuántos
clientes tenemos en cada rango de edad?
*/

--Clientes con sus edades
SELECT 
CONCAT(c.nombres,' ',c.apellidos) AS cliente,
DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) AS edad
FROM parcialii.cliente as c

--Reportes de clientes por rango de edad
SELECT 
  CASE 
    WHEN DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) BETWEEN 18 AND 25 THEN '18-25 años'
    WHEN DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) BETWEEN 26 AND 35 THEN '26-35 años'
    WHEN DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) BETWEEN 36 AND 45 THEN '36-45 años'
    WHEN DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) BETWEEN 46 AND 65 THEN '46-65 años'
    ELSE 'Más de 66 años'
  END AS rango_edad,
  COUNT(*) AS total_clientes
FROM parcialii.cliente
GROUP BY 
  CASE 
    WHEN DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) BETWEEN 18 AND 25 THEN '18-25 años'
    WHEN DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) BETWEEN 26 AND 35 THEN '26-35 años'
    WHEN DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) BETWEEN 36 AND 45 THEN '36-45 años'
    WHEN DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) BETWEEN 46 AND 65 THEN '46-65 años'
    ELSE 'Más de 66 años'
  END;


--8.¿Cuál es el total de ventas que hemos realizado cada mes?
SELECT 
FORMAT(fe.fecha, 'yyyy-MM') AS mes,
SUM(fe.total) AS total_ventas
FROM parcialii.factura_encabezado fe
GROUP BY FORMAT(fe.fecha, 'yyyy-MM')
ORDER BY mes;


--9. ¿Cuál es el promedio de ventas por cliente en nuestra clínica?
SELECT 
  AVG(total_por_cliente) AS promedio_ventas
FROM (
  SELECT id_cliente, 
  SUM(total) AS total_por_cliente
  FROM parcialii.factura_encabezado
  GROUP BY id_cliente
) AS sub;

--10.¿Quién es el empleado que ha realizado más ventas en nuestra clínica?
SELECT TOP 1 
CONCAT(e.nombre,' ', e.apellidos) AS empleado,
COUNT(*) AS total_ventas
FROM parcialii.facturas_detalle as fd
JOIN parcialii.empleado as e ON fd.id_vendedor = e.id_empleado
GROUP BY e.nombre, e.apellidos
ORDER BY total_ventas DESC;


--11.¿Cuál es el total de ingresos que hemos generado en cada año y mes?
SELECT 
YEAR(fe.fecha) AS año,
MONTH(fe.fecha) AS mes,
SUM(fe.total) AS total_ingresos
FROM parcialii.factura_encabezado as fe
GROUP BY YEAR(fe.fecha), MONTH(fe.fecha)
ORDER BY año, mes;

--12.¿Cuál es el promedio de precio de nuestros productos por marca?
SELECT 
id_marca,
AVG(precio) AS precio_promedio
FROM parcialii.producto
GROUP BY id_marca;



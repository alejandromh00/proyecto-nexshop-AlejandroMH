-- =============================================================
--  NexShop Group S.A. — consultas.sql
--  14 consultas con lógica de negocio real
--  Autor : Alejandro Morales Hermosín
--  Motor  : MySQL 8.x / MariaDB 10.6+
--  Ejecutar con nexshop activo: USE nexshop;
-- =============================================================

USE nexshop;


-- ─────────────────────────────────────────────────────────────
-- CONSULTA 1
-- Muestra todos los registros de la tabla Empleado.
-- Útil para el departamento de RRHH como listado completo
-- del personal con su sede y cargo asignado.
-- ─────────────────────────────────────────────────────────────
SELECT *
FROM Empleado;


-- ─────────────────────────────────────────────────────────────
-- CONSULTA 2
-- Muestra solo el nombre, apellidos y email de los clientes
-- registrados online.
-- Útil para el equipo de marketing al preparar envíos de
-- newsletter o campañas de email.
-- ─────────────────────────────────────────────────────────────
SELECT
    nombre,
    apellidos,
    email
FROM Cliente
WHERE tipo_cliente = 'registrado';


-- ─────────────────────────────────────────────────────────────
-- CONSULTA 3
-- Filtra los pedidos online cuyo estado sea exactamente
-- 'pendiente'.
-- Permite al equipo de logística identificar qué pedidos
-- necesitan procesarse de forma inmediata.
-- ─────────────────────────────────────────────────────────────
SELECT
    id_pedido,
    id_cliente,
    fecha_pedido,
    total,
    estado
FROM PedidoOnline
WHERE estado = 'pendiente';


-- ─────────────────────────────────────────────────────────────
-- CONSULTA 4
-- Busca productos cuyo nombre contenga la palabra 'Pro'
-- (LIKE con patrón en cualquier posición).
-- Útil en el buscador del catálogo online para encontrar
-- referencias por palabra clave.
-- ─────────────────────────────────────────────────────────────
SELECT
    id_producto,
    sku,
    nombre,
    pvp_actual
FROM Producto
WHERE nombre LIKE '%Pro%'
  AND activo = 1;


-- ─────────────────────────────────────────────────────────────
-- CONSULTA 5
-- Devuelve los clientes registrados cuyo nombre empiece
-- por la letra 'A' (LIKE con patrón al inicio).
-- Ejemplo de uso: búsqueda alfabética en el CRM del equipo
-- de atención al cliente.
-- ─────────────────────────────────────────────────────────────
SELECT
    id_cliente,
    nombre,
    apellidos,
    email,
    fecha_registro
FROM Cliente
WHERE nombre LIKE 'A%'
  AND tipo_cliente = 'registrado';


-- ─────────────────────────────────────────────────────────────
-- CONSULTA 6
-- Devuelve los pedidos online realizados entre el
-- 01/01/2024 y el 30/06/2024 (rango de fechas con BETWEEN).
-- Permite al departamento de operaciones analizar el
-- volumen de ventas online del primer semestre de 2024.
-- ─────────────────────────────────────────────────────────────
SELECT
    id_pedido,
    id_cliente,
    fecha_pedido,
    estado,
    total
FROM PedidoOnline
WHERE fecha_pedido BETWEEN '2024-01-01 00:00:00'
                       AND '2024-06-30 23:59:59'
ORDER BY fecha_pedido;


-- ─────────────────────────────────────────────────────────────
-- CONSULTA 7
-- Devuelve los productos con un PVP comprendido entre
-- 100 € y 500 € (rango numérico con BETWEEN).
-- Útil para el equipo de marketing al preparar campañas
-- segmentadas por franja de precio.
-- ─────────────────────────────────────────────────────────────
SELECT
    id_producto,
    sku,
    nombre,
    pvp_actual
FROM Producto
WHERE pvp_actual BETWEEN 100.00 AND 500.00
  AND activo = 1
ORDER BY pvp_actual;


-- ─────────────────────────────────────────────────────────────
-- CONSULTA 8
-- Muestra las líneas de pedido online cuya cantidad
-- sea superior a 1 unidad.
-- Permite detectar pedidos en los que un cliente ha
-- comprado más de una unidad de un mismo producto,
-- útil para revisar el stock consumido.
-- ─────────────────────────────────────────────────────────────
SELECT
    lpo.id_linea,
    lpo.id_pedido,
    lpo.id_producto,
    lpo.cantidad,
    lpo.precio_unitario,
    lpo.descuento_aplicado
FROM LineaPedidoOnline lpo
WHERE lpo.cantidad > 1;


-- ─────────────────────────────────────────────────────────────
-- CONSULTA 9
-- Devuelve todos los pedidos online ordenados de forma
-- ascendente por fecha (del más antiguo al más reciente).
-- Permite revisar la cronología completa de pedidos.
-- ─────────────────────────────────────────────────────────────
SELECT
    id_pedido,
    id_cliente,
    fecha_pedido,
    estado,
    total
FROM PedidoOnline
ORDER BY fecha_pedido ASC;


-- ─────────────────────────────────────────────────────────────
-- CONSULTA 10
-- Lista los productos activos ordenados de mayor a menor
-- precio (ORDER BY descendente).
-- Útil para mostrar primero los productos premium en el
-- catálogo o para revisar la política de precios.
-- ─────────────────────────────────────────────────────────────
SELECT
    id_producto,
    sku,
    nombre,
    pvp_actual
FROM Producto
WHERE activo = 1
ORDER BY pvp_actual DESC;


-- ─────────────────────────────────────────────────────────────
-- CONSULTA 11
-- Lista los clientes registrados ordenados alfabéticamente
-- por nombre de la A a la Z.
-- Orden útil para listados de atención al cliente y
-- exportaciones a ficheros de contacto.
-- ─────────────────────────────────────────────────────────────
SELECT
    id_cliente,
    nombre,
    apellidos,
    email
FROM Cliente
WHERE tipo_cliente = 'registrado'
ORDER BY nombre ASC, apellidos ASC;


-- ─────────────────────────────────────────────────────────────
-- CONSULTA 12
-- Actualiza el estado del pedido online con id_pedido = 10
-- de 'pendiente' a 'en_proceso'.
-- Simula la acción del sistema cuando el almacén comienza
-- a preparar un pedido.
-- ─────────────────────────────────────────────────────────────
UPDATE PedidoOnline
SET estado = 'en_proceso'
WHERE id_pedido = 10;

-- Verificación: muestra el pedido actualizado
SELECT id_pedido, estado, total
FROM PedidoOnline
WHERE id_pedido = 10;


-- ─────────────────────────────────────────────────────────────
-- CONSULTA 13
-- Actualiza el email corporativo del empleado con
-- id_empleado = 6 usando su identificador como filtro WHERE.
-- Simula la corrección de un dato en el sistema de RRHH.
-- ─────────────────────────────────────────────────────────────
UPDATE Empleado
SET email_corporativo = 'carmen.ibanez@nexshop.es'
WHERE id_empleado = 6;

-- Verificación: muestra el empleado actualizado
SELECT id_empleado, nombre, apellidos, email_corporativo
FROM Empleado
WHERE id_empleado = 6;


-- ─────────────────────────────────────────────────────────────
-- CONSULTA 14
-- Combina Cliente y PedidoOnline mediante JOIN para mostrar
-- el nombre completo del cliente junto con los datos de
-- cada uno de sus pedidos online.
-- Permite al equipo de atención al cliente ver el historial
-- de pedidos de forma legible sin conocer los IDs internos.
-- ─────────────────────────────────────────────────────────────
SELECT
    c.id_cliente,
    c.nombre                    AS nombre_cliente,
    c.apellidos                 AS apellidos_cliente,
    p.id_pedido,
    p.fecha_pedido,
    p.estado,
    p.total
FROM Cliente c
JOIN PedidoOnline p ON p.id_cliente = c.id_cliente
ORDER BY c.apellidos, c.nombre, p.fecha_pedido;


-- =============================================================
--  FIN DE CONSULTAS
-- =============================================================

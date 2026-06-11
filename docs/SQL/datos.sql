-- =============================================================
--  NexShop Group S.A. — datos.sql
--  Datos de prueba realistas para todas las tablas
--  Autor : Alejandro Morales Hermosín
--  Nota  : Ejecutar DESPUÉS de schema.sql
-- =============================================================

USE nexshop;

-- =============================================================
--  1. SEDES  (3 tiendas + 1 almacén central)
-- =============================================================
INSERT INTO Sede (nombre, tipo, ciudad, direccion, email_contacto) VALUES
('Almacén Central Valencia',  'almacen_central', 'Valencia',  'Calle Industria 14, Polígono Norte',       'almacen@nexshop.es'),
('Tienda Valencia Centro',    'tienda_fisica',   'Valencia',  'Calle Colón 22, Local 3',                  'valencia@nexshop.es'),
('Tienda Madrid Gran Vía',    'tienda_fisica',   'Madrid',    'Gran Vía 45, Bajo',                        'madrid@nexshop.es'),
('Tienda Barcelona Diagonal', 'tienda_fisica',   'Barcelona', 'Avinguda Diagonal 312',                   'barcelona@nexshop.es');


-- =============================================================
--  2. EMPLEADOS  (12 empleados repartidos entre sedes)
-- =============================================================
INSERT INTO Empleado (nombre, apellidos, dni, email_corporativo, fecha_incorporacion, id_sede, cargo) VALUES
-- Almacén central (sede 1)
('Ana',      'Ferrer Molina',      '11111111A', 'a.ferrer@nexshop.es',      '2015-03-01', 1, 'Directora de Operaciones'),
('David',    'Cano Pérez',         '22222222B', 'd.cano@nexshop.es',         '2016-06-15', 1, 'Responsable de Logística'),
('Sergio',   'Blanco Torres',      '33333333C', 's.blanco@nexshop.es',       '2016-09-01', 1, 'Responsable de IT'),
-- Tienda Valencia (sede 2)
('Laura',    'Pons García',        '44444444D', 'l.pons@nexshop.es',         '2017-01-10', 2, 'Encargada Atención Cliente'),
('Miguel',   'Soriano Ruiz',       '55555555E', 'm.soriano@nexshop.es',      '2018-03-20', 2, 'Encargado de Tienda'),
('Carmen',   'Ibáñez Llopis',      '66666666F', 'c.ibanez@nexshop.es',       '2019-07-01', 2, 'Vendedora'),
-- Tienda Madrid (sede 3)
('Roberto',  'Díaz Fernández',     '77777777G', 'r.diaz@nexshop.es',         '2018-11-15', 3, 'Encargado de Tienda'),
('Sofía',    'Martínez Vega',      '88888888H', 's.martinez@nexshop.es',     '2020-02-01', 3, 'Vendedora'),
('Javier',   'Romero Castillo',    '99999999I', 'j.romero@nexshop.es',       '2021-05-10', 3, 'Vendedor'),
-- Tienda Barcelona (sede 4)
('Núria',    'Puig Solà',          '10101010J', 'n.puig@nexshop.es',         '2019-04-01', 4, 'Encargada de Tienda'),
('Oriol',    'Mas Ribera',         '12121212K', 'o.mas@nexshop.es',          '2020-09-15', 4, 'Vendedor'),
('Elena',    'Vidal Esteve',       '13131313L', 'e.vidal@nexshop.es',        '2022-01-10', 4, 'Vendedora');


-- =============================================================
--  3. PROVEEDORES
-- =============================================================
INSERT INTO Proveedor (razon_social, cif, email, telefono, id_representante) VALUES
('TechDistrib S.L.',          'B12345678', 'ventas@techdistrib.es',    '912345678', 2),
('GlobalComp Import S.A.',    'A98765432', 'comercial@globalcomp.es',  '934567890', 2),
('PerifericasPlus S.L.',      'B55556666', 'pedidos@perifericasplus.es','960111222', 1),
('StoragePro Iberia S.A.',    'A11223344', 'info@storagepro.es',       '914455667', 3),
('AudioVisual Mayorista S.L.','B99887766', 'av@avmayorista.es',        '932211445', 2);


-- =============================================================
--  4. CATÁLOGO
-- =============================================================

-- Categorías
INSERT INTO Categoria (nombre_categoria) VALUES
('Informática'),
('Telefonía'),
('Audio y Sonido'),
('Almacenamiento'),
('Periféricos');

-- Subcategorías
INSERT INTO Subcategoria (id_categoria, nombre_subcategoria, descripcion) VALUES
-- Informática (1)
(1, 'Portátiles Gaming',    'Portátiles de alto rendimiento para juegos'),
(1, 'Portátiles Oficina',   'Portátiles ligeros para trabajo y productividad'),
(1, 'Portátiles Ultrabook', 'Portátiles ultraligeros de alta gama'),
(1, 'Ordenadores Sobremesa','Torres y mini-PC de escritorio'),
-- Telefonía (2)
(2, 'Smartphones Android',  'Teléfonos con sistema Android'),
(2, 'Smartphones iOS',      'Teléfonos Apple iPhone'),
(2, 'Accesorios Móvil',     'Fundas, cargadores y cables'),
-- Audio y Sonido (3)
(3, 'Auriculares',          'Auriculares con y sin cable'),
(3, 'Altavoces Bluetooth',  'Altavoces portátiles inalámbricos'),
-- Almacenamiento (4)
(4, 'SSD Interno',          'Discos de estado sólido internos'),
(4, 'Disco Duro Externo',   'Discos duros portátiles USB'),
-- Periféricos (5)
(5, 'Ratones',              'Ratones con cable e inalámbricos'),
(5, 'Teclados',             'Teclados mecánicos y de membrana'),
(5, 'Monitores',            'Pantallas para escritorio');

-- Productos (20 referencias)
INSERT INTO Producto (id_subcategoria, nombre, descripcion, sku, pvp_actual, activo) VALUES
-- Portátiles Gaming (1)
(1,  'ASUS ROG Strix G15',          'Intel i7, RTX 4060, 16GB RAM, 512GB SSD',      'ASU-ROG-G15-2024',  1299.99, 1),
(1,  'MSI Raider GE78 HX',          'Intel i9, RTX 4080, 32GB RAM, 1TB SSD',        'MSI-RAI-GE78-24',   2199.00, 1),
-- Portátiles Oficina (2)
(2,  'Lenovo ThinkPad E15',         'Intel i5, 16GB RAM, 512GB SSD, 15.6"',         'LEN-TP-E15-2024',    849.00, 1),
(2,  'HP ProBook 450 G10',          'Intel i5, 8GB RAM, 256GB SSD, 15.6"',          'HP-PB-450-G10',      699.00, 1),
-- Portátiles Ultrabook (3)
(3,  'Apple MacBook Air M3',        'Chip M3, 8GB RAM, 256GB SSD, 13.6"',           'APL-MBA-M3-256',    1299.00, 1),
(3,  'Dell XPS 13 Plus',            'Intel i7, 16GB RAM, 512GB SSD, OLED',          'DEL-XPS13P-512',    1499.00, 1),
-- Smartphones Android (5)
(5,  'Samsung Galaxy S24 Ultra',    '12GB RAM, 256GB, cámara 200MP',                'SAM-S24U-256',      1329.00, 1),
(5,  'Google Pixel 8 Pro',          '12GB RAM, 128GB, IA integrada',                'GOO-P8PRO-128',      999.00, 1),
-- Smartphones iOS (6)
(6,  'Apple iPhone 15 Pro',         'A17 Pro, 128GB, titanio natural',              'APL-IP15P-128',     1229.00, 1),
(6,  'Apple iPhone 15',             'A16 Bionic, 128GB, negro',                     'APL-IP15-128',       979.00, 1),
-- Auriculares (8)
(8,  'Sony WH-1000XM5',             'ANC, Bluetooth, 30h batería, negro',           'SON-WH1000XM5-B',    349.00, 1),
(8,  'Apple AirPods Pro 2ª gen',    'ANC, chip H2, estuche MagSafe',                'APL-APP-2GEN',       279.00, 1),
-- Altavoces Bluetooth (9)
(9,  'JBL Charge 5',                'IP67, 20h batería, power bank integrado',      'JBL-CHG5-BLK',      179.00, 1),
-- SSD Interno (10)
(10, 'Samsung 990 Pro 1TB NVMe',    'PCIe 4.0, 7450 MB/s lectura',                 'SAM-990PRO-1T',      129.00, 1),
(10, 'WD Black SN850X 2TB',         'PCIe 4.0, 7300 MB/s lectura',                 'WD-SN850X-2T',       199.00, 1),
-- Disco Duro Externo (11)
(11, 'Seagate Expansion 2TB',       'USB 3.0, formato 2.5"',                        'SEA-EXP-2TB',         69.00, 1),
-- Ratones (12)
(12, 'Logitech MX Master 3S',       'Inalámbrico, 8000 DPI, recarga USB-C',        'LOG-MXM3S-GR',        99.99, 1),
(12, 'Razer DeathAdder V3',         'Gaming, 30000 DPI, 59g',                       'RAZ-DAV3-BLK',        79.99, 1),
-- Teclados (13)
(13, 'Keychron K8 Pro',             'TKL mecánico, Gateron G Pro Red, RGB',         'KEY-K8PRO-RED',       99.00, 1),
-- Monitores (14)
(14, 'LG 27GP850-B 27" IPS',        '2560x1440, 165Hz, 1ms, HDMI+DP',              'LG-27GP850B',         349.00, 1);


-- =============================================================
--  5. HISTÓRICO DE PRECIOS
-- =============================================================
INSERT INTO HistoricoPrecioProducto (id_producto, pvp, fecha_inicio, fecha_fin) VALUES
-- ASUS ROG G15 (prod 1): subida en enero 2024
(1,  1199.99, '2023-06-01', '2024-01-14'),
(1,  1299.99, '2024-01-15', NULL),
-- MacBook Air M3 (prod 5): precio de lanzamiento más alto
(5,  1399.00, '2023-11-01', '2024-03-31'),
(5,  1299.00, '2024-04-01', NULL),
-- Sony WH-1000XM5 (prod 11): bajada de precio
(11,  399.00, '2023-01-01', '2024-02-28'),
(11,  349.00, '2024-03-01', NULL),
-- Samsung Galaxy S24 Ultra (prod 7): lanzamiento
(7,  1449.00, '2024-01-17', '2024-05-31'),
(7,  1329.00, '2024-06-01', NULL);


-- =============================================================
--  6. CONDICIONES PRODUCTO–PROVEEDOR
-- =============================================================
INSERT INTO ProductoProveedor (id_producto, id_proveedor, precio_coste, plazo_entrega_dias, fecha_inicio, fecha_fin) VALUES
-- ASUS ROG G15 — TechDistrib
(1,  1, 950.00,  5, '2023-06-01', '2024-01-14'),
(1,  1, 980.00,  5, '2024-01-15', NULL),
-- MacBook Air M3 — GlobalComp
(5,  2, 980.00,  7, '2023-11-01', '2024-03-31'),
(5,  2, 950.00,  7, '2024-04-01', NULL),
-- MacBook Air M3 — segundo proveedor alternativo
(5,  1,1020.00, 10, '2024-01-01', NULL),
-- Sony WH-1000XM5 — AudioVisual Mayorista
(11, 5, 220.00,  4, '2023-01-01', '2024-02-28'),
(11, 5, 195.00,  4, '2024-03-01', NULL),
-- Samsung SSD — StoragePro
(14, 4,  72.00,  3, '2024-01-01', NULL),
-- Logitech MX Master — PerifericasPlus
(17, 3,  58.00,  3, '2023-06-01', NULL),
-- iPhone 15 Pro — GlobalComp
(9,  2, 900.00,  6, '2023-09-22', NULL),
-- Samsung S24 Ultra — TechDistrib
(7,  1,1050.00,  5, '2024-01-17', NULL);


-- =============================================================
--  7. STOCK POR UBICACIÓN
-- =============================================================
INSERT INTO StockUbicacion (id_producto, id_sede, cantidad) VALUES
-- Sede 1: Almacén central (stock elevado)
(1,  1, 25), (2,  1, 10), (3,  1, 30), (4,  1, 40),
(5,  1, 20), (6,  1, 15), (7,  1, 18), (8,  1, 22),
(9,  1, 25), (10, 1, 30), (11, 1, 35), (12, 1, 40),
(13, 1, 50), (14, 1, 60), (15, 1, 45), (16, 1, 80),
(17, 1, 55), (18, 1, 45), (19, 1, 30), (20, 1, 20),
-- Sede 2: Valencia
(1,  2,  5), (3,  2,  8), (5,  2,  4), (7,  2,  6),
(9,  2,  5), (11, 2,  7), (13, 2, 10), (17, 2,  8),
(19, 2,  4), (20, 2,  3),
-- Sede 3: Madrid
(1,  3,  4), (3,  3,  6), (5,  3,  3), (7,  3,  8),
(9,  3,  4), (10, 3,  5), (11, 3,  6), (14, 3, 12),
(17, 3,  9), (20, 3,  5),
-- Sede 4: Barcelona
(1,  4,  3), (4,  4,  7), (5,  4,  5), (9,  4,  6),
(11, 4,  8), (12, 4, 10), (13, 4,  6), (16, 4, 15),
(17, 4,  7), (20, 4,  4);


-- =============================================================
--  8. PROMOCIONES
-- =============================================================
INSERT INTO Promocion (nombre, descuento_pct, fecha_inicio, fecha_fin) VALUES
('Black Friday 2023',         20.00, '2023-11-24', '2023-11-27'),
('Rebajas Enero 2024',        15.00, '2024-01-08', '2024-01-31'),
('San Valentín Tech',         10.00, '2024-02-10', '2024-02-14'),
('Vuelta al Cole 2024',       12.00, '2024-09-02', '2024-09-15'),
('Cyber Monday 2024',         25.00, '2024-12-02', '2024-12-02'),
('Promo Auriculares Verano',   8.00, '2024-07-01', '2024-08-31');

INSERT INTO PromocionProducto (id_promocion, id_producto) VALUES
-- Black Friday: portátiles y auriculares
(1, 1), (1, 3), (1, 5), (1, 11), (1, 12),
-- Rebajas Enero: varios
(2, 1), (2, 4), (2, 7), (2, 14), (2, 17),
-- San Valentín: auriculares y altavoces
(3, 11), (3, 12), (3, 13),
-- Vuelta al cole: portátiles y ratones
(4, 3), (4, 4), (4, 17), (4, 19),
-- Cyber Monday: todo lo anterior más
(5, 1), (5, 2), (5, 5), (5, 6), (5, 9), (5, 10),
-- Verano auriculares
(6, 11), (6, 12), (6, 13);


-- =============================================================
--  9. CLIENTES
-- =============================================================
INSERT INTO Cliente (nombre, apellidos, email, password_hash, fecha_nacimiento, tipo_cliente, fecha_registro, activo, puntos_saldo) VALUES
-- Clientes registrados
('Carlos',   'Ruiz Herrero',      'c.ruiz@email.com',        '$2b$12$abc1', '1990-04-12', 'registrado', '2022-03-15 10:30:00', 1, 1250),
('Isabel',   'Navarro Ortega',    'i.navarro@gmail.com',     '$2b$12$abc2', '1985-11-23', 'registrado', '2022-07-20 14:15:00', 1, 3400),
('Pedro',    'Gómez Santos',      'p.gomez@outlook.com',     '$2b$12$abc3', '1992-08-05', 'registrado', '2023-01-10 09:00:00', 1,  580),
('María',    'López Fernández',   'm.lopez@email.com',       '$2b$12$abc4', '1988-02-28', 'registrado', '2023-03-22 16:45:00', 1, 7800),
('Andrés',   'Martín Jiménez',    'a.martin@gmail.com',      '$2b$12$abc5', '1995-07-14', 'registrado', '2023-06-01 11:20:00', 1,  200),
('Lucía',    'Sánchez Moreno',    'l.sanchez@email.com',     '$2b$12$abc6', '2000-12-03', 'registrado', '2023-09-15 18:00:00', 1,    0),
('Tomás',    'Jiménez Castro',    't.jimenez@hotmail.com',   '$2b$12$abc7', '1978-06-19', 'registrado', '2024-01-05 08:30:00', 1, 4100),
('Beatriz',  'Alonso Muñoz',      'b.alonso@gmail.com',      '$2b$12$abc8', '1993-09-30', 'registrado', '2024-02-14 20:10:00', 1,  650),
('Fernando', 'Castro Vargas',     'f.castro@email.com',      '$2b$12$abc9', '1982-03-07', 'registrado', '2024-03-01 13:00:00', 1, 1900),
('Rosa',     'Iglesias Blanco',   'r.iglesias@gmail.com',    '$2b$12$abcA', '1997-05-22', 'registrado', '2024-04-10 15:30:00', 1,    0),
-- Clientes anónimos (compras presenciales)
(NULL, NULL, NULL, NULL, NULL, 'anonimo', NULL, 1, 0),
(NULL, NULL, NULL, NULL, NULL, 'anonimo', NULL, 1, 0),
(NULL, NULL, NULL, NULL, NULL, 'anonimo', NULL, 1, 0);


-- =============================================================
--  10. DIRECCIONES
-- =============================================================
INSERT INTO Direccion (id_cliente, alias, calle, numero, piso, codigo_postal, ciudad, pais, predeterminada) VALUES
(1, 'Casa',    'Calle Mayor',             '15',  '2ºB', '46001', 'Valencia',  'España', 1),
(1, 'Trabajo', 'Avenida del Puerto',      '28',  NULL,  '46023', 'Valencia',  'España', 0),
(2, 'Casa',    'Calle Serrano',           '88',  '4ºA', '28006', 'Madrid',    'España', 1),
(3, 'Casa',    'Gran Via de les Corts',   '312', '1º',  '08007', 'Barcelona', 'España', 1),
(4, 'Casa',    'Calle Ruzafa',            '7',   NULL,  '46002', 'Valencia',  'España', 1),
(4, 'Oficina', 'Paseo de la Alameda',     '33',  '3ºC', '46010', 'Valencia',  'España', 0),
(5, 'Casa',    'Calle Fuencarral',        '45',  '2ºD', '28004', 'Madrid',    'España', 1),
(6, 'Casa',    'Calle Balmes',            '120', '5ºA', '08008', 'Barcelona', 'España', 1),
(7, 'Casa',    'Avinguda Diagonal',       '200', '3ºB', '08011', 'Barcelona', 'España', 1),
(8, 'Casa',    'Calle Alcalá',            '150', NULL,  '28009', 'Madrid',    'España', 1),
(9, 'Casa',    'Calle Colón',             '10',  '1ºA', '46004', 'Valencia',  'España', 1),
(10,'Casa',    'Calle Pelayo',            '58',  '2ºC', '08010', 'Barcelona', 'España', 1);


-- =============================================================
--  11. PEDIDOS ONLINE
-- =============================================================
INSERT INTO PedidoOnline (id_cliente, id_direccion, fecha_pedido, estado, total, puntos_canjeados) VALUES
(1,  1,  '2023-11-25 10:15:00', 'entregado', 1039.99,    0),   -- Black Friday: MacBook Air
(2,  3,  '2024-01-12 16:30:00', 'entregado',  944.50,    0),   -- Rebajas enero: ThinkPad + ratón
(3,  5,  '2024-02-11 11:00:00', 'entregado',  349.00,    0),   -- Sony auriculares
(4,  7,  '2024-03-05 09:45:00', 'entregado', 1329.00,    0),   -- Samsung S24 Ultra
(5,  9,  '2024-04-20 14:20:00', 'enviado',    849.00,    0),   -- Lenovo ThinkPad
(4,  8,  '2024-05-10 18:00:00', 'entregado',  428.99,  500),   -- Logitech + Keychron (500 pts canjeados)
(6,  10, '2024-06-15 20:30:00', 'entregado',  179.00,    0),   -- JBL Charge 5
(7,  11, '2024-09-03 08:15:00', 'entregado', 1299.00,    0),   -- MacBook Air M3
(8,  12, '2024-10-28 17:45:00', 'en_proceso', 699.00,    0),   -- HP ProBook
(1,  2,  '2024-11-25 22:00:00', 'pendiente', 2199.00,    0),   -- MSI Raider (Cyber Monday)
(9,  13, '2024-12-02 09:00:00', 'enviado',    279.00,    0),   -- AirPods Pro
(10, 14, '2024-12-10 15:00:00', 'pendiente',  199.00,    0);   -- WD SSD


-- =============================================================
--  12. LÍNEAS DE PEDIDO ONLINE
-- =============================================================
INSERT INTO LineaPedidoOnline (id_pedido, id_producto, cantidad, precio_unitario, descuento_aplicado) VALUES
-- Pedido 1: MacBook Air M3 con descuento Black Friday 20%
(1,  5, 1, 1399.00, 20.00),
-- Pedido 2: ThinkPad E15 con 15% rebajas + Logitech
(2,  3, 1,  849.00, 15.00),
(2, 17, 1,   99.99,  0.00),
-- Pedido 3: Sony auriculares sin descuento
(3, 11, 1,  349.00,  0.00),
-- Pedido 4: Samsung S24 Ultra
(4,  7, 1, 1329.00,  0.00),
-- Pedido 5: Lenovo ThinkPad
(5,  3, 1,  849.00,  0.00),
-- Pedido 6: Logitech + Keychron
(6, 17, 1,   99.99,  0.00),
(6, 19, 1,   99.00,  0.00),
(6, 14, 1,  129.00,  0.00),
-- Pedido 7: JBL Charge 5
(7, 13, 1,  179.00,  0.00),
-- Pedido 8: MacBook Air M3 (precio actualizado)
(8,  5, 1, 1299.00,  0.00),
-- Pedido 9: HP ProBook
(9,  4, 1,  699.00,  0.00),
-- Pedido 10: MSI Raider con Cyber Monday 25%
(10, 2, 1, 2199.00, 25.00),
-- Pedido 11: AirPods Pro
(11,12, 1,  279.00,  0.00),
-- Pedido 12: WD SSD
(12,15, 1,  199.00,  0.00);


-- =============================================================
--  13. ENVÍOS
-- =============================================================
INSERT INTO Envio (id_pedido, id_sede_origen, numero_seguimiento, transportista, fecha_estimada_entrega, fecha_entrega_real, estado) VALUES
(1,  1, 'MRW2023112501', 'MRW',    '2023-11-28', '2023-11-27', 'entregado'),
(2,  1, 'SEUR202401201', 'SEUR',   '2024-01-15', '2024-01-14', 'entregado'),
(3,  1, 'CORREOS240211', 'Correos','2024-02-14', '2024-02-13', 'entregado'),
(4,  1, 'MRW2024030501', 'MRW',    '2024-03-08', '2024-03-07', 'entregado'),
-- Pedido 5 dividido en dos envíos parciales
(5,  2, 'SEUR202404201', 'SEUR',   '2024-04-24', NULL,         'enviado'),
(5,  3, 'SEUR202404202', 'SEUR',   '2024-04-25', NULL,         'enviado'),
(6,  1, 'MRW2024051001', 'MRW',    '2024-05-13', '2024-05-12', 'entregado'),
(7,  1, 'NACEX24061501', 'Nacex',  '2024-06-18', '2024-06-17', 'entregado'),
(8,  1, 'MRW2024090301', 'MRW',    '2024-09-06', '2024-09-05', 'entregado'),
(9,  1, 'SEUR202410281', 'SEUR',   '2024-10-31', NULL,         'preparando'),
(10, 1, 'MRW2024112501', 'MRW',    '2024-11-28', NULL,         'preparando'),
(11, 1, 'NACEX24120201', 'Nacex',  '2024-12-05', NULL,         'enviado'),
(12, 1, 'MRW2024121001', 'MRW',    '2024-12-13', NULL,         'preparando');


-- =============================================================
--  14. VENTAS PRESENCIALES
-- =============================================================
INSERT INTO VentaPresencial (id_sede, id_empleado, id_cliente, fecha_venta, total) VALUES
-- Tienda Valencia (empleados 5,6)
(2, 6,  NULL, '2024-01-15 11:30:00',  349.00),  -- anónimo
(2, 5,     4, '2024-02-20 17:00:00', 1229.00),  -- iPhone 15 Pro
(2, 6,     1, '2024-03-10 12:45:00',   79.99),  -- Razer DeathAdder
(2, 5,  NULL, '2024-06-22 10:15:00',  129.00),  -- Samsung SSD
-- Tienda Madrid (empleados 8,9)
(3, 8,     2, '2024-01-20 16:00:00',  699.00),  -- HP ProBook
(3, 9,     5, '2024-04-05 13:30:00',  349.00),  -- LG Monitor
(3, 8,  NULL, '2024-07-18 11:00:00',   99.99),  -- Logitech
(3, 9,     7, '2024-09-10 18:30:00',  849.00),  -- Lenovo ThinkPad
-- Tienda Barcelona (empleados 11,12)
(4, 11,    3, '2024-02-14 15:00:00',  279.00),  -- AirPods (San Valentín)
(4, 12,    6, '2024-05-25 12:00:00',  179.00),  -- JBL Charge 5
(4, 11, NULL, '2024-10-12 10:30:00', 1299.00),  -- MacBook Air anónimo
(4, 12,    9, '2024-11-15 17:45:00',   69.00);  -- Seagate HDD


-- =============================================================
--  15. LÍNEAS DE VENTA PRESENCIAL
-- =============================================================
INSERT INTO LineaVentaPresencial (id_venta, id_producto, cantidad, precio_unitario) VALUES
(1,  11, 1,  349.00),  -- Sony WH-1000XM5
(2,   9, 1, 1229.00),  -- iPhone 15 Pro
(3,  18, 1,   79.99),  -- Razer DeathAdder
(4,  14, 1,  129.00),  -- Samsung SSD
(5,   4, 1,  699.00),  -- HP ProBook
(6,  20, 1,  349.00),  -- LG Monitor
(7,  17, 1,   99.99),  -- Logitech MX Master
(8,   3, 1,  849.00),  -- Lenovo ThinkPad
(9,  12, 1,  279.00),  -- AirPods Pro
(10, 13, 1,  179.00),  -- JBL Charge 5
(11,  5, 1, 1299.00),  -- MacBook Air M3
(12, 16, 1,   69.00);  -- Seagate HDD


-- =============================================================
--  16. DEVOLUCIONES PRESENCIALES
-- =============================================================
INSERT INTO DevolucionPresencial (id_venta, id_producto, cantidad, fecha_devolucion, motivo) VALUES
(1, 11, 1, '2024-01-20', 'Producto defectuoso: el micrófono no funciona correctamente'),
(5,  4, 1, '2024-01-25', 'El cliente ha cambiado de opinión, prefiere un modelo superior');


-- =============================================================
--  17. TRANSFERENCIAS DE STOCK
-- =============================================================
INSERT INTO TransferenciaStock (id_producto, id_sede_origen, id_sede_destino, cantidad, fecha, id_empleado_autoriza) VALUES
-- Reposición de MacBook Air en Valencia desde almacén
(5,  1, 2,  5, '2024-01-10', 2),
-- Reposición iPhone 15 Pro en Barcelona
(9,  1, 4,  4, '2024-02-08', 2),
-- Almacén → Madrid: Samsung S24 Ultra
(7,  1, 3,  6, '2024-03-01', 2),
-- Valencia → Barcelona: Lenovo ThinkPad (traspaso entre tiendas)
(3,  2, 4,  2, '2024-04-15', 5),
-- Almacén → Valencia: Sony auriculares
(11, 1, 2,  5, '2024-07-01', 2),
-- Almacén → Madrid: LG Monitor
(20, 1, 3,  4, '2024-09-01', 2);


-- =============================================================
--  18. TICKETS DE ATENCIÓN AL CLIENTE
-- =============================================================
INSERT INTO Ticket (id_cliente, id_empleado, id_pedido, asunto, descripcion, fecha_apertura, estado, fecha_cierre, nota_resolucion) VALUES
-- Ticket resuelto: devolución online pedido 3
(3,  4, 3,  'Solicitud devolución auriculares',
 'El cliente indica que los auriculares Sony llegaron con la diadema rota',
 '2024-02-15 09:00:00', 'resuelto', '2024-02-17 11:00:00',
 'Se aprueba devolución completa. Reembolso procesado en 3-5 días hábiles.'),
-- Ticket en gestión: problema de envío
(5,  4, 5,  'Pedido dividido sin aviso previo',
 'El cliente no fue informado de que su pedido llegaría en dos envíos distintos',
 '2024-04-26 14:30:00', 'en_gestion', NULL, NULL),
-- Ticket resuelto: consulta general sin pedido
(2,  4, NULL, 'Consulta compatibilidad MacBook',
 '¿El MacBook Air M3 es compatible con monitores 4K por USB-C?',
 '2024-04-10 10:15:00', 'resuelto', '2024-04-10 10:45:00',
 'Confirmado: el MBA M3 soporta hasta un monitor externo 6K por Thunderbolt 3.'),
-- Ticket abierto: queja Cyber Monday
(1,  4, 10, 'El descuento Cyber Monday no se aplicó correctamente',
 'El 25% de descuento en el MSI Raider no aparece en el resumen del pedido',
 '2024-11-25 23:15:00', 'abierto', NULL, NULL),
-- Ticket resuelto: cliente anónimo presencial
(NULL, 4, NULL, 'Consulta sobre garantía producto en tienda',
 'Cliente pregunta cuánto dura la garantía de un portátil comprado en tienda física',
 '2024-07-10 12:00:00', 'resuelto', '2024-07-10 12:20:00',
 'Se informa: 2 años de garantía legal + posibilidad de extensión a 3 años.');


-- =============================================================
--  19. VALORACIONES
-- =============================================================
INSERT INTO Valoracion (id_cliente, id_producto, puntuacion, comentario, fecha_valoracion, verificada) VALUES
-- Valoraciones verificadas (compraron el producto)
(1,  5, 5, 'El MacBook Air M3 es una pasada. Rapidísimo para el día a día, batería increíble.',
           '2023-12-05 10:00:00', 1),
(2,  3, 4, 'Muy buen portátil para oficina. La pantalla es correcta y el teclado cómodo. Le falta algo de potencia para tareas pesadas.',
           '2024-01-20 09:30:00', 1),
(3, 11, 4, 'Cancelación de ruido excelente. El sonido es muy bueno aunque para mi gusto los graves podrían tener más presencia.',
           '2024-02-20 15:00:00', 1),
(4,  7, 5, 'El S24 Ultra es el mejor Android del mercado. La cámara es brutalmente buena.',
           '2024-03-15 18:00:00', 1),
(7,  5, 5, 'Segundo MacBook Air que compro. M3 es notablemente más rápido que el M1. 100% recomendable.',
           '2024-09-10 11:00:00', 1),
(8,  4, 3, 'Bien para el precio. La pantalla es mediocre y el touchpad se queda justo. Para trabajo básico cumple.',
           '2024-11-10 20:00:00', 1),
-- Valoración histórica sin compra verificada (permitida en el pasado)
(6, 13, 5, 'El JBL Charge 5 lleva conmigo a todos lados. El sonido es impresionante para su tamaño.',
           '2024-07-20 17:00:00', 0),
-- Valoración de cliente que compró en tienda física
(3, 12, 5, 'Los AirPods Pro 2ª gen son increíbles. Los compré en la tienda de Barcelona y quedé encantado.',
           '2024-03-01 12:00:00', 1),
(9, 16, 4, 'Buen disco externo, cumple su función perfectamente. La velocidad de transferencia es correcta.',
           '2024-11-20 10:00:00', 1);


-- =============================================================
--  20. MOVIMIENTOS DE PUNTOS
-- =============================================================
INSERT INTO MovimientoPuntos (id_cliente, id_pedido, tipo, puntos, fecha, descripcion) VALUES
-- Carlos (cliente 1): compras y canje
(1, 1,  'ganado',  10399, '2023-11-25 10:15:00', 'Compra online pedido #1 (1039.99€ × 10)'),
(1, NULL,'canjeado',-1250, '2024-03-10 12:45:00', 'Canje parcial en compra presencial tienda Valencia'),
(1, 10, 'ganado',  21990, '2024-11-25 22:00:00', 'Compra online pedido #10 (2199.00€ × 10)'),
-- Isabel (cliente 2): historial acumulado
(2, 2,  'ganado',   9445, '2024-01-12 16:30:00', 'Compra online pedido #2 (944.50€ × 10)'),
(2, NULL,'ganado',  6990, '2024-01-20 16:00:00', 'Compra presencial tienda Madrid'),
(2, NULL,'canjeado',-3035,'2024-03-15 10:00:00', 'Canje descuento en tienda física'),
-- Pedro (cliente 3): compra + devolución parcial
(3, 3,  'ganado',   3490, '2024-02-11 11:00:00', 'Compra online pedido #3 (349.00€ × 10)'),
(3, NULL,'canjeado',-2910,'2024-02-17 11:00:00', 'Devolución pedido #3, puntos revertidos'),
-- María (cliente 4)
(4, 4,  'ganado',  13290, '2024-03-05 09:45:00', 'Compra online pedido #4 (1329.00€ × 10)'),
(4, 6,  'ganado',   4290, '2024-05-10 18:00:00', 'Compra online pedido #6 (428.99€ × 10)'),
(4, NULL,'canjeado',-9780,'2024-06-01 10:00:00', 'Canje 9780 puntos = 97.80€ descuento'),
-- Andrés (cliente 5)
(5, 5,  'ganado',   8490, '2024-04-20 14:20:00', 'Compra online pedido #5 (849.00€ × 10)'),
(5, NULL,'canjeado',-8290,'2024-05-10 09:00:00', 'Canje en tienda física'),
-- Tomás (cliente 7)
(7, 8,  'ganado',  12990, '2024-09-03 08:15:00', 'Compra online pedido #8 (1299.00€ × 10)'),
(7, NULL,'canjeado',-8890,'2024-10-01 09:00:00', 'Canje 8890 puntos = 88.90€ descuento'),
-- Beatriz (cliente 8)
(8, 9,  'ganado',   6990, '2024-10-28 17:45:00', 'Compra online pedido #9 (699.00€ × 10)'),
(8, NULL,'canjeado',-6340,'2024-11-01 11:00:00', 'Canje en tienda'),
-- Fernando (cliente 9)
(9, 11, 'ganado',   2790, '2024-12-02 09:00:00', 'Compra online pedido #11 (279.00€ × 10)'),
(9, NULL,'ganado',   690, '2024-11-15 17:45:00', 'Compra presencial tienda Barcelona');


-- =============================================================
--  FIN DE DATOS
-- =============================================================

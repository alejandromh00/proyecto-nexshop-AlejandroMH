-- =============================================================
--  NexShop Group S.A. — schema.sql
--  Modelo relacional completo
--  Autor : Alejandro Morales Hermosín
--  Motor  : MySQL 8.x / MariaDB 10.6+
-- =============================================================

DROP DATABASE IF EXISTS nexshop;
CREATE DATABASE nexshop
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE nexshop;

-- =============================================================
--  1. INFRAESTRUCTURA
-- =============================================================

-- ------------------------------------------------------------
--  Sede
--  Representa cada ubicación física de NexShop: las tres
--  tiendas y el almacén central de Valencia.
-- ------------------------------------------------------------
CREATE TABLE Sede (
    id_sede         INT             NOT NULL AUTO_INCREMENT,
    nombre          VARCHAR(100)    NOT NULL,
    tipo            ENUM('tienda_fisica','almacen_central') NOT NULL,
    ciudad          VARCHAR(100)    NOT NULL,
    direccion       VARCHAR(255)    NULL,
    email_contacto  VARCHAR(150)    NULL,
    CONSTRAINT pk_sede          PRIMARY KEY (id_sede),
    CONSTRAINT uq_sede_email    UNIQUE      (email_contacto)
) ENGINE=InnoDB;


-- ------------------------------------------------------------
--  Empleado
--  Personal de la empresa. Cada empleado está asignado a una
--  sede. El campo cargo indica su rol (encargado, vendedor…).
-- ------------------------------------------------------------
CREATE TABLE Empleado (
    id_empleado         INT             NOT NULL AUTO_INCREMENT,
    nombre              VARCHAR(100)    NOT NULL,
    apellidos           VARCHAR(150)    NOT NULL,
    dni                 VARCHAR(20)     NOT NULL,
    email_corporativo   VARCHAR(150)    NOT NULL,
    fecha_incorporacion DATE            NOT NULL,
    id_sede             INT             NOT NULL,
    cargo               VARCHAR(100)    NULL,
    activo              TINYINT(1)      NOT NULL DEFAULT 1,
    CONSTRAINT pk_empleado          PRIMARY KEY (id_empleado),
    CONSTRAINT uq_empleado_dni      UNIQUE      (dni),
    CONSTRAINT uq_empleado_email    UNIQUE      (email_corporativo),
    CONSTRAINT fk_empleado_sede     FOREIGN KEY (id_sede)
        REFERENCES Sede(id_sede)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;


-- =============================================================
--  2. CLIENTES Y DIRECCIONES
-- =============================================================

-- ------------------------------------------------------------
--  Cliente
--  Unifica clientes registrados online y anónimos presenciales
--  en una sola tabla. Los campos de datos personales admiten
--  NULL para el caso anónimo. La vinculación futura se resuelve
--  actualizando tipo_cliente y completando los campos.
-- ------------------------------------------------------------
CREATE TABLE Cliente (
    id_cliente      INT             NOT NULL AUTO_INCREMENT,
    nombre          VARCHAR(100)    NULL,
    apellidos       VARCHAR(150)    NULL,
    email           VARCHAR(150)    NULL,
    password_hash   VARCHAR(255)    NULL,
    fecha_nacimiento DATE           NULL,
    tipo_cliente    ENUM('registrado','anonimo') NOT NULL DEFAULT 'anonimo',
    fecha_registro  DATETIME        NULL,
    activo          TINYINT(1)      NOT NULL DEFAULT 1,
    puntos_saldo    INT             NOT NULL DEFAULT 0,
    CONSTRAINT pk_cliente       PRIMARY KEY (id_cliente),
    CONSTRAINT uq_cliente_email UNIQUE      (email),
    CONSTRAINT ck_cliente_puntos CHECK (puntos_saldo >= 0)
) ENGINE=InnoDB;


-- ------------------------------------------------------------
--  Direccion
--  Direcciones de envío de un cliente registrado (1:N).
-- ------------------------------------------------------------
CREATE TABLE Direccion (
    id_direccion    INT             NOT NULL AUTO_INCREMENT,
    id_cliente      INT             NOT NULL,
    alias           VARCHAR(50)     NULL,
    calle           VARCHAR(255)    NOT NULL,
    numero          VARCHAR(10)     NULL,
    piso            VARCHAR(20)     NULL,
    codigo_postal   VARCHAR(10)     NOT NULL,
    ciudad          VARCHAR(100)    NOT NULL,
    pais            VARCHAR(100)    NOT NULL DEFAULT 'España',
    predeterminada  TINYINT(1)      NOT NULL DEFAULT 0,
    CONSTRAINT pk_direccion         PRIMARY KEY (id_direccion),
    CONSTRAINT fk_direccion_cliente FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id_cliente)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;


-- =============================================================
--  3. CATÁLOGO
-- =============================================================

-- ------------------------------------------------------------
--  Categoria
-- ------------------------------------------------------------
CREATE TABLE Categoria (
    id_categoria        INT             NOT NULL AUTO_INCREMENT,
    nombre_categoria    VARCHAR(100)    NOT NULL,
    CONSTRAINT pk_categoria         PRIMARY KEY (id_categoria),
    CONSTRAINT uq_categoria_nombre  UNIQUE      (nombre_categoria)
) ENGINE=InnoDB;


-- ------------------------------------------------------------
--  Subcategoria
-- ------------------------------------------------------------
CREATE TABLE Subcategoria (
    id_subcategoria     INT             NOT NULL AUTO_INCREMENT,
    id_categoria        INT             NOT NULL,
    nombre_subcategoria VARCHAR(100)    NOT NULL,
    descripcion         TEXT            NULL,
    CONSTRAINT pk_subcategoria          PRIMARY KEY (id_subcategoria),
    CONSTRAINT fk_subcategoria_cat      FOREIGN KEY (id_categoria)
        REFERENCES Categoria(id_categoria)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;


-- ------------------------------------------------------------
--  Producto
--  pvp_actual almacena el precio vigente. El historial de
--  cambios se registra en HistoricoPrecioProducto.
-- ------------------------------------------------------------
CREATE TABLE Producto (
    id_producto     INT             NOT NULL AUTO_INCREMENT,
    id_subcategoria INT             NOT NULL,
    nombre          VARCHAR(200)    NOT NULL,
    descripcion     TEXT            NULL,
    sku             VARCHAR(50)     NOT NULL,
    pvp_actual      DECIMAL(10,2)   NOT NULL,
    activo          TINYINT(1)      NOT NULL DEFAULT 1,
    CONSTRAINT pk_producto          PRIMARY KEY (id_producto),
    CONSTRAINT uq_producto_sku      UNIQUE      (sku),
    CONSTRAINT ck_producto_pvp      CHECK       (pvp_actual > 0),
    CONSTRAINT fk_producto_subcat   FOREIGN KEY (id_subcategoria)
        REFERENCES Subcategoria(id_subcategoria)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;


-- ------------------------------------------------------------
--  HistoricoPrecioProducto
--  Registra cada cambio de PVP del producto con su período de
--  vigencia. fecha_fin = NULL indica que es el precio actual.
-- ------------------------------------------------------------
CREATE TABLE HistoricoPrecioProducto (
    id_historico    INT             NOT NULL AUTO_INCREMENT,
    id_producto     INT             NOT NULL,
    pvp             DECIMAL(10,2)   NOT NULL,
    fecha_inicio    DATE            NOT NULL,
    fecha_fin       DATE            NULL,
    CONSTRAINT pk_historico_precio      PRIMARY KEY (id_historico),
    CONSTRAINT ck_historico_pvp         CHECK       (pvp > 0),
    CONSTRAINT ck_historico_fechas      CHECK       (fecha_fin IS NULL OR fecha_fin > fecha_inicio),
    CONSTRAINT fk_historico_producto    FOREIGN KEY (id_producto)
        REFERENCES Producto(id_producto)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;


-- =============================================================
--  4. PROVEEDORES
-- =============================================================

-- ------------------------------------------------------------
--  Proveedor
--  id_representante es la FK al empleado de NexShop asignado.
-- ------------------------------------------------------------
CREATE TABLE Proveedor (
    id_proveedor        INT             NOT NULL AUTO_INCREMENT,
    razon_social        VARCHAR(200)    NOT NULL,
    cif                 VARCHAR(20)     NULL,
    email               VARCHAR(150)    NULL,
    telefono            VARCHAR(20)     NULL,
    id_representante    INT             NULL,
    CONSTRAINT pk_proveedor             PRIMARY KEY (id_proveedor),
    CONSTRAINT uq_proveedor_cif         UNIQUE      (cif),
    CONSTRAINT fk_proveedor_empleado    FOREIGN KEY (id_representante)
        REFERENCES Empleado(id_empleado)
        ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;


-- ------------------------------------------------------------
--  ProductoProveedor  [tabla puente N:M con historial]
--  Cada fila registra las condiciones pactadas para un par
--  producto-proveedor en un período. fecha_fin = NULL = vigente.
-- ------------------------------------------------------------
CREATE TABLE ProductoProveedor (
    id_pp               INT             NOT NULL AUTO_INCREMENT,
    id_producto         INT             NOT NULL,
    id_proveedor        INT             NOT NULL,
    precio_coste        DECIMAL(10,2)   NOT NULL,
    plazo_entrega_dias  INT             NOT NULL,
    fecha_inicio        DATE            NOT NULL,
    fecha_fin           DATE            NULL,
    CONSTRAINT pk_producto_proveedor        PRIMARY KEY (id_pp),
    CONSTRAINT ck_pp_precio                 CHECK (precio_coste > 0),
    CONSTRAINT ck_pp_plazo                  CHECK (plazo_entrega_dias > 0),
    CONSTRAINT ck_pp_fechas                 CHECK (fecha_fin IS NULL OR fecha_fin > fecha_inicio),
    CONSTRAINT fk_pp_producto               FOREIGN KEY (id_producto)
        REFERENCES Producto(id_producto)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_pp_proveedor              FOREIGN KEY (id_proveedor)
        REFERENCES Proveedor(id_proveedor)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;


-- =============================================================
--  5. PROMOCIONES Y STOCK
-- =============================================================

-- ------------------------------------------------------------
--  Promocion
-- ------------------------------------------------------------
CREATE TABLE Promocion (
    id_promocion    INT             NOT NULL AUTO_INCREMENT,
    nombre          VARCHAR(150)    NOT NULL,
    descuento_pct   DECIMAL(5,2)    NOT NULL,
    fecha_inicio    DATE            NOT NULL,
    fecha_fin       DATE            NOT NULL,
    CONSTRAINT pk_promocion         PRIMARY KEY (id_promocion),
    CONSTRAINT ck_promocion_desc    CHECK (descuento_pct > 0 AND descuento_pct <= 100),
    CONSTRAINT ck_promocion_fechas  CHECK (fecha_fin >= fecha_inicio)
) ENGINE=InnoDB;


-- ------------------------------------------------------------
--  PromocionProducto  [tabla puente N:M]
--  PK compuesta garantiza que un producto aparece una sola vez
--  por promoción.
-- ------------------------------------------------------------
CREATE TABLE PromocionProducto (
    id_promocion    INT NOT NULL,
    id_producto     INT NOT NULL,
    CONSTRAINT pk_promo_producto        PRIMARY KEY (id_promocion, id_producto),
    CONSTRAINT fk_pp2_promocion         FOREIGN KEY (id_promocion)
        REFERENCES Promocion(id_promocion)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_pp2_producto          FOREIGN KEY (id_producto)
        REFERENCES Producto(id_producto)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;


-- ------------------------------------------------------------
--  StockUbicacion  [tabla puente N:M]
--  Un registro por combinación producto-sede.
-- ------------------------------------------------------------
CREATE TABLE StockUbicacion (
    id_stock        INT     NOT NULL AUTO_INCREMENT,
    id_producto     INT     NOT NULL,
    id_sede         INT     NOT NULL,
    cantidad        INT     NOT NULL DEFAULT 0,
    CONSTRAINT pk_stock_ubicacion       PRIMARY KEY (id_stock),
    CONSTRAINT uq_stock_prod_sede       UNIQUE      (id_producto, id_sede),
    CONSTRAINT ck_stock_cantidad        CHECK       (cantidad >= 0),
    CONSTRAINT fk_stock_producto        FOREIGN KEY (id_producto)
        REFERENCES Producto(id_producto)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_stock_sede            FOREIGN KEY (id_sede)
        REFERENCES Sede(id_sede)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;


-- =============================================================
--  6. CANAL ONLINE
-- =============================================================

-- ------------------------------------------------------------
--  PedidoOnline
-- ------------------------------------------------------------
CREATE TABLE PedidoOnline (
    id_pedido           INT             NOT NULL AUTO_INCREMENT,
    id_cliente          INT             NOT NULL,
    id_direccion        INT             NOT NULL,
    fecha_pedido        DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado              ENUM('pendiente','en_proceso','enviado','entregado','cancelado')
                                        NOT NULL DEFAULT 'pendiente',
    total               DECIMAL(10,2)   NOT NULL,
    puntos_canjeados    INT             NOT NULL DEFAULT 0,
    CONSTRAINT pk_pedido_online         PRIMARY KEY (id_pedido),
    CONSTRAINT ck_pedido_total          CHECK (total >= 0),
    CONSTRAINT ck_pedido_puntos         CHECK (puntos_canjeados >= 0),
    CONSTRAINT fk_pedido_cliente        FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id_cliente)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_pedido_direccion      FOREIGN KEY (id_direccion)
        REFERENCES Direccion(id_direccion)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;


-- ------------------------------------------------------------
--  LineaPedidoOnline  [tabla puente N:M]
--  precio_unitario es un snapshot del PVP en el momento de la
--  compra, ya que pvp_actual en Producto puede cambiar.
-- ------------------------------------------------------------
CREATE TABLE LineaPedidoOnline (
    id_linea            INT             NOT NULL AUTO_INCREMENT,
    id_pedido           INT             NOT NULL,
    id_producto         INT             NOT NULL,
    cantidad            INT             NOT NULL,
    precio_unitario     DECIMAL(10,2)   NOT NULL,
    descuento_aplicado  DECIMAL(5,2)    NOT NULL DEFAULT 0.00,
    CONSTRAINT pk_linea_pedido          PRIMARY KEY (id_linea),
    CONSTRAINT ck_lpo_cantidad          CHECK (cantidad > 0),
    CONSTRAINT ck_lpo_precio            CHECK (precio_unitario > 0),
    CONSTRAINT ck_lpo_descuento         CHECK (descuento_aplicado >= 0 AND descuento_aplicado <= 100),
    CONSTRAINT fk_lpo_pedido            FOREIGN KEY (id_pedido)
        REFERENCES PedidoOnline(id_pedido)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_lpo_producto          FOREIGN KEY (id_producto)
        REFERENCES Producto(id_producto)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;


-- ------------------------------------------------------------
--  Envio
--  Un pedido online puede generar varios envíos parciales
--  desde distintos almacenes (1:N con PedidoOnline).
-- ------------------------------------------------------------
CREATE TABLE Envio (
    id_envio                INT             NOT NULL AUTO_INCREMENT,
    id_pedido               INT             NOT NULL,
    id_sede_origen          INT             NOT NULL,
    numero_seguimiento      VARCHAR(100)    NULL,
    transportista           VARCHAR(100)    NULL,
    fecha_estimada_entrega  DATE            NULL,
    fecha_entrega_real      DATE            NULL,
    estado                  ENUM('preparando','enviado','entregado','incidencia')
                                            NOT NULL DEFAULT 'preparando',
    CONSTRAINT pk_envio                 PRIMARY KEY (id_envio),
    CONSTRAINT uq_envio_seguimiento     UNIQUE      (numero_seguimiento),
    CONSTRAINT fk_envio_pedido          FOREIGN KEY (id_pedido)
        REFERENCES PedidoOnline(id_pedido)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_envio_sede            FOREIGN KEY (id_sede_origen)
        REFERENCES Sede(id_sede)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;


-- =============================================================
--  7. CANAL PRESENCIAL
-- =============================================================

-- ------------------------------------------------------------
--  VentaPresencial
--  id_cliente puede ser NULL si el cliente es anónimo y no
--  tiene ficha en el sistema.
-- ------------------------------------------------------------
CREATE TABLE VentaPresencial (
    id_venta    INT             NOT NULL AUTO_INCREMENT,
    id_sede     INT             NOT NULL,
    id_empleado INT             NOT NULL,
    id_cliente  INT             NULL,
    fecha_venta DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total       DECIMAL(10,2)   NOT NULL,
    CONSTRAINT pk_venta_presencial      PRIMARY KEY (id_venta),
    CONSTRAINT ck_venta_total           CHECK (total >= 0),
    CONSTRAINT fk_venta_sede            FOREIGN KEY (id_sede)
        REFERENCES Sede(id_sede)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_venta_empleado        FOREIGN KEY (id_empleado)
        REFERENCES Empleado(id_empleado)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_venta_cliente         FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id_cliente)
        ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;


-- ------------------------------------------------------------
--  LineaVentaPresencial  [tabla puente N:M]
-- ------------------------------------------------------------
CREATE TABLE LineaVentaPresencial (
    id_linea        INT             NOT NULL AUTO_INCREMENT,
    id_venta        INT             NOT NULL,
    id_producto     INT             NOT NULL,
    cantidad        INT             NOT NULL,
    precio_unitario DECIMAL(10,2)   NOT NULL,
    CONSTRAINT pk_linea_venta           PRIMARY KEY (id_linea),
    CONSTRAINT ck_lvp_cantidad          CHECK (cantidad > 0),
    CONSTRAINT ck_lvp_precio            CHECK (precio_unitario > 0),
    CONSTRAINT fk_lvp_venta             FOREIGN KEY (id_venta)
        REFERENCES VentaPresencial(id_venta)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_lvp_producto          FOREIGN KEY (id_producto)
        REFERENCES Producto(id_producto)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;


-- ------------------------------------------------------------
--  DevolucionPresencial
--  Vinculada al ticket de venta original.
-- ------------------------------------------------------------
CREATE TABLE DevolucionPresencial (
    id_devolucion   INT             NOT NULL AUTO_INCREMENT,
    id_venta        INT             NOT NULL,
    id_producto     INT             NOT NULL,
    cantidad        INT             NOT NULL,
    fecha_devolucion DATE           NOT NULL DEFAULT (CURRENT_DATE),
    motivo          TEXT            NULL,
    CONSTRAINT pk_devolucion            PRIMARY KEY (id_devolucion),
    CONSTRAINT ck_dev_cantidad          CHECK (cantidad > 0),
    CONSTRAINT fk_dev_venta             FOREIGN KEY (id_venta)
        REFERENCES VentaPresencial(id_venta)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_dev_producto          FOREIGN KEY (id_producto)
        REFERENCES Producto(id_producto)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;


-- =============================================================
--  8. LOGÍSTICA
-- =============================================================

-- ------------------------------------------------------------
--  TransferenciaStock
--  Movimiento de stock entre sedes. Dos FK a Sede (origen /
--  destino). El empleado que la autoriza también se registra.
-- ------------------------------------------------------------
CREATE TABLE TransferenciaStock (
    id_transferencia        INT     NOT NULL AUTO_INCREMENT,
    id_producto             INT     NOT NULL,
    id_sede_origen          INT     NOT NULL,
    id_sede_destino         INT     NOT NULL,
    cantidad                INT     NOT NULL,
    fecha                   DATE    NOT NULL,
    id_empleado_autoriza    INT     NOT NULL,
    CONSTRAINT pk_transferencia             PRIMARY KEY (id_transferencia),
    CONSTRAINT ck_trans_cantidad            CHECK (cantidad > 0),
    CONSTRAINT ck_trans_sedes_distintas     CHECK (id_sede_origen <> id_sede_destino),
    CONSTRAINT fk_trans_producto            FOREIGN KEY (id_producto)
        REFERENCES Producto(id_producto)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_trans_sede_origen         FOREIGN KEY (id_sede_origen)
        REFERENCES Sede(id_sede)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_trans_sede_destino        FOREIGN KEY (id_sede_destino)
        REFERENCES Sede(id_sede)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_trans_empleado            FOREIGN KEY (id_empleado_autoriza)
        REFERENCES Empleado(id_empleado)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;


-- =============================================================
--  9. ATENCIÓN AL CLIENTE
-- =============================================================

-- ------------------------------------------------------------
--  Ticket
--  id_pedido es nullable (no todos los tickets vienen de un
--  pedido). id_cliente es nullable (clientes anónimos).
-- ------------------------------------------------------------
CREATE TABLE Ticket (
    id_ticket       INT             NOT NULL AUTO_INCREMENT,
    id_cliente      INT             NULL,
    id_empleado     INT             NOT NULL,
    id_pedido       INT             NULL,
    asunto          VARCHAR(255)    NOT NULL,
    descripcion     TEXT            NULL,
    fecha_apertura  DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado          ENUM('abierto','en_gestion','resuelto') NOT NULL DEFAULT 'abierto',
    fecha_cierre    DATETIME        NULL,
    nota_resolucion TEXT            NULL,
    CONSTRAINT pk_ticket                PRIMARY KEY (id_ticket),
    CONSTRAINT fk_ticket_cliente        FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id_cliente)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_ticket_empleado       FOREIGN KEY (id_empleado)
        REFERENCES Empleado(id_empleado)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_ticket_pedido         FOREIGN KEY (id_pedido)
        REFERENCES PedidoOnline(id_pedido)
        ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;


-- =============================================================
--  10. MARKETING Y FIDELIZACIÓN
-- =============================================================

-- ------------------------------------------------------------
--  Valoracion
--  UNIQUE (id_cliente, id_producto): un cliente solo puede
--  valorar una vez cada producto. verificada = 1 indica que
--  el cliente ha comprado ese producto.
-- ------------------------------------------------------------
CREATE TABLE Valoracion (
    id_valoracion       INT             NOT NULL AUTO_INCREMENT,
    id_cliente          INT             NOT NULL,
    id_producto         INT             NOT NULL,
    puntuacion          TINYINT         NOT NULL,
    comentario          TEXT            NULL,
    fecha_valoracion    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    verificada          TINYINT(1)      NOT NULL DEFAULT 0,
    CONSTRAINT pk_valoracion            PRIMARY KEY (id_valoracion),
    CONSTRAINT uq_valoracion_cli_prod   UNIQUE      (id_cliente, id_producto),
    CONSTRAINT ck_valoracion_puntos     CHECK       (puntuacion BETWEEN 1 AND 5),
    CONSTRAINT fk_valoracion_cliente    FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id_cliente)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_valoracion_producto   FOREIGN KEY (id_producto)
        REFERENCES Producto(id_producto)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;


-- ------------------------------------------------------------
--  MovimientoPuntos
--  Fuente de verdad del programa de fidelización.
--  El saldo siempre se calcula con:
--    SELECT SUM(puntos) FROM MovimientoPuntos WHERE id_cliente = ?
--  puntos puede ser positivo (ganado) o negativo (canjeado).
-- ------------------------------------------------------------
CREATE TABLE MovimientoPuntos (
    id_movimiento   INT             NOT NULL AUTO_INCREMENT,
    id_cliente      INT             NOT NULL,
    id_pedido       INT             NULL,
    tipo            ENUM('ganado','canjeado') NOT NULL,
    puntos          INT             NOT NULL,
    fecha           DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descripcion     VARCHAR(255)    NULL,
    CONSTRAINT pk_movimiento_puntos     PRIMARY KEY (id_movimiento),
    CONSTRAINT fk_mp_cliente            FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id_cliente)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_mp_pedido             FOREIGN KEY (id_pedido)
        REFERENCES PedidoOnline(id_pedido)
        ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;


-- =============================================================
--  FIN DE SCHEMA
-- =============================================================

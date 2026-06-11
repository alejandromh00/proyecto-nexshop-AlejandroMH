# 🛍️ NexShop Group S.A. — Base de Datos

**Autor:** Alejandro Morales Hermosín  
**Nivel:** Intermedio–Avanzado · Modalidad Individual  
**Motor:** MySQL 8.x / MariaDB 10.6+

---

## 📋 Descripción del proyecto

Diseño e implementación completa de la base de datos relacional para **NexShop Group S.A.**, empresa de distribución y venta al por menor con tienda online y tres tiendas físicas (Valencia, Madrid y Barcelona).

El modelo cubre dos canales de venta independientes, gestión de stock por ubicación, programa de fidelización por puntos, atención al cliente, logística de envíos y transferencias internas de stock.

---

## 🗂️ Estructura del repositorio

```
mi-proyecto-nexshop/
│
├── README.md
│
├── docs/
│   ├── memoria.pdf              ← Fase 1: análisis, entidades, relaciones y preguntas de reflexión
│   ├── diagrama_er.pdf          ← Fase 2: diagrama Entidad–Relación completo (A3 apaisado)
│   └── modelo_relacional.pdf    ← Fase 3: notación relacional, FKs y resolución de N:M
│
├── sql/
│   ├── schema.sql               ← Fase 4: CREATE TABLE, restricciones y claves foráneas
│   └── datos.sql                ← Fase 4: INSERT con datos de prueba realistas
│
└── consultas/
    └── consultas.sql            ← Fase 5: 14 consultas comentadas
```

---

## 🏗️ Resumen del modelo

| Elemento | Cantidad |
|---|---|
| Tablas | 23 |
| Relaciones N:M resueltas con tabla puente | 5 |
| Claves foráneas | 28 |
| Restricciones CHECK | 12 |
| Registros de prueba (aprox.) | ~300 |

**Tablas principales:** `Sede`, `Empleado`, `Cliente`, `Direccion`, `Categoria`, `Subcategoria`, `Producto`, `HistoricoPrecioProducto`, `Proveedor`, `ProductoProveedor`, `Promocion`, `PromocionProducto`, `StockUbicacion`, `PedidoOnline`, `LineaPedidoOnline`, `Envio`, `VentaPresencial`, `LineaVentaPresencial`, `DevolucionPresencial`, `TransferenciaStock`, `Ticket`, `Valoracion`, `MovimientoPuntos`




---

## 📄 Fases del proyecto

| Fase | Entregable | Descripción |
|---|---|---|
| 1 | `docs/memoria.pdf` | Identificación de entidades, atributos, relaciones y 6 preguntas de reflexión |
| 2 | `docs/diagrama_er.pdf` | Diagrama ER completo con cardinalidades |
| 3 | `docs/modelo_relacional.pdf` | Notación relacional, FKs y resolución de N:M |
| 4 | `sql/schema.sql` + `sql/datos.sql` | DDL completo y datos de prueba |
| 5 | `consultas/consultas.sql` | 14 consultas SQL comentadas |

---

## 🛠️ Tecnologías utilizadas

- **MySQL 8 / MariaDB 10.6**
- **MySQL Workbench**
- **XAMPP**
- **Python + ReportLab** (generación de diagramas y documentos)
- **Node.js + docx** (generación de memoria en Word)

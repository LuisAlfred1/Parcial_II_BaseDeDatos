--Script de modificaciones

--En clientes(pacientes) agregué los campos que faltaban
ALTER TABLE parcialii.cliente
ADD
genero VARCHAR(10),
ocupacion VARCHAR(100),
estado_civil VARCHAR(50),
contactos_emergencia VARCHAR(255);

--Cree la tabla de sucursales
CREATE TABLE parcialii.sucursal (
  id_sucursal INT PRIMARY KEY IDENTITY,
  nombre VARCHAR(255) NOT NULL,
  direccion VARCHAR(500)
);

--Cree la tabla de citas
CREATE TABLE parcialii.cita (
  id_cita INT PRIMARY KEY IDENTITY,
  id_cliente INT NOT NULL,
  id_sucursal INT NOT NULL,
  id_servicio INT NOT NULL,
  fecha_hora DATETIME NOT NULL,
  estado VARCHAR(20) CHECK (estado IN ('PROGRAMADA', 'CANCELADA', 'COMPLETADA')),
  fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_cliente) REFERENCES parcialii.cliente(id_cliente),
  FOREIGN KEY (id_sucursal) REFERENCES parcialii.sucursal(id_sucursal),
  FOREIGN KEY (id_servicio) REFERENCES parcialii.servicio(id_servicio)
);

--Cree la tabla de Historias clinicas
CREATE TABLE parcialii.historia_clinica (
  id_historia INT PRIMARY KEY IDENTITY,
  id_cliente INT NOT NULL,
  id_sucursal INT NOT NULL,
  diagnostico TEXT,
  tratamiento TEXT,
  procedimiento TEXT,
  fecha_registro DATE NOT NULL DEFAULT GETDATE(),
  FOREIGN KEY (id_cliente) REFERENCES parcialii.cliente(id_cliente),
  FOREIGN KEY (id_sucursal) REFERENCES parcialii.sucursal(id_sucursal)
);

--Cree la tabla de pagos
CREATE TABLE parcialii.pago (
  id_pago INT PRIMARY KEY IDENTITY,
  id_cliente INT NOT NULL,
  cantidad DECIMAL(10,2) NOT NULL,
  metodo_pago VARCHAR(50) NOT NULL,
  id_sucursal INT NOT NULL,
  fecha_pago DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_cliente) REFERENCES parcialii.cliente(id_cliente),
  FOREIGN KEY (id_sucursal) REFERENCES parcialii.sucursal(id_sucursal)
);

--Cree la tabla de comisiones
CREATE TABLE parcialii.comision (
  id_comision INT PRIMARY KEY IDENTITY,
  id_empleado INT NOT NULL,
  id_servicio INT NOT NULL,
  id_sucursal INT NOT NULL,
  periodo VARCHAR(10) CHECK (periodo IN ('15 días', '30 días')),
  monto DECIMAL(10,2) NOT NULL,
  estatus VARCHAR(20) CHECK (estatus IN ('PENDIENTE', 'PAGADO')),
  fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_empleado) REFERENCES parcialii.empleado(id_empleado),
  FOREIGN KEY (id_servicio) REFERENCES parcialii.servicio(id_servicio),
  FOREIGN KEY (id_sucursal) REFERENCES parcialii.sucursal(id_sucursal)
);

--Cree la tabla de Inventario
CREATE TABLE parcialii.inventario (
  id_inventario INT PRIMARY KEY IDENTITY,
  nombre_producto VARCHAR(255) NOT NULL,
  cantidad INT NOT NULL,
  unidad_medida VARCHAR(50),
  precio DECIMAL(10,2),
  proveedor VARCHAR(255),
  id_sucursal INT NOT NULL,
  fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_sucursal) REFERENCES parcialii.sucursal(id_sucursal)
);


--Cree la tabla de procedimientos esteticos
CREATE TABLE parcialii.procedimiento (
  id_procedimiento INT PRIMARY KEY IDENTITY,
  nombre VARCHAR(255) NOT NULL,
  descripcion TEXT,
  duracion VARCHAR(50),
  costo DECIMAL(10,2) NOT NULL
);

--Cree la tabla de ventas
CREATE TABLE parcialii.venta (
  id_venta INT PRIMARY KEY IDENTITY,
  id_producto INT,
  id_servicio INT,
  cantidad INT NOT NULL,
  precio_venta DECIMAL(10,2) NOT NULL,
  fecha_venta DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_producto) REFERENCES parcialii.producto(id_producto),
  FOREIGN KEY (id_servicio) REFERENCES parcialii.servicio(id_servicio)
);

--En la tabla de empleados agregué los campos que faltaban
ALTER TABLE parcialii.empleado
ADD 
  direccion VARCHAR(255),
  genero VARCHAR(10),
  ocupacion VARCHAR(100),
  estado_civil VARCHAR(50),
  numero_identificacion VARCHAR(20),
  id_sucursal INT,
  FOREIGN KEY (id_sucursal) REFERENCES parcialii.sucursal(id_sucursal);







-- SCRIPT "GK Innovatech"
-- INSERCIÓN DEL LOTE DE DATOS
USE GK_Innovatech;

-- Datos de prueba para la tabla Rol
INSERT INTO Rol (Descripcion, Fecha_Registro) VALUES
('Administrador', '2024-09-01'),
('Vendedor', '2024-09-02'),
('Cliente', '2024-09-03');

-- Datos de prueba para la tabla Cliente
INSERT INTO Cliente (Documento_Cliente, Nombre, Apellido, Correo, Telefono, Estado, Fecha_Registro) VALUES
(12345678, 'Gio', 'Perez', 'gio.perez@gmail.com', '555-1234', 1, '2024-09-10'),
(87654321, 'Kevin', 'Gomez', 'kevin.gomez@yahoo.com', '555-5678', 1, '2024-09-11'),
(11223344, 'Mari', 'Lopez', 'mari.lopez@hotmail.com', '555-8765', 1, '2024-09-12');

-- Datos de prueba para la tabla Proveedor
INSERT INTO Proveedor (Documento_Proveedor, Razon_Social, Correo, Telefono, Estado, Fecha_Registro) VALUES
(10020030, 'Proveedor A', 'contacto@provA.com', '555-0001', 1, '2024-09-01'),
(10030040, 'Proveedor B', 'ventas@provB.com', '555-0002', 1, '2024-09-05'),
(10040050, 'Proveedor C', 'info@provC.com', '555-0003', 1, '2024-09-10');

-- Datos de prueba para la tabla Usuario
INSERT INTO Usuario (Documento_Usuario, Nombre, Apellido, Correo, Clave, Estado, Fecha_Registro, Id_Rol) VALUES
(10203040, 'Juan', 'Garcia', 'juan.garcia@correo.com', 'password123', 1, '2024-09-05', 1),
(20406080, 'Ana', 'Martinez', 'ana.martinez@correo.com', 'password456', 1, '2024-09-06', 2),
(30609010, 'Luis', 'Rodriguez', 'luis.rodriguez@correo.com', 'password789', 1, '2024-09-07', 3);

-- Datos de prueba para la tabla Categorias
INSERT INTO Categorias (Descripcion_Categoria, Estado, Fecha_Registro) VALUES
('Electrónica', 1, '2024-09-01'),
('Accesorios', 1, '2024-09-02'),
('Componentes', 1, '2024-09-03');

-- Datos de prueba para la tabla Tipo_Documento
INSERT INTO Tipo_Documento (Descripcion) VALUES
('Factura'),
('Boleta'),
('Recibo');

-- Datos de prueba para la tabla Productos
INSERT INTO Productos (Codigo_Producto, Nombre_Producto, Descripcion_Producto, Stock, Precio_Compra, Precio_Venta, Estado, Fecha_Registro, Id_Categoría, Id_Proveedor) VALUES
('PROD001', 'Laptop', 'Laptop 14 pulgadas', 50, 500.00, 650.00, 1, '2024-09-05', 1, 1),
('PROD002', 'Teclado', 'Teclado mecánico', 100, 20.00, 35.00, 1, '2024-09-06', 2, 2),
('PROD003', 'Mouse', 'Mouse inalámbrico', 200, 10.00, 20.00, 1, '2024-09-07', 2, 3),
('PROD004', 'Monitor', 'Monitor LED 24 pulgadas', 30, 100.00, 150.00, 1, '2024-09-08', 3, 1),
('PROD005', 'Cargador USB', 'Cargador rápido USB', 200, 5.00, 15.00, 1, '2024-09-09', 2, 2),
('PROD006', 'Memoria USB', 'Memoria USB 32GB', 150, 8.00, 20.00, 1, '2024-09-10', 2, 3),
('PROD007', 'Auriculares', 'Auriculares Bluetooth', 120, 18.00, 35.00, 1, '2024-09-11', 2, 1),
('PROD008', 'Smartphone', 'Smartphone 128GB', 40, 200.00, 300.00, 1, '2024-09-12', 1, 2),
('PROD009', 'Tablet', 'Tablet 10 pulgadas', 60, 150.00, 220.00, 1, '2024-09-13', 1, 3),
('PROD010', 'Fuente de Poder', 'Fuente de poder 500W', 25, 35.00, 60.00, 1, '2024-09-14', 3, 1);

-- Datos de prueba para la tabla Compra
INSERT INTO Compra (Numero_Documento, Monto_Total, Fecha_Registro, Id_Usuario, Id_TipoDocumento) VALUES
(2024001, 1000.00, '2024-09-15', 1, 1),
(2024002, 500.00, '2024-09-16', 2, 2);

-- Datos de prueba para la tabla Venta
INSERT INTO Venta (Numero_Documento, Monto_Pago, Monto_Total, Fecha_Registro, Id_Cliente, Id_Usuario, Id_TipoDocumento) VALUES
(2024001, 200.00, 220.00, '2024-09-20', 1, 2, 1),
(2024002, 300.00, 320.00, '2024-09-21', 2, 3, 2);

-- Datos de prueba para la tabla Detalle_Compra
INSERT INTO Detalle_Compra (Cantidad, SubTotal, Fecha_Registro, Id_Compra, Id_Producto) VALUES
(5, 500.00, '2024-09-15', 1, 1),
(10, 200.00, '2024-09-16', 2, 2);

-- Datos de prueba para la tabla Detalle_Venta
INSERT INTO Detalle_Venta (Cantidad, SubTotal, Fecha_Registro, Id_Venta, Id_Producto) VALUES
(2, 440.00, '2024-09-20', 1, 1),
(5, 175.00, '2024-09-21', 2, 2);



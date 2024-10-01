-- SCRIPT "GK Innovatech"
-- INSERCIÓN DEL LOTE DE DATOS


-- Datos de prueba para la tabla Rol
INSERT INTO Rol (Id_Rol, Descripcion, Fecha_Registro) VALUES
(1, 'Administrador', '2024-09-01'),
(2, 'Vendedor', '2024-09-02'),
(3, 'Cliente', '2024-09-03');

-- Datos de prueba para la tabla Cliente
INSERT INTO Cliente (Id_Cliente, Documento_Cliente, Nombre, Apellido, Correo, Telefono, Estado, Fecha_Registro) VALUES
(1, 12345678, 'Giovanni', 'Perez', 'giovanni.perez@gmail.com', '555-1234', 1, '2024-09-10'),
(2, 87654321, 'Kevin', 'Gomez', 'kevin.gomez@yahoo.com', '555-5678', 1, '2024-09-11'),
(3, 11223344, 'Maria', 'Lopez', 'maria.lopez@hotmail.com', '555-8765', 1, '2024-09-12');

-- Datos de prueba para la tabla Proveedor
INSERT INTO Proveedor (Id_Proveedor, Documento_Proveedor, Razon_Social, Correo, Telefono, Estado, Fecha_Registro) VALUES
(1, 10020030, 'Proveedor A', 'contacto@provA.com', '555-0001', 1, '2024-09-01'),
(2, 10030040, 'Proveedor B', 'ventas@provB.com', '555-0002', 1, '2024-09-05'),
(3, 10040050, 'Proveedor C', 'info@provC.com', '555-0003', 1, '2024-09-10');

-- Datos de prueba para la tabla Usuario
INSERT INTO Usuario (Id_Usuario, Documento_Usuario, Nombre, Apellido, Correo, Clave, Estado, Fecha_Registro, Id_Rol) VALUES
(1, 10203040, 'Juan', 'Garcia', 'juan.garcia@correo.com', 'password123', 1, '2024-09-05', 1),
(2, 20406080, 'Ana', 'Martinez', 'ana.martinez@correo.com', 'password456', 1, '2024-09-06', 2),
(3, 30609010, 'Luis', 'Rodriguez', 'luis.rodriguez@correo.com', 'password789', 1, '2024-09-07', 3);

-- Datos de prueba para la tabla Categorias
INSERT INTO Categorias (Id_Categoría, Descripcion_Categoria, Estado, Fecha_Registro) VALUES
(1, 'Electrónica', 1, '2024-09-01'),
(2, 'Accesorios', 1, '2024-09-02'),
(3, 'Componentes', 1, '2024-09-03');

-- Datos de prueba para la tabla Tipo_Documento
INSERT INTO Tipo_Documento (Id_TipoDocumento, Descripcion) VALUES
(1, 'Factura'),
(2, 'Boleta'),
(3, 'Recibo');

-- Datos de prueba para la tabla Productos
INSERT INTO Productos (Id_Producto, Codigo_Producto, Nombre_Producto, Descripcion_Producto, Stock, Precio_Compra, Precio_Venta, Estado, Fecha_Registro, Id_Categoría, Id_Proveedor) VALUES
(1, 'PROD001', 'Laptop', 'Laptop 14 pulgadas', 50, 500.00, 650.00, 1, '2024-09-05', 1, 1),
(2, 'PROD002', 'Teclado', 'Teclado mecánico', 100, 20.00, 35.00, 1, '2024-09-06', 2, 2),
(3, 'PROD003', 'Mouse', 'Mouse inalámbrico', 200, 10.00, 20.00, 1, '2024-09-07', 2, 3);

-- Datos de prueba para la tabla Compra
INSERT INTO Compra (Id_Compra, Numero_Documento, Monto_Total, Fecha_Registro, Id_Usuario, Id_TipoDocumento) VALUES
(1, 2024001, 1000.00, '2024-09-15', 1, 1),
(2, 2024002, 500.00, '2024-09-16', 2, 2);

-- Datos de prueba para la tabla Venta
INSERT INTO Venta (Id_Venta, Numero_Documento, Monto_Pago, Monto_Total, Fecha_Registro, Id_Cliente, Id_Usuario, Id_TipoDocumento) VALUES
(1, 2024001, 200.00, 220.00, '2024-09-20', 1, 2, 1),
(2, 2024002, 300.00, 320.00, '2024-09-21', 2, 3, 2);

-- Datos de prueba para la tabla Detalle_Compra
INSERT INTO Detalle_Compra (Id_DetalleCompra, Cantidad, SubTotal, Fecha_Registro, Id_Compra, Id_Producto) VALUES
(1, 5, 500.00, '2024-09-15', 1, 1),
(2, 10, 200.00, '2024-09-16', 2, 2);

-- Datos de prueba para la tabla Detalle_Venta
INSERT INTO Detalle_Venta (Id_DetalleVenta, Cantidad, SubTotal, Fecha_Registro, Id_Venta, Id_Producto) VALUES
(1, 2, 440.00, '2024-09-20', 1, 1),
(2, 5, 175.00, '2024-09-21', 2, 2);


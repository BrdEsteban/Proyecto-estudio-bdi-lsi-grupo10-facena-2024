-- Usuarios Ingresados con INSERT
INSERT INTO Usuario(Documento_Usuario, Nombre, Apellido, Correo, Clave, Estado, Fecha_Registro, Id_Rol)
VALUES(11222334, 'Juan', 'Gomez', 'juan@correo.com', 'pass@123', 1, GETDATE(), 2),
      (12412443, 'Maria', 'Lopez', 'maria@correo.com', 'clave$321', 1, GETDATE(), 3),
      (98124645, 'Luis', 'Perez', 'luis@correo.com', 'contra*111', 1, GETDATE(), 2),
      (98123357, 'Ana', 'Martinez', 'ana@correo.com', 'pssw@789', 1, GETDATE(), 3);


-- Usuarios Ingresados con Procedimiento
EXEC altaUsuario @Dni = 12345678, @Nombre = 'Carlos', @Apellido = 'Sanchez', @Correo = 'carlos@correo.com', @Clave = 'clave#123', @Estado = 1, @Rol = 2;
EXEC altaUsuario @Dni = 98129412, @Nombre = 'Raul', @Apellido = 'Fernandez', @Correo = 'raul@correo.com', @Clave = 'contra%432', @Estado = 1, @Rol = 3;
EXEC altaUsuario @Dni = 19812612, @Nombre = 'Lucia', @Apellido = 'Diaz', @Correo = 'lucia@correo.com', @Clave = 'segur@543', @Estado = 1, @Rol = 2;
EXEC altaUsuario @Dni = 44162351, @Nombre = 'Fernando', @Apellido = 'Garcia', @Correo = 'fernando@correo.com', @Clave = 'clave#999', @Estado = 1, @Rol = 3;




-- Productos ingresados con INSERT
INSERT INTO Productos(Codigo_Producto, Nombre_Producto, Descripcion_Producto, Stock, Precio_Compra, Precio_Venta, Estado, Fecha_Registro, Id_Categoría, Id_Proveedor)
VALUES('CODPROD_001', 'Monitor LED 24"', 'Monitor de alta resolución', 10, 120.5, 200, 1, GETDATE(), 1, 1),
      ('CODPROD_002', 'Teclado Mecánico RGB', 'Teclado con retroiluminación RGB', 15, 50, 85, 1, GETDATE(), 2, 2),
      ('CODPROD_003', 'SSD 1TB', 'Unidad de almacenamiento de estado sólido', 8, 100, 160, 1, GETDATE(), 3, 1),
      ('CODPROD_050', 'Smartphone', 'Teléfono inteligente de última generación', 25, 300, 450, 1, GETDATE(), 6, 3);


-- Productos ingresados con Procedimiento
EXEC altaProducto @Codigo = 'CODPROD_051', @Nombre_p = 'Laptop Gamer', @Descripcion = 'Laptop de alto rendimiento', @Stock = 5, @Precio_compra = 800, @Precio_venta = 1200, @Categoria = 1, @Proveedor = 2;
EXEC altaProducto @Codigo = 'CODPROD_052', @Nombre_p = 'Mouse Inalámbrico', @Descripcion = 'Mouse con sensor óptico', @Stock = 20, @Precio_compra = 10, @Precio_venta = 25, @Categoria = 2, @Proveedor = 1;
EXEC altaProducto @Codigo = 'CODPROD_053', @Nombre_p = 'Placa Madre', @Descripcion = 'Placa para ensamblado', @Stock = 12, @Precio_compra = 150, @Precio_venta = 220, @Categoria = 3, @Proveedor = 3;
EXEC altaProducto @Codigo = 'CODPROD_100', @Nombre_p = 'Tablet', @Descripcion = 'Tablet con pantalla táctil', @Stock = 18, @Precio_compra = 150, @Precio_venta = 300, @Categoria = 6, @Proveedor = 2;


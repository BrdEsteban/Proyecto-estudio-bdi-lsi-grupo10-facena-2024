-- SCRIPT TEMA "Definicion de la base de datos"
-- DEFINNICIÓN DEL MODELO DE DATOS

Create database GK_Innovatech
GO

USE GK_Innovatech
GO


CREATE TABLE Cliente
(
  Id_Cliente INT NOT NULL,
  Documento_Cliente INT NOT NULL,
  Nombre VARCHAR(100) NOT NULL,
  Apellido VARCHAR(100) NOT NULL,
  Correo VARCHAR(100) NOT NULL,
  Telefono VARCHAR(15) NOT NULL,
  Estado INT NOT NULL,
  Fecha_Registro DATE NOT NULL,
  Constraint PK_Cliente_IdCliente PRIMARY KEY (Id_Cliente),
  Constraint UQ_Cliente_Documento UNIQUE (Documento_Cliente),
  Constraint UQ_Cliente_Correo UNIQUE (Correo)
);

CREATE TABLE Proveedor
(
  Id_Proveedor INT NOT NULL,
  Documento_Proveedor INT NOT NULL,
  Razon_Social VARCHAR(100) NOT NULL,
  Correo VARCHAR(100) NOT NULL,
  Telefono VARCHAR(15) NOT NULL,
  Estado INT NOT NULL,
  Fecha_Registro DATE NOT NULL,
  Constraint PK_Proveedor_IdProveedor PRIMARY KEY (Id_Proveedor),
  Constraint UQ_Proveedor_Documento UNIQUE (Documento_Proveedor),
  Constraint UQ_Proveedor_Correo UNIQUE (Correo)
);

CREATE TABLE Rol
(
  Id_Rol INT NOT NULL,
  Descripcion VARCHAR(80) NOT NULL,
  Fecha_Registro DATE NOT NULL,
  Constraint PK_Rol_IdRol PRIMARY KEY (Id_Rol)
);

CREATE TABLE Usuario
(
  Id_Usuario INT NOT NULL,
  Documento_Usuario INT NOT NULL,
  Nombre VARCHAR(100) NOT NULL,
  Apellido VARCHAR(100) NOT NULL,
  Correo VARCHAR(100) NOT NULL,
  Clave VARCHAR(80) NOT NULL,
  Estado INT NOT NULL,
  Fecha_Registro DATE NOT NULL,
  Id_Rol INT NOT NULL,
  Constraint PK_Usuario_IdUsuario PRIMARY KEY (Id_Usuario),
  Constraint FK_Usuario_IdRol FOREIGN KEY (Id_Rol) REFERENCES Rol(Id_Rol),
  Constraint UQ_Usuario_Documento UNIQUE (Documento_Usuario),
  Constraint UQ_Usuario_Correo UNIQUE (Correo)
);

CREATE TABLE Categorias
(
  Id_Categoría INT NOT NULL,
  Descripcion_Categoria VARCHAR(100) NOT NULL,
  Estado INT NOT NULL,
  Fecha_Registro DATE NOT NULL,
  Constraint PK_Categorias_IdCategoria PRIMARY KEY (Id_Categoría)
);

CREATE TABLE Tipo_Documento
(
  Id_TipoDocumento INT NOT NULL,
  Descripcion VARCHAR(100) NOT NULL,
  Constraint PK_TipoDocumento_IdTipoDocumento PRIMARY KEY (Id_TipoDocumento)
);

CREATE TABLE Permiso
(
  Id_Permiso INT NOT NULL,
  Nombre_Menu VARCHAR(50) NOT NULL,
  Fecha_Registro DATE NOT NULL,
  Id_Rol INT NOT NULL,
  Constraint PK_Permiso_IdPermiso PRIMARY KEY (Id_Permiso),
  Constraint FK_Permiso_IdRol FOREIGN KEY (Id_Rol) REFERENCES Rol(Id_Rol)
);

CREATE TABLE Productos
(
  Id_Producto INT NOT NULL,
  Codigo_Producto VARCHAR(80) NOT NULL,
  Nombre_Producto VARCHAR(100) NOT NULL,
  Descripcion_Producto VARCHAR(100) NOT NULL,
  Stock INT NOT NULL,
  Precio_Compra FLOAT NOT NULL,
  Precio_Venta FLOAT NOT NULL,
  Estado INT NOT NULL,
  Fecha_Registro DATE NOT NULL,
  Id_Categoría INT NOT NULL,
  Id_Proveedor INT NOT NULL,
  Constraint PK_Productos_IdProducto PRIMARY KEY (Id_Producto),
  Constraint FK_Productos_IdCategoria FOREIGN KEY (Id_Categoría) REFERENCES Categorias(Id_Categoría),
  Constraint FK_Productos_IdProveedor FOREIGN KEY (Id_Proveedor) REFERENCES Proveedor(Id_Proveedor),
  Constraint UQ_Productos_CodigoProd UNIQUE (Codigo_Producto)
);

CREATE TABLE Compra
(
  Id_Compra INT NOT NULL,
  Numero_Documento INT NOT NULL,
  Monto_Total FLOAT NOT NULL,
  Fecha_Registro DATE NOT NULL,
  Id_Usuario INT NOT NULL,
  Id_TipoDocumento INT NOT NULL,
  Constraint PK_Compra_IdCompra PRIMARY KEY (Id_Compra),
  Constraint FK_Compra_IdUsuario FOREIGN KEY (Id_Usuario) REFERENCES Usuario(Id_Usuario),
  Constraint FK_Compra_TipoDocumento FOREIGN KEY (Id_TipoDocumento) REFERENCES Tipo_Documento(Id_TipoDocumento),
  Constraint UQ_Compra_NumeroDocumento UNIQUE (Numero_Documento)
);

CREATE TABLE Venta
(
  Id_Venta INT NOT NULL,
  Numero_Documento INT NOT NULL,
  Monto_Pago FLOAT NOT NULL,
  Monto_Total FLOAT NOT NULL,
  Fecha_Registro DATE NOT NULL,
  Id_Cliente INT NOT NULL,
  Id_Usuario INT NOT NULL,
  Id_TipoDocumento INT NOT NULL,
  Constraint PK_Venta_IdVenta PRIMARY KEY (Id_Venta),
  Constraint FK_Venta_IdCliente FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente),
  Constraint FK_Venta_IdUsuario FOREIGN KEY (Id_Usuario) REFERENCES Usuario(Id_Usuario),
  Constraint FK_Venta_TipoDocumento FOREIGN KEY (Id_TipoDocumento) REFERENCES Tipo_Documento(Id_TipoDocumento),
  Constraint UQ_Venta_NumeroDocumento UNIQUE (Numero_Documento)
);

CREATE TABLE Detalle_Compra
(
  Id_DetalleCompra INT NOT NULL,
  Cantidad INT NOT NULL,
  SubTotal FLOAT NOT NULL,
  Fecha_Registro DATE NOT NULL,
  Id_Compra INT NOT NULL,
  Id_Producto INT NOT NULL,
  Constraint PK_DetalleCompra_IdDetalle_IdCompra PRIMARY KEY (Id_DetalleCompra, Id_Compra),
  Constraint FK_DetalleCompra_IdCompra FOREIGN KEY (Id_Compra) REFERENCES Compra(Id_Compra),
  Constraint FK_DetalleCompra_IdProducto FOREIGN KEY (Id_Producto) REFERENCES Productos(Id_Producto)
);

CREATE TABLE Detalle_Venta
(
  Id_DetalleVenta INT NOT NULL,
  Cantidad INT NOT NULL,
  SubTotal FLOAT NOT NULL,
  Fecha_Registro DATE NOT NULL,
  Id_Venta INT NOT NULL,
  Id_Producto INT NOT NULL,
  Constraint PK_DetalleVenta_IdDetalleVenta_IdVenta PRIMARY KEY (Id_DetalleVenta, Id_Venta),
  Constraint FK_Venta_IdVenta FOREIGN KEY (Id_Venta) REFERENCES Venta(Id_Venta),
  Constraint FK_Venta_IdProducto FOREIGN KEY (Id_Producto) REFERENCES Productos(Id_Producto)
);

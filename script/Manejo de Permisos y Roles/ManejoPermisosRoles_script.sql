---------------------------
-- BASE DE DATOS I.
-- PROYECTO: Gestión de Ventas de Productos Electrónicos - GRUPO 10 - COMISIÓN 2
-- INTEGRANTES:
--          Garay, Kevin Emiliano
--          Borda, Esteban Sebastian
--          Acosta, Gonzalo Nahuel
--          Mancedo, Joaquin
---------------------------

-- **Creación del inicio de sesión y usuario AdminUser con rol de administrador**
CREATE LOGIN [AdminUser] 
WITH PASSWORD = 'Password111',  -- Contraseña para el inicio de sesión AdminUser
CHECK_EXPIRATION = OFF,         -- Desactiva expiración de contraseña
CHECK_POLICY = OFF,             -- Desactiva política de complejidad de contraseña
DEFAULT_DATABASE = GK_Innovatech;  -- Base de datos predeterminada

-- Selecciona la base de datos y crea un usuario asociado a AdminUser
USE [GK_Innovatech];
CREATE USER Garay FOR LOGIN [AdminUser];  -- Usuario Garay vinculado a AdminUser

-- Asignación del rol de administrador (sysadmin) a AdminUser
EXEC sys.sp_addsrvrolemember 
    @loginame = N'AdminUser', 
    @rolename = N'sysadmin';

----------------------------------------
-- **Creación de inicio de sesión y usuario ABM con permisos de lectura/escritura**
CREATE LOGIN [ABM] 
WITH PASSWORD = 'Password222',  
CHECK_EXPIRATION = OFF, 
CHECK_POLICY = OFF,
DEFAULT_DATABASE = GK_Innovatech;

USE GK_Innovatech;  
CREATE USER Borda FOR LOGIN ABM;  -- Usuario Borda vinculado a ABM

-- Asigna permisos de lectura y escritura a Borda
EXEC sp_addrolemember 'db_datareader', 'Borda';  
EXEC sp_addrolemember 'db_datawriter', 'Borda';

-- Permite a Borda ejecutar procedimientos almacenados de alta, baja y modificación
GRANT EXECUTE ON [altaCategoria] TO Borda;
GRANT EXECUTE ON [altaUsuario] TO Borda;
GRANT EXECUTE ON [altaProducto] TO Borda;

GRANT EXECUTE ON [eliminarCategoria] TO Borda;
GRANT EXECUTE ON [eliminarProducto] TO Borda;
GRANT EXECUTE ON [eliminarUsuario] TO Borda;

GRANT EXECUTE ON [modUsuario] TO Borda;
GRANT EXECUTE ON [modProducto] TO Borda;

----------------------------------------
-- **Creación de inicio de sesión y usuario Consulta con rol de solo lectura**
CREATE LOGIN [Consulta] 
WITH PASSWORD = 'Password333',  
CHECK_EXPIRATION = OFF, 
CHECK_POLICY = OFF,
DEFAULT_DATABASE = GK_Innovatech;

USE GK_Innovatech;  
CREATE USER Acosta FOR LOGIN Consulta;

-- Crear rol de solo lectura y asignar permisos de consulta
CREATE ROLE ReadOnlyRole;
GRANT SELECT ON Productos TO ReadOnlyRole;
GRANT SELECT ON Venta TO ReadOnlyRole;
GRANT SELECT ON Detalle_Venta TO ReadOnlyRole;
GRANT SELECT ON Compra TO ReadOnlyRole;
GRANT SELECT ON Detalle_Compra TO ReadOnlyRole;
GRANT SELECT ON Cliente TO ReadOnlyRole;
GRANT SELECT ON Proveedor TO ReadOnlyRole;
GRANT SELECT ON Categorias TO ReadOnlyRole;
GRANT EXECUTE ON ganancias_N_Meses TO ReadOnlyRole;
GRANT EXECUTE ON porcentajeDeVenta TO ReadOnlyRole;
GRANT EXECUTE ON ganancias_de_venta TO ReadOnlyRole;
EXEC sp_addrolemember 'ReadOnlyRole', 'Acosta';

----------------------------------------
-- **Creación de inicio de sesión y usuario G10 con permisos específicos**
CREATE LOGIN G10  
WITH PASSWORD = 'Password444',  
CHECK_EXPIRATION = OFF, 
CHECK_POLICY = OFF,
DEFAULT_DATABASE = GK_Innovatech;

CREATE USER Mancedo FOR LOGIN G10;

-- Asigna permisos específicos al usuario Mancedo
GRANT SELECT ON Venta TO Mancedo;
GRANT SELECT ON Productos TO Mancedo;
GRANT EXECUTE ON [altaUsuario] TO Mancedo;
GRANT EXECUTE ON [altaProducto] TO Mancedo;
GRANT EXECUTE ON [altaCategoria] TO Mancedo;

GRANT EXECUTE ON [bajaProducto] TO Mancedo;
GRANT EXECUTE ON [bajaCategoria] TO Mancedo;

GRANT EXECUTE ON [modProducto] TO Mancedo;
GRANT EXECUTE ON ganancias_N_Meses TO Mancedo;
GRANT EXECUTE ON porcentajeDeVenta TO Mancedo;
GRANT EXECUTE ON ganancias_de_venta TO Mancedo;
DENY UPDATE TO Mancedo;
DENY INSERT TO Mancedo;
DENY DELETE TO Mancedo;
GO  

--Pruebas con los usuarios y sus roles


-----------------------------------------------
--Pruebas con el usuario Mancedo
-----------------------------------------------

Execute AS User = 'Mancedo'

Update Productos set Precio_Compra = 0 --Debe fallar en la actualizacion

EXEC altaUsuario @Dni = 44162351, @Nombre = 'Fernando', @Apellido = 'Garcia', @Correo = 'fernando@correo.com', @Clave = 'clave#999', @Estado = 1, @Rol = 3; --Permite ejecutar el procedimiento y agrega el usuario

INSERT INTO Productos (Codigo_Producto, Nombre_Producto, Descripcion_Producto, Stock, Precio_Venta, Precio_Compra, Estado, Id_Categoría, Id_Proveedor) 
VALUES ('4598','Monitor HD','19" pulgadas', 0, 25.50, 15.50, 1, 1, 1);  -- Prueba de inserción (debería fallar)

Select * from Venta -- Debe permitirlo
Select * from Cliente -- No permite
REVERT;

-----------------------------------------------
--Pruebas con el usuario Acosta
-----------------------------------------------


Execute AS User = 'Acosta'
Update Productos set Precio_Compra = 0 --Debe fallar en la actualizacion

EXEC altaUsuario @Dni = 44162351, @Nombre = 'Fernando', @Apellido = 'Garcia', @Correo = 'fernando@correo.com', @Clave = 'clave#999', @Estado = 1, @Rol = 3; -- Debe fallar

INSERT INTO Productos (Codigo_Producto, Nombre_Producto, Descripcion_Producto, Stock, Precio_Venta, Precio_Compra, Estado, Id_Categoría, Id_Proveedor) 
VALUES ('4598','Monitor HD','19" pulgadas', 0, 25.50, 15.50, 1, 1, 1);  -- Prueba de inserción (debería fallar)

Select * from Venta -- Debe permitirlo
Select * from Cliente -- Debe permitirlo
REVERT;

-----------------------------------------------
--Pruebas con el usuario Borda
-----------------------------------------------


Execute AS User = 'Borda'
Update Productos set Precio_Compra = 0 --Deberia actualizar

EXEC altaUsuario @Dni = 44162351, @Nombre = 'Fernando', @Apellido = 'Garcia', @Correo = 'fernando@correo.com', @Clave = 'clave#999', @Estado = 1, @Rol = 3; -- Debe agregarlo

INSERT INTO Productos (Codigo_Producto, Nombre_Producto, Descripcion_Producto, Stock, Precio_Venta, Precio_Compra, Estado, Id_Categoría, Id_Proveedor) 
VALUES ('4598','Monitor HD','19" pulgadas', 0, 25.50, 15.50, 1, 1, 1);  -- Prueba de inserción debe agregarlo

Select * from Venta -- Debe permitirlo
Select * from Cliente -- Debe permitirlo
REVERT;
-----------------------------------------------
--Pruebas con el usuario Garay
-----------------------------------------------

Execute AS User = 'Garay'
Update Productos set Precio_Compra = 0 --Deberia actualizar

EXEC altaUsuario @Dni = 44162351, @Nombre = 'Fernando', @Apellido = 'Garcia', @Correo = 'fernando@correo.com', @Clave = 'clave#999', @Estado = 1, @Rol = 3; -- Debe agregarlo

INSERT INTO Productos (Codigo_Producto, Nombre_Producto, Descripcion_Producto, Stock, Precio_Venta, Precio_Compra, Estado, Id_Categoría, Id_Proveedor) 
VALUES ('4598','Monitor HD','19" pulgadas', 0, 25.50, 15.50, 1, 1, 1);  -- Prueba de inserción debe agregarlo

Select * from Venta -- Debe permitirlo
Select * from Cliente -- Debe permitirlo
REVERT;

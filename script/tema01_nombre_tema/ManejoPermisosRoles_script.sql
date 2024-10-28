---------------------------
-- BASE DE DATOS I.
-- PROYECTO: Gestion de Ventas de Productos Electronicos - GRUPO 10 - COMISION 2
-- INTEGRANTES:
--          Garay, Kevin Emiliano
--          Borda, Esteban Sebastian
--          Acosta, Gonzalo Nahuel
--          Mancedo, Joaquin
---------------------------

-- Creación del inicio de sesión para AdminUser
CREATE LOGIN [AdminUser] 
WITH PASSWORD = 'Password111',  -- Establece la contraseña para el inicio de sesión
CHECK_EXPIRATION = OFF,  -- Desactiva la expiración de contraseña
CHECK_POLICY = OFF;      -- Desactiva la política de complejidad de contraseña

-- Creación del usuario en la base de datos 
USE [GK_Innovatech];  -- Selecciona la base de datos correcta
CREATE USER Garay FOR LOGIN [AdminUser];  -- Crea un usuario llamado Garay asociado al inicio de sesión AdminUser

-- Asignación del rol de sysadmin al usuario creado
EXEC sys.sp_addsrvrolemember 
    @loginame = N'AdminUser',  -- Nombre del inicio de sesión
    @rolename = N'sysadmin';    -- Rol asignado (sysadmin) que otorga todos los permisos en el servidor

----------------------------------------
-- Creación de inicio de sesión ABM y Rol de Lectura/Escritura
CREATE LOGIN [ABM] 
WITH PASSWORD = 'Password222',  -- Establece la contraseña para el inicio de sesión ABM
CHECK_EXPIRATION = OFF, 
CHECK_POLICY = OFF,
DEFAULT_DATABASE = GK_Innovatech;  -- Define la base de datos predeterminada

USE GK_Innovatech;  -- Selecciona la base de datos correcta
CREATE USER Borda FOR LOGIN ABM;  -- Crea un usuario llamado Borda asociado al inicio de sesión ABM

-- Asignación de permisos de lectura y escritura al usuario Borda
EXEC sp_addrolemember 'db_datareader', 'Borda';  -- Asigna el rol db_datareader (permiso de lectura)
EXEC sp_addrolemember 'db_datawriter', 'Borda';  -- Asigna el rol db_datawriter (permiso de escritura)

----------------------------------------
-- Creación de inicio de sesión consulta y rol público
CREATE LOGIN [Consulta] 
WITH PASSWORD = 'Password333',  -- Establece la contraseña para el inicio de sesión Consulta
CHECK_EXPIRATION = OFF, 
CHECK_POLICY = OFF,
DEFAULT_DATABASE = GK_Innovatech;  -- Define la base de datos predeterminada

USE GK_Innovatech;  -- Selecciona la base de datos correcta
CREATE USER Acosta FOR LOGIN Consulta;  -- Crea un usuario llamado Acosta asociado al inicio de sesión Consulta

-- Asignación de permisos de solo lectura al usuario Acosta en varias tablas
GRANT SELECT ON Venta TO Acosta;        -- Permite al usuario Acosta realizar SELECT en la tabla Venta
GRANT SELECT ON Productos TO Acosta;    -- Permite al usuario Acosta realizar SELECT en la tabla Productos
GRANT SELECT ON Categorias TO Acosta;    -- Permite al usuario Acosta realizar SELECT en la tabla Categorias

-- Crea un rol de solo lectura
CREATE ROLE ReadOnlyRole;
GRANT SELECT ON Productos TO ReadOnlyRole;
GRANT SELECT ON Venta TO ReadOnlyRole;
GRANT SELECT ON Productos TO ReadOnlyRole;
GRANT SELECT ON Detalle_Venta TO ReadOnlyRole;

EXEC sp_addrolemember 'ReadOnlyRole', 'Acosta';


----------------------------------------
-- Creación de usuario de la base de datos, usuario público
USE GK_Innovatech;  -- Selecciona la base de datos correcta

CREATE LOGIN G10  -- Se crea un ingreso para un usuario G10
WITH PASSWORD = 'Password444';  -- Establece la contraseña para el inicio de sesión G10
  
CREATE USER Mancedo FOR LOGIN G10;  -- Se registra el usuario llamado Mancedo asociado al inicio de sesión G10

-- Asignación de permisos específicos al usuario Mancedo
GRANT SELECT ON Venta TO Mancedo;  -- Permite al usuario Mancedo realizar SELECT en la tabla Venta
GRANT SELECT ON Productos TO Mancedo;  -- Permite al usuario Mancedo realizar SELECT en la tabla Productos
GRANT INSERT ON Productos TO Mancedo;  -- Permite al usuario Mancedo realizar INSERT en la tabla Productos
GRANT INSERT ON Categorias TO Mancedo;  -- Permite al usuario Mancedo realizar INSERT en la tabla Categorias
GRANT INSERT ON Proveedor TO Mancedo;  -- Permite al usuario Mancedo realizar INSERT en la tabla Proveedor
GRANT EXECUTE ON [altaUsuario] TO Mancedo;  -- Permite al usuario Mancedo ejecutar el procedimiento almacenado altaUsuario
GRANT DELETE ON Cliente TO Mancedo;  -- Permite al usuario Mancedo realizar DELETE en la tabla Cliente
GRANT DELETE ON Proveedor TO Mancedo;  -- Permite al usuario Mancedo realizar DELETE en la tabla Proveedor
DENY UPDATE TO Mancedo;  -- Niega el permiso de UPDATE al usuario Mancedo, evitando modificaciones en las tablas

GO  -- Finaliza el lote de comandos SQL


--Pruebas usuario Garay
CREATE TABLE TestAdmin (ID INT);
DROP TABLE TestAdmin;
--Deberia permitir agregar y eliminar tablas

--Inserciones usuario Borda
INSERT INTO Productos (Codigo_Producto, Nombre_Producto, Descripcion_Producto, Stock, Precio_Venta, Precio_Compra, Estado, Id_Categoría, Id_Proveedor) 
VALUES ('1596','Producto de prueba','Descripcion Prueba', 0, 25.50, 15.50, 1, 1, 1);
SELECT * FROM Productos;--Deberia permitir

--Permisos de lectura con usuario Acosta
SELECT * FROM Productos; -- Debe permitir la consulta

--Con usuario que no tenga el rol
SELECT * FROM Productos; -- Debe denegar el acceso

--Prueba de insercion Acosta
INSERT INTO Productos (Codigo_Producto, Nombre_Producto, Descripcion_Producto, Stock, Precio_Venta, Precio_Compra, Estado, Id_Categoría, Id_Proveedor) 
VALUES ('1234','Producto de prueba','Descripcion Prueba', 0, 25.50, 15.50, 1, 1, 1); --Debe de fallar


--Pruebas con el usuario Mancedo

-- Ejemplo de SELECT
SELECT * FROM Venta;

-- Ejemplo de INSERT
INSERT INTO Productos (Codigo_Producto, Nombre_Producto, Descripcion_Producto, Stock, Precio_Venta, Precio_Compra, Estado, Id_Categoría, Id_Proveedor) 
VALUES ('4598','Monitor HD','19" pulgadas', 0, 25.50, 15.50, 1, 1, 1);

-- Ejemplo de DELETE
DELETE FROM Proveedor WHERE ID_Proveedor = 1;

-- Ejemplo de ejecución de procedimiento almacenado
   EXEC [altaUsuario]       @Dni = 25406089,
    @Nombre  = 'Pepe',
    @Apellido  = 'Martinez',
    @Correo  = 'p2d@correo.com',
    @Clave  = 'password456',
    @Estado = 1,
    @Rol = 3;

-- Ejemplo de UPDATE (debería fallar)
UPDATE Productos SET Precio_Venta = 30.50 WHERE Nombre_Producto = 'Producto de prueba';


	
--**Verificar el comportamiento de ambos usuarios**:
   -- Con el usuario con rol de solo lectura (`User1`), intenta leer el contenido de la tabla:

     SELECT * FROM Productos;

    -- Resultado esperado: acceso permitido.
   
   -- Con el usuario sin permisos de lectura (`User2`), intenta hacer lo mismo:

     SELECT * FROM Productos;
 
    -- Resultado esperado: acceso denegado.

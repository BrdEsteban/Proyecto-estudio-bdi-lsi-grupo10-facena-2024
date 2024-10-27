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

-- Creación del usuario en la base de datos (se asume que estás en la base de datos correcta)
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

# GK Innovatech
    

# Gestión de Ventas - GK Innovatech

**Asignatura**: Bases de Datos I (FaCENA-UNNE)

**Integrantes**:
 - Acosta, Lopez Gonzalo Nahuel.
 - Borda, Esteban Rubén.
 - Garay, Kevin Emiliano.
 - Mancedo Joaquin.

**Año**: 2024

## CAPÍTULO I: INTRODUCCIÓN

### Caso de estudio

#### 1.1 -	Tema

Implementación, Análisis y Optimización de la Base de Datos para un Sistema de Gestión de Ventas de Productos Electrónicos en GK Innovatech: Mejorando la Eficiencia e Integridad de Datos.


#### 1.2 - Alcance
En este proyecto de estudio se trabajará exclusivamente con el sistema de las ventas y el control del stock, quedará exento de esto las compras de productos, los permisos de los usuarios siendo estos los vendedores  y la modificación o eliminación de los proveedores

### Definición o planteamiento del problema

Este proyecto de estudio investiga la base de datos del sistema de gestión de ventas de GK Innovatech, una empresa de artículos electrónicos. El objetivo es identificar y resolver problemas relacionados con la eficiencia operativa, la integridad de los datos y la experiencia del usuario. 

Se busca optimizar la estructura y el rendimiento de la base de datos para garantizar un manejo eficiente de la información de ventas, inventario y clientes, contribuyendo así a una mejor toma de decisiones y satisfacción del cliente.

# i. Objetivo General

Entendemos que la implementación de una base de datos que realice tanto el control de stock, como las ventas de forma automática, reducirá el error humano en la carga de planillas que ya no será necesaria.

- Crear y optimizar la base de datos del sistema de gestión de ventas y productos de GK Innovatech para mejorar la eficiencia y la integridad de los datos.
- La base de datos deberá permitir auditar los registros de ventas y altas de productos. Esto a través del manejo de vistas.

# ii. Objetivos Específicos

1. **Identificar los posibles problemas al crear la base de datos en el sistema de gestión de ventas**, incluyendo problemas en el rendimiento, inconsistencias en la integridad de los datos.
    - Este objetivo se centra en diagnosticar las áreas problemáticas para establecer un punto de partida claro.

2. **Analizar y proponer mejoras en la estructura del negocio** de manera que el énfasis esté orientado a la creación de una base de datos consistente.
    - Aquí se busca encontrar soluciones técnicas que mejoren el rendimiento del sistema.

3. **Implementar técnicas de normalización y mejores prácticas de diseño de bases de datos** para asegurar la integridad y consistencia de los datos de ventas e inventario.
    - Este objetivo se enfoca en garantizar la calidad y fiabilidad de los datos.

4. **Identificar e implementar las vistas necesarias** para la correcta auditoría de los datos necesarios de las ventas y productos.



## CAPITULO II: MARCO CONCEPTUAL O REFERENCIAL

Las innovaciones tecnológicas han cambiado completamente la manera en que las empresas gestionan sus ventas, especialmente en el ámbito de los productos electrónicos. En este contexto, el uso de una base de datos para la gestión de ventas tiene un impacto directo sobre cómo se maneja la gran cantidad de información, como los patrones de compra de los clientes, el control del inventario y el seguimiento de las ventas diarias.
Esto permite que las decisiones se tomen de manera más rápida y precisa, lo que mejora la eficiencia de la empresa.

Temas:
1. **Manejo de Permisos y Roles**
2. **Procedimientos y Funciones**
3. **Optimizacion por Indices**
4. **Manejo de JSON**

## CAPÍTULO III: METODOLOGÍA SEGUIDA 

Usaremos como metodología “Programación Extrema”, proponemos reuniones a través de discord, donde pactamos las tareas que hacían falta para el proyecto. Luego ese listado de tareas serían subidas  a la plataforma “TRELLO”, donde cada colaborador podrá asignarse tareas, las cuales se dividirán en "En proceso", "Finalizados, por subir",  "Finalizados, subidos". Para que cada colaborador pueda hacer y ver los cambios de los otros en el proyecto, optamos por utilizar la plataforma de “Git” como sistema de control de versiones distribuido y “GitHub” como plataforma para alojar el repositorio Git.

https://trello.com/b/NCpbVGAy/base-de-datos

![Imagen Permisos](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/Img/image.png) 


## CAPÍTULO IV: DESARROLLO DEL TEMA / PRESENTACIÓN DE RESULTADOS 





### Diagrama conceptual (opcional)
![diagrama_relacional](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/doc/image.png) 

### Diagrama relacional
![diagrama_relacional](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/doc/Relational.png) 

### Diccionario de datos

Acceso al documento [PDF](doc/diccionario_datos.pdf) del diccionario de datos.

### Modelo Fisico

~~~
CREATE TABLE Cliente
(
  Id_Cliente INT IDENTITY NOT NULL,
  Documento_Cliente INT NOT NULL,
  Nombre VARCHAR(100) NOT NULL,
  Apellido VARCHAR(100) NOT NULL,
  Correo VARCHAR(100) NOT NULL,
  Telefono VARCHAR(15) NOT NULL,
  Estado INT NOT NULL,
  Fecha_Registro DATE NOT NULL,
  Constraint PK_Cliente_IdCliente PRIMARY KEY (Id_Cliente),
  Constraint UQ_Cliente_Documento UNIQUE (Documento_Cliente),
  Constraint UQ_Cliente_Correo UNIQUE (Correo),
  Constraint DF_Cliente_Fecha Default getDate() for Fecha_Registro
);

CREATE TABLE Proveedor
(
  Id_Proveedor INT IDENTITY NOT NULL,
  Documento_Proveedor INT NOT NULL,
  Razon_Social VARCHAR(100) NOT NULL,
  Correo VARCHAR(100) NOT NULL,
  Telefono VARCHAR(15) NOT NULL,
  Estado INT NOT NULL,
  Fecha_Registro DATE NOT NULL,
  Constraint PK_Proveedor_IdProveedor PRIMARY KEY (Id_Proveedor),
  Constraint UQ_Proveedor_Documento UNIQUE (Documento_Proveedor),
  Constraint UQ_Proveedor_Correo UNIQUE (Correo),
  Constraint DF_Proveedor_Fecha Default getDate() for Fecha_Registro
);

CREATE TABLE Rol
(
  Id_Rol INT IDENTITY NOT NULL,
  Descripcion VARCHAR(80) NOT NULL,
  Fecha_Registro DATE NOT NULL,
  Constraint PK_Rol_IdRol PRIMARY KEY (Id_Rol),
  Constraint DF_Rol_Fecha Default getDate() for Fecha_Registro
);

CREATE TABLE Usuario
(
  Id_Usuario INT IDENTITY NOT NULL,
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
  Constraint UQ_Usuario_Correo UNIQUE (Correo),
  Constraint DF_Usuario_Fecha Default getDate() for Fecha_Registro
);

CREATE TABLE Categorias
(
  Id_Categoría INT IDENTITY NOT NULL,
  Descripcion_Categoria VARCHAR(100) NOT NULL,
  Estado INT NOT NULL,
  Fecha_Registro DATE NOT NULL,
  Constraint PK_Categorias_IdCategoria PRIMARY KEY (Id_Categoría),
  Constraint DF_Categorias_Fecha Default getDate() for Fecha_Registro
);

CREATE TABLE Tipo_Documento
(
  Id_TipoDocumento INT IDENTITY NOT NULL,
  Descripcion VARCHAR(100) NOT NULL,
  Constraint PK_TipoDocumento_IdTipoDocumento PRIMARY KEY (Id_TipoDocumento)
);

CREATE TABLE Permiso
(
  Id_Permiso INT IDENTITY NOT NULL,
  Nombre_Menu VARCHAR(50) NOT NULL,
  Fecha_Registro DATE NOT NULL,
  Id_Rol INT NOT NULL,
  Constraint PK_Permiso_IdPermiso PRIMARY KEY (Id_Permiso),
  Constraint FK_Permiso_IdRol FOREIGN KEY (Id_Rol) REFERENCES Rol(Id_Rol),
  Constraint DF_Permiso_Fecha Default getDate() for Fecha_Registro
);

CREATE TABLE Productos
(
  Id_Producto INT IDENTITY NOT NULL,
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
  Constraint UQ_Productos_CodigoProd UNIQUE (Codigo_Producto),
  Constraint DF_Productos_Fecha Default getDate() for Fecha_Registro
);

CREATE TABLE Compra
(
  Id_Compra INT IDENTITY NOT NULL,
  Numero_Documento INT NOT NULL,
  Monto_Total FLOAT NOT NULL,
  Fecha_Registro DATE NOT NULL,
  Id_Usuario INT NOT NULL,
  Id_TipoDocumento INT NOT NULL,
  Constraint PK_Compra_IdCompra PRIMARY KEY (Id_Compra),
  Constraint FK_Compra_IdUsuario FOREIGN KEY (Id_Usuario) REFERENCES Usuario(Id_Usuario),
  Constraint FK_Compra_TipoDocumento FOREIGN KEY (Id_TipoDocumento) REFERENCES Tipo_Documento(Id_TipoDocumento),
  Constraint UQ_Compra_NumeroDocumento UNIQUE (Numero_Documento),
  Constraint DF_Compra_Fecha Default getDate() for Fecha_Registro
);

CREATE TABLE Venta
(
  Id_Venta INT IDENTITY NOT NULL,
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
  Constraint UQ_Venta_NumeroDocumento UNIQUE (Numero_Documento),
  Constraint DF_Venta_Fecha Default getDate() for Fecha_Registro
);

CREATE TABLE Detalle_Compra
(
  Id_DetalleCompra INT IDENTITY NOT NULL,
  Cantidad INT NOT NULL,
  SubTotal FLOAT NOT NULL,
  Fecha_Registro DATE NOT NULL,
  Id_Compra INT NOT NULL,
  Id_Producto INT NOT NULL,
  Constraint PK_DetalleCompra_IdDetalle_IdCompra PRIMARY KEY (Id_DetalleCompra, Id_Compra),
  Constraint FK_DetalleCompra_IdCompra FOREIGN KEY (Id_Compra) REFERENCES Compra(Id_Compra),
  Constraint FK_DetalleCompra_IdProducto FOREIGN KEY (Id_Producto) REFERENCES Productos(Id_Producto),
  Constraint DF_DetalleCompra_Fecha Default getDate() for Fecha_Registro
);

CREATE TABLE Detalle_Venta
(
  Id_DetalleVenta INT IDENTITY NOT NULL,
  Cantidad INT NOT NULL,
  SubTotal FLOAT NOT NULL,
  Fecha_Registro DATE NOT NULL,
  Id_Venta INT NOT NULL,
  Id_Producto INT NOT NULL,
  Constraint PK_DetalleVenta_IdDetalleVenta_IdVenta PRIMARY KEY (Id_DetalleVenta, Id_Venta),
  Constraint FK_Venta_IdVenta FOREIGN KEY (Id_Venta) REFERENCES Venta(Id_Venta),
  Constraint FK_Venta_IdProducto FOREIGN KEY (Id_Producto) REFERENCES Productos(Id_Producto),
  Constraint DF_DetalleVenta_Fecha Default getDate() for Fecha_Registro
);
~~~

## Desarrollo Manejo de Permisos y Roles

En SQL Server, todos los elementos protegibles tienen permisos asociados que se pueden asignar a entidades de seguridad. La gestión de permisos en el Motor de base de datos se lleva a cabo tanto a nivel de servidor, mediante la asignación a inicios de sesión y roles de servidor, como a nivel de base de datos, mediante la asignación a usuarios y roles específicos de la base de datos. Esta estructura permite un control granular sobre las acciones que pueden realizarse en los diferentes objetos y recursos del sistema.

![Imagen Permisos](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/Img/Manejo%20de%20Permisos.png) 

1. Creación de inicios de sesión y usuarios en la base de datos

- AdminUser: Se crea un inicio de sesión para un usuario administrador, permitiéndole privilegios de administrador en el servidor (sysadmin).
- ABM: Se crea un inicio de sesión específico para manejar permisos de lectura y escritura.
- Consulta: Se configura un usuario solo con permisos de lectura sobre ciertas tablas.
- G10: Se crea un usuario de base de datos para Mancedo, con permisos de lectura, inserción y eliminación sobre ciertas tablas.

2. Asignación de roles y permisos
   
- AdminUser: Se otorga el rol sysadmin, permitiendo acceso completo en el servidor. Este usuario puede agregar o eliminar tablas, entre otros.
- ABM: Concede permisos de db_datareader y db_datawriter al usuario Borda, permitiendo lectura y escritura en la base de datos.
- Consulta: Usuario Acosta tiene permisos de solo lectura sobre ciertas tablas (Venta, Productos, Categorías), asignado al rol ReadOnlyRole.
- G10: Usuario Mancedo recibe permisos de lectura e inserción en productos y categorías, ejecución de un procedimiento almacenado (altaUsuario), y permisos para eliminar registros en tablas específicas. Se le niega el permiso de UPDATE.

3. Pruebas de permisos y roles
   
- Usuario AdminUser: Prueba la capacidad de crear y eliminar tablas (debería permitirlo).
- Usuario Borda (ABM): Prueba la inserción y consulta en la tabla Productos.
- Usuario Acosta (Consulta): Prueba consultas de lectura, y se confirma que no puede insertar.
- Usuario Mancedo (G10): Se verifica que puede realizar operaciones de lectura, inserción y eliminación, ejecutar procedimientos almacenados, pero que falla al intentar realizar un UPDATE.

4. Comprobación del comportamiento de permisos
- Se verifica el acceso de lectura con el usuario de solo lectura (Acosta) y se espera que el acceso esté permitido.
- Con un usuario sin permisos de lectura, el acceso a la misma consulta debería estar denegado, validando la configuración de seguridad implementada.


## Desarrollo Procedimientos y Funciones
### Procedimientos Almacenados

Un procedimiento almacenado es un conjunto de instrucciones SQL que se almacenan en el servidor y se pueden ejecutar de forma repetida. Permiten la reutilización de código en operaciones complejas que se realizan frecuentemente. Pueden, además, mejorar el rendimiento y la seguridad del sistema.

Los procedimientos se crean con la sentencia 'CREATE PROCEDURE' de la siguiente forma:

![Imagen Permisos](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/Img/ClausulaProc.png) 

Aceptan parámetros de entrada y pueden retornar valores o incluso tablas.

![Imagen Permisos](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/Img/ParametrosProc.png) 

Permiten la manipulación de datos mediante sentencias INSERT, UPDATE o DELETE; además del manejo de excepciones usando ‘BEGIN TRY’ y ‘BEGIN CATCH’

![Imagen Permisos](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/Img/Excepciones_Proc.png) 

Los procedimientos se ejecutan usando el comando ‘EXEC’ seguido del nombre del procedimiento y sus parámetros.  

![Imagen Permisos](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/Img/ProcedimientoConsulta.png) 


En el siguiente ejemplo se observan algunas de estas caráterísticas.
Este procedimiento permite la inserción de registros en la tabla Usuario de nuestra base de datos.


Ejemplo:
~~~
// ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // -----  // 

CREATE PROCEDURE altaUsuario 
	
	--  Recive parametros y les asigna un valor por defecto
	
	
    @Dni INT = NULL,
    @Nombre NVARCHAR(100) = NULL,
    ...
	@Estado INT = 1,
    @Rol INT = 3
AS
BEGIN

    ...
	
	
	-- Manejo de Excepciones
    BEGIN TRY
						 BEGIN TRANSACTION;
        
		-- Realiza una transacción utilizando un comando Insert, 
		
        INSERT INTO Usuario (Documento_Usuario, Nombre, Apellido, Correo, Clave, Estado, Id_Rol) 
        VALUES (@Dni, @Nombre, @Apellido, @Correo, @Clave, @Estado, @Rol);
        
						 COMMIT TRANSACTION;
    END TRY
	
    ...
	
	-- Este procedimiento no retorna ningún valor.
	
END;

// ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // -----  //
~~~
Ejemplo de Uso:

~~~
// ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // -----  //

EXEC altaUsuario @Dni = 22333444, @Nombre = 'Noname', @Apellido = 'nolastname', @Correo = 'noname@mail.com', @Clave = 'clave'
-- Los últimos dos parámetros no son necesarios ya que los valores por defecto son válidos

// ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // -----  //
~~~

### Funciones 

Las funciones son fragmentos de código que realizan un tarea y devuelven un valo o tabla. Al igual que los Procedimientos, pueden recibir párametros de entrada y, a diferencia es estos, no permiten realizar operaciones de datos con INSERT, UPDATE o DELETE, límitandose a operaciones de lectura.

Las funciones se crean con el comando 'CREATE FUNCTION'

![Imagen Permisos](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/Img/Funciones5.png) 

Devuelven valores únicos o tablas y son más utilizadas para cálculos, conversiones o formato de datos


### Tipos de funciones:
- Funciones escalares: Devuelven un valor único, como un número o texto.
- Funciones con valor de tabla: Devuelven una tabla y se utilizan en operaciones de consulta más complejas.

El siguiente ejemplo es una función con valor de tabla. Esta devuelve la id de los productos y su porcentaje de ventas en una cantadidad de meses pasada por parámetros 

Ejemplo:
~~~
// ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // -----  // 

CREATE FUNCTION porcentajeDeVenta ( @Meses INT = 1)
RETURNS TABLE 
AS
RETURN 
(
	-- Calculo del porcentaje: 
		 --Suma la cantidad ventas de cada producto y calcula el porcentaje
	SELECT ROUND(SUM(dv.Cantidad) * 100.0 / total.total, 2) AS Porcentajes, dv.Id_Producto
	FROM Detalle_Venta dv
	--Crea una tabla temporal con el total de productos vendidos en los últimos @Meses
	JOIN 
		(	
			SELECT SUM(Cantidad) AS total 
			FROM Detalle_Venta 
			WHERE DATEDIFF(MONTH, Fecha_Registro ,GETDATE() ) <= @Meses
		) AS total ON total.total > 0
	WHERE DATEDIFF( MONTH, dv.Fecha_Registro, GETDATE() ) <= @Meses
	GROUP BY dv.Id_Producto, total.total

)
GO

// ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // -----  //
~~~
Ejemplo de uso:
~~~
// ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // -----  //

SELECT P.*, PV.Porcentajes AS 'Porcentaje de venta últimos 2 meses' FROM Productos P
	JOIN dbo.porcentajeDeVenta(2) AS PV ON PV.Id_Producto = P.Id_Producto

// ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // -----  //
~~~
### Diferencias:
- Uso: Los procedimientos almacenados están orientados a ejecutar operaciones complejas de manipulación de datos, mientras que las funciones se enfocan en realizar cálculos o transformaciones que devuelven un valor o conjunto de valores.
- Capacidades de modificación: Los procedimientos almacenados permiten modificar datos en las tablas, a diferencia de las funciones.
- Invocación: Los procedimientos almacenados se ejecutan con `EXEC`, mientras que las funciones se llaman dentro de una consulta.



## Desarrollo Optimizacion por Indices

Los índices son fundamentales para mejorar el rendimiento de consultas en bases de datos grandes. En un sistema de ventas, los índices pueden optimizar consultas frecuentes, como la búsqueda de productos, el registro de ventas, o la consulta de inventarios, haciendo que el sistema responda de manera más ágil.

- Existen dos tipos de índices: “Índices Agrupados” y los “Índices NO Agrupados”

### Índice Agrupado
Un índice agrupado organiza la información de una tabla de manera física, es decir, los datos se almacenan en el disco en el mismo orden en que están organizados por el índice. Solo puede haber un índice agrupado por tabla, ya que no se pueden ordenar físicamente los datos de más de una forma.

### Índice NO Agrupado
Un índice no agrupado no altera el orden físico de los datos en la tabla. En lugar de esto, crea una estructura separada que contiene las claves del índice y punteros a las ubicaciones físicas de los datos. Actúa como un índice de un libro en el cual puedes acceder a la información de forma directa.

1. Tabla de prueba
Ejemplo de uso de índice agrupados.
La tabla en la que vamos a estar probando los índices acumulados es la tabla Cliente que cuenta con la siguiente estructura:


![Imagen Permisos](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/Img/Optimizacion1.png) 


Para que las consultas sean costosas en términos de tiempo y recursos vamos a hacer una inserción de 1 millón de datos con la ayuda de un script

2. Script para inserción masiva
~~~
--SCRIPT para carga masiva (1 millón) de datos en la tabla Cliente.
-- Variables para generar valores
DECLARE @i INT = 0;  -- Inicializar Id_Cliente en 0
DECLARE @MaxClientes INT = 1000000;

-- Comenzar a insertar datos
WHILE @i < @MaxClientes
BEGIN
    -- Documento Cliente (No repetido) usando un número incremental basado en @i
    DECLARE @Documento_Cliente INT = @i + 1000000;  -- Por ejemplo, empezar desde 1,000,000 para evitar colisiones

    -- Nombre y Apellido variando entre opciones de ejemplo
    DECLARE @Nombre NVARCHAR(100) = CASE (ABS(CHECKSUM(NEWID())) % 5)
        WHEN 0 THEN 'Juan'
        WHEN 1 THEN 'María'
        WHEN 2 THEN 'Carlos'
        WHEN 3 THEN 'Lucía'
        ELSE 'Pedro'
    END;
    
    DECLARE @Apellido NVARCHAR(100) = CASE (ABS(CHECKSUM(NEWID())) % 5)
        WHEN 0 THEN 'González'
        WHEN 1 THEN 'Rodríguez'
        WHEN 2 THEN 'Pérez'
        WHEN 3 THEN 'Martínez'
        ELSE 'García'
    END;

    -- Correo no repetido (combinando nombre, apellido, y un valor aleatorio)
    DECLARE @Correo NVARCHAR(100) = LOWER(@Nombre + '.' + @Apellido + CAST(@i AS VARCHAR) + '@correo.com');
    
    -- Teléfono (permitiendo repeticiones)
    DECLARE @Telefono NVARCHAR(15) = CAST(600000000 + ABS(CHECKSUM(NEWID())) % 40000000 AS VARCHAR);

    -- Estado como entero (0 para pausado, 1 para activo)
    DECLARE @Estado INT = CASE (ABS(CHECKSUM(NEWID())) % 2)
        WHEN 0 THEN 0  -- Pausado
        ELSE 1         -- Activo
    END;

    -- Fecha de Registro entre "01/01/2014" y "31/12/2024"
    DECLARE @Fecha_Registro DATE = DATEADD(DAY, ABS(CHECKSUM(NEWID())) % DATEDIFF(DAY, '2014-01-01', '2024-12-31'), '2014-01-01');

    -- Insertar datos en la tabla Cliente con el Id_Cliente manualmente incrementado
    INSERT INTO Cliente (Id_Cliente, Documento_Cliente, Nombre, Apellido, Correo, Telefono, Estado, Fecha_Registro)
    VALUES (@i, @Documento_Cliente, @Nombre, @Apellido, @Correo, @Telefono, @Estado, @Fecha_Registro);

    -- Incrementar el contador de Id_Cliente
    SET @i = @i + 1;
END;
~~~

3. Prueba de consultas sin índice agrupado
Una vez insertados el millón de datos procedemos a realizar consultas de pruebas, para verificar los tiempos de ejecución.

~~~
-- Prueba 1 (consulta solo por fecha)
SELECT * FROM Cliente
WHERE Fecha_Registro BETWEEN '2016-01-01' AND '2021-01-01'		

--//Columnas devueltas: 455.339 //Tiempos (3 intentos): 2640ms/2.495s, 2822ms/2.763s, 2570ms/2.483s

-- Prueba 2 (consulta por fecha y documento)
SELECT * FROM Cliente
WHERE
	Fecha_Registro BETWEEN '2016-01-01' AND '2023-01-01' AND
	Documento_Cliente BETWEEN '1000000' AND '1800000'		

--//Columnas devueltas: 509.760 //Tiempos (3 intentos): 2854ms/2.761s, 2913ms/2.771s, 2893ms/2.765s

-- Prueba 3 (consulta por fecha, documento y telefono)
SELECT * FROM Cliente
WHERE
	Fecha_Registro BETWEEN '2016-01-01' AND '2023-01-01' AND
	Documento_Cliente BETWEEN '1000000' AND '1800000' AND
	Telefono BETWEEN '61000000' AND '690000000'			

--//Columnas devueltas: 381.526 //Tiempos (3 intentos): 2140ms/1.963s, 2428ms/2.218s, 2240ms/2.198s
~~~



Estas consultas variadas fueron realizadas con el propósito de medir los tiempos de ejecución según la complejidad de las mismas, como se puede observar las consultas van escalando en complejidad, la 1era consulta solo filtra por Fecha, la 2da consulta filtra por fecha y documento y la 3ra consulta filtra por fecha, documento y teléfono.

4. Creación de índice acumulado y pruebas
Ahora procederemos a crear un índice el cual afecte a la columna de fecha_registro:


![Imagen Permisos](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/Img/Optimizacion4.png) 


Una vez creado el índice en la columna fecha procedemos a realizar las mismas pruebas realizadas cuando no teníamos un índice agrupado.

~~~
--Ahora realizaremos las mismas consultas para verificar los tiempos pero con el plan ("CLUSTERED INDEX SEEK").
-- Prueba 1 (consulta solo por fecha)
SELECT * FROM Cliente
WHERE Fecha_Registro BETWEEN '2016-01-01' AND '2021-01-01'		--//Columnas devueltas: 455.339 //Tiempos (3 intentos): 2491ms/2.250s, 2502ms/2.474s, 2477ms/2.235s

-- Prueba 2 (consulta por fecha y documento)
SELECT * FROM Cliente
WHERE
	Fecha_Registro BETWEEN '2016-01-01' AND '2023-01-01' AND
	Documento_Cliente BETWEEN '1000000' AND '1800000'		
--//Columnas devueltas: 509.760 //Tiempos (3 intentos): 2801ms/2.751s, 2795ms/2.975s, 2897ms/2.759s

-- Prueba 3 (consulta por fecha, documento y telefono)
SELECT * FROM Cliente
WHERE
	Fecha_Registro BETWEEN '2016-01-01' AND '2023-01-01' AND
	Documento_Cliente BETWEEN '1000000' AND '1800000' AND
	Telefono BETWEEN '61000000' AND '690000000'			
--//Columnas devueltas: 381.526 //Tiempos (3 intentos): 2119ms/1.935s, 2321ms/2.221s, 2086ms/1.938s

~~~
Como pueden ver, a pesar de ser las mismas pruebas hubo cambios notables en los tiempos de ejecución.

5. Eliminación del índice, creación de otro índice agrupado y prueba
Ahora procedemos a eliminar el índice anterior porque como ya mencionamos no pueden haber más de un índice agrupado en una misma tabla.


![Imagen Permisos](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/Img/Optimizacion5.1.png) 


Ahora creamos un nuevo índice agrupado el cual agrupe otras columnas deseadas en este caso usaremos las utilizadas por las pruebas: fecha, documento y teléfono.


![Imagen Permisos](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/Img/Optimizacion5.2.png) 


Y ahora volveremos a realizar las mismas pruebas y verificamos los nuevos tiempos.

~~~
--Realizamos las mismas pruebas con el nuevo índice agrupado.
-- Prueba 1 (consulta solo por fecha)
SELECT * FROM Cliente
WHERE Fecha_Registro BETWEEN '2016-01-01' AND '2021-01-01'		--//Columnas devueltas: 455.339 //Tiempos (3 intentos): 2505ms/2.479s, 2638ms/2.499s, 2599ms/2.506s

-- Prueba 2 (consulta por fecha y documento)
SELECT * FROM Cliente
WHERE
	Fecha_Registro BETWEEN '2016-01-01' AND '2023-01-01' AND
	Documento_Cliente BETWEEN '1000000' AND '1800000'		
--//Columnas devueltas: 509.760 //Tiempos (3 intentos): 2719ms/2.485s, 2800ms/2.761s, 2830ms/2.751s

-- Prueba 3 (consulta por fecha, documento y telefono)
SELECT * FROM Cliente
WHERE
	Fecha_Registro BETWEEN '2016-01-01' AND '2023-01-01' AND
	Documento_Cliente BETWEEN '1000000' AND '1800000' AND
	Telefono BETWEEN '61000000' AND '690000000'			
--//Columnas devueltas: 381.526 //Tiempos (3 intentos): 2069ms/1.960s, 2152ms/1.953s, 2069ms/1.956s

~~~



## Desarrollo Manejo de Tipo de Datos JSON

El manejo de JSON (JavaScript Object Notation) es relevante cuando se trabaja con integraciones de sistemas externos, ya que permite el intercambio de datos de manera eficiente y estructurada. JSON es útil para almacenar configuraciones de productos o integrar datos de ventas desde otras plataformas. Otro beneficio es que los datos de tipo JSON es su longitud que puede ser variable. Dentro de un Json se puede agregar tags nuevos e insertar nuevos datos sin afectar a los demás campos sin la necesidad de crear nuevas columnas.

En SQL Server, en lugar de un tipo de datos JSON explícito, se usa el tipo de datos NVARCHAR (normalmente NVARCHAR(MAX)) para almacenar los datos JSON. Luego, se utilizan funciones JSON nativas para manipular y consultar datos.

Una funcion basica pero a la vez muy util es la funcion FOR JSON

![Imagen Permisos](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/Img/JSON1.png) 

Nos devuelve los 3 primeros clientes de la tabla cliente pero en un único registro de tipo json.

![Imagen Permisos](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/Img/JSON2.png) 

Si utilizamos un editor de texto para ver mejor, se visualiza de la siguiente manera:


![Imagen Permisos](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/Img/JSON3.png) 

Para ver el funcionamiento de este tipo de dato Json seguimos los siguientes pasos.
1. Crear una tabla que permita almacenar datos JSON. Se crea además una constraint con la función definida ISJSON que verifica que el formato del nvarchar que se ingrese sea del formato Json.

![Imagen Permisos](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/Img/JSON4.png) 

SQL Server proporciona funciones como JSON_VALUE, JSON_QUERY y OPENJSON para leer y manipular datos JSON.
- JSON_VALUE: Extrae un valor específico de un documento JSON.
- JSON_QUERY: Extrae un objeto o arreglo completo de un documento JSON.
- OPENJSON: Convierte un texto JSON en un conjunto de filas.

2. Insertamos en nuestra nueva tabla los datos extraídos de la tabla productos a través de la función json_query que nos permite manipular el arreglo en formato json para insertar en la columna info_producto de tipo json (nvarchar(max)).

![Imagen Permisos](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/Img/JSON5.png) 

3. Ahora para utilizar la funcion JSON_MODIFY cambiamos una propiedad del json para que su lectura sea más descriptiva.

- JSON MODIFY MODIFY te permite actualizar, agregar o “eliminar” valores específicos dentro de un documento JSON sin sobreescribir todo el contenido.

![Imagen Permisos](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/Img/JSON6.png) 

Observamos el resultado:
~~~
{
  "Codigo_producto": "PROD001",
  "Nombre_producto": "Laptop",
  "Descripcion_producto": "Laptop 14 pulgadas",
  "Stock": 50,
  "Precio_Compra": "500",
  "Precio_Venta": "650",
  "Estado": "publicado",
  "Categoria": "Electrónica",
  "Proveedor": "Proveedor A"
}
~~~
4. Usando la función JSON_VALUE extraemos un valor específico que posee un atributo dentro del json, Observamos que nos devuelve los datos a nivel registro como si se tratara de una tabla.

![Imagen Permisos](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/Img/JSON7.png) 

* Una aproximación a una optimización del consumo de este tipo de datos se realiza a través de índices. Se pueden crear columnas calculadas que extraen valores del json y agregar índices. De esta forma las consultas hacia ese tipo de datos serían más eficientes.
 
Creamos las columnas calculadas:

![Imagen Permisos](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/Img/JSON8.png) 

Veamos la optimización obtenida de una consulta simple:
Notamos que el motor realiza un ‘index scan’ por la pk de productos.

![Imagen Permisos](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/Img/JSON9.png) 

Luego agregamos el índice a las nuevas columnas para observar alguna optimización:

![Imagen Permisos](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/Img/JSON10.png) 

Vemos el plan de ejecución nuevamente:
Ahora notamos que el motor realiza un index seek que efectivamente es más eficiente que un scan.


![Imagen Permisos](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/Img/JSON11.png) 





## CAPÍTULO V: CONCLUSIONES

A lo largo del desarrollo del trabajo se tuvo que investigar sobre la entidad para implementar una base de datos, aclarar objetivos, restricciones, sortear complicaciones en cuanto a aspectos técnicos, además de emplear varios diagramas y herramientas para bosquejar el sistema lo más óptimo posible. 

Se generaron diferentes usuarios con sus respectivas contraseñas y rango para llevar a cabo la utilización y el control de la base de datos. Se implementaron procedimientos almacenados, transacciones para tener un mejor nivel de integridad y seguridad.
También se agregó una tabla con un campo Json que permite tener otra forma de acceder a los datos y se planteó una aproximación a una optimización para su uso logrando ver algunos beneficios como ser la ampliación de información por cada producto.
Se utilizaron muchas herramientas de comunicación para trabajar en equipo e ir coordinando y solucionando los problemas que surgían a medida que avanzaba el proyecto, ya que fueron varias etapas las que se llevaron a cabo. Como ser la planificación, donde se recopiló información sobre distintas herramientas, el funcionamiento de las terminales ya existentes, etc. Se estableció el diseño del diagrama entidad-relación para de este modo realizar el desarrollo y las distintas pruebas de control del mismo. 

Como conclusión podemos decir que se alcanzaron los objetivos planteados realizando una buena estructuración y modelado de la base de datos, se utilizaron diferentes técnicas aplicando buenas prácticas de programación y normalización de tablas, esto también da la posibilidad para que en un futuro se pueda implementar nuevas mejoras.

Dificultades: 
Nuestra mayor dificultad fue a la hora de usar las distintas herramientas tanto para el modelado como para el desarrollo de los distintos script, además de aprender el manejo del repositorio, sus funciones y sentencias. 
Otras dificultades fueron entender y estudiar sobre el negocio, dado que la documentación es extensa, por lo que recabar información se hizo tedioso, y más aún, la selectividad de la misma. 
Por último, al principio, la extensión del proyecto fue inabarcable, por una mala delimitación de alcance o funciones, lo cual llevó a reestructurar el proyecto, la documentación y las buenas prácticas de programación. Fueron errores lógicos dada la poca información o teoría que se manejaba en ese momento.



## BIBLIOGRAFÍA DE CONSULTA

Material de lectura/consulta que se utilizó para el desarrollo del trabajo.
 
1. https://learn.microsoft.com/en-us/sql/t-sql/functions/getdate-transact-sql?view=sql-server-ver16 
2. https://learn.microsoft.com/es-es/sql/relational-databases/stored-procedures/create-a-stored-procedure?view=sql-server-ver16 
3. https://learn.microsoft.com/es-es/sql/relational-databases/security/permissions-database-engine?view=sql-server-ver16
4. https://learn.microsoft.com/es-es/sql/t-sql/language-elements/transactions-transact-sql?view=sql-server-ver16 
5. https://learn.microsoft.com/es-es/sql/relational-databases/stored-procedures/stored-procedures-database-engine?view=sql-server-ver16 



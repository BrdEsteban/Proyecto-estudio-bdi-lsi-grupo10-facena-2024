##Procedimientos Almacenados

Un procedimiento almacenado es un conjunto de instrucciones SQL que se almacenan en el servidor y se pueden ejecutar de forma repetida. Permiten la reutilización de código en operaciones complejas que se realizan frecuentemente. Pueden, además, mejorar el rendimiento y la seguridad del sistema.

Los procedimientos se crean con la sentencia 'CREATE PROCEDURE'
Aceptan parámetros de entrada y pueden retornar valores o incluso tablas.
Permiten la manipulación de datos mediante sentencias INSERT, UPDATE o DELETE; además del manejo de excepciones

En el siguiente ejemplo se observan algunas de estas caráterísticas.
Este procedimiento permite la inserción de registros en la tabla Usuario de nuestra base de datos.


Ejemplo:

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

Ejemplo de Uso:

EXEC altaUsuario @Dni = 22333444, @Nombre = 'Noname', @Apellido = 'nolastname', @Correo = 'noname@mail.com', @Clave = 'clave'
-- Los últimos dos parámetros no son necesarios ya que los valores por defecto son válidos

// ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // -----  //


##Funciones 

Las funciones son fragmentos de código que realizan un tarea y devuelven un valo o tabla. Al igual que los Procedimientos, pueden recibir párametros de entrada y, a diferencia es estos, no permiten realizar operaciones de datos con INSERT, UPDATE o DELETE, límitandose a operaciones de lectura.

Las funciones se crean con el comando 'CREATE FUNCTION'
Devuelven valores únicos o tablas y son más utilizadas para cálculos, conversiones o formato de datos


Tipos de funciones:
Funciones escalares: Devuelven un valor único, como un número o texto.
Funciones con valor de tabla: Devuelven una tabla y se utilizan en operaciones de consulta más complejas.

El siguiente ejemplo es una función con valor de tabla. Esta devuelve la id de los productos y su porcentaje de ventas en una cantadidad de meses pasada por parámetros 

Ejemplo:

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
Ejemplo de uso:

SELECT P.*, PV.Porcentajes AS 'Porcentaje de venta últimos 2 meses' FROM Productos P
	JOIN dbo.porcentajeDeVenta(2) AS PV ON PV.Id_Producto = P.Id_Producto


// ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // ----- // -----  //

##Diferencias:
- Uso: Los procedimientos almacenados están orientados a ejecutar operaciones complejas de manipulación de datos, mientras que las funciones se enfocan en realizar cálculos o transformaciones que devuelven un valor o conjunto de valores.
- Capacidades de modificación: Los procedimientos almacenados permiten modificar datos en las tablas, a diferencia de las funciones.
- Invocación: Los procedimientos almacenados se ejecutan con `EXEC`, mientras que las funciones se llaman dentro de una consulta.

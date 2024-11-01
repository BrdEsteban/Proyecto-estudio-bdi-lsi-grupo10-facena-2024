--Usamos la base GK_Innovatech
USE GK_Innovatech

--Utilizamos el Time para medir los tiempos. (elapsed time)
SET STATISTICS TIME ON;

--\\-------------------------------------------------------------------------------------------------------------------//--
---\\-----------------------------------------------------------------------------------------------------------------//---
									    --Tema 2. Optimización por índices--
---//-----------------------------------------------------------------------------------------------------------------\\---
--//-------------------------------------------------------------------------------------------------------------------\\--

---//-----------------------------------------------------------------------------------------------------------------\\---
--//-------------------------------------------------------------------------------------------------------------------\\--
--Haremos uso de la siguiente tabla:
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
--\\-------------------------------------------------------------------------------------------------------------------//--
---\\-----------------------------------------------------------------------------------------------------------------//---

---//-----------------------------------------------------------------------------------------------------------------\\---
--//-------------------------------------------------------------------------------------------------------------------\\--
--SCRIPT para carga masiva (1 millon) de datos en la tabla Cliente.

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
--\\-------------------------------------------------------------------------------------------------------------------//--
---\\-----------------------------------------------------------------------------------------------------------------//---
												--Indice agrupado--
---//-----------------------------------------------------------------------------------------------------------------\\---
--//-------------------------------------------------------------------------------------------------------------------\\--
--Busqueda por periodo en la tabla Cliente.
SELECT 
	* 
FROM 
	Cliente
WHERE Fecha_Registro BETWEEN '2014-01-01' AND '2020-12-31'
--Plan utilizado "Clustered Index Scan"

--Como se generó automaticamente un indice acumulado en la columna Id_Cliente automaticamente, procedemos a eliminarlo.
ALTER TABLE Cliente
DROP CONSTRAINT PK_Cliente_IdCliente;

--Realizamos nuevamente la consulta para verificar el Plan utilizado.
SELECT 
	* 
FROM 
	Cliente
WHERE Fecha_Registro BETWEEN '2014-01-01' AND '2020-12-31'
--Plan utilizado: "Table Scan".

--Ahora realizaremos una serie de consultas variadas para verificar los tiempos con el plan ("TABLE SCAN").
-- Prueba 1 (consulta solo por fecha)
SELECT * FROM Cliente
WHERE Fecha_Registro BETWEEN '2016-01-01' AND '2021-01-01'	--//Columnas devueltas: 455.339 //Tiempos (3 intentos): 2640ms/2.495s, 2822ms/2.763s, 2570ms/2.483s

-- Prueba 2 (consulta por fecha y documento)
SELECT * FROM Cliente
WHERE
	Fecha_Registro BETWEEN '2016-01-01' AND '2023-01-01' AND
	Documento_Cliente BETWEEN '1000000' AND '1800000'		--//Columnas devueltas: 509.760 //Tiempos (3 intentos): 2854ms/2.761s, 2913ms/2.771s, 2893ms/2.765s

-- Prueba 3 (consulta por fecha, documento y telefono)
SELECT * FROM Cliente
WHERE
	Fecha_Registro BETWEEN '2016-01-01' AND '2023-01-01' AND
	Documento_Cliente BETWEEN '1000000' AND '1800000' AND
	Telefono BETWEEN '61000000' AND '690000000'				--//Columnas devueltas: 381.526 //Tiempos (3 intentos): 2140ms/1.963s, 2428ms/2.218s, 2240ms/2.198s

--Ahora aplicamos el índice acumulado en la fecha.
 CREATE CLUSTERED INDEX IDX_FechaRegistro
 ON Cliente (Fecha_Registro);


--Ahora realizaremos las mismas consultas para verificar los tiempos pero con el plan ("CLUSTERED INDEX SEEK").
-- Prueba 1 (consulta solo por fecha)
SELECT * FROM Cliente
WHERE Fecha_Registro BETWEEN '2016-01-01' AND '2021-01-01'	--//Columnas devueltas: 455.339 //Tiempos (3 intentos): 2491ms/2.250s, 2502ms/2.474s, 2477ms/2.235s

-- Prueba 2 (consulta por fecha y documento)
SELECT * FROM Cliente
WHERE
	Fecha_Registro BETWEEN '2016-01-01' AND '2023-01-01' AND
	Documento_Cliente BETWEEN '1000000' AND '1800000'		--//Columnas devueltas: 509.760 //Tiempos (3 intentos): 2801ms/2.751s, 2795ms/2.975s, 2897ms/2.759s

-- Prueba 3 (consulta por fecha, documento y telefono)
SELECT * FROM Cliente
WHERE
	Fecha_Registro BETWEEN '2016-01-01' AND '2023-01-01' AND
	Documento_Cliente BETWEEN '1000000' AND '1800000' AND
	Telefono BETWEEN '61000000' AND '690000000'				--//Columnas devueltas: 381.526 //Tiempos (3 intentos): 2119ms/1.935s, 2321ms/2.221s, 2086ms/1.938s

--Eliminamos el índice anterior
DROP INDEX IDX_FechaRegistro ON Cliente;

--Aplicamos un índice agrupado incluyendo varias columnas
CREATE CLUSTERED INDEX IXD_FechaRegistro_Documento_Telefono
ON Cliente (Fecha_Registro, Documento_Cliente, Telefono)

--Realizamos las mismas pruebas con el nuevo índice agrupado.
-- Prueba 1 (consulta solo por fecha)
SELECT * FROM Cliente
WHERE Fecha_Registro BETWEEN '2016-01-01' AND '2021-01-01'	--//Columnas devueltas: 455.339 //Tiempos (3 intentos): 2505ms/2.479s, 2638ms/2.499s, 2599ms/2.506s

-- Prueba 2 (consulta por fecha y documento)
SELECT * FROM Cliente
WHERE
	Fecha_Registro BETWEEN '2016-01-01' AND '2023-01-01' AND
	Documento_Cliente BETWEEN '1000000' AND '1800000'		--//Columnas devueltas: 509.760 //Tiempos (3 intentos): 2719ms/2.485s, 2800ms/2.761s, 2830ms/2.751s

-- Prueba 3 (consulta por fecha, documento y telefono)
SELECT * FROM Cliente
WHERE
	Fecha_Registro BETWEEN '2016-01-01' AND '2023-01-01' AND
	Documento_Cliente BETWEEN '1000000' AND '1800000' AND
	Telefono BETWEEN '61000000' AND '690000000'				--//Columnas devueltas: 381.526 //Tiempos (3 intentos): 2069ms/1.960s, 2152ms/1.953s, 2069ms/1.956s

--\\-------------------------------------------------------------------------------------------------------------------//--
---\\-----------------------------------------------------------------------------------------------------------------//---

--Encaso de querer eliminar el índice (acumulado), ejecutamos el sig código.
 DROP INDEX IDX_FechaRegistro ON Cliente; --Indice acumulado en Fecha_Registro;
 DROP INDEX IXD_FechaRegistro_Documento_Telefono ON Cliente; --Indice acumulado en fecha, documento y telefono;
--Utilizarlo en caso de querer reiterar una consulta sin índice agrupado.

--\\-------------------------------------------------------------------------------------------------------------------//--
---\\-----------------------------------------------------------------------------------------------------------------//---
												--Índices no agrupados--
---//-----------------------------------------------------------------------------------------------------------------\\---
--//-------------------------------------------------------------------------------------------------------------------\\--

---//-----------------------------------------------------------------------------------------------------------------\\---
--//-------------------------------------------------------------------------------------------------------------------\\--
--Ahora vamos a realizar pruebas con índices no acumulados.

--Primero realizaremos una consulta para verificar que no haiga ningún indice "no acumulado" creado.
SELECT *
FROM Cliente
WHERE Id_Cliente = '2135'
--Plan Clustered Index Scan, por lo visto está utilizando el indice acumulado "IDX_FechaRegistro" pero este no es eficiente
--ya que realiza un escaneo completo de la tabla para encontrar el resultado deseado.

--Ahora realizaremos una serie de consultas variadas para verificar los tiempos con el plan ("Clustered Index Scan").
--Prueba 1 (consulta preguntando por un id en específico).
SELECT * 
FROM Cliente
WHERE Id_Cliente = 12345; --Tiempos (3 intentos elapsedTime/segundos): 68ms/0.045s, 75ms/0.046s y 75ms/0.050s
--Prueba 2 (consulta preguntando por 2 id en particular).
SELECT * 
FROM Cliente
WHERE Id_Cliente = 12345 OR Id_Cliente = 34533; --Tiempos (3 intentos elapsedTime/segundos): 106ms/0.044s, 95ms/0.047s y 99ms/0.066s
--Prueba 3(consulta preguntando por un intervalo de 17 Ids).
SELECT * 
FROM Cliente
WHERE Id_Cliente IN --Tiempos (3 intentos elapsedTime/segundos): 241ms/0.082s, 229ms/0.081s y 225ms/0.081s
	(4, 5, 54562, 123354, 154625, 213543, 1, 35657, 20000, 999999, 36353, 356645, 1000000, 17, 3456424, 8, 5464);
--Prueba 4(consulta preguntando por un intervalo moderado de Ids).
SELECT * 
FROM Cliente
WHERE Id_Cliente BETWEEN 1 AND 3650; --Tiempos (3 intentos elapsedTime/segundos): 130ms/0.058s, 134ms/0.056s y 133ms/0.056s
--Prueba 5(consulta preguntando por un intervalo grande de Ids).
SELECT * 
FROM Cliente
WHERE Id_Cliente BETWEEN 1 AND 20000; --Tiempos (3 intentos elapsedTime/segundos): 220ms/0.063s, 191ms/0.062s y 184ms/0.060s

--Prueba 6(consulta preguntando por un intervalo masivo de Ids).
SELECT * 
FROM Cliente
WHERE Id_Cliente BETWEEN 1 AND 700000; --Tiempos (3 intentos elapsedTime/segundos): 3897ms/3.861s, 3887ms/3.859s y 3805ms/3.581s

--Ahora realizamos la creación del índice no acumulado (Id_Cliente).
 CREATE NONCLUSTERED INDEX IDX_IDCliente
 ON Cliente (Id_Cliente);

--Ahora realizaremos las mismas consultas para verificar los tiempos pero con el plan ("Index Seek (NonClustered)").
--Prueba 1 (consulta preguntando por un id en específico).
SELECT * 
FROM Cliente
WHERE Id_Cliente = 12345; --Tiempos (3 intentos elapsedTime/segundos): 66ms/0.000s, 70ms/0.000s y 30ms/0.000s
--Prueba 2 (consulta preguntando por 2 id en particular).
SELECT * 
FROM Cliente
WHERE Id_Cliente = 12345 OR Id_Cliente = 34533; --Tiempos (3 intentos elapsedTime/segundos): 69ms/0.000s, 76ms/0.000s y 73ms/0.066s
--Prueba 3(consulta preguntando por un intervalo de 17 Ids).
SELECT * 
FROM Cliente
WHERE Id_Cliente IN --Tiempos (3 intentos elapsedTime/segundos): 75ms/0.000s, 73ms/0.000s y 82ms/0.000s
	(4, 5, 54562, 123354, 154625, 213543, 1, 35657, 20000, 999999, 36353, 356645, 1000000, 17, 3456424, 8, 5464);
--Prueba 4(consulta preguntando por un intervalo moderado de Ids).
SELECT * 
FROM Cliente
WHERE Id_Cliente BETWEEN 1 AND 3650; --Tiempos (3 intentos elapsedTime/segundos): 96ms/0.062s, 100ms/0.066s y 98ms/0.002s

--Prueba 5(consulta preguntando por un intervalo grande de Ids).
SELECT * 
FROM Cliente
WHERE Id_Cliente BETWEEN 1 AND 20000; --Tiempos (3 intentos elapsedTime/segundos): 192ms/0.063s, 184ms/0.059s y 194ms/0.062s --Plan: Index Scan

--Prueba 6(consulta preguntando por un intervalo masivo de Ids).
SELECT * 
FROM Cliente
WHERE Id_Cliente BETWEEN 1 AND 700000; --Tiempos (3 intentos elapsedTime/segundos): 3876ms/3.817s, 3837ms/3.585s y 3895ms/3.820s --Plan: Index Scan
--\\-------------------------------------------------------------------------------------------------------------------//--
---\\-----------------------------------------------------------------------------------------------------------------//---

 --Encaso de querer eliminar el índice (NO acumulado), ejecutamos el sig código.
 DROP INDEX IDX_IDCliente ON Cliente;
 --Utilizarlo en caso de querer reiterar una consulta sin índice NO agrupado.

 --//------------------------------------------------------------------------------------------------------------------\\--
 --Nota: estas pruebas de índices acumulados e índices NO acumulados fueron básicas, no se probaron en una gran variedad
 --de funciones, sin embargo nos sirve para comprobar que el uso de los mismos bajo ciertas condiciones presentan mejoras
 --notables en las consultas que realizamos.
 --\\------------------------------------------------------------------------------------------------------------------//--
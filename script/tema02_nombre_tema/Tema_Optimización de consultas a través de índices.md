# Proyecto: Gestión de Ventas de Productos Electrónicos
# Tema: Optimización por índices

**Grupo:** 10  
**Comisión:** 2  
**Integrantes:**  
- Acosta López, Gonzalo Nahuel
- Garay, Kevin Emiliano  
- Borda, Esteban Rubén
- Mancedo, Joaquin  

- ## Teoría
Los índices agrupados son técnicas utilizadas en base de datos para mejorar el rendimiento de las consultas reduciendo el tiempo de respuesta al acceder y manipular los datos.
En esta oportunidad vamos conocer los índices 'Agrupado' y 'No Agrupado'.

- ### Índice Agrupado
Un índice agrupado organiza los datos de una tabla de manera física, es decir, los datos se almacenan en el disco en el mismo orden en que están organizados por el índice. 
Solo puede haber un índice agrupado por tabla, ya que no se pueden ordenar físicamente los datos de más de una forma.

- ### Índice No Agrupado
Un índice no agrupado no altera el orden físico de los datos en la tabla. En lugar de esto, crea una estructura separada que contiene las claves del índice y punteros a las 
ubicaciones físicas de los datos. Actúa como un índice de un libro en el cual puedes acceder a la información de forma directa.

---

- ## 1. Elección de tabla e inserción de Datos Masivos.
La tabla que vamos a estar utilizando en esta ocasión es la tabla Cliente de la base GK_Innovatech, la tabla luce de la siguiente forma:
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

Para la carga masiva de 1 millon de datos haremos uso del siguiente script:
DECLARE @i INT = 0;
DECLARE @MaxClientes INT = 1000000;

WHILE @i < @MaxClientes
BEGIN

    DECLARE @Documento_Cliente INT = @i + 1000000;  -- Por ejemplo, empezar desde 1,000,000 para evitar colisiones
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
    
    DECLARE @Correo NVARCHAR(100) = LOWER(@Nombre + '.' + @Apellido + CAST(@i AS VARCHAR) + '@correo.com');
    DECLARE @Telefono NVARCHAR(15) = CAST(600000000 + ABS(CHECKSUM(NEWID())) % 40000000 AS VARCHAR);
    DECLARE @Estado INT = CASE (ABS(CHECKSUM(NEWID())) % 2)
        WHEN 0 THEN 0  -- Pausado
        ELSE 1         -- Activo
    END;
    
    DECLARE @Fecha_Registro DATE = DATEADD(DAY, ABS(CHECKSUM(NEWID())) % DATEDIFF(DAY, '2014-01-01', '2024-12-31'), '2014-01-01');
    
    INSERT INTO Cliente (Id_Cliente, Documento_Cliente, Nombre, Apellido, Correo, Telefono, Estado, Fecha_Registro)
    VALUES (@i, @Documento_Cliente, @Nombre, @Apellido, @Correo, @Telefono, @Estado, @Fecha_Registro);
    
    SET @i = @i + 1;
END;

---

- ## 2. Prueba de consultas Table Scan (Scan Completo) vs Indice Agrupado
Para evaluar si realmente ocurre una mejora al utilizar índices agrupados haremos lo siguiente.
Primero procedemos a realizar una serie de consultas variadas para medir los tiempos utilizando el Plan "Table Scan".

(PLAN: TABLE SCAN)
*Prueba 1 (consulta solo por fecha)*
SELECT * FROM Cliente
WHERE Fecha_Registro BETWEEN '2016-01-01' AND '2021-01-01'		--//Columnas devueltas: 455.339 //Tiempos (3 intentos): 2640ms/2.495s, 2822ms/2.763s, 2570ms/2.483s

*Prueba 2 (consulta por fecha y documento)*
SELECT * FROM Cliente
WHERE
	Fecha_Registro BETWEEN '2016-01-01' AND '2023-01-01' AND
	Documento_Cliente BETWEEN '1000000' AND '1800000'		        --//Columnas devueltas: 509.760 //Tiempos (3 intentos): 2854ms/2.761s, 2913ms/2.771s, 2893ms/2.765s

*Prueba 3 (consulta por fecha, documento y telefono)*
SELECT * FROM Cliente
WHERE
	Fecha_Registro BETWEEN '2016-01-01' AND '2023-01-01' AND
	Documento_Cliente BETWEEN '1000000' AND '1800000' AND
	Telefono BETWEEN '61000000' AND '690000000'			            --//Columnas devueltas: 381.526 //Tiempos (3 intentos): 2140ms/1.963s, 2428ms/2.218s, 2240ms/2.198s
 
---

Ahora creamos un índice acumulado que afecte a la columna 'Fecha_Registro'
 CREATE CLUSTERED INDEX IDX_FechaRegistro
 ON Cliente (Fecha_Registro);
 
---

 Una vez creado el índice acumulado, volvemos a realizar las mismas consultas.
 (PLAN: CLUSTERED INDEX IDX_FechaRegistro)
*Prueba 1 (consulta solo por fecha)*
SELECT * FROM Cliente
WHERE Fecha_Registro BETWEEN '2016-01-01' AND '2021-01-01'		--//Columnas devueltas: 455.339 //Tiempos (3 intentos): 2491ms/2.250s, 2502ms/2.474s, 2477ms/2.235s

*Prueba 2 (consulta por fecha y documento)*
SELECT * FROM Cliente
WHERE
	Fecha_Registro BETWEEN '2016-01-01' AND '2023-01-01' AND
	Documento_Cliente BETWEEN '1000000' AND '1800000'		        --//Columnas devueltas: 509.760 //Tiempos (3 intentos): 2801ms/2.751s, 2795ms/2.975s, 2897ms/2.759s

*Prueba 3 (consulta por fecha, documento y telefono)*
SELECT * FROM Cliente
WHERE
	Fecha_Registro BETWEEN '2016-01-01' AND '2023-01-01' AND
	Documento_Cliente BETWEEN '1000000' AND '1800000' AND
	Telefono BETWEEN '61000000' AND '690000000'			            --//Columnas devueltas: 381.526 //Tiempos (3 intentos): 2119ms/1.935s, 2321ms/2.221s, 2086ms/1.938s
 
---

Y Por último vamos a crear otro índice agrupado que incluya más columnas seleccionadas (no sin antes eliminar el anterior índice agrupado, 
ya que como mencionamos antes, no se puede tener 2 índices agrupados en una misma tabla)
*Eliminamos el índice anterior*
DROP INDEX IDX_FechaRegistro ON Cliente;

*Aplicamos un índice agrupado incluyendo varias columnas*
CREATE CLUSTERED INDEX IXD_FechaRegistro_Documento_Telefono
ON Cliente (Fecha_Registro, Documento_Cliente, Telefono)

---

Una vez eliminado el anterior índice y creado el indice agrupado incluyendo varias columnas, realizamos las mismas consultas. 
(PLAN: CLUSTERED INDEX IXD_FechaRegistro_Documento_Telefono)
*Prueba 1 (consulta solo por fecha)*
SELECT * FROM Cliente
WHERE Fecha_Registro BETWEEN '2016-01-01' AND '2021-01-01'		--//Columnas devueltas: 455.339 //Tiempos (3 intentos): 2505ms/2.479s, 2638ms/2.499s, 2599ms/2.506s

*Prueba 2 (consulta por fecha y documento)*
SELECT * FROM Cliente
WHERE
	Fecha_Registro BETWEEN '2016-01-01' AND '2023-01-01' AND
	Documento_Cliente BETWEEN '1000000' AND '1800000'		        --//Columnas devueltas: 509.760 //Tiempos (3 intentos): 2719ms/2.485s, 2800ms/2.761s, 2830ms/2.751s

*Prueba 3 (consulta por fecha, documento y telefono)*
SELECT * FROM Cliente
WHERE
	Fecha_Registro BETWEEN '2016-01-01' AND '2023-01-01' AND
	Documento_Cliente BETWEEN '1000000' AND '1800000' AND
	Telefono BETWEEN '61000000' AND '690000000'			            --//Columnas devueltas: 381.526 //Tiempos (3 intentos): 2069ms/1.960s, 2152ms/1.953s, 2069ms/1.956s

---

## 3. Conclusiones.
Plan sin índices ("TABLE SCAN"):
Al realizar las consultas sin un índice, todas las búsquedas involucraban un escaneo completo de la tabla. 
Esto resultó en tiempos de ejecución más largos, especialmente para consultas más complejas, como aquellas que 
involucraban múltiples filtros (como la prueba 3 con fecha, documento y teléfono).

Uso del índice en Fecha_Registro (IDX_FechaRegistro):
Al aplicar un índice sobre la columna Fecha_Registro, observamos una notable mejora en los tiempos de las consultas que 
solo filtraban por fecha (la 1era prueba), Sin embargo en las pruebas siguientes no se registraron grandes cambios
en la eficiencia del índice, debido a la complejidad de estas. Sin embargo presentando ventajas ante el Plan "Table Scan"
ya que no está realizando un escaneo completo de toda la tabla si no de una porción de la misma.

Índice compuesto en Fecha_Registro, Documento_Cliente, y Telefono (IXD_FechaRegistro_Documento_Telefono):
al crear un índice compuesto que incluyera todas las columnas clave de las consultas (fecha, documento y teléfono), 
los tiempos de ejecución mejoraron de manera más significativa, especialmente en las consultas más complejas.
es decir las que involucran las columnas Fecha, Documento y Teléfono, ya que justamente este índice está "preparado"
para consultas que involucran estas columnas.

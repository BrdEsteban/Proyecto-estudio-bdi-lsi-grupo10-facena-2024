/*
Tema: Manejo de tipos de datos JSON.

Objetivos de Aprendizaje:

Conocer el manejo de tipos de datos JSON en bases de datos relacionales.
Implementar operaciones CRUD sobre datos almacenados en formato JSON.
Criterios de Evaluación:

Implementación correcta de operaciones con datos JSON
Evaluación de la eficiencia en consultas y manipulaciones de datos JSON.
Documentación clara y conclusiones derivadas de las pruebas.
Tareas: 

1)Crear una nueva tabla  con una columna JSON
2)Agregar un conjunto de datos no estructurados en formato JSON, y realizar operaciones de actualización, agregación y borrado de datos.
3)Realizar operaciones de consultas.
4)Aproximaciones a la optimización de consultas para estas estructuras
Expresar sus conclusiones.
*/
/*
Primero nos aproximamos a funciones basicas que se pueden usar en SQL SERVER para extraer datos de tablas en formato JSON.
Funcion: FOR JSON. Sirve para extraer datos de una tabla en formato json.
*/
SELECT TOP 1 Id_Producto FROM Productos
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER --WITHOUTH_ARRAY_WRAPPER Sirve para eliminar los corchetes

SELECT TOP 3 * FROM Cliente
FOR JSON AUTO
-- Agregando la funcion FOR JSON podemos almacenar todos los datos obtenidos dentro de una unica columna en formato Json

--1)Crear una nueva tabla  con una columna JSON

CREATE TABLE Productos_json (
    Id_Producto INT NOT NULL,
    Info_producto NVARCHAR(MAX) NULL, -- Columna para almacenar datos en formato JSON
    Fecha_Registro DATE NOT NULL,
    CONSTRAINT PK_Productos_Info PRIMARY KEY (Id_Producto))

--Agregamos un CHECK que verifique que solo se ingresen datos con formato JSON en el campo Info_producto
ALTER TABLE Productos_json
ADD CONSTRAINT CK_Productos_json CHECK (ISJSON(Info_producto) > 0) -- Se utiliza la funcion ISJSON.

/*
Select * from Productos
Select * from Productos_json
DELETE FROM Productos_json
*/

/*2)Agregar un conjunto de datos no estructurados en formato JSON, y realizar operaciones de actualización, agregación y borrado de datos.
*/
INSERT INTO Productos_json (Id_Producto, Info_producto, Fecha_Registro)
SELECT 
    Id_Producto,
    JSON_QUERY(
        CONCAT('{"Codigo_producto": "', Codigo_Producto, '", ',
               '"Nombre_producto": "', Nombre_Producto, '", ',
               '"Descripcion_producto": "', Descripcion_Producto, '", ',
               '"Stock": ', Stock, ', ',
               '"Precio_Compra": "', CAST(Precio_Compra AS NVARCHAR(255)), '", ',-- Es necesario convertir el tipo de dato FLOAT a NVARCHAR
               '"Precio_Venta": "', CAST(Precio_Venta AS NVARCHAR(255)), '", ',-- Es necesario convertir el tipo de dato FLOAT a NVARCHAR
               '"Estado": ', Estado, ', ',
               '"Categoria": ', Id_Categoría, ', ',
               '"Proveedor": ', Id_Proveedor, '}')
    ) AS Info_producto,
    Fecha_Registro
FROM 
    Productos;

/*
Ahora bien. Como modifico una propiedad especifica dentro de la columna json?
La funcion JSON_MODIFY nos permite modificar los atributos dentro de la columna json
*/
--Podemos observar que el atributo "estado" de la columna json solo devuelve el valor 1 o 2. Esto podria ser mas descriptivo.

UPDATE Productos_json
SET Info_producto = JSON_MODIFY(Info_producto,'$.Estado',
    CASE
        WHEN JSON_VALUE(Info_producto, '$.Estado') = '1' THEN 'publicado'
        WHEN JSON_VALUE(Info_producto, '$.Estado') = '2' THEN 'Dado de baja'
        ELSE JSON_VALUE(Info_producto, '$.Estado') -- Mantiene el valor si no es 1 o 2
    END
)
--Para realizar la actualizacion del estado en todos los productos quitariamos el where.
WHERE Id_Producto = 2;

--Tambien podemos eliminar un atributo dentro de un json con JSON_MODIFY igualando el atributo a NULL
UPDATE Productos_json
SET Info_producto = JSON_MODIFY(Info_producto,'$.Estado',NULL)
Where Id_Producto = 2-- En caso de no poner el where se borraria el atributo 'Estado' de todos los productos dentro de la columna json.

Select * from Productos_json
Where Id_Producto = 2

/*De manera que la columna sea un poco mas descriptiva se propone un script para modificar la columna json
En lugar de mostrar el id_Categoria para el atributo "Categoria" se va a mostrar la descripcion de la categoria.
*/
UPDATE Productos_json
SET Info_producto = JSON_MODIFY(
    JSON_MODIFY(
        Info_producto,
        '$.Categoria',
        c.Descripcion_Categoria
    ),
    '$.Proveedor',
    pr.Razon_Social
)
FROM Productos_json pj
JOIN Productos p ON pj.Id_Producto = p.Id_Producto
JOIN Categorias c ON p.Id_Categoría = c.Id_Categoría
JOIN Proveedor pr ON p.Id_Proveedor = pr.Id_Proveedor;

Select	
JSON_VALUE(Info_producto, '$.Categoria') AS Categoria,
JSON_VALUE(Info_producto, '$.Proveedor') AS Proveedor
From Productos_json

/*
3)Realizar operaciones de consultas.*/
/*
A traves de la funcion JSON_VALUE Podemos extraer a modo registro los campos guardados en la columna JSON.
En caso de que se quiera extrar un campo con un arreglo se utiliza JSON_QUERY
*/
Select	JSON_VALUE(Info_producto, '$.Estado') AS nombre from Productos_json
WHERE Id_Producto = 2

/*
Tambien puedo extrar varios campos en un solo select y normalizarlos en formato tabla
*/
Select	
JSON_VALUE(Info_producto, '$.Nombre_producto') AS Nombre, 
JSON_VALUE(Info_producto, '$.Precio_Venta') AS Precio,
JSON_VALUE(Info_producto, '$.Estado') AS Estado
From Productos_json


Select	
JSON_VALUE(Info_producto, '$.Nombre_producto') AS Nombre
From Productos_json
Where JSON_VALUE(Info_producto, '$.Categoria')= 'Accesorios' AND JSON_VALUE(Info_producto, '$.Stock')< '60'

/*4)Aproximaciones a la optimización de consultas para estas estructuras

Al almacenar datos JSON en SQL Server, normalmente querrá filtrar u ordenar resultados de consultas por una o varias propiedades de los documentos JSON.
Los índices funcionan de la misma manera en los datos JSON en varchar/nvarchar o en el tipo de datos json nativo.
Se pueden indexar las propiedades o "atributos" dentro del JSON mediante columnas calculadas
*/

--Para optimizar la siguiente consulta:
--Trae el nombre de los productos de la categoria accesorios con un stock menor a 200.
SELECT	
    JSON_VALUE(Info_producto, '$.Nombre_producto') AS Nombre
FROM 
    Productos_json
WHERE 
    JSON_VALUE(Info_producto, '$.Categoria') = 'Accesorios' 
    AND TRY_CAST(JSON_VALUE(Info_producto, '$.Stock') AS INT) < 200;

/* Creamos columnas calculadas Nombre_producto, Categoria y Stock en la tabla Productos_json
Esto permitirá que la consulta acceda a los valores de Categoria y Stock directamente desde el índice, 
en lugar de extraer los datos de Info_producto en cada consulta.*/

ALTER TABLE Productos_json
ADD 
    Nombre_producto AS JSON_VALUE(Info_producto, '$.Nombre_producto'),
    Categoria AS JSON_VALUE(Info_producto, '$.Categoria'),
    Stock AS TRY_CAST(JSON_VALUE(Info_producto, '$.Stock') AS INT); -- Convertimos a INT para poder usar mejor los comparadores <,>

--Select * from Productos_json

-- Creamos los indices
CREATE INDEX IDX_ProductosJson_Categoria ON Productos_json(Categoria);
CREATE INDEX IDX_ProductosJson_Stock ON Productos_json(Stock);

--Ejecuto nuevamente la consulta para observar el rendimiento
SELECT Nombre_producto AS Nombre
FROM Productos_json
WHERE Categoria = 'Accesorios' AND Stock < 200;


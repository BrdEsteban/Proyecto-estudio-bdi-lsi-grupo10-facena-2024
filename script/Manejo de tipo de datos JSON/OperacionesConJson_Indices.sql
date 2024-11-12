/*
Tema: Manejo de tipos de datos JSON en SQL Server.

**Objetivos de Aprendizaje:**
1. Conocer el manejo de tipos de datos JSON en bases de datos relacionales.
2. Implementar operaciones CRUD sobre datos almacenados en formato JSON.

**Tareas:**
1. Crear una nueva tabla con una columna JSON.
2. Agregar datos no estructurados en formato JSON y realizar operaciones de actualización, agregación y borrado.
3. Ejecutar operaciones de consulta sobre datos JSON.
4. Optimizar consultas para estas estructuras JSON.

*/

/* 
Ejemplo de funciones básicas para extraer datos de tablas en formato JSON. 
Función: FOR JSON - convierte los datos en JSON.
*/

-- Ejemplo de FOR JSON con PATH y WITHOUT_ARRAY_WRAPPER para eliminar corchetes:
SELECT TOP 1 Id_Producto, Nombre_Producto, Descripcion_Producto 
FROM Productos
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER; --WITHOUT_ARRAY_WRAPPER quita los corchetes

-- Ejemplo de FOR JSON AUTO:
SELECT * FROM Cliente
FOR JSON AUTO;

SELECT * FROM Productos
FOR JSON AUTO;

/* 
1. Crear una nueva tabla con una columna JSON 
*/

CREATE TABLE Productos_json (
    Id_Producto INT NOT NULL,
    Info_producto NVARCHAR(MAX) NULL, -- Columna para almacenar datos JSON
    Fecha_Registro DATE NOT NULL,
    CONSTRAINT PK_Productos_Info PRIMARY KEY (Id_Producto)
);

-- Agregamos un CHECK para verificar que solo se ingresen datos en formato JSON en Info_producto
ALTER TABLE Productos_json
ADD CONSTRAINT CK_Productos_json_isjson CHECK (ISJSON(Info_producto) > 0);

/* 
2. Insertar datos en formato JSON y realizar operaciones de actualización, agregación y borrado 
*/

-- Insertar datos de la tabla Productos en formato JSON en la nueva tabla Productos_json
INSERT INTO Productos_json (Id_Producto, Info_producto, Fecha_Registro)
SELECT 
    Id_Producto,
    JSON_QUERY(
        CONCAT('{"Codigo_producto": "', Codigo_Producto, '", ',
               '"Nombre_producto": "', Nombre_Producto, '", ',
               '"Descripcion_producto": "', Descripcion_Producto, '", ',
               '"Stock": ', Stock, ', ',
               '"Precio_Compra": "', CAST(Precio_Compra AS NVARCHAR(255)), '", ',
               '"Precio_Venta": "', CAST(Precio_Venta AS NVARCHAR(255)), '", ',
               '"Estado": ', Estado, ', ',
               '"Categoria": ', Id_Categoría, ', ',
               '"Proveedor": ', Id_Proveedor, '}')
    ) AS Info_producto,
    Fecha_Registro
FROM 
    Productos;

/* 
Actualización de un campo específico en la columna JSON usando JSON_MODIFY
*/

-- Modificar el campo "Estado" para hacerlo más descriptivo
UPDATE Productos_json
SET Info_producto = JSON_MODIFY(Info_producto, '$.Estado',
    CASE
        WHEN JSON_VALUE(Info_producto, '$.Estado') = '1' THEN 'publicado'
        WHEN JSON_VALUE(Info_producto, '$.Estado') = 'Dado de baja'
        ELSE JSON_VALUE(Info_producto, '$.Estado')
    END
)
WHERE Id_Producto = 2;

-- Eliminar un atributo dentro de la columna JSON estableciendo el valor del atributo en NULL
UPDATE Productos_json
SET Info_producto = JSON_MODIFY(Info_producto, '$.Estado', NULL)
WHERE Id_Producto = 2;

/* 
Actualizar el campo "Categoria" con el nombre descriptivo y "Proveedor" con la razón social
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

/* 
3. Consultas en datos JSON 
*/

-- Consultar un campo específico dentro del JSON utilizando JSON_VALUE
SELECT JSON_VALUE(Info_producto, '$.Estado') AS Estado
FROM Productos_json
WHERE Id_Producto = 2;

-- Extraer varios campos de la columna JSON
SELECT	
    JSON_VALUE(Info_producto, '$.Nombre_producto') AS Nombre, 
    JSON_VALUE(Info_producto, '$.Precio_Venta') AS Precio,
    JSON_VALUE(Info_producto, '$.Estado') AS Estado
FROM Productos_json;

/* 
Consultar productos con un stock menor a un valor específico
*/

SELECT	
    JSON_VALUE(Info_producto, '$.Nombre_producto') AS Nombre,
    JSON_VALUE(Info_producto, '$.Descripcion_producto') AS Descripcion
FROM Productos_json
WHERE JSON_VALUE(Info_producto, '$.Stock') < '60';

/*Observamos en el plan de ejecucion que se realiza un index scan*/

/* 
4. Optimización de consultas en estructuras JSON 
*/

-- Ejemplo de consulta que optimizaremos mediante índices:
SELECT	
    JSON_VALUE(Info_producto, '$.Nombre_producto') AS Nombre
FROM 
    Productos_json
WHERE 
    JSON_VALUE(Info_producto, '$.Categoria') = 'Accesorios' 
    AND TRY_CAST(JSON_VALUE(Info_producto, '$.Stock') AS INT) >= 50;

/* 
Creación de columnas calculadas para optimizar consultas mediante índices en columnas JSON
*/

ALTER TABLE Productos_json
ADD 
    Nombre_producto AS JSON_VALUE(Info_producto, '$.Nombre_producto'),
    Categoria AS LEFT(JSON_VALUE(Info_producto, '$.Categoria'), 100) PERSISTED, --Limitamos caracteres para el índice para poder crear un indice sin problemas
    Stock AS TRY_CAST(JSON_VALUE(Info_producto, '$.Stock') AS INT);

/*Probamos la consulta pero utilizando las columnas calculadas*/

SELECT Nombre_producto AS Nombre
FROM Productos_json
WHERE Categoria like 'Accesorios' AND Stock > 50;

select * from Productos_json
--Notamos que el motor sigue haciendo un scan

/* 
Creación de índice para mejorar la consulta por Categoria incluyendo a las columnas Nombre_producto, Stock
*/

CREATE INDEX IDX_ProductosJson_Categoria_Nombre_Stock ON Productos_json(Categoria) INCLUDE (Nombre_producto, Stock);

--drop index IDX_ProductosJson_Categoria_Nombre_Stock on Productos_json

/* Consulta optimizada */
--Utilizamos las columnas calculadas para realizar la consulta

SELECT Nombre_producto AS Nombre
FROM Productos_json
WHERE Categoria = 'Accesorios' AND Stock > 50;

Select * from Productos_json
/*Observamos que se utiliza un Idex seek que resulta mas eficiente que un index scan.*/

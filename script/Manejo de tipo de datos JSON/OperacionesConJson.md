# Proyecto: Gestión de Ventas de Productos Electrónicos
# Tema: Manejo de tipos de datos Json
**Grupo:** 10  
**Comisión:** 2  
**Integrantes:**  
- Garay, Kevin Emiliano  
- Borda, Esteban Rubén
- Acosta López, Gonzalo Nahuel
- Mancedo, Joaquin  

## Teoría
El manejo de JSON (JavaScript Object Notation) es relevante cuando se trabaja con integraciones de sistemas externos, ya que permite el intercambio de datos de manera eficiente y estructurada. JSON es útil para almacenar configuraciones de productos o integrar datos de ventas desde otras plataformas. Otro beneficio es que los datos de tipo JSON es su longitud que puede ser variable. Dentro de un Json se puede agregar tags nuevos e insertar nuevos datos sin afectar a los demás campos y sin la necesidad de crear nuevas columnas.
En SQL Server, en lugar de un tipo de datos JSON explícito, se usa el tipo de datos NVARCHAR (normalmente NVARCHAR(MAX)) para almacenar los datos JSON. Luego, se utilizan funciones JSON nativas para manipular y consultar datos.

## 1. Creación de una tabla que almacene datos tipo Json
1.Crear una tabla que permita almacenar datos json.
2.La columna que permite almacenar JSON es 'Info_producto NVARCHAR(MAX) NULL'.
3.Se crea además una constraint con la función definida ISJSON que verifica que el formato del nvarchar que se ingrese sea del formato Json
'CK_Productos_json_isjson CHECK (ISJSON(Info_producto) > 0);'

## 2. Inserciones a la tabla Json a partir de columnas no estructuradas como Json
1. Insertamos en nuestra nueva tabla los datos extraídos de la tabla 'producto' a través de la función json_query que nos permite manipular el arreglo en formato json para insertar en la columna info_producto de tipo json (nvarchar(max)).
## 3. Operaciones y funciones para manejo de tipo de datos Json
1. Se realizan consultas basicas para extraer informacion almacenada dentro de la columna Json Info_producto.
2. Utilizamos la funcion 'JSON VALUE'.
## 4. Aproximacion a la optimizacion de consultas operando datos Json
1. Primero ejecutamos una consulta sencilla para visualizar su plan de ejecucion.Observamos que el motoro realiza un 'Index Scan'.
2. Aplicamos una tecnica basica para indexar datos almacenados de json que consiste en generar columnas calculadas a partir de los datos extraidos de del json para poder indexar.
3. Creamos un indice no agrupado incluyendo a las columnas generadas que forman parte de la consulta.
4. Ejecutamos nuevamente la consulta para observar su plan de ejecucion y observamos que el motor realiza efectivamente un 'Index Seek'.

## Conclusiones
- Realizando las operaciones basicas y entendiendo como se realiza el manejo de datos JSON en SQL Server podemos observar los siguientes topicos.
-Ventajas:
    -Versatilidad: Permite manejar grandes volúmenes de datos semi-estructurados sin la necesidad de crear múltiples tablas. *Es importante considerar que los datos
      a almacenar no comprometan la integridad de la base de datos.*
    -Flexibilidad en Actualizaciones: JSON facilita agregar o modificar propiedades sin alterar el esquema de la tabla. *En columnas json bien estructuradas donde         no se realicen consultas tan complejas.*
    -Almacenamiento: Al consolidar múltiples atributos dentro de un campo JSON, se reduce la cantidad de columnas en la tabla y la complejidad en el diseño de la         base de datos. El campo json puede crecer y ser editado siempre que se maneje dentro del limite de caracteres designado a la columna. *Pero es importante             tener en cuenta que a mayor tamaño mayor implicancia en el rendimiento de las consultas*

 -Desventajas:
     -Rendimiento: Las consultas en JSON pueden ser más lentas que las consultas en columnas tradicionales. Aun cuando se crean columnas calculadas e índices, el         rendimiento puede no ser óptimo para consultas complejas. *Casi siempre tendremos que implementar indices de manera estrategica para optimizar las consultas.         Sin embargo el uso de multiples indices podria generar problemas en el rendimiento por la naturaleza propia de los indices*.
     -Mantenimiento: Los datos JSON requieren *validación adicional* y una prueba de rendimiento para sistemas donde los datos semi-formateados sean muy                     extensos. En este punto el rendimiento se veria afectado por el tiempo que lleve solucionar las consultas de manera eficiente por parte del equipo de                desarrolladores. 
Oobservamos que el uso de json en SQL puede ser muy útil exportar un json con la información requerida para algún otro sistema.
Sus desventajas estan dadas por el tamaño, la complejidad en el diseño de la base de datos y de los datos almacenados de tipo json.
Teniendo en cuenta estos puntos entendemos que una buena forma de aprovechar el potencial de estos tipos de datos semi estructurados sería que guarden información que pudiera cambiar con el tiempo pero que no comprometa el diseño estructural de la base de datos. Es decir, información que complemente al sistema y sea necesaria pero que al ser tan cambiante pueda estar en un json aprovechando sus ventajas y no haya que cambiar el modelo de la base SQL. 
    


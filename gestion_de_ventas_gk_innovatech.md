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


## CAPÍTULO IV: DESARROLLO DEL TEMA / PRESENTACIÓN DE RESULTADOS 





### Diagrama conceptual (opcional)
![diagrama_relacional](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/doc/image.png) 

### Diagrama relacional
![diagrama_relacional](https://github.com/BrdEsteban/Proyecto-estudio-bdi-lsi-grupo10-facena-2024/blob/master/doc/Relational.png) 

### Diccionario de datos

Acceso al documento [PDF](doc/diccionario_datos.pdf) del diccionario de datos.

### Modelo Fisico

-- SCRIPT TEMA "Definicion de la base de datos"
-- DEFINNICIÓN DEL MODELO DE DATOS

Create database GK_Innovatech
GO

USE GK_Innovatech
GO


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


### Desarrollo Manejo de Permisos y Roles


### Desarrollo TEMA 2 "----"




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



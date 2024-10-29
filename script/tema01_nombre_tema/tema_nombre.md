# Proyecto: Gestión de Ventas de Productos Electrónicos
# Tema: Manejo de permisos y roles

**Grupo:** 10  
**Comisión:** 2  
**Integrantes:**  
- Garay, Kevin Emiliano  
- Borda, Esteban Sebastian  
- Acosta, Gonzalo Nahuel  
- Mancedo, Joaquin  

## Teoría
En SQL Server, todos los elementos protegibles tienen permisos asociados que se pueden asignar a entidades de seguridad. La gestión de permisos en el motor de base de datos se realiza a nivel de servidor, mediante la asignación a inicios de sesión y roles de servidor, y a nivel de base de datos, mediante la asignación a usuarios y roles específicos. Esta estructura permite un control granular sobre las acciones que pueden realizarse en los diferentes objetos y recursos del sistema.

---

## 1. Creación de inicios de sesión y usuarios en la base de datos
1. **AdminUser**: Se crea un inicio de sesión para un usuario administrador, permitiéndole privilegios de administrador en el servidor (`sysadmin`).
2. **ABM**: Se crea un inicio de sesión específico para manejar permisos de lectura y escritura.
3. **Consulta**: Se configura un usuario solo con permisos de lectura sobre ciertas tablas.
4. **G10**: Se crea un usuario de base de datos para Mancedo, con permisos de lectura, inserción y eliminación sobre ciertas tablas.

## 2. Asignación de roles y permisos
1. **AdminUser**: Se otorga el rol `sysadmin`, permitiendo acceso completo en el servidor. Este usuario puede agregar o eliminar tablas, entre otros.
2. **ABM**: Concede permisos de `db_datareader` y `db_datawriter` al usuario `Borda`, permitiendo lectura y escritura en la base de datos.
3. **Consulta**: Usuario `Acosta` tiene permisos de solo lectura sobre ciertas tablas (Venta, Productos, Categorías), asignado al rol `ReadOnlyRole`.
4. **G10**: Usuario `Mancedo` recibe permisos de lectura e inserción en productos y categorías, ejecución de un procedimiento almacenado (`altaUsuario`), y permisos para eliminar registros en tablas específicas. Se le niega el permiso de `UPDATE`.

## 3. Pruebas de permisos y roles
1. **Usuario AdminUser**: Prueba la capacidad de crear y eliminar tablas (debería permitirlo).
2. **Usuario Borda (ABM)**: Prueba la inserción y consulta en la tabla `Productos`.
3. **Usuario Acosta (Consulta)**: Prueba consultas de lectura, y se confirma que no puede insertar.
4. **Usuario Mancedo (G10)**: Se verifica que puede realizar operaciones de lectura, inserción y eliminación, ejecutar procedimientos almacenados, pero que falla al intentar realizar un `UPDATE`.

## 4. Comprobación del comportamiento de permisos
1. Se verifica el acceso de lectura con el usuario de solo lectura (`Acosta`) y se espera que el acceso esté permitido.
2. Con un usuario sin permisos de lectura, el acceso a la misma consulta debería estar denegado, validando la configuración de seguridad implementada.

---

## Conclusiones
La implementación de permisos en una base de datos incrementa significativamente la confiabilidad y la integridad de los datos, ya que permite definir con precisión qué usuarios pueden realizar modificaciones. Esto añade una capa adicional de seguridad a las funcionalidades del sistema, garantizando que solo los usuarios autorizados puedan efectuar cambios específicos. La adecuada administración de permisos es fundamental para mantener la seguridad y la consistencia de la base de datos, protegiendo así los datos sensibles y asegurando un entorno controlado y fiable.

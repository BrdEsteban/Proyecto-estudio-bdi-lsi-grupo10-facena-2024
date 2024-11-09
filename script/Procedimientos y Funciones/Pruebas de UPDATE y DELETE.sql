SELECT * FROM Usuario WHERE Id_Usuario = 1003

-- Modifica el correo del Usuario 1003 Juan Gomez
EXEC modUsuario @id = 1003, @modDni = NULL,  @modCorreo = 'juan@mail.com', @modNombre = NULL, @modApellido = NULL, @modClave = NULL

SELECT * FROM Usuario WHERE Id_Usuario = 1003

SELECT Estado FROM Productos WHERE Id_Producto = 1005

-- Baja lógica (Cambia el estado a 0)
	EXEC bajaProducto @idBaja = 1005

SELECT Estado FROM Productos WHERE Id_Producto = 1005
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
SELECT * FROM Productos WHERE Id_Producto = 1009
	-- Baja física (Elimina el registro)
	EXEC eliminarProducto @idBaja = 1009

SELECT * FROM Productos WHERE Id_Producto = 1009

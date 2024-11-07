-- ================================================
-- Procedimientos de Modificación de registros
-- ================================================


-- ================================================
-- Modificar Usuarios
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Borda Esteban Ruben
-- Create date: 11/10/2024
-- Description:	Modifica los datos de un usuario
-- =============================================
CREATE PROCEDURE modUsuario
	@id				 INT          = NULL,
    @modDni          INT          = NULL,
	@modCorreo		 VARCHAR(100) = NULL,
	@modNombre		 VARCHAR(100) = NULL,
	@modApellido     VARCHAR(100) = NULL,
	@modClave        VARCHAR(80)  = NULL
AS
BEGIN
	--Validación de datos
	--Verifica que se haya ingresado una ID
    IF @id IS NULL
		BEGIN
			PRINT 'No se ingresó una id';
		END
	--Verifica que la ID exista
	IF @id NOT IN (SELECT Id_Usuario FROM Usuario WHERE @id = Id_Usuario)
		BEGIN
			PRINT 'No se ingresó una id válida'
		END
	--Toma el valor anterior en caso de que alguno de los parámetros no haya sido modificado
	IF @modDni = NULL
		BEGIN
			SET @modDni = (SELECT Documento_Usuario FROM Usuario WHERE @id = Id_Usuario);
		END
	IF @modCorreo = NULL
		BEGIN
			SET @modCorreo = (SELECT Correo FROM Usuario WHERE @id = Id_Usuario);
		END
	IF @modNombre = NULL
		BEGIN
			SET @modNombre    = (SELECT Nombre FROM Usuario WHERE @id = Id_Usuario)
		END
	IF @modApellido = NULL
		BEGIN
			SET @modApellido    = (SELECT Apellido FROM Usuario WHERE @id = Id_Usuario)
		END
	IF @modClave = NULL
		BEGIN
			SET @modClave    = (SELECT Clave FROM Usuario WHERE @id = Id_Usuario)
		END
	--Try Catch por si ocurre algún error
    BEGIN TRY
		
			UPDATE Usuario
				SET Documento_Usuario = @modDni,
					Nombre = @modNombre,
					Apellido = @modApellido,
					Correo = @modCorreo,
					Clave = @modClave
			WHERE Id_Usuario = @id

    END TRY
    BEGIN CATCH
        PRINT 'Error al modificar usuario ';
    END CATCH;
END;

GO


-- =============================================
-- Author:		Borda Esteban Ruben
-- Create date: 11/10/2024
-- Description:	Modifica los datos de un producto
-- =============================================

CREATE PROCEDURE modProducto
	@id				 INT          = NULL,
    @modCod          VARCHAR(80)  = NULL,
	@modNombre		 VARCHAR(100) = NULL,
	@modDescripcion  VARCHAR(100) = NULL,
	@modStock        INT          = NULL,
	@modPrecioC		 FLOAT        = NULL,
	@modPrecioV		 FLOAT        = NULL
AS
BEGIN
	--Validación de datos
	--Verifica que se haya ingresado una ID
    IF @id IS NULL
		BEGIN
			PRINT 'No se ingresó una id';
		END
	--Verifica que la ID exista
	IF @id NOT IN (SELECT Id_Producto FROM Productos WHERE @id = Id_Producto)
		BEGIN
			PRINT 'No se ingresó una id válida'
		END
	--Toma el valor anterior en caso de que alguno de los parámetros no haya sido modificado
	IF @modCod = NULL
		BEGIN
			SET @modCod = (SELECT Codigo_Producto FROM Productos WHERE @id = Id_Producto);
		END
	IF @modNombre = NULL
		BEGIN
			SET @modNombre    = (SELECT Nombre_Producto FROM Productos WHERE @id = Id_Producto)
		END
	IF @modDescripcion = NULL
		BEGIN
			SET @modDescripcion = (SELECT Descripcion_Producto FROM Productos WHERE @id = Id_Producto)
		END
	IF @modStock = NULL
		BEGIN
			SET @modStock    = (SELECT Stock FROM Productos WHERE @id = Id_Producto)
		END
	IF @modPrecioC = NULL
		BEGIN
			SET @modPrecioC = (SELECT Precio_Compra FROM Productos WHERE @id = Id_Producto)
		END
	IF @modPrecioV = NULL
		BEGIN
			SET @modPrecioV = (SELECT Precio_Venta FROM Productos WHERE @id = Id_Producto)
		END
	--Try Catch por si ocurre algún error
    BEGIN TRY
		
			UPDATE Productos
				SET Codigo_Producto = @modCod,
					Nombre_Producto = @modNombre,
					Descripcion_Producto = @modDescripcion,
					Stock = @modStock,
					Precio_Compra = @modPrecioC,
					Precio_Venta = @modPrecioV
			WHERE Id_Producto = @id

    END TRY
    BEGIN CATCH
        PRINT 'Error al modificar producto';
    END CATCH;
END;

GO

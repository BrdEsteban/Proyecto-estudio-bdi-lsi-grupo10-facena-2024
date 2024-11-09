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
    @id            INT          = NULL,
    @modDni        INT          = NULL,
    @modCorreo     VARCHAR(100) = NULL,
    @modNombre     VARCHAR(100) = NULL,
    @modApellido   VARCHAR(100) = NULL,
    @modClave      VARCHAR(80)  = NULL
AS
BEGIN
    -- Validación de datos
    IF @id IS NULL
    BEGIN
        PRINT 'No se ingresó una ID';
        RETURN;
    END
    
    -- Verifica que la ID exista
    IF NOT EXISTS (SELECT 1 FROM Usuario WHERE Id_Usuario = @id)
    BEGIN
        PRINT 'No se ingresó una ID válida';
        RETURN;
    END

    -- Try-Catch por si ocurre algún error
    BEGIN TRY
        -- Si los valores fueron ingresados, realiza el UPDATE
        IF @modDni IS NOT NULL
        BEGIN
            UPDATE Usuario SET Documento_Usuario = @modDni WHERE Id_Usuario = @id;
        END
        IF @modCorreo IS NOT NULL
        BEGIN
            UPDATE Usuario SET Correo = @modCorreo WHERE Id_Usuario = @id;
        END
        IF @modNombre IS NOT NULL
        BEGIN
            UPDATE Usuario SET Nombre = @modNombre WHERE Id_Usuario = @id;
        END
        IF @modApellido IS NOT NULL
        BEGIN
            UPDATE Usuario SET Apellido = @modApellido WHERE Id_Usuario = @id;
        END
        IF @modClave IS NOT NULL
        BEGIN
            UPDATE Usuario SET Clave = @modClave WHERE Id_Usuario = @id;
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error al modificar usuario';
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
	IF NOT EXISTS (SELECT Id_Producto FROM Productos WHERE @id = Id_Producto)
		BEGIN
			PRINT 'No se ingresó una id válida'
		END
	--Try Catch por si ocurre algún error
	BEGIN TRY
	-- Realiza los UPDATE si hay cambios que realizar
	IF @modCod IS NOT NULL
		BEGIN
			UPDATE Productos
				SET Codigo_Producto = @modCod
			WHERE Id_Producto = @id
		END
	IF @modNombre IS NOT NULL
		BEGIN
			UPDATE Productos
				SET Nombre_Producto = @modNombre
			WHERE Id_Producto = @id
		END
	IF @modDescripcion IS NOT NULL
		BEGIN
			UPDATE Productos
				SET Descripcion_Producto = @modDescripcion
			WHERE Id_Producto = @id
		END
	IF @modStock IS NOT NULL
		BEGIN
			UPDATE Productos
				SET Stock = @modStock
			WHERE Id_Producto = @id
		END
	IF @modPrecioC IS NOT NULL
		BEGIN
			UPDATE Productos
				SET Precio_Compra = @modPrecioC
			WHERE Id_Producto = @id
		END
	IF @modPrecioV = NULL
		BEGIN
			UPDATE Productos
				SET Precio_Venta = @modPrecioV
			WHERE Id_Producto = @id
		END
	
		


    END TRY
    BEGIN CATCH
        PRINT 'Error al modificar producto';
    END CATCH;
END;

GO

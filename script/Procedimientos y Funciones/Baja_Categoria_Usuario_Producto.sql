-- ================================================
-- Procedimientos de Baja lógica
-- ================================================


-- ================================================
-- Baja de Categorias
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Borda Esteban Ruben
-- Create date: 11/10/2024
-- Description:	Actualiza el estado de categorias en la base de datos
-- =============================================
CREATE PROCEDURE bajaCategoria 
    @idBaja         INT       = NULL
AS
BEGIN
	--Validación de datos
    IF @idBaja IS NULL
		PRINT 'Hay valores no ingresados';
	--Try Catch por si ocurre algún error
    BEGIN TRY
		
			UPDATE Categorias
			SET Estado = 0
			WHERE Id_Categoría = @idBaja

    END TRY
    BEGIN CATCH
        PRINT 'Error al dar de baja la Categoria';
    END CATCH;
END;

GO

-- ================================================
-- Baja de Usuarios
-- ================================================

-- =============================================
-- Author:		Borda Esteban Ruben
-- Create date: 11/10/2024
-- Description:	Actualiza el estado de Usuarios en la base de datos
-- =============================================
CREATE PROCEDURE bajaUsuario
    @dniBaja         INT       = NULL
AS
BEGIN
	--Validación de datos
    IF @dniBaja IS NULL
			PRINT 'Hay valores no ingresados';
	--Try Catch por si ocurre algún error
    BEGIN TRY
		
			UPDATE Usuario
			SET Estado = 0
			WHERE Documento_Usuario = @dniBaja

    END TRY
    BEGIN CATCH
        PRINT 'Error al dar de baja al usuario ';
    END CATCH;
END;

GO

-- ================================================
-- Baja de Productos
-- ================================================

-- =============================================
-- Author:		Borda Esteban Ruben
-- Create date: 11/10/2024
-- Description:	Actualiza el estado de Productos en la base de datos
-- =============================================
CREATE PROCEDURE bajaProducto
    @idBaja         INT       = NULL
AS
BEGIN
	--Validación de datos
    IF @idBaja IS NULL
		PRINT 'Hay valores no ingresados';
	--Try Catch por si ocurre algún error
    BEGIN TRY
		
			UPDATE Productos
			SET Estado = 0
			WHERE Id_Producto = @idBaja

    END TRY
    BEGIN CATCH
        PRINT 'Error al dar de baja el producto';
    END CATCH;
END;

GO

-- ================================================
-- Procedimientos de Baja física
-- ================================================

-- =============================================
-- Author:		Borda Esteban Ruben
-- Create date: 02/11/2024
-- Description:	Elimina un registro de la tabla categorias en la base de datos
-- =============================================
CREATE PROCEDURE eliminarCategoria 
    @idBaja         INT       = NULL
AS
BEGIN
	--Validación de datos
    IF @idBaja IS NULL
		PRINT 'Hay valores no ingresados';
	--Try Catch por si ocurre algún error
    BEGIN TRY
		
			DELETE Categorias
			WHERE Id_Categoría = @idBaja

    END TRY
    BEGIN CATCH
        PRINT 'Error al dar de baja la Categoria';
    END CATCH;
END;

GO

-- ================================================
-- Baja de Usuarios
-- ================================================

-- =============================================
-- Author:		Borda Esteban Ruben
-- Create date: 02/11/2024
-- Description:	Elimina un registro de la tabla Usuarios en la base de datos
-- =============================================
CREATE PROCEDURE eliminarUsuario
    @dniBaja         INT       = NULL
AS
BEGIN
	--Validación de datos
    IF @dniBaja IS NULL
		PRINT 'Hay valores no ingresados';
	--Try Catch por si ocurre algún error
    BEGIN TRY
		
			DELETE Usuario
			WHERE Documento_Usuario = @dniBaja

    END TRY
    BEGIN CATCH
        PRINT 'Error al dar de baja al usuario ';
    END CATCH;
END;

GO

-- ================================================
-- Baja de Productos
-- ================================================

-- =============================================
-- Author:		Borda Esteban Ruben
-- Create date: 02/11/2024
-- Description:	Elimina un registro de la tabla Productos en la base de datos
-- =============================================
CREATE PROCEDURE eliminarProducto
    @idBaja         INT       = NULL
AS
BEGIN
	--Validación de datos
    IF @idBaja IS NULL
		PRINT 'Hay valores no ingresados';
	--Try Catch por si ocurre algún error
    BEGIN TRY
		
			DELETE Productos
			WHERE Id_Producto = @idBaja

    END TRY
    BEGIN CATCH
        PRINT 'Error al dar de baja el producto';
    END CATCH;
END;

GO

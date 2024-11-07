-- ================================================
-- Alta de Categorias
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Borda Esteban Ruben
-- Create date: 11/10/2024
-- Description:	Registra categorias en la base de datos
-- =============================================
CREATE PROCEDURE altaCategoria
	--Parámetros y valores por defecto
    @Descripcion    nvarchar(100)  = NULL,
    @Estado         INT            = NULL,
    @Fecha_registro DATE           = NULL
AS
BEGIN
	--Valor por defecto de la fecha
    IF @Fecha_registro IS NULL
		BEGIN
			SET @Fecha_registro = GETDATE();
		END
	--Validación de datos
    IF @Descripcion IS NULL OR @Estado IS NULL
		BEGIN
			PRINT 'Hay valores no ingresados';
			RETURN;
		END
	--Try Catch por si ocurre algún error
    BEGIN TRY
		BEGIN TRANSACTION; --Aplicamos una transaccion entonces el id no autoincrementara
			INSERT INTO Categorias (Descripcion_Categoria, Estado, Fecha_Registro) VALUES
			(@Descripcion, @Estado, @Fecha_registro);
		COMMIT TRANSACTION; --Si todo salio bien entonces subimos el cambio
    END TRY
    BEGIN CATCH
        PRINT 'Error al insertar la categoria';
			ROLLBACK TRANSACTION; -- Si algo falla regresamos
    END CATCH;
END;

GO


-- ================================================
-- Alta de Productos
-- ================================================

-- =============================================
-- Author:		Borda Esteban Ruben
-- Create date: 11/10/2024
-- Description:	Registra productos en la base de datos
-- =============================================
CREATE PROCEDURE altaProducto 
	--Parámetros y valores por defecto
    @Codigo         nvarchar(80)   = NULL,
    @Nombre_p       nvarchar(100)  = NULL,
    @Descripcion    nvarchar(100)  = NULL,
    @Stock          INT            = NULL,
    @Precio_compra  FLOAT          = NULL,
    @Precio_venta   FLOAT          = 1,
    @Estado         INT            = 1,
	@Categoria      INT            = NULL,
	@Proveedor      INT            = NULL,
	@Fecha_registro DATE           = NULL
AS
BEGIN
	--Valor por defecto de la fecha
    IF @Fecha_registro IS NULL
		BEGIN
			SET @Fecha_registro = GETDATE();
		END
	--Validación de datos
    IF @Codigo IS NULL OR @Nombre_p IS NULL OR @Descripcion IS NULL OR @Stock IS NULL OR @Precio_compra IS NULL OR @Precio_venta IS NULL OR @Estado IS NULL OR @Categoria IS NULL OR @Proveedor IS NULL
		BEGIN
			PRINT 'Hay valores no ingresados';
			RETURN;
		END
	--Try Catch por si ocurre algún error
    BEGIN TRY
		BEGIN TRANSACTION; --Aplicamos una transaccion entonces el id no autoincrementara
			INSERT INTO Productos (Codigo_Producto, Nombre_Producto, Descripcion_Producto, Stock, Precio_Compra, Precio_Venta, Estado, Fecha_Registro, Id_Categoría, Id_Proveedor) VALUES
			(@Codigo, @Nombre_p, @Descripcion, @Stock, @Precio_compra, @Precio_venta, @Estado, @Fecha_registro, @Categoria, @Proveedor);
		COMMIT TRANSACTION; --Si todo salio bien entonces subimos el cambio
    END TRY
    BEGIN CATCH
        PRINT 'Error al insertar el producto';
			ROLLBACK TRANSACTION; -- Si algo falla regresamos
    END CATCH;
END;

GO


-- ================================================
-- Alta de Usuarios
-- ================================================

-- =============================================
-- Author:		Borda Esteban Ruben
-- Create date: 11/10/2024
-- Description:	Registra usuarios en la base de datos
-- =============================================
CREATE PROCEDURE altaUsuario 
	--Parámetros y valores por defecto
    @Dni INT = NULL,
    @Nombre NVARCHAR(100) = NULL,
    @Apellido NVARCHAR(100) = NULL,
    @Correo NVARCHAR(100) = NULL,
    @Clave NVARCHAR(80) = NULL,
    @Estado INT = 1,
    @Rol INT = 3

AS
BEGIN

    -- Validación de datos
    IF @Dni IS NULL OR @Nombre IS NULL OR @Apellido IS NULL OR @Correo IS NULL OR @Clave IS NULL OR @Estado IS NULL OR @Rol IS NULL
    BEGIN
        PRINT 'Hay valores no ingresados';
        RETURN;
    END
    
    -- Try Catch para manejo de errores
    BEGIN TRY
						 BEGIN TRANSACTION; --Aplicamos una transaccion entonces el id no autoincrementara
        
        INSERT INTO Usuario (Documento_Usuario, Nombre, Apellido, Correo, Clave, Estado, Id_Rol) 
        VALUES (@Dni, @Nombre, @Apellido, @Correo, @Clave, @Estado, @Rol);
        
						 COMMIT TRANSACTION; --Si todo salio bien entonces subimos el cambio
    END TRY
    BEGIN CATCH
        PRINT 'Error al insertar el usuario: ';
						 ROLLBACK TRANSACTION; -- Si algo falla regresamos
    END CATCH;
END;
GO

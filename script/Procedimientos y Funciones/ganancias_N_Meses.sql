-- ================================================
-- Devuelve la suma de los precios de venta de un producto
-- ================================================
-- =============================================
-- Author:		Borda Esteban Ruben
-- Create date: 16/10/2024
-- Description:	
-- =============================================
 
CREATE FUNCTION ganancias_N_Meses(@pNro_meses INT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @venta FLOAT
    SET @venta = (SELECT SUM(P.Precio_Venta * DV.Cantidad) FROM Detalle_Venta DV 
	JOIN Productos P ON P.Id_Producto = DV.Id_Producto
	WHERE DATEDIFF(MONTH, DV.Fecha_Registro, GETDATE()) <= @pNro_meses
	)
	DECLARE @gastos FLOAT
	SET @gastos = (SELECT SUM(P.Precio_Compra * DV.Cantidad) FROM Detalle_Venta DV
	JOIN Productos P ON P.Id_Producto = DV.Id_Producto
	WHERE DATEDIFF(MONTH, DV.Fecha_Registro, GETDATE()) <= @pNro_meses
	)
	DECLARE @ganancia FLOAT
	SET @ganancia = @venta - @gastos
    RETURN @ganancia
END

-- ================================================
-- Devuelve la ganacia de una venta
-- ================================================
-- =============================================
-- Author:		Borda Esteban Ruben
-- Create date: 16/10/2024
-- Description:	
-- =============================================

CREATE FUNCTION ganancias_de_venta(@pDetalle_venta INT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @venta FLOAT
    SET @venta = (SELECT SUM(P.Precio_Venta * DV.Cantidad) FROM Detalle_Venta DV 
	JOIN Productos P ON P.Id_Producto = DV.Id_Producto
	WHERE DV.Id_DetalleVenta = @pDetalle_venta
	)
	DECLARE @gastos FLOAT
	SET @gastos = (SELECT SUM(P.Precio_Compra * DV.Cantidad) FROM Detalle_Venta DV
	JOIN Productos P ON P.Id_Producto = DV.Id_Producto
	WHERE DV.Id_DetalleVenta = @pDetalle_venta
	)
	DECLARE @ganancia FLOAT
	SET @ganancia = @venta - @gastos
    RETURN @ganancia
END

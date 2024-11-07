-- ================================================
-- Devuelve el porcentaje de venta que representa la venta de un producto en los últimos meses
-- ================================================
-- =============================================
-- Author:		Borda Esteban Ruben
-- Create date: 05/11/2024
-- Description:	
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION porcentajeDeVenta ( @Meses INT = 1)
RETURNS TABLE 
AS
RETURN 
(
	-- Calculo del porcentaje: 
		 --Suma la cantidad ventas de cada producto y calcula el porcentaje
	SELECT ROUND(SUM(dv.Cantidad) * 100.0 / total.total, 2) AS Porcentajes, dv.Id_Producto
	FROM Detalle_Venta dv
	--Crea una tabla temporal con el total de productos vendidos en los últimos @Meses
	JOIN 
		(	
			SELECT SUM(Cantidad) AS total 
			FROM Detalle_Venta 
			WHERE DATEDIFF(MONTH, Fecha_Registro ,GETDATE() ) <= @Meses
		) AS total ON total.total > 0
	WHERE DATEDIFF( MONTH, dv.Fecha_Registro, GETDATE() ) <= @Meses
	GROUP BY dv.Id_Producto, total.total

)
GO

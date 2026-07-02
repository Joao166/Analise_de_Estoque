WITH Producoes AS
(
    SELECT
        YEAR(PWO.StartDate) AS Ano,
        PPC.Name AS Categoria,
        SUM(PWO.OrderQty) AS QuantidadeProduzida

    FROM Production.WorkOrder AS PWO

    INNER JOIN Production.Product AS PP
        ON PWO.ProductID = PP.ProductID

    INNER JOIN Production.ProductSubcategory AS PPS
        ON PP.ProductSubcategoryID = PPS.ProductSubcategoryID

    INNER JOIN Production.ProductCategory AS PPC
        ON PPS.ProductCategoryID = PPC.ProductCategoryID

    GROUP BY
        YEAR(PWO.StartDate),
        PPC.Name
),

Demandas AS
(
    SELECT
        YEAR(SSOH.OrderDate) AS Ano,
        PPC.Name AS Categoria,
        SUM(SSOD.OrderQty) AS QuantidadeVendida

    FROM Sales.SalesOrderDetail AS SSOD

    INNER JOIN Sales.SalesOrderHeader AS SSOH
        ON SSOD.SalesOrderID = SSOH.SalesOrderID

    INNER JOIN Production.Product AS PP
        ON SSOD.ProductID = PP.ProductID

    INNER JOIN Production.ProductSubcategory AS PPS
        ON PP.ProductSubcategoryID = PPS.ProductSubcategoryID

    INNER JOIN Production.ProductCategory AS PPC
        ON PPS.ProductCategoryID = PPC.ProductCategoryID

    GROUP BY
        YEAR(SSOH.OrderDate),
        PPC.Name
)

SELECT
    P.Ano,
    P.Categoria,
    P.QuantidadeProduzida,
    D.QuantidadeVendida


FROM Producoes AS P

INNER JOIN Demandas AS D
    ON P.Ano = D.Ano
    AND P.Categoria = D.Categoria

ORDER BY
    P.Ano,
    P.Categoria;
SELECT
    PP.ProductID,
    PP.Name AS Produto,
    PL.Name AS Localizacao,
    SUM(PPI.Quantity) AS QuantidadeEstoque
FROM Production.Product AS PP
INNER JOIN Production.ProductInventory AS PPI
    ON PP.ProductID = PPI.ProductID
INNER JOIN Production.Location AS PL
    ON PPI.LocationID = PL.LocationID
GROUP BY
    PP.ProductID,
    PP.Name,
    PP.StandardCost,
    PL.Name
ORDER BY ProductID ASC
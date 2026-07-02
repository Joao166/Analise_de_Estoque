SELECT
    PP.ProductID,
    PP.Name AS Produto,
    PC.Name AS Categoria,
    SUM(PPI.Quantity) AS EstoqueAtual,
    PP.StandardCost,
    SUM(PPI.Quantity) * PP.StandardCost AS ValorEstoque

FROM Production.Product AS PP

INNER JOIN Production.ProductInventory AS PPI
    ON PP.ProductID = PPI.ProductID

INNER JOIN Production.ProductSubcategory AS PSC
    ON PP.ProductSubcategoryID = PSC.ProductSubcategoryID

INNER JOIN Production.ProductCategory AS PC
    ON PSC.ProductCategoryID = PC.ProductCategoryID

GROUP BY
    PP.ProductID,
    PP.Name,
    PC.Name,
    PP.StandardCost

HAVING SUM(PPI.Quantity) > 0

ORDER BY ValorEstoque DESC;




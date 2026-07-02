SELECT
    PP.ProductID,
    PP.Name AS Produto,
    SUM(PPI.Quantity) AS EstoqueAtual,
    PP.ReorderPoint,

    CASE
        WHEN SUM(PPI.Quantity) <= PP.ReorderPoint
            THEN 'Repor'
            ELSE 'OK'
        END AS Situacao

FROM Production.Product AS PP
INNER JOIN Production.ProductInventory AS PPI
    ON PP.ProductID = PPI.ProductID

GROUP BY
    PP.ProductID,
    PP.Name,
    PP.ReorderPoint
With 
    ProductToYear AS (
        Select product_id, MIN(year) as year
        From Sales
        Group by 1
    )
Select 
    Sales.product_id,
    ProductToYear.year AS first_year,
    Sales.quantity,
    Sales.price
From Sales
Inner join ProductToYear
    using (product_id, year);
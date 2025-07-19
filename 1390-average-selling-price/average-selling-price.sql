Select 
    prices.product_id,
    IFNULL(
        ROUND(
            SUM(Prices.price*UnitsSold.units)/SUM(UnitsSold.units),
            2
        ),
        0
    ) AS average_price
From prices
Left Join UnitsSold
    ON(
        Prices.product_id = UnitsSold.product_id
        AND UnitsSold.purchase_date Between prices.start_date AND Prices.end_date
    )
Group By 1;
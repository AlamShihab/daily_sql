
select 
    product_id 
from Products
where concat(low_fats, recyclable) = 'YY'

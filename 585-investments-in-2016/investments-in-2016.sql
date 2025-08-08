With
    InsuranceWithCounts AS (
        Select
            tiv_2016,
            Count(*) Over(partition by tiv_2015) as tiv_2015_count,
            count(*) over(partition by lat, lon) as city_count
        From Insurance
    )
    Select Round(sum(tiv_2016), 2) as tiv_2016
    From InsuranceWithCounts
    Where tiv_2015_count > 1
        And city_count = 1;
select
    StartActivity.machine_id,
    ROUND(
        AVG(EndActivity.timestamp - StartActivity.timestamp),
        3
    ) AS processing_time
From Activity AS StartActivity
inner join Activity AS EndActivity 
    USING (machine_id, process_id)
WHERE 
    StartActivity.activity_type = 'start'
    AND EndActivity.activity_type = 'end'
Group BY 1;

-- query one 
select gender, age, education_level,internet_type from students s inner join learning_environment le
ON s.student_id = le.student_id;

-- query two 
select gender, education_level, device from students s inner join learning_environment le
ON s.student_id = le.student_id
where internet_type ='Wifi' and adaptivity_level ='Moderate';

--query three 

select gender, age,network_type from students s inner join learning_environment le
ON s.student_id = le.student_id 
where internet_type ='Mobile Data' and adaptivity_level ='Low';

--query four 
select count (s.student_id) ,le.internet_type,le.network_type  from students s inner join learning_environment le
ON s.student_id = le.student_id 
group by network_type,internet_type;

--query five
select  education_level, device  ,count (s.student_id) as number_of_students
from  students s inner join learning_environment le
ON s.student_id = le.student_id
where financial_condition ='poor' 
or 
financial_condition ='Mid'
group by education_level, device ;

--query six 
select s.education_level , avg(cast (left(le.class_duration,1)as float )) as Average_Duration
from  students s inner join learning_environment le
ON s.student_id = le.student_id
  group by  s.education_level
HAVING AVG(CAST(LEFT(le.Class_Duration, 1) AS FLOAT)) > 1;

  -- query seven 
  select count (s.student_id ) as number_of_students , le.device 
  from students s  inner join learning_environment le
ON s.student_id = le.student_id 
group by device HAVING COUNT(s.student_id) > 1;

--query eight 
select s.gender,
s.education_level,
le.internet_type,
le.network_type,
case 
when le.Internet_Type = 'Wifi' 
and le.Network_Type  ='4.00' 
then 'Good'
else 'Limited'
end as Internet_Quality  
from students s  inner join 
learning_environment le 
ON s.student_id = le.student_id;  
 
 --query 9
 create view connected_students as 
 select s.student_id  ,le.Adaptivity_Level from students s inner join 
learning_environment le 
ON s.student_id = le.student_id 
where le.location =1
and internet_type ='Wifi' ;
 


    SELECT * FROM connected_students
ORDER BY 
    CASE Adaptivity_Level
        WHEN 'High' THEN 1
        WHEN 'Moderate' THEN 2
        WHEN 'Low' THEN 3
        ELSE 4
    END ASC;

    --query 10 

select education_level, total_students, low_count
    from(
     SELECT 
        s.education_level, 
        COUNT(s.student_id) AS total_students,
        SUM(CASE WHEN le.adaptivity_level = 'Low' THEN 1 ELSE 0 END) AS low_count
    FROM students s 
    INNER JOIN learning_environment le ON s.student_id = le.student_id 
    GROUP BY s.education_level
)as subquery
WHERE (CAST(low_count AS FLOAT) / total_students) > 0.30;
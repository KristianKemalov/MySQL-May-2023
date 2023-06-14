SELECT 
    employee_id,
    CONCAT(first_name, ' ', last_name) AS 'full_name',
    departments.department_id,
    departments.name AS 'department_name'
FROM
    departments
        JOIN
    employees ON departments.manager_id = employees.employee_id
ORDER BY employee_id
LIMIT 5;

-- 2 
SELECT 
    towns.town_id, name AS 'town_name', address_text
FROM
    towns
        JOIN
    addresses ON towns.town_id = addresses.town_id
WHERE
    towns.name IN ('Sofia' , 'Carnation', 'San Francisco')
ORDER BY town_id , address_id;


-- 3

SELECT 
    employee_id, first_name, last_name, department_id, salary
FROM
    employees
WHERE
    manager_id IS NULL;


-- 4

SELECT 
    COUNT(employee_id)
FROM
    employees
WHERE
    salary > (SELECT 
            (AVG(salary))
        FROM
            employees);


    
    
    
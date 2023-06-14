
-- 1

SELECT 
    employee_id, job_title, e.address_id, a.address_text
FROM
    employees AS e
        JOIN
    addresses AS a ON e.address_id = a.address_id
ORDER BY address_id
LIMIT 5;

-- 2

SELECT 
    first_name, last_name, t.name, address_text
FROM
    employees AS e
        JOIN
    addresses AS a ON e.address_id = a.address_id
        JOIN
    towns AS t ON a.town_id = t.town_id
ORDER BY first_name , last_name 
LIMIT 5;


-- 3

SELECT 
    employee_id, first_name, last_name, name
FROM
    employees AS e
        JOIN
    departments AS d ON e.department_id = d.department_id
        AND d.name = 'Sales'
ORDER BY employee_id DESC;


-- 4

SELECT 
    employee_id, first_name, salary, name
FROM
    employees AS e
        JOIN
    departments AS d ON e.department_id = d.department_id
WHERE
    salary > 15000
ORDER BY d.department_id DESC LIMIT 5;

-- 5 //////////////////////////////////////////






-- //////////////////////////////////////////


-- 6

SELECT 
    first_name, last_name, hire_date, name AS 'dept_name'
FROM
    employees AS e
        JOIN
    departments AS d ON e.department_id = d.department_id
WHERE
    hire_date > 1 / 1 / 1999
        AND name IN ('Sales' , 'Finance')
ORDER BY hire_date;


-- 7

SELECT 
    e.employee_id, e.first_name, p.name
FROM
    employees AS e
        JOIN
    employees_projects AS ep ON e.employee_id = ep.employee_id
        JOIN
    projects AS p ON p.project_id = ep.project_id
WHERE
    DATE(p.start_date) > '2002-08-13'
        AND p.end_date IS NULL
ORDER BY first_name , p.name
LIMIT 5;


-- 8

SELECT 
    e.employee_id,
    e.first_name,
    IF(YEAR(p.start_date) >= 2005,
        NULL,
        p.name)
FROM
    employees AS e
        JOIN
    employees_projects AS ep ON e.employee_id = ep.employee_id
        JOIN
    projects AS p ON ep.project_id = p.project_id
WHERE
    e.employee_id = 24
ORDER BY p.name;


SELECT 
    e.employee_id, e.first_name, e.manager_id, m.first_name
FROM
    employees AS e
        JOIN
    employees AS m ON e.manager_id = m.employee_id
WHERE
    e.manager_id IN (3 , 7)
ORDER BY e.first_name; 


-- 10

SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS 'employee_name',
    CONCAT(m.first_name, ' ', m.last_name) AS 'manager_name',
    d.name AS 'department_name'
FROM
    employees AS e
        JOIN
    employees AS m ON e.manager_id = m.employee_id
        JOIN
    departments AS d ON e.department_id = d.department_id
ORDER BY e.employee_id LIMIT 5;



-- 11
SELECT 
    AVG(salary) AS 'avg'
FROM
    employees
GROUP BY department_id
ORDER BY `avg`
LIMIT 1;



-- 12
SELECT 
    c.country_code, mountain_range, peak_name, elevation
FROM
    countries AS c
        JOIN
    mountains_countries AS mc ON c.country_code = mc.country_code
        JOIN
    mountains AS m ON m.id = mc.mountain_id
        JOIN
    peaks AS p ON p.mountain_id = m.id
WHERE
    c.country_code = 'BG'
        AND elevation > 2835
ORDER BY elevation DESC;

-- 13

SELECT 
    c.country_code, COUNT(mountain_range) AS 'mountain_range'
FROM
    countries AS c
        JOIN
    mountains_countries AS mc ON c.country_code = mc.country_code
        JOIN
    mountains AS m ON m.id = mc.mountain_id
WHERE
    c.country_code IN ('BG' , 'US', 'RU')
GROUP BY country_code
ORDER BY mountain_range DESC;


-- 14

SELECT 
    c.country_name, river_name
FROM
    countries AS c
        LEFT JOIN
    countries_rivers AS cr ON cr.country_code =  c.country_code 
        LEFT JOIN
    rivers AS r ON r.id = cr.river_id
WHERE
    continent_code = 'AF'
ORDER BY c.country_name
LIMIT 5;





-- 17
SELECT 
    c.country_name,
    MAX(p.elevation) AS 'highest_peak_elevation',
    MAX(r.length) AS 'longest_river_length'
FROM
    countries AS c
        JOIN
    mountains_countries AS mc ON c.country_code = mc.country_code
        JOIN
    mountains AS m ON m.id = mc.mountain_id
        JOIN
    peaks AS p ON p.mountain_id = m.id
        JOIN
    countries_rivers AS cr ON cr.country_code = c.country_code
        JOIN
    rivers AS r ON r.id = cr.river_id
GROUP BY country_name
ORDER BY highest_peak_elevation DESC , longest_river_length DESC , country_name
LIMIT 5;





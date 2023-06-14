CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL UNIQUE,
    `type` VARCHAR(30) NOT NULL,
    price DECIMAL(10 , 2 ) NOT NULL
);

CREATE TABLE clients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birthdate DATE NOT NULL,
    card VARCHAR(50),
    review TEXT
);

CREATE TABLE `tables` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    floor INT NOT NULL,
    reserved TINYINT(1),
    capacity INT NOT NULL
);

CREATE TABLE waiters (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    phone VARCHAR(50),
    salary DECIMAL(10 , 2 )
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    table_id INT NOT NULL,
    waiter_id INT NOT NULL,
    order_time TIME NOT NULL,
    payed_status TINYINT(1),
    constraint fk_orders_tables
    foreign key (table_id) references `tables`(id),
    constraint fk_orders_waiters
    foreign key (waiter_id) references waiters(id)
);

CREATE TABLE orders_clients (
    order_id INT,
    client_id INT,
    constraint fk_orders_clients_orders 
    foreign key (order_id) references orders(id),
    constraint fk_orders_clients_clients
    foreign key (client_id) references clients(id)
);

CREATE TABLE orders_products (
    order_id INT,
    product_id INT,
    CONSTRAINT fk_orders_products_orders FOREIGN KEY (order_id)
        REFERENCES orders (id),
    CONSTRAINT fk_orders_clients_products FOREIGN KEY (product_id)
        REFERENCES products (id)
);

-- 2
insert into products(name,type,price)
(
select concat(last_name,' ','specialty') as 'name','Cocktail',ceiling(0.01*salary) as 'price'
from waiters as w
where id>6);


-- 3
UPDATE orders 
SET 
    table_id = table_id - 1
WHERE
    id > 11 AND id < 24;
 
 -- 4
 delete from waiters as w
    where  (select count(*) from orders where waiter_id = w.id)=0;
    
    
-- 5 
SELECT 
    *
FROM
    clients
ORDER BY birthdate DESC , id DESC;


-- 6

SELECT 
    first_name, last_name, birthdate, review
FROM
    clients
WHERE
    card IS NULL
        AND YEAR(birthdate) BETWEEN 1978 AND 1993
ORDER BY last_name DESC , id
LIMIT 5; 


-- 7
SELECT CONCAT(last_name,first_name,length(first_name),'Restaurant') as 'username',
reverse(substring(email,2,12)) 'password'
from waiters
where salary is not null
order by `password` desc;

-- 8

SELECT 
    id, name, COUNT(product_id) AS 'count'
FROM
    products AS p
        JOIN
    orders_products AS op ON p.id = op.product_id
GROUP BY id
HAVING `count` > 4
ORDER BY `count` DESC , name
;


-- 9

SELECT 
    t.id,
    capacity,
    COUNT(oc.client_id) AS 'count_clients',
    (CASE
        WHEN capacity = COUNT(oc.client_id) THEN 'Full'
        WHEN capacity > COUNT(oc.client_id) THEN 'Free seats'
        WHEN capacity < COUNT(oc.client_id) THEN 'Extra seats'
    END) AS 'availability'
FROM
    tables AS t
        JOIN
    orders AS o ON o.table_id = t.id
        JOIN
    orders_clients AS oc ON oc.order_id = o.id
WHERE
    floor = 1
GROUP BY t.id
ORDER BY t.id DESC;


-- 10

DELIMITER $$
CREATE FUNCTION udf_client_bill(full_name VARCHAR(50))
returns DECIMAL(19,2)
deterministic

BEGIN 
declare space_index int;
set space_index := LOCATE(' ',full_name);

return(
	SELECT sum(p.price) as 'bill'
	from clients as c
		join orders_clients as oc on c.id = oc.client_id
		join orders as o on o.id = oc.order_id
		join orders_products as op on op.order_id = o.id
		join products as p on p.id = op.product_id
        where c.first_name= Substring(full_name,1,space_index-1) and
        c.last_name = substring(full_name,space_index+1)
);

END$$
DELIMITER ; 
;


-- 11
delimiter //
CREATE PROCEDURE udp_happy_hour(`type` VARCHAR(50))
begin
update products as p set price= price*0.8
where p.type = `type` and price>= 10;

end//







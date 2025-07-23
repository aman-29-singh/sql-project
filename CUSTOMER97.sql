create database customer97;

use customer97;

create table Customer97(
id integer PRIMARY KEY,
cname varchar(255),
Address varchar(255),
Gender char(255),
city varchar(255),
Pincode integer
);

insert into customer97 values(1,'farhan','jogeshwari','M','Mumbai',400010);
select * from customer97;

-- toh agar hum farhan ko delete kar denge toh order table k andar ek aisi entry padi hui hai ki jismein customer i.e cust_id hai hii nhi delete hogya
-- so this is caleed integrity constraint ki integrity maintain rahe
Delete from customer97 where id=1; -- Cannot delete parent row because it is foreign key in order_info table ye integrity maintain karne k liye aata hai error
-- toh aise humara RDBMS YA SQL humare data integrity ko maintain karke rakhta hai
-- But mein chahta hoon ye delete karna so we can use 1)on cascade 2) on delete Null

create table order_info(
order_id integer PRIMARY KEY,
delivery_date DATE,
cust_id INT,
foreign key(cust_id) references customer97(id) ON DELETE CASCADE -- isse hum farhan ko delete kar sakte hai from customer97
);

insert into order_info values(3,'2019-03-11',1); -- ye 1 farhan ka hai from customer97 table i.e foreign key
insert into order_info values(3,'2019-03-12',1); -- ek customer 2 order kar sakta hai
delete from customer97 where id = 1; -- abb delete ho jayega farhan because of on Delete CASACADE
select * from customer97; -- abb farhan i.e cust_id 1 delete hogya hai nhi dikega in customer97 table k andar

select * from order_info; -- abb farhan k dwara kiye gye order bhi delete ho jayenge because of ON DELETE CASCADE
-- Jaise On delete cascade ne parent se kuch entry delete hui toh uske corresponding jitne bhi refrenced rows padi thi mere child table k andar woh bhi delete hogyi

-- abb mein chahta hoon ki order_info k details ya information bane rahe customer i.e farhan chala jaye par order_info bana rahe hai
-- so order_info bane rehne k liye hum use karenge ON DELETE SET NULL ye FOREIGN KEY par lagayenge in order_info table

-- Now hum DML mein ek aur command dekhenge jiska naam hai REPLACE hum DML padh rahe hai toh data already database mein pada hai uske upar hum DML operations perform karenge
-- so REPLACE  two behavior show karta hai 1)agar data pehle se presenrt hai toh woh data REPLACE ho jayega 2) agar data pehle se present nhi hai toh ye REPLACE as a INSERT command act karegi

-- Now we will see the jOINS 
--  So in Relational tables mein Foreign key ki help se Relations establish kar diye 
-- so ab Jo Relations humne establish kiye hai unn relations ko use karke mein kaise data fetch karunga so yeh data fetch karne k liye hum use karte hai JOINS ka
-- Relationship mein data ko fetch karne k liye hum use karte hai JOINS ka
-- so agar two table hai aur unmein Relationship hai toh Inner Joins Returns a resultant table that has matching values from both the tables
-- so dono table ek ho jayenge toh column increase hoga aur dono table se humein matching value uthani hai i.e jo common hoga
-- Now agar humein JOINS apply karne hai toh mere passcommon attributes hone chaiye i.e FOREIGN KEY-PRIMARY KEY wala relation establish hona chaiye
-- To apply JOINS there should be a common attribute between both the table
-- Dono table k andar jo Key value match hongi toh mein wahi wala answer karunga toh Inner join matlab 2 table ki bich ki baat hoti hai
-- syntax- Select c.*,o.* FROM customer97 AS c INNER JOIN order_info AS o ON c.id = o.cust_id; 

-- Now we will see the Outer join matlab hum dono table k matching value se thoda Bahar jane ki koshish karenge
-- so in left joins this returns a resulting table that all the data from left table and the matched data from the Right table 
-- left join mein left table ki toh  muje saari values chaiye but satth hi saath matching value bhi chaiye left aur Right table ki 
 -- Dhyan dena Joins se andar hum column wise chalte hai matlab column increase kar dete hai i.e new table k andar columns increase ho chuka hota hai
 -- Select c.*,o.* FROM customer97 AS c LEFT JOIN order_info AS o ON c.id = o.cust_id; this is a syntax of left join
 
 -- Now we will see the RIGHT JOIN this is a just opposite of LEFT JOIN iske andar hum interested hote hai in Knowing only the Right side table information
 -- ismein Right table ka toh saara data aur left table ka matching data
 
 -- NOW We will see the FULL JOIN SO FULL JOIN is nothing but Left aur Right join ka UNION matlab left aur right join dono ko humne mila diya matlab ek tarah se add kar diya
 -- UNION matlab left join k corresponding saara data milega muje agar woh data Right table mein nhi hai toh bhi milega muje vice versa with left
 -- MY Sql k k andar FULL JOIN karke koi keyword nhi hai not available toh humlog isko emulate karte hai
 -- Emulate karne k liye humlog Left join karenge aur uska UNION Kar denge Right join k saath
 -- syntax- Select * from leftTable AS L LEFT JOIN RightTable AS R ON L.key = R.key 
 -- ye upar wala hogya LEFT JOIN Phir key word likhenge UNION Then Right Join
 -- Select * from leftTable AS L RightJoin RightTable AS R ON L.key = R.key; -- ye Right Join ka syntax hai
 
 -- NOW WE will see Cross Join so Cross Join is nothing but Cartesian product
 -- Cartesian product ka matlab hai agar mere pass Table left hai aur table left mein 5 Rows hai aur Table Right mein 10 Rows haiso Resultant table mein 5*10= 50 rows ban jayegi
 -- Cartesian product ka koi Industrial use nhi hai
 
 -- Now we will see Self Join jaise employ is Manager so Manager itself handle itself i.e employ
 -- So Self Join k liye bhi koi operator nhi hai ye bhi emulate kiya jata hai emulate hum INNER JOIN ka use karke aur ALIASE i.e as keyword ka use karke emulate karte hai
 -- example is Select e1.id,e2.id,e2.name FROM employee as e1 INNER JOIN employee as e2 ON e1.id = e2.id; same table hai but 2 ALIAS bana diye isliye ye left and Right table jaisa behave kar rhe hai
 
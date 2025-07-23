create database temp;

use temp;

create table Customer(
id integer PRIMARY KEY,
cname varchar(255),
Address varchar(255),
Gender char(255),
city varchar(255),
Pincode integer
);

Select * from customer;



INSERT INTO Customer 
values (1200,'RAM KUMAR','SHIVAJI NAGAR','M','MUMBAI',4000101),
(1300,'krishna KUMAR','gandhi NAGAR','M','patna',4000102),
(1400,'shivKUMAR','hanuman NAGAR','M','pune',4000109),
(1500,'kiran KUMAR','SHIVAJI NAGAR','F','MUMBAI',4000101),
(1600,'AVNEET KAUR','GURU NAGAR','F','LUDHIANA',400011);

insert into Customer values(1,'codehelp','delhi','M','DELHI',11000); -- without column name bhi insert kar sakte h

insert into customer(id,cname) values(121,'ramesh'); -- aise sirf 2 attribute ka value bhi insert kar sakte h

Select * from customer;
-- toh ye kuch teen chaar tarike hai insert karne k above humne dekha

-- update dekhenge 
UPDATE Customer SET Address='Noida', Gender='M' WHERE id=121;

-- Now Update multiple Rows or tuple so mein WHERE ka use nhi karunga toh sab par locate hojayega
SET SQL_SAFE_UPDATES = 0; -- YE Default mein humein chalana padhta hai kyunki hum saare rows par change kar rahe hai
UPDATE Customer SET Pincode = 50000; -- toh sab tuples ka pincode 50000 ho jayega
UPDATE Customer SET Pincode = Pincode + 1; -- so aise add bhi kar sakte hai
SET SQL_SAFE_UPDATES = 1; -- abb security 1 laga dete toh security mode is ON Active ho jata hai


-- Now Dekhenge Delete command kaise work karti hai
Delete from Customer where id='121';
-- Poora customer table bhi delte kar sakte hai by using Delete from customer command but security ko disable i.e 0 karna padega

-- Now dekhenge on Delete cascade and on Delete Null
-- we know Refrential constraint i.e 1)insert ki child k andar mein value tab tak nhi insert kar sakta jab tak value is not lying in parent table
-- 2)Delete constraint means value app parent se delete nhi kar sakte agar corresponding  value child mein available hi
-- so Delete Constraint ko overcome karne k liye mere pass 2 tarike hai 1)on Delete cascade 2)on delete set Null
-- on delete cascade matlab hai hai ki agar mein parent se item delete kar rha hoon toh uske corresponding jo bhi chiz child table k andar hogi woh bhi delete ho jayega
-- on delete set Null means agar parent se maine entry delete kardi toh uske corresponding jo entry child table mein hai uski foreign key ki jo value hai woh Null set ho jayega
-- Interview ka Question hai ki can foreign key have Null value toh iska answer hai yes upar wale line mein explain kiye hai



Select * from customer;

create table order_details(
order_id integer PRIMARY KEY,
delivery_date DATE,
cust_id INT,
foreign key(cust_id) references Customer(id)
);

insert into order_details values
(1,'2019-03-11',245);


create table account(
id int primary key,
name varchar(255) UNIQUE,
balance INT NOT NULL DEFAULT 0
-- CONSTRAINT acc_balance_chk CHECK(balance > 1000) -- ye mat rakho agar niche k command ko execute karwana h
);

insert into account(id,name,balance) values
(1,'A');

insert into account(id,name,balance) values
(2,'B',100); -- yye check ko vilet karega because of constraint we use

insert into account(id,name,balance) values
(1,'c');

DROP TABLE account;
select * from account;

-- ALTER Operations ki humne already Schema bana diya hai like customer ka,worker ka etc
-- i.e humne starting mein schema bana diya hai par hum abb chahte hai ki Schema change ho jaye ki
-- Schema change matlab koi requirement aagayi ki new column add karna hai toh abb new column kaise add karenge
-- ya phir humein data type change karna hai kisi column ka i.e starting mein humne varchar(20) insert kiya tha abb 255 karna chahte hai

-- ADD NEW COLUMN i.e add an attribute 
ALTER TABLE account ADD interest FLOAT NOT NULL DEFAULT 0;
-- MODIFY i.e data type float se Double karenge niche interest attribute ka
alter table account MODIFY interest DOUBLE NOT NULL DEFAULT 0;
SELECT * FROM account;
DESC account; -- ye description hai table ka isse malum padege ki interest ka datatype float se double hogya

-- Change column ka use karenge ye Rename the column  k kaam aata hai
-- i.e interest se saving_interest naam change karenge with datatype bhi change karege
-- Change Column -RENAME 	the Column
alter table account CHANGE COLUMN interest saving_interest FLOAT NOT NULL DEFAULT 0;

-- Now we will see the the DROP COLUMN command saving_interest attribute ko delete kar denge
alter table account DROP COLUMN saving_interest;
desc account;

-- Rename the table
alter table account RENAME TO account_details;
-- so this above all are ALTER Operations


-- Now we will see DML(Data Modification Language)
-- DML Includes 1)insert 2)update 3)Delete 4)Replace commands


drop table account;


-- Now hum DML mein ek aur command dekhenge jiska naam hai REPLACE hum DML padh rahe hai toh data already database mein pada hai uske upar hum DML operations perform karenge
-- so REPLACE  two behavior show karta hai 1)agar data pehle se presenrt hai toh woh data REPLACE ho jayega 2) agar data pehle se present nhi hai toh ye REPLACE as a INSERT command act karegi
-- REPLACE
REPLACE into customer(id,city) values(1600,'London'); -- id is primary key aur ye PRIMARY KEY Dena bohat jaruri hai agar aap Primary key nhi doge toh muje ye kaise pata chalega ki muje kiske corresponding kaam karna hai
select * from customer;
REPLACE into customer(id,city) values(1600,'London'); -- toh idhar humne id diya i. primary key aur bas city replace kiya
select * from customer; -- so baki columns null ho jayenge bas city wale column mein 'Ludhiana' se 'London mein Replace ho jayega
-- i.e 1600 id k corresponding pehle se data pada hua tha toh REPLACE idhar behave kar rahi hai Replacement ki tarah toh Replace kardi saari value

REPLACE into customer (id,city)
  values(1333,'jaisalmer'); -- idhar humne new id diya jo id pehle se customer table mein nhi hai toh idhar REPLACE act as Insert command
  --  aur idhar ye new id 1333 and city jaislmer add ho jayega customer table mein
select * from customer; -- toh idhar ye id 1333 and city table mein add ho jayega  

-- Now 2nd type of syntax of REPLACE IS below
Replace into customer set id = 1300, cname='john', city='utah'; -- id dena jaruri hai for recognition
-- so idhar 1300 id mein krishnaKumar replace ho jayega 'john' se and patna REplace ho jayega 'utah' se baki sab column null hogi
select * from customer;


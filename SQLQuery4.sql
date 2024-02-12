use dhruvkhoradiya_db;

select * from Products
--Assignment 1
--1. Write a query to get a Product list (id, name, unit price) where current products cost less than $20.
select ProductID,ProductName,UnitPrice from Products where UnitPrice<20

--2. Write a query to get Product list (id, name, unit price) where products cost between $15 and $25
select ProductID,ProductName,UnitPrice from Products where UnitPrice between 15 and 25
 
 --3. Write a query to get Product list (name, unit price) of above average price. 
select ProductName,UnitPrice from Products where UnitPrice >(select avg(UnitPrice) from Products)

--4.Write a query to get Product list (name, unit price) of ten most expensive products
select top 10  ProductName,UnitPrice from Products order by UnitPrice asc 

--5. Write a query to count current and discontinued products
select Discontinued, COUNT(Discontinued) as totalAvailable from Products group by Discontinued

--6. Write a query to get Product list (name, units on order , units in stock) of stock is less than the quantity on order
select  ProductName,UnitsOnOrder,UnitsInStock from Products where UnitsInStock<UnitsOnOrder



--Assignment 2
create table tblSalesman
(salesman_id "int" NOT NULL primary key,
name varchar(20) not null,
city varchar(20) not null,
commission decimal(2,2)  NOT NULL );

create table tblCustomer
(customer_id "int" NOT NULL primary key,
customer_name varchar(20) not null,
city varchar(20) not null,
grade "int" not null,
salesman_id "int"  NOT NULL references tblSalesman(salesman_id) );

create table tblOrder
(order_no "int" NOT NULL primary key,
purchase_amount "int" not null,
order_date date not null,
customer_id "int" references tblCustomer(customer_id) ,
salesman_id "int" references tblSalesman(salesman_id) );

insert into tblSalesman values(11,'Pranav','Karwar',0.2);
insert into tblSalesman values(24,'Prasanna','Bengalore',0.3);
insert into tblSalesman values(39,'Prajwal','Kodagu',0.1);
insert into tblSalesman values(44,'Pooja','Hubli',0.5);
insert into tblSalesman values(15,'Prokta','Mysore',0.2);

insert into tblCustomer values(101,'Bhargav','Mysore',1,15);
insert into tblCustomer values(206,'Ramya','Bengalore',3,24);
insert into tblCustomer values(225,'Rajesh','Hubli',2,39);
insert into tblCustomer values(324,'Ravi','Mangalore',5,44);
insert into tblCustomer values(456,'Rajdeep','Belagavi',3,15);
insert into tblCustomer values(501,'Raghu','Dharavad',4,39);
insert into tblCustomer values(300,'Bhavya','Bengalore',1,15);

insert into tblOrder values(5,10000,'2020-03-25',101,11);
insert into tblOrder values(10,5000,'2020-03-25',456,15);
insert into tblOrder values(7,9500,'2020-04-30',225,44);
insert into tblOrder values(11,8700,'2020-07-07',324,24);
insert into tblOrder values(17,1500,'2020-07-07',206,39);

select * from tblSalesman;
select * from tblCustomer;
select * from tblOrder;	


--1. write a SQL query to find the salesperson and customer who reside in the same city.Return Salesman, cust_name and city
select tblSalesman.name as salesman_name,tblCustomer.customer_name,tblCustomer.city 
from tblSalesman inner join tblCustomer on tblSalesman.city = tblCustomer.city	

--2. write a SQL query to find those orders where the order amount exists between 500 and 2000. 
--Return ord_no, purch_amt, cust_name, city
 select tblCustomer.customer_name,tblOrder.order_no,tblOrder.purchase_amount,tblCustomer.city
 from tblOrder inner join tblCustomer 
 on tblCustomer.customer_id = tblOrder.customer_id where purchase_amount between 500 and 2000

--3. write a SQL query to find the salesperson(s) and the customer(s) he represents.
--Return Customer Name, city, Salesman, commission
select tblCustomer.customer_name,tblSalesman.city,tblSalesman.name as salesman_name,tblSalesman.commission 
from tblSalesman 
inner join tblCustomer 
on tblCustomer.salesman_id = tblSalesman.salesman_id

--4. write a SQL query to find salespeople who received commissions of more than 12
--percent from the company. Return Customer Name, customer city, Salesman,
--commission.
select tblCustomer.customer_name,tblCustomer.city,tblSalesman.name as salesman_name,tblSalesman.commission 
from tblSalesman 
inner join tblCustomer 
on tblCustomer.salesman_id = tblSalesman.salesman_id
where commission>0.12

--5. write a SQL query to locate those salespeople who do not live in the same city where
--their customers live and have received a commission of more than 12% from the
--company. Return Customer Name, customer city, Salesman, salesman city,
--commission
select tblCustomer.customer_name,tblCustomer.city,tblSalesman.name as salesman_name,tblSalesman.commission 
from tblSalesman 
inner join tblCustomer 
on tblCustomer.salesman_id = tblSalesman.salesman_id
where commission>0.12 and tblCustomer.city<>tblSalesman.city

--6. write a SQL query to find the details of an order. Return ord_no, ord_date,
--purch_amt, Customer Name, grade, Salesman, commission

select tblOrder.order_no,tblOrder.order_date,tblOrder.purchase_amount,tblCustomer.customer_name,tblCustomer.grade,tblSalesman.name,tblSalesman.commission
from tblOrder inner join 
tblCustomer on
tblCustomer.customer_id = tblOrder.customer_id 
inner join tblSalesman on 
tblCustomer.salesman_id = tblSalesman.salesman_id

--7. Write a SQL statement to join the tables salesman, customer and orders so that the
--same column of each table appears once and only the relational rows are returned. 
select tblCustomer.customer_id,customer_name,tblCustomer.city,tblSalesman.salesman_id,name,commission,order_no,purchase_amount,order_date
from tblOrder inner join 
tblCustomer on
tblCustomer.customer_id = tblOrder.customer_id 
inner join tblSalesman on 
tblCustomer.salesman_id = tblSalesman.salesman_id


--8. write a SQL query to display the customer name, customer city, grade, salesman,
--salesman city. The results should be sorted by ascending customer_id.
select tblCustomer.customer_name,tblCustomer.city,tblCustomer.grade,tblSalesman.name,tblSalesman.city ,tblCustomer.customer_id
from tblCustomer inner join
tblSalesman on
tblCustomer.salesman_id =tblSalesman.salesman_id order by tblCustomer.customer_id

--9. write a SQL query to find those customers with a grade less than 300. Return
--cust_name, customer city, grade, Salesman, salesmancity. The result should be
--ordered by ascending customer_id. 
select tblCustomer.customer_name,tblCustomer.city,tblCustomer.grade,tblSalesman.name,tblSalesman.city 
from tblCustomer inner join
tblSalesman on
tblCustomer.salesman_id =tblSalesman.salesman_id where grade<300 order by tblCustomer.customer_id

--10. Write a SQL statement to make a report with customer name, city, order number,
--order date, and order amount in ascending order according to the order date to
--determine whether any of the existing customers have placed an order or not
select tblCustomer.customer_name,tblCustomer.city,tblOrder.order_no,tblOrder.order_date,tblOrder.purchase_amount as [order ammount]
from tblCustomer left join 
tblOrder on
tblCustomer.customer_id = tblOrder.customer_id order by tblOrder.order_date

--11. Write a SQL statement to generate a report with customer name, city, order number,
--order date, order amount, salesperson name, and commission to determine if any of
--the existing customers have not placed orders or if they have placed orders through
--their salesman or by themselves
select tblCustomer.customer_name,tblCustomer.city,tblOrder.order_no,tblOrder.order_date,tblOrder.purchase_amount,tblSalesman.name,tblSalesman.commission
from tblCustomer left join tblOrder on 
tblCustomer.customer_id = tblOrder.customer_id 
left join tblSalesman on 
tblSalesman.salesman_id =tblCustomer.salesman_id


--12. Write a SQL statement to generate a list in ascending order of salespersons who
--work either for one or more customers or have not yet joined any of the customers
select tblSalesman.salesman_id,name as salesman_name,commission,customer_id,customer_name,tblCustomer.city
from tblCustomer right join 
tblSalesman on 
tblSalesman.salesman_id = tblCustomer.salesman_id
order by tblSalesman.name


--13. write a SQL query to list all salespersons along with customer name, city, grade,
--order number, date, and amount.
select tblSalesman.name ,tblCustomer.customer_name,tblCustomer.city,tblCustomer.grade,tblOrder.order_no,tblOrder.order_no,tblOrder.purchase_amount
from tblSalesman left join tblCustomer 
on tblSalesman.salesman_id = tblCustomer.salesman_id 
left join  tblOrder 
on tblOrder.customer_id = tblCustomer.customer_id 


--14. Write a SQL statement to make a list for the salesmen who either work for one or
--more customers or yet to join any of the customers. The customer may have placed,
--either one or more orders on or above order amount 2000 and must have a grade, or
--he may not have placed any order to the associated supplier
select tblSalesman.salesman_id,tblSalesman.name as [salesman name],tblSalesman.city,tblSalesman.commission,tblCustomer.customer_name,tblCustomer.grade,tblOrder.order_date,tblOrder.purchase_amount
from tblSalesman left join tblCustomer 
on tblSalesman.salesman_id = tblCustomer.salesman_id 
left join tblOrder on tblCustomer.customer_id = tblOrder.customer_id where tblOrder.purchase_amount>2000

--15. Write a SQL statement to generate a list of all the salesmen who either work for one
--or more customers or have yet to join any of them. The customer may have placed
--one or more orders at or above order amount 2000, and must have a grade, or he
--may not have placed any orders to the associated supplier
select tblSalesman.salesman_id,tblSalesman.name as [salesman name],tblSalesman.city,tblSalesman.commission,tblCustomer.customer_name,tblCustomer.grade,tblOrder.order_date,tblOrder.purchase_amount
from tblSalesman left join tblCustomer 
on tblSalesman.salesman_id = tblCustomer.salesman_id 
left join tblOrder on tblCustomer.customer_id = tblOrder.customer_id where tblOrder.purchase_amount>2000


--16. Write a SQL statement to generate a report with the customer name, city, order no.
--order date, purchase amount for only those customers on the list who must have a
--grade and placed one or more orders or which order(s) have been placed by the
--customer who neither is on the list nor has a grade.
select tblCustomer.customer_name,tblCustomer.city,tblOrder.order_no,tblOrder.order_date,tblOrder.purchase_amount
from tblOrder left join tblCustomer on tblCustomer.customer_id = tblOrder.customer_id where tblCustomer.grade is not null

--17. Write a SQL query to combine each row of the salesman table with each row of the
--customer table
select * from tblCustomer cross join tblSalesman   


--18. Write a SQL statement to create a Cartesian product between salesperson and
--customer, i.e. each salesperson will appear for all customers and vice versa for that
--salesperson who belongs to that city
select * from tblCustomer cross join tblSalesman where tblCustomer.city = tblSalesman.city;

--19. Write a SQL statement to create a Cartesian product between salesperson and
--customer, i.e. each salesperson will appear for every customer and vice versa for
--those salesmen who belong to a city and customers who require a grade
select * from tblCustomer cross join tblSalesman where tblSalesman.city is not null and tblCustomer.grade is null;

--20. Write a SQL statement to make a Cartesian product between salesman and
--customer i.e. each salesman will appear for all customers and vice versa for those
--salesmen who must belong to a city which is not the same as his customer and the
--customers should have their own grade
select * from tblCustomer cross join tblSalesman where tblSalesman.city<>tblCustomer.city and tblCustomer.grade is not null




--Assignment 3
create table department (
dept_id int primary key,
dept_name nvarchar(20))

create table employee (
emp_id int primary key,
dept_id int foreign key references department(dept_id),
mngr_id int foreign key references employee(emp_id),
emp_name nvarchar(20) ,
salary int)

INSERT INTO department (dept_id, dept_name)
VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Operations'),
(6, 'Sales');

INSERT INTO employee (emp_id, dept_id, mngr_id, emp_name, salary)
VALUES
(101, 1, NULL, 'John Smith', 60000),
(102, 2, 101, 'Alice Johnson', 80000),
(103, 3, 101, 'Bob Williams', 70000),
(104, 1, 102, 'Eva Davis', 55000),
(105, 4, 103, 'Michael Clark', 90000),
(106, 5, 103, 'Sophia Martin', 75000),
(107, 2, 104, 'David Brown', 62000),
(108, 3, 105, 'Olivia Wilson', 78000),
(109, 4, 106, 'James Miller', 72000),
(110, 5, 107, 'Emma Garcia', 68000),
(111, 6, 108, 'Daniel Jackson', 95000),
(112, 6, 108, 'Ava Taylor', 87000),
(113, 6, 109, 'Noah White', 89000),
(114, 1, 110, 'Lily Anderson', 60000),
(115, 2, 110, 'Liam Martinez', 82000),
(116, 3, 111, 'Isabella Hall', 73000),
(117, 4, 112, 'Mason Lee', 71000),
(118, 5, 113, 'Sophie Perez', 79000),
(119, 6, 114, 'Logan Turner', 88000),
(120, 6, 114, 'Mia Lewis', 92000);

--1. write a SQL query to find Employees who have the biggest salary in their Department
select department.dept_name,max(salary) as maximum_salary_in_dept 
from department inner join employee 
on department.dept_id = employee.dept_id 
group by dept_name order by maximum_salary_in_dept desc


--2. write a SQL query to find Departments that have less than 3 people in it
select dept_name,count(*)as total_employee 
from department inner join employee 
on employee.dept_id = department.dept_id 
group by department.dept_name having COUNT(*)<4

--3. write a SQL query to find All Department along with the number of people there
select dept_name,count(*)as total_employee 
from department inner join employee 
on employee.dept_id = department.dept_id 
group by department.dept_name

--4. write a SQL query to find All Department along with the total salary there
select department.dept_name,sum(salary) as total_salary
from department inner join employee 
on employee.dept_id = department.dept_id group by department.dept_name


--Assignment 4

--1. Create a stored procedure in the Northwind database that will calculate the average
--value of Freight for a specified customer.Then, a business rule will be added that will
--be triggered before every Update and Insert command in the Orders controller,and
--will use the stored procedure to verify that the Freight does not exceed the average
--freight. If it does, a message will be displayed and the command will be cancelled.
select * from Orders
create procedure spGetAverageFreight @CustomerId nvarchar(20)
as 
begin
	Declare @avgFreight decimal(6,2)
	select @avgFreight= avg(Freight) from orders group by Orders.CustomerID having Orders.CustomerID=@CustomerId
	return @avgFreight
end 

create trigger dbo.trCheckIfFreightExceedAvgValue
on dbo.Orders 
FOR UPDATE,INSERT
as
Begin
	Declare @Freight money
	Declare @CustomerId nvarchar(5)
	select @Freight  = Freight from inserted
	select @CustomerId = CustomerId from inserted
	Declare @avgFreightOfCustomer money
	exec @avgFreightOfCustomer = spGetAverageFreight @CustomerId
	if(@Freight > @avgFreightOfCustomer)
		Begin
		Raiserror('Current Freight is Greater than Average Freight',16,1) 
		rollback transaction
		end
end


DECLARE @result DECIMAL(18, 2);
EXEC @result = spGetAverageFreight 'ALFKI'
SELECT @result AS Result;




select * from Orders where CustomerID = 'ALFKI'
insert into orders values ('ALFKI',2,GetDate(),GETDATE(),null,null,4,null,null,null,null,null,null)
select * from orders where CustomerID='ALFKI'
update Orders set freight = 4 where orderId =11081


--2. write a SQL query to Create Stored procedure in the Northwind database to retrieve Employee Sales by Country
ALTER procedure spEmployeeSalesByCountry @Country varchar(20)
as
begin
	select Employees.FirstName, SUM(UnitPrice*[Order Details].Quantity)  ,Employees.Country
	from Employees inner join Orders 
	on Orders.EmployeeID = Employees.EmployeeID 
	inner join [Order Details] 
	on Orders.OrderID=[Order Details].OrderID 
	group by Employees.FirstName , Employees.Country 
	having country =@Country
end


--3.write a SQL query to Create Stored procedure in the Northwind database to retrieve Sales by Year
create procedure spSalesPerYear @Year int
as
Begin

	select sum(UnitPrice*[Order Details].Quantity) as total_sale,year(Orders.OrderDate)as "year" 
	from [Order Details] inner join Orders on Orders.OrderID =[Order Details].OrderID 
	group by YEAR(Orders.OrderDate) having YEAR(Orders.OrderDate) =@Year
end
	select * from [Order Details]
	select * from Orders
exec spSalesPerYear 1998

--4.write a SQL query to Create Stored procedure in the Northwind database to retrieve Sales By Category
alter procedure spSalesByCategory  @category int
as
begin
	
	
	select  Categories.CategoryID,sum([Order Details].UnitPrice*[Order Details].Quantity) as  total_sales 
	from Categories inner join Products 
	on Products.CategoryID = Categories.CategoryID 
	inner join  [Order Details] 
	on [Order Details].ProductID = Products.ProductID 
	group by Categories.CategoryID having Categories.CategoryID =@category
end
	
exec spSalesByCategory 6

--5. write a SQL query to Create Stored procedure in the Northwind database to retrieve Ten Most Expensive Products
create procedure spTopTenMostExpensiveProducts
as
begin
	select top 10 * from Products where Discontinued=0 order by UnitPrice desc 
end

exec spTopTenMostExpensiveProducts

--6. write a SQL query to Create Stored procedure in the Northwind database to insert Customer Order Details 
Alter procedure spInsertOrderDetails @OrderId int , @ProductId int,@Quantity int , @Discount decimal(3,2)
as
Begin
	Declare @UnitPrice int
	select @UnitPrice =  Unitprice from Products where ProductID = @ProductId
	insert into [Order Details] values (@OrderId,@ProductId,@UnitPrice,@Quantity,@Discount);
end

exec spInsertOrderDetails 11079,51,12.0,0.15
select * from [Order Details] where OrderID =11079

--7. write a SQL query to Create Stored procedure in the Northwind database to update Customer Order Details 
Create procedure spUpdateOrderDetails @OrderId int ,@UnitPrice int, @ProductId int,@Quantity int , @Discount decimal(3,2)
as
Begin
	
	update [Order Details] set 
	UnitPrice =@UnitPrice,
	ProductID =@ProductId,
	Discount =@Discount
	where [Order Details].OrderId = @OrderId
	
end
select * from [Order Details] where OrderID = 11081
exec spUpdateOrderDetails 11081,45,22,10,0.18
select * from [Order Details] where OrderID = 11081







--------------------------------------------------------------------------------------------------------------------------------
create table logtable (
order_no int ,
[Description] varchar(100),
[Type] varchar(10))
select * from tblCustomer
alter table logtable add customer_id int foreign key references tblCustomer(customer_id)

alter trigger trNewOrder 
on tblOrder 
after insert 
as 
begin 
	Declare @orderId int
	select @orderId = order_no from inserted
	Declare @customerId int
	select @customerId = customer_id from inserted
	Declare @customerName varchar(10)
	select @customerName = customer_name from tblCustomer where customer_id =@customerId 	
	insert into logtable values (
	@orderId,
	'Ordered by ' +  @customerName +' On '+ CAST(GETDATE() as varchar(25)),
	'Placed',
	@customerId
	)
end
select * from logtable
create trigger trOrderDeleted
on tblOrder
after  delete
as
Begin
	Declare @orderId int
	select @orderId = order_no from deleted
	Declare @customerId int
	select @customerId = customer_id from deleted
	Declare @customerName varchar(10)
	select @customerName = customer_name from tblCustomer where customer_id =@customerId 	
	insert into logtable values (
	@orderId,
	'Order cancelled by ' +  @customerName +' On '+ CAST(GETDATE() as varchar(25)),
	'Cancelled',
	@customerId
	)
end

select * from tblOrder,tblSalesman,tblCustomer
select * from logtable
delete from tblOrder where tblOrder.order_no = 7

create function fngetTotalOrdersOnTheDate (@Date Date) 
returns table
as
Return 
select * from tblOrder where order_date = @Date 

print fngetTotalOrdersOnTheDate('2020-03-25')

create function fnGetTotalOrderAmmountOnTheDate (@Date Date)
returns  int
as
Begin
Declare @ans int

select @ans = sum(purchase_amount) from tblOrder group by order_date having order_date = @Date
return @ans
end

DECLARE @result INT		
set @result = dbo.fnGetTotalOrderAmmountOnTheDate ('2020-03-25')  

PRINT 'Total Order Amount: ' + CAST(@result AS VARCHAR(10))


create function fnGetOrdersByCustomer (@customerID int)
returns table 
as 
return 
select tblOrder.*,tblCustomer.city,tblCustomer.customer_name from tblCustomer inner join tblOrder on tblOrder.customer_id = tblCustomer.customer_id where tblCustomer.customer_id =@customerID

select * from tblOrder
select  * from fnGetOrdersByCustomer(101)

create view vOrdersByYear 
as
select sum(UnitPrice*[Order Details].Quantity) as total_sale,year(Orders.OrderDate)as "year" 
	from [Order Details] inner join Orders on Orders.OrderID =[Order Details].OrderID 
	group by YEAR(Orders.OrderDate)

create view vOrdersByCategory
as
	select  Categories.CategoryID,sum([Order Details].UnitPrice*[Order Details].Quantity) as  total_sales 
	from Categories inner join Products 
	on Products.CategoryID = Categories.CategoryID 
	inner join  [Order Details] 
	on [Order Details].ProductID = Products.ProductID 
	group by Categories.CategoryID 

select * from vOrdersByCategory

create view vTop10MostOderedProducts as
select top 10 sum(Quantity)as totalOrders,ProductName,Products.UnitPrice  
from [Order Details] inner join Products on 
[Order Details].ProductID = Products.ProductID 
group by Products.ProductID,ProductName,Products.UnitPrice 
order by totalOrders desc

select * from vTop10MostOderedProducts

create view vSubTotalOfCustomer as
SELECT	ContactName,Orders.CustomerID, [Order Details].OrderID, SUM(UnitPrice * Quantity) as total FROM [Order Details] inner join Orders on [Order Details].OrderID= Orders.OrderID 
inner join Customers on Orders.CustomerID = Customers.CustomerID
GROUP BY [Order Details].OrderID,Orders.CustomerID,Customers.ContactName

select * from vSubTotalOfCustomer


create view TotalDiscountOnOrder as
SELECT	ContactName,Orders.CustomerID, [Order Details].OrderID, SUM(Discount) as totalDiscount FROM [Order Details] inner join Orders on [Order Details].OrderID= Orders.OrderID 
inner join Customers on Orders.CustomerID = Customers.CustomerID
GROUP BY [Order Details].OrderID,Orders.CustomerID,Customers.ContactName 

select * from TotalDiscountOnOrder order by totalDiscount desc

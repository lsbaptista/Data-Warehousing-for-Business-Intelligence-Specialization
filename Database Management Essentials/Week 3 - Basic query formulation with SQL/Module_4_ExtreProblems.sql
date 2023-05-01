--List the customer number, the name (first and last), and the balance of customers.
select
	CustNo
	,CustfirstName
	,CustLastName
	,CustBal
from
	OrderEntry.dbo.Customer

--List the customer number, the name (first and last), and the balance of customers who reside in Colorado (CustState is CO).
select
	CustNo
	,CustfirstName
	,CustLastName
	,CustBal
from
	OrderEntry.dbo.Customer
where
	CustState = 'CO'

--List all columns of the Product table for products costing more than $50. Order the result by product manufacturer (ProdMfg) and product name.

select
	*
from
	Product
where 
	ProdPrice > 50
order by
	ProdMfg,ProdName

--List the customer number, the name (first and last), the city, and the balance of customers who reside in Denver with a balance greater than $150 or who reside in Seattle with a balance greater than $300.

select
	CustNo
	,CustfirstName
	,CustLastName
	,CustCity
	,CustBal
from
	OrderEntry.dbo.Customer
where (CustCity = 'Denver' and CustBal > 150) or (CustCity = 'Seattle' and CustBal > 300)

-- List the order number, order date, customer number, and customer name (first and last) of orders placed in January 2021 sent to Colorado recipients.

select
	o.OrdNo
	,o.OrdDate
	,c.CustNo
	,c.CustfirstName
	,c.CustLastName
from
	OrderTbl o
inner join 
	Customer c
on
	c.CustNo = o.CustNo
where c.CustState = 'CO' and MONTH(o.OrdDate)=1

--List the average balance of customers by city. Include only customers residing in Washington state (WA).


select
	avg(CustBal)
	,CustCity
from
	OrderEntry.dbo.Customer
where
	CustState='WA'
group by
	CustCity

-- List the average balance and number of customers by city. Only include customers residing in Washington State (WA). Eliminate cities in the result with less than two customers.
select
	avg(CustBal)
	,CustCity
from
	OrderEntry.dbo.Customer
where
	CustState='WA'
group by
	CustCity
having COUNT(CustCity) >1
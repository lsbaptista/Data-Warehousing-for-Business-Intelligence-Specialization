/****** Script for SelectTopNRows command from SSMS  ******/
--List the customer number, the name, the phone number, and the city of customers.
select
	CustName
	,CustName
	,Phone
	,City
from 
	dbo.Customer

--List the customer number, the name, the phone number, and the city of customers who reside in Colorado (State is CO).
select
	CustName
	,CustName
	,Phone
	,City
from 
	dbo.Customer
where
	State = 'CO'

--List all columns of the EventRequest table for events costing more than $4000. Order the result by the event date (DateHeld).
select
	*
from
	EventRequest
where EstCost > 4000
order by
	DateHeld

--List the event number, the event date (DateHeld), and the estimated audience number with approved status and audience greater than 9000 or with pending status and audience greater than 7000.
select
	EventNo
	,DateHeld
	,EstAudience
from
	EventRequest
where 
	(Status='Approved' and EstAudience > 9000) or (Status='Pending' and EstAudience > 7000)

--List the event number, event date (DateHeld), customer number and customer name of events placed in January 2022 by customers from Boulder.
select
	EventNo
	,DateHeld
	,ev.CustNo
	,c.CustName
from
	EventRequest ev
inner join Customer c on 
	c.CustNo = ev.CustNo
where 1=1
	and month(ev.DateReq) = 1	
	and c.City = 'Boulder'

	-- List the average number of resources used (NumberFld) by plan number. Include only location number L100.
SELECT
		[PlanNo]
      ,avg([ResourceCnt])
FROM 
	[ICA].[dbo].[EventPlanLine]
where 
	LocNo = 'L100'
group by
	PlanNo
--having LocNo = 'L100'

--List the average number of resources used (NumberFld) by plan number. Only include location number L100. Eliminate plans with less than two event lines containing location number L100.

SELECT PlanNo, AVG(ResourceCnt) AS AvgNumResources,
 COUNT(*) AS NumEventLines
 FROM EventPlanLine
 WHERE LocNo = 'L100'
 GROUP BY PlanNo
 HAVING COUNT(*) > 1;
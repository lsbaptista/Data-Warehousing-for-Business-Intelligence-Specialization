--. List the city, state, and zip codes in the customer table. Your result should not have
--duplicates. (Hint: The DISTINCT keyword eliminates duplicates.)
SELECT
    DISTINCT
     City
    ,[State]
    ,Zip
FROM 
    ICA.dbo.Customer

--List the name, department, phone number, and email address of employees with a phone
--number beginning with “3-”.
SELECT
    DISTINCT
     EmpName
     , Department
     ,Phone
     ,Email
FROM 
    ICA.dbo.Employee
WHERE
    Phone LIKE '3%'

--List all columns of the resource table with a rate between $10 and $20. Sort the result by rate.

SELECT
    *
FROM 
    ICA.dbo.ResourceTbl
WHERE
    Rate BETWEEN 10 and 20
ORDER BY 
    Rate

--List the event requests with a status of “Approved” or “Denied” and an authorized date in
--July 2022. Include the event number, authorization date, and status in the output
SELECT 
       [EventNo]
      ,[DateAuth]
      ,[Status]
FROM 
    [ICA].[dbo].[EventRequest]
WHERE 
    ([Status]='Approved' or [Status]='Denied') 
    and MONTH(DateAuth)=7

--List the location number and name of locations that are part of the “Basketball arena”. Your
--WHERE clause should not have a condition involving the facility number compared to a
--constant (“F101”). Instead, you should use a condition on the FacName column for the value
--of “Basketball arena”.
SELECT
      [LocName]
      ,[LocNo]
FROM 
    [ICA].[dbo].[Location] lo
INNER JOIN 
    [ICA].[dbo].[Facility] fa
ON  
    fa.FacNo = lo.FacNo
WHERE
    fa.FacName = 'Basketball arena'

-- IN operator
SELECT location.locno, locname
FROM [ICA].[dbo].[Location] 
WHERE location.facno IN 
   ( SELECT facno FROM [ICA].[dbo].[Facility] WHERE facname = 'Basketball arena' );

--For each event plan, list the plan number, count of the event plan lines, and sum of the
--number of resources assigned. For example, plan number P100 has 4 lines and 7 resources
--assigned. You only need to consider event plans that have at least one line. 
SELECT
        [PlanNo]
        ,COUNT([LinesNo]) as LinesNo
       ,sum([ResourceCnt]) as ResourceCnt
FROM 
    [ICA].[dbo].[EventPlanLine] 
GROUP BY
    PlanNo

--For each event plan with a time start in October 2022, list the plan number, count of the event
--plan lines, and sum of the number of resources assigned. For example, plan number P100
--has 4 lines and 7 resources assigned. The result should only contain event plans that have
--sum of resources of 10 or more. For conditions on columns containing both date and time
--details, you should include both the date and time for conditions testing end of day. In
--PostgreSQL, the condition to test the end of December 2022 should use a TIMESTAMP
--constant of '31-Dec-2022 11:59PM'. In Oracle with the DATE data type for a column, you
--should use the TO_DATE function such as TO_DATE('31-Dec-2022 23:59', 'DD-MonYYYY HH24:MI').

SELECT
        [PlanNo]
        ,COUNT([LinesNo]) as LinesNo
       ,sum([ResourceCnt]) as ResourceCnt
FROM 
    [ICA].[dbo].[EventPlanLine] 
WHERE
    MONTH(TimeStart) = 10
GROUP BY
    PlanNo
HAVING
    sum([ResourceCnt])>=10

SELECT planno, COUNT(*) "Number of Lines", SUM(resourcecnt) "Resource Sum"
FROM  [ICA].[dbo].[EventPlanLine] 
WHERE TimeStart BETWEEN '01-Oct-2022' AND '31-Oct-2022 11:59PM'
GROUP BY planno
HAVING SUM(resourcecnt) >= 10;


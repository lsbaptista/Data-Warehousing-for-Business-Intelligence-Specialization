SELECT 
    er.EventNo
    ,er.DateHeld
    ,er.CustNo
    ,ct.CustName
    ,fc.FacNo
    ,fc.FacName
FROM
    ICA.dbo.EventRequest AS er
    JOIN ICA.dbo.Customer AS ct 
    ON ct.CustNo = er.CustNo
    JOIN ICA.dbo.Facility AS fc
    ON fc.FacNo = er.FacNo
WHERE
    ct.City = 'Boulder'

--------------------------------------------

SELECT 
    ct.CustNo
    ,ct.CustName
    ,er.EventNo
    ,er.DateHeld
    ,fc.FacNo
    ,fc.FacName
    ,(er.EstCost/er.EstAudience) as costperperson
FROM
    ICA.dbo.EventRequest AS er
    JOIN ICA.dbo.Customer AS ct 
    ON ct.CustNo = er.CustNo
    JOIN ICA.dbo.Facility AS fc
    ON fc.FacNo = er.FacNo
WHERE
    YEAR(er.DateHeld) = 2022 AND er.EstCost/er.EstAudience <0.2

-------------------------------------------------

SELECT 
    ct.CustNo
    ,ct.CustName
    ,SUM(er.EstCost)
FROM
    ICA.dbo.EventRequest AS er
    JOIN ICA.dbo.Customer AS ct 
    ON ct.CustNo = er.CustNo
WHERE
    er.[Status] = 'APPROVED'
GROUP BY 
    ct.CustNo, ct.CustName

--------------------------------------------------

SELECT 
    emp.EmpNo
    ,emp.EmpName
    ,MONTH(ep.WorkDate) as month
    ,COUNT(ep.EventNo) as totalevents
    ,SUM(er.EstCost) AS estcost
    
FROM
    ICA.dbo.EventPlan AS ep
    JOIN ICA.dbo.Employee AS emp 
    ON ep.EmpNo = emp.EmpNo
    JOIN ICA.dbo.EventRequest AS er
    ON ep.EventNo = er.EventNo
WHERE
    YEAR(ep.WorkDate) = 2022
GROUP BY
    emp.EmpNo
    ,emp.EmpName
    ,MONTH(ep.WorkDate)

--------------------------------------------------

INSERT INTO ICA.dbo.Customer (CustNo, CustName,Address,City,State,Zip,Phone,Contact,Internal)
VALUES ('C106','Tenis','Parceiros','Leiria','LL','20300','084567834','janes Oo','Y')

SELECT * FROM ICA.dbo.Customer

DELETE FROM ICA.dbo.Customer
    WHERE City = 'Leiria'

---------------------------------------------------

UPDATE ICA.dbo.ResourceTbl
    SET Rate = 30 
    WHERE ResName = 'nurse'

select * from ICA.dbo.ResourceTbl

INSERT INTO ICA.dbo.Customer
 (CustNo, CustName, Address, Internal, Contact, Phone, City, State, Zip)
VALUES ('C9999999', 'Michael Mannino', '123 Any Street', 'Y', 'Self', '720000',
 'Denver', 'CO', '80204');

 DELETE FROM  ICA.dbo.Customer
 WHERE  CustNo = 'C9999999';
-- Executes in both Oracle and PostgreSQL

DROP TABLE IF EXISTS EVENTPLANLINE;
DROP TABLE IF EXISTS EVENTPLAN;
DROP TABLE IF EXISTS EVENTREQUEST;
DROP TABLE IF EXISTS LOCATION;
DROP TABLE IF EXISTS FACILITY;
DROP TABLE IF EXISTS RESOURCETBL;
DROP TABLE IF EXISTS CUSTOMER;
DROP TABLE IF EXISTS EMPLOYEE;

-- Extended practice problems
-- CREATE TABLE statements for Customer, Facility, and Location

-------------------- CUSTOMER --------------------------------

CREATE TABLE Customer
( CustNo 	    VARCHAR(8),
  CustName		VARCHAR(50) CONSTRAINT custnameRequired NOT NULL,
  Address		VARCHAR(50) CONSTRAINT addressRequired NOT NULL,
  Internal	    CHAR(1) DEFAULT 'Y' CONSTRAINT internalRequired NOT NULL,
  Contact	    VARCHAR(35)	    CONSTRAINT contactRequired NOT NULL,
  Phone			VARCHAR(11)    CONSTRAINT phoneRequired NOT NULL,
  City		    VARCHAR(30)  CONSTRAINT cityRequired NOT NULL,
  State			CHAR(2)  CONSTRAINT stateRequired NOT NULL,
  Zip			VARCHAR(10)  DEFAULT '80202' CONSTRAINT zipRequired NOT NULL,
  CONSTRAINT custnoPK PRIMARY KEY (CustNo), 
  );



CREATE TABLE Facility
( FacNo 	    VARCHAR(8),
  FacName		VARCHAR(30) CONSTRAINT factnameRequired NOT NULL,
  CONSTRAINT Uniquefactname UNIQUE (FacName),
  CONSTRAINT factnoPK PRIMARY KEY (FacNo), 
  );

CREATE TABLE Location
( LocNo 	    VARCHAR(8),
  LocName		VARCHAR(30) CONSTRAINT factnameRequired NOT NULL,
  FacNo			VARCHAR(8) CONSTRAINT factnameRequired NOT NULL,
  CONSTRAINT locnonPK PRIMARY KEY (LocNo), 
  CONSTRAINT facnonK FOREIGN KEY (FacNo) REFERENCES Facility
  );

CREATE TABLE ResourceTbl
( ResNo 	    VARCHAR(8),
  ResName		VARCHAR(30) CONSTRAINT restnameRequired NOT NULL,
  Rate			DECIMAL(10,2)  DEFAULT 1 CONSTRAINT rateRequired NOT NULL,
  CONSTRAINT uniquerestname UNIQUE (ResName),
  CONSTRAINT restnoPK PRIMARY KEY (ResNo), 
  );

CREATE TABLE Employee
( EmpNo 	    VARCHAR(8),
  EmpName		VARCHAR(50) CONSTRAINT empnameRequired NOT NULL,
  Department	VARCHAR(25) CONSTRAINT departmentRequired NOT NULL,
  Email		    CHAR(30)    CONSTRAINT emailRequired NOT NULL,
  Phone			VARCHAR(11)    CONSTRAINT phoneRequired NOT NULL,
  MgrNo			VARCHAR(8),
  CONSTRAINT uniquerestemail UNIQUE (Email),
  CONSTRAINT custnonPK PRIMARY KEY (EmpNo), 
  CONSTRAINT mgrnonK FOREIGN KEY (MgrNo) REFERENCES Employee
  );

CREATE TABLE EventRequest
( EventNo 	    VARCHAR(8),
  DateHeld		DATE CONSTRAINT dateheldRequired NOT NULL,
  DateReq		DATE DEFAULT GETDATE() CONSTRAINT datereqRequired NOT NULL,
  DateAuth		DATE,
  Status		VARCHAR(10) CONSTRAINT statusRequired NOT NULL,
  EstCost		DECIMAL(10,2) CONSTRAINT estcostRequired NOT NULL,
  EstAudience	INTEGER CONSTRAINT estaudienceRequired NOT NULL,
  BudNo			VARCHAR(8),
  CustNo		VARCHAR(8)  CONSTRAINT custnoRequired NOT NULL,
  FacNo		VARCHAR(8)  CONSTRAINT factnoRequired NOT NULL,
  CONSTRAINT estaudienceStatus CHECK ( EstAudience > 0),
  CONSTRAINT ValidStatus CHECK (Status IN ('PENDING','APPROVED', 'DENIED')),
  CONSTRAINT eventnonPK PRIMARY KEY (EventNo), 
  CONSTRAINT custnonK FOREIGN KEY (CustNo) REFERENCES Customer,
  CONSTRAINT factnonK FOREIGN KEY (FacNo) REFERENCES Facility,
  );

CREATE TABLE EventPlan
( PlanNo 	    VARCHAR(8),
  Notes			VARCHAR(50),
  WorkDate		DATE CONSTRAINT workdateRequired NOT NULL,
  Activity		VARCHAR(50) CONSTRAINT activityRequired NOT NULL,
  EventNo		VARCHAR(8) CONSTRAINT eventnoRequired NOT NULL,
  EmpNo			VARCHAR(8),
  CONSTRAINT plannoPK PRIMARY KEY (PlanNo), 
  CONSTRAINT eventnonK FOREIGN KEY (EventNo) REFERENCES EventRequest ON DELETE CASCADE,
  CONSTRAINT empnonK FOREIGN KEY (EmpNo) REFERENCES Employee,
  );
  
CREATE TABLE EventPlanLine
( PlanNo	VARCHAR(8),
  LinesNo	INTEGER,
  TimeStart	DATETIME CONSTRAINT timestartRequired NOT NULL,
  TimeEnd	DATETIME CONSTRAINT timesendRequired NOT NULL,
  ResourceCnt	INTEGER CONSTRAINT resourcecntRequired NOT NULL,
  LocNo VARCHAR(8) CONSTRAINT locnoRequired NOT NULL,
  ResNo	VARCHAR(8) CONSTRAINT resnoRequired NOT NULL,
  CONSTRAINT timetatus CHECK (TimeStart<TimeEnd),
  CONSTRAINT plannonPK PRIMARY KEY (PlanNo,LinesNo), 
  CONSTRAINT plannonK FOREIGN KEY (PlanNo) REFERENCES EventPlan ON DELETE CASCADE,
  CONSTRAINT locnonK FOREIGN KEY (LocNo) REFERENCES Location,
  CONSTRAINT resnonK FOREIGN KEY (ResNo) REFERENCES ResourceTbl,
  );
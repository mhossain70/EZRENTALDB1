CREATE TABLE CUSTOMERUSERACCOUNT(

		CustomerUserAccountID
		Raw(16)  Primary Key,
		Username VARCHAR2(20)   UNIQUE NOT NULL,
		Password VARCHAR2(20) NOT NULL,
		Email VARCHAR2(100)  UNIQUE NOT NULL
		);
        
  CREATE TABLE CUSTOMER (
		CustomerID     NUMBER GENERATED ALWAYS AS IDENTITY   Primary Key,
		FirstName   VARCHAR2(50)   NOT NULL,
		LastName   VARCHAR2(50)   NOT NULL,
		BirthDate  DATE         NOT NULL,
		AddressLine1  VARCHAR2(50) NOT NULL,
		AddressLine2  VARCHAR2(50) NOT NULL,
		City               VARCHAR2(25) NOT NULL,
		StateCode             VARCHAR2(2) NOT NULL,
		ZipCode        VARCHAR2(10) NOT NULL,
		Country        VARCHAR2(50) NOT NULL,
		Phone           VARCHAR2(20) NOT NULL,
		Email      VARCHAR2(100) NOT NULL,
		DriverLicenseNumber  VARCHAR2(20) NOT NULL,
		DriverLicenseExpDate  DATE NOT NULL,
		CustomerUserAccountID Raw(16) NOT NULL,
		CustomerType   Char(1)  NOT NULL,
		
		CONSTRAINT CustomerUserAccountID_FK 
		FOREIGN KEY (CustomerUserAccountID)
		REFERENCES CUSTOMERUSERACCOUNT (CustomerUserAccountID)
);


CREATE TABLE DISCOUNT(
		DiscountID  NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
		DiscountCode  VARCHAR2(8) NOT NULL,
		DiscountCodeDesc   VARCHAR2(100) NOT NULL
);


CREATE TABLE EZPLUS (
EZPlusID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
EZPlusRewardsCode VARCHAR2(50) NOT NULL,
EZPlusRewardsEarnedPoints Number(5)    NOT NULL
);


-- Table #5
CREATE TABLE RETAILCUSTOMER(
		R_CustomerID NUMBER GENERATED ALWAYS AS IDENTITY Primary Key,
		DiscountID  Number(10) NOT NULL,
		EZPlusID  Number(10) NOT NULL,
		
		CONSTRAINT R_CustomerID_FK 
		FOREIGN KEY (R_CustomerID)
		REFERENCES CUSTOMER (CustomerID),
		
		CONSTRAINT DiscountID_FK 
		FOREIGN KEY (DiscountID)
		REFERENCES DISCOUNT (DiscountID),
		
		CONSTRAINT EZPlusID_FK 
		FOREIGN KEY (EZPlusID)
		REFERENCES EZPLUS ( EZPLUSID)
);

-- Table #6
CREATE TABLE COMPANY (
		CompanyID Number(10) Primary Key,
		CompanyName  VARCHAR2(50)  UNIQUE NOT NULL,
		AddressLine1  VARCHAR2(50) NOT NULL,
		AddressLine2  VARCHAR2(50) NOT NULL,
		City               VARCHAR2(25) NOT NULL,
		StateCode             VARCHAR2(2) NOT NULL,
		ZipCode        VARCHAR2(10) NOT NULL,
		Country        VARCHAR2(50) NOT NULL,
		ContactName	VARCHAR2(50)   NOT NULL,
		ContactPhone           VARCHAR2(20) NOT NULL,
		ContactEmail      VARCHAR2(100)  UNIQUE NOT NULL,
		CompanyDailyRentalRate DECIMAL(8,2 )   NOT NULL
);

-- Table #7
CREATE TABLE CorporateCustomer (
		C_CustomerID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
		CompanyID NUMBER(10)  NOT NULL,
		
		CONSTRAINT C_CustomerID_FK 
		FOREIGN KEY (C_CustomerID)
		REFERENCES CUSTOMER (CustomerID),
		
		CONSTRAINT CompanyID_FK 
		FOREIGN KEY (CompanyID)
		REFERENCES COMPANY (CompanyID) 
);

-- Table #8
CREATE TABLE CREDITCARD(
		CreditCardNumber VARCHAR2(16)   Primary Key,
		OwnerName VARCHAR2(50)   NOT NULL,
		MerchantName VARCHAR2(50)   NOT NULL,
		ExpDate Date Not NULL,
		AddressLine1 VARCHAR2(50)   NOT NULL,
		AddressLine2  VARCHAR2(50) NOT NULL,
		City VARCHAR2(25)   NOT NULL,
		StateCode VARCHAR2(2)   NOT NULL,
		Zipcode VARCHAR2(10)   NOT NULL,
		Country VARCHAR2(50)   NOT NULL,
		CreditCardBalance DECIMAL(8,2)  NOT NULL,
		CreditCardLimit DECIMAL(8,2) NOT NULL,
		ActivationStatus VARCHAR2(3)  NOT NULL

);

-- Table #9
CREATE TABLE CUSTOMERCREDITCARD(
		CreditCardNumber VARCHAR2(16) NOT NULL,
		CustomerID Number(16) NOT NULL,
		
		CONSTRAINT CreditCardNumber_CustomerID_PK 
		PRIMARY KEY(CreditCardNumber, CustomerID),
		
		CONSTRAINT CreditCardNumber_FK 
		FOREIGN KEY (CreditCardNumber)
		REFERENCES CREDITCARD (CreditCardNumber),
		
		CONSTRAINT CustomerID_FK 
		FOREIGN KEY (CustomerID)
		REFERENCES CUSTOMER (CustomerID)
);

-- Table #10
CREATE TABLE RENTALAGENCY (
		RentalAgencyID NUMBER(10) PRIMARY KEY,
		RentalAgencyName  VARCHAR2(50)     NOT NULL,
		AddressLine1 VARCHAR2(50)     NOT NULL,
		AddressLine2  VARCHAR2(50)     NOT NULL,
		City VARCHAR2(25) NOT NULL,
		StateCode VARCHAR2(2) NOT NULL,
		Country VARCHAR2(50) NOT NULL,
		ZipCode VARCHAR2(10) NOT NULL,
		Phone VARCHAR2(20) NOT NULL,
		Email VARCHAR2(50) UNIQUE NOT NULL
);


CREATE TABLE RESERVATIONSTATUS (
		ReservationStatusID NUMBER(1)    Primary Key,
		ReservationStatusDesc VARCHAR2(50)    NULL
);

-- Table #12
CREATE TABLE VEHICLERENTALCATEGORY (
		VehicleRentalCategoryID NUMBER(2 )  Primary Key,
		CategoryName VARCHAR(20)  NOT NULL,
		CategoryDailyRentalRate DECIMAL(8,2)   NOT NULL
);

-- Table #13
CREATE TABLE RESERVATION (
		ReservationID NUMBER(10)   Primary Key,
		Reservation_CustomerID  NUMBER(10)   NOT NULL,
		RentalAgencyID NUMBER(10)   NOT NULL,
		VehicleRentalCategoryID  NUMBER(2)       NOT NULL,
		ReservationDropOffAgencyID NUMBER(10)   NOT NULL,
		ReservationPickUplDate DATE NOT NULL,
		ReservationPickUpTime NUMBER(4)      NOT NULL,
		ReservationDropOffDate DATE     NOT NULL,
		ReservationDropOffTime NUMBER(4)     NOT NULL,
		R_ReservationStatusID NUMBER(1)    NOT NULL,
		
		CONSTRAINT R_ReservationStatusID_FK 
		FOREIGN KEY (R_ReservationStatusID)
		REFERENCES RESERVATIONSTATUS (ReservationStatusID),
		
		CONSTRAINT Reservation_CustomerID_FK 
		FOREIGN KEY (Reservation_CustomerID)
		REFERENCES CUSTOMER (CustomerID),
		
		CONSTRAINT VehicleRentalCategoryID_FK 
		FOREIGN KEY (VehicleRentalCategoryID)
		REFERENCES VEHICLERENTALCATEGORY (VehicleRentalCategoryID),
		
		CONSTRAINT RentalAgencyID_FK 
		FOREIGN KEY (RentalAgencyID)
		REFERENCES RENTALAGENCY (RentalAgencyID),
		
		CONSTRAINT ReservationDropOffAgencyID_FK 
		FOREIGN KEY (ReservationDropOffAgencyID)
		REFERENCES RENTALAGENCY (RentalAgencyID)
		 
);

-- Table #14
CREATE TABLE VEHICLESTATUS(
		VehicleStatusID NUMBER(1)    Primary Key,
		VehicleStatusDesc VARCHAR2(50)    NULL
);


-- Table #15
CREATE TABLE VEHICLE (
		VehicleID NUMBER GENERATED ALWAYS AS IDENTITY   Primary Key,
		VINNumber VARCHAR2(50)   NOT NULL,
		Make VARCHAR2(10)   NOT NULL,
		Model VARCHAR2(10)   NOT NULL,
		Year VARCHAR2(4)   NOT NULL,
		Color VARCHAR2(8)  NOT NULL,
		LicensePlateNumber VARCHAR2(16)   NOT NULL,
		LicensePlateState VARCHAR2(16)   NOT NULL,
		Mileage NUMBER(10)    NOT NULL,
		TransmissionType VARCHAR2(10)   NOT NULL,
		SeatCapacity NUMBER(2)   NOT NULL,
		V_VehicleRentalCategoryID NUMBER(2)       NOT NULL,
		VehicleStatusID NUMBER(1)  NOT NULL,
		VehicleOwningAgencyID NUMBER(10)   NOT NULL,
		VehicleCurrentLocationAgencyID NUMBER(10)       NOT NULL,
		VehicleType VARCHAR2(8)     NOT NULL,
        
		CONSTRAINT V_VehicleRentalCategoryID_FK 
		FOREIGN KEY (V_VehicleRentalCategoryID)
		REFERENCES  VEHICLERENTALCATEGORY (VehicleRentalCategoryID),
		CONSTRAINT VehicleOwningAgencyID_FK 
		FOREIGN KEY (VehicleOwningAgencyID)
		REFERENCES RENTALAGENCY (RentalAgencyID),
    
		CONSTRAINT VehicleCurrentLocationAgencyID_FK 
		FOREIGN KEY (VehicleCurrentLocationAgencyID)
		REFERENCES RENTALAGENCY (RentalAgencyID),
		
		CONSTRAINT VehicleStatusID_FK 
		FOREIGN KEY (VehicleStatusID)
		REFERENCES VEHICLESTATUS (VehicleStatusID)
);

-- Table #16
CREATE TABLE CAR (
		CarVehicleID NUMBER GENERATED ALWAYS AS IDENTITY   Primary Key,
		TrunkCapacity NUMBER(10)   NOT NULL,
		CONSTRAINT CarVehicleID_FK 
		FOREIGN KEY (CarVehicleID)
		REFERENCES VEHICLE (VehicleID)
);

-- Table #17
CREATE TABLE SUV(
		SuvVehicleID NUMBER GENERATED ALWAYS AS IDENTITY    Primary Key,
		TowingCapacity VARCHAR2(8) NOT NULL,
		IsAWD  NUMBER(1) NOT NULL,
		CONSTRAINT SuvVehicleID_FK 
		FOREIGN KEY (SuvVehicleID)
		REFERENCES VEHICLE (VehicleID)
);

--Table #18
CREATE TABLE  MINIVAN(

		MiniVehicleID NUMBER GENERATED ALWAYS AS IDENTITY   Primary Key,
		HasDisabilityOption CHAR(1)   NOT NULL,
		CONSTRAINT MiniVehicleID_FK 
		FOREIGN KEY (MiniVehicleID)
		REFERENCES VEHICLE (VehicleID)
);

-- Table #19
CREATE TABLE CARGOVAN(

		CarGoVehicleID NUMBER GENERATED ALWAYS AS IDENTITY   Primary Key,
		CargoCapacity VARCHAR2(10)  NOT NULL,
		MaximumPayload VARCHAR2(10) NOT NULL,
		CONSTRAINT CarGoVehicleID_FK 
		FOREIGN KEY (CarGoVehicleID)
		REFERENCES VEHICLE (VehicleID)
);

-- Table #20
CREATE TABLE RENTALINSURANCEOPTION(
		InsuranceOptionID NUMBER(1)   PRIMARY KEY,
		InsuranceOptionDesc VARCHAR2(50)  NOT NULL,
		InsuranceOptionAdditionalCost DEC(8,2)  NOT NULL
);

-- Table #21
CREATE TABLE RENTALSTATUS(
		ReservationStatusID NUMBER (1)   PRIMARY KEY, 
		ReservationStatusDesc VARCHAR2(50)  NOT NULL
);




-- Table #22
CREATE TABLE FUELOPTION(
		FuelOptionID NUMBER(1)  NOT NULL PRIMARY KEY,
		FuelOptionDesc VARCHAR2(100)  NOT NULL,
        RENTALOPTIONADDITIONALCOST VARCHAR2(100) NOT NULL
);

-- Table #23
CREATE TABLE RENTAL (
		RentalAgreementID NUMBER(10)  PRIMARY KEY,
		RCustomerID NUMBER(10)  NOT NULL,
		RVehicleID  NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
		R_RentalAgencyID  NUMBER(10)  NOT NULL,
		R_RentalDropOffAgencyID  NUMBER(10)  NOT NULL,
		R_ReservationID  NUMBER(10)  NOT NULL,
		RentalPickUpDate DATE NOT NULL,
		RentalPickUpTime Number(4)  NOT NULL,
		RentalDropOffDate DATE NOT NULL,
		RentalDropOffTime NUMBER(4)     NOT NULL,
		RentalPickUpOdometerValue NUMBER(3)  NOT NULL,
		RentalDropOffOdometerValue NUMBER(3)  NOT NULL,
		R_RentalFuelOptionID NUMBER(1)  NOT NULL,
		R_InsuranceOptionID  NUMBER (1)  NOT NULL,
		R_RentalStatusID NUMBER(1)   NOT NULL,
		RentalDeposit	DEC(8,2)  NOT NULL,
        
		CONSTRAINT RCustomerID_FK 
		FOREIGN KEY (RCustomerID)
		REFERENCES CUSTOMER (CustomerID),
		CONSTRAINT RVehicleID_FK 
		FOREIGN KEY (RVehicleID)
		REFERENCES VEHICLE (VehicleID),
		CONSTRAINT R_RentalAgencyID_FK 
		FOREIGN KEY (R_RentalAgencyID)
		REFERENCES RENTALAGENCY (RentalAgencyID),
		CONSTRAINT R_RentalDropOffAgencyID_FK 
		FOREIGN KEY (R_RentalDropOffAgencyID)
		REFERENCES RENTALAGENCY (RentalAgencyID),
		CONSTRAINT R_ReservationID_FK 
		FOREIGN KEY (R_ReservationID )
		REFERENCES RESERVATION (ReservationID),
		CONSTRAINT R_RentalFuelOptionID_FK 
		FOREIGN KEY (R_RentalFuelOptionID)
		REFERENCES FUELOPTION (FuelOptionID),
		CONSTRAINT R_InsuranceOptionID_FK 
		FOREIGN KEY (R_InsuranceOptionID)
		REFERENCES RENTALINSURANCEOPTION (InsuranceOptionID),
		CONSTRAINT R_RentalStatusID_FK 
		FOREIGN KEY (R_RentalStatusID)
		REFERENCES VEHICLESTATUS (VehicleStatusID)
);

-- Table #24
CREATE TABLE EMPLOYEEUSERACCOUNT(

		EMPLOYEEUSERACCOUNTID Raw(16)  Primary Key,
		Username VARCHAR2(20)   UNIQUE NOT NULL,
		Password VARCHAR2(20) NOT NULL,
		Email VARCHAR2(100)  UNIQUE NOT NULL
);





-- Table #25
CREATE TABLE EMPLOYEE(

		EmployeeID NUMBER GENERATED ALWAYS AS IDENTITY   Primary Key,
		FirstName VARCHAR2(50)   NOT NULL,
		LastName VARCHAR2(50)   NOT NULL,
		SSNumber NUMBER(9)  UNIQUE NOT NULL,
		BirthDate    DATE    NOT NULL,
		AddressLine1  VARCHAR2(50)     NOT NULL,
		AddressLine2  VARCHAR2(50)     NOT NULL,
		City VARCHAR2(25) NOT NULL,
		State VARCHAR2(2) NOT NULL,
		ZipCode VARCHAR2(10) NOT NULL,
		Country VARCHAR2(50) NOT NULL,
		EmployeePhone Number(20)   NOT NULL,
		EmployeeJobTitle VARCHAR2(50)   NOT NULL,
		EmployeeEmail  VARCHAR2(100)    UNIQUE NOT NULL,
		E_EMPLOYEEUSERACCOUNTID Raw(16)  NOT NULL,
		
		CONSTRAINT E_EMPLOYEEUSERACCOUNTID_FK 
		FOREIGN KEY (E_EMPLOYEEUSERACCOUNTID)
		REFERENCES EMPLOYEEUSERACCOUNT (EMPLOYEEUSERACCOUNTID)
);



-- Table #26
CREATE TABLE USSTATE(

		StateID NUMBER(2)   Primary key,
		StateCode VARCHAR2(2)   UNIQUE NOT NULL,
		StateName VARCHAR2(20)  NOT NULL
);



-- Table #27
CREATE TABLE COUNTRY (
		CountryID NUMBER(3)   Primary Key,
		CountryCode  VARCHAR2(2)NOT NULL,
		CountryName VARCHAR2(50)  NOT NULL
);





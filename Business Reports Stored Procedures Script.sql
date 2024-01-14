--Second Procedure #1
create or replace PROCEDURE usp_oldercarPromotion 
IS
--declare variable needed for SELECT INTO statement
v_FirstName   VARCHAR2(50);
v_LastName VARCHAR2(50) ;
v_AddressLine1  VARCHAR2(50);
v_City   VARCHAR2(25);
v_StateCode  VARCHAR2(2);
v_ZipCode        VARCHAR2(10);
v_Country        VARCHAR2(50);
v_Phone           VARCHAR2(20);
v_Email      VARCHAR2(100);
v_DriverLicenseNumber  VARCHAR2(20);
v_RentalAgencyName  VARCHAR2(50) ;
v_Make VARCHAR2(10) ;
v_Model VARCHAR2(10)  ;
v_Year VARCHAR2(4);
v_Color VARCHAR2(8);
--Declare Cursor
CURSOR cur_Customer IS 
 -- Query cursor will point to results
 SELECT 
CUSTOMER.FirstName, CUSTOMER.LastName, CUSTOMER.AddressLine1, 
CUSTOMER.City, CUSTOMER.StateCode, CUSTOMER.ZipCode , 
CUSTOMER.Country, CUSTOMER.Phone, CUSTOMER.Email, CUSTOMER.DriverLicenseNumber, 
RENTALAGENCY. RentalAgencyName, 
VEHICLE.Make, VEHICLE.Model, VEHICLE.Year, VEHICLE.Color
FROM Customer,RESERVATION,RENTALAGENCY,VEHICLE
WHERE Customer.CustomerID = RESERVATION.Reservation_CustomerID 
and RESERVATION.RentalAgencyID = RENTALAGENCY. RentalAgencyID
and  RENTALAGENCY.RentalAgencyID  =VEHICLE. VehicleCurrentLocationAgencyID 
and VEHICLE.Year= '2015';
--Start Execution section
BEGIN
--Open Cursor
 OPEN cur_Customer;
 LOOP
 FETCH cur_Customer INTO v_FirstName,v_LastName , v_AddressLine1, v_City, 
 v_StateCode , v_ZipCode , v_Country, v_Phone   , v_Email , v_DriverLicenseNumber,v_RentalAgencyName,
  v_Make,v_Model,v_Year,v_Color;
 EXIT WHEN cur_Customer%NOTFOUND;
 --Display each record
 DBMS_OUTPUT.PUT_LINE('Customer info: 
 ' ||v_FirstName|| ' | ' ||v_LastName || '|' || v_AddressLine1|| '|' || v_City || '|'
 ||v_StateCode || '|' || v_ZipCode || '|'||v_Country||'|' || v_Phone || '|' || v_Email || '|' || v_DriverLicenseNumber || '|'
 || v_RentalAgencyName||  '|' || v_Make || '|' || v_Model|| '|' || v_Year|| '|' || v_Color);

 END LOOP;
CLOSE cur_Customer; 
END usp_oldercarPromotion;





--Second Procedure #2
CREATE OR REPLACE PROCEDURE usp_How_many_TOYOTA_cars
IS
v_VehicleID NUMBER;
v_VINNumber VARCHAR2(50);
v_Make VARCHAR2(10);
v_Model VARCHAR2(10);
v_Year VARCHAR2(4);
v_Color VARCHAR2(8);
v_LicensePlateNumber VARCHAR2(16) ;
v_LicensePlateState VARCHAR2(16) ;
CURSOR cur_Car IS 
SELECT Vehicle.VehicleID, Vehicle.VINNumber, Vehicle.Make, Vehicle.Model, Vehicle.Year, Vehicle.Color, Vehicle.LicensePlateNumber, Vehicle.LicensePlateState
FROM VEHICLE
where Make = 'TOYOTA';
BEGIN
 OPEN cur_Car; 
 LOOP
 FETCH cur_Car INTO 
	v_VehicleID ,
	v_VINNumber ,
	v_Make, 
	v_Model ,
	v_Year ,
	v_Color ,
	v_LicensePlateNumber,
	v_LicensePlateState;
 EXIT WHEN cur_Car%NOTFOUND;
 DBMS_OUTPUT.PUT_LINE('Car info: 
 ' ||v_VehicleID || ' | ' ||v_VINNumber || '|' || v_Make|| '|' || v_Model || '|'
 ||v_Year || '|' || v_Color ||'|' || v_LicensePlateNumber|| '|'|| v_LicensePlateState) ;
 
 END LOOP;
 
 CLOSE cur_Car; 
END usp_How_many_TOYOTA_cars;




--Second Procedure #3

create or replace PROCEDURE usp_CompanyNameEbay
IS
v_FirstName   VARCHAR2(50);
v_LastName VARCHAR2(50) ;
v_AddressLine1  VARCHAR2(50);
v_City   VARCHAR2(25);
v_StateCode  VARCHAR2(2);
v_ZipCode        VARCHAR2(10);
v_Country        VARCHAR2(50);
v_Phone           VARCHAR2(20);
v_Email      VARCHAR2(100);
v_CompanyID NUMBER(10);
v_CompanyName  VARCHAR2(50);
CURSOR cur_CompanyName IS  
SELECT CUSTOMER.FirstName, CUSTOMER.LastName, CUSTOMER.AddressLine1, 
CUSTOMER.City, CUSTOMER.StateCode, CUSTOMER.ZipCode , 
CUSTOMER.Country, CUSTOMER.Phone, CUSTOMER.Email,
CorporateCustomer.CompanyID,
Company. CompanyName
FROM ((CUSTOMER
INNER JOIN CorporateCustomer ON CUSTOMER.CustomerID = CorporateCustomer.C_CustomerID)
INNER JOIN Company ON CorporateCustomer.CompanyID = company.companyid)
where Company.CompanyName ='Ebay';


BEGIN

 OPEN cur_CompanyName;
 LOOP
 FETCH cur_CompanyName INTO v_FirstName,v_LastName , v_AddressLine1, v_City, 
 v_StateCode , v_ZipCode , v_Country, v_Phone   , v_Email , v_CompanyID,v_CompanyName ;
 EXIT WHEN cur_CompanyName%NOTFOUND;
 DBMS_OUTPUT.PUT_LINE('Company info: 
 ' ||v_FirstName|| ' | ' ||v_LastName || '|' || v_AddressLine1|| '|' || v_City || '|'
 ||v_StateCode || '|' || v_ZipCode || '|' || v_Country || '|'|| v_Phone || '|' || v_Email || '|' || v_CompanyID || '|'
 || v_CompanyName);

 END LOOP;
CLOSE cur_CompanyName; 
END usp_CompanyNameEbay;

--Second Procedure #4



CREATE OR REPLACE PROCEDURE usp_Get_reservation_status
IS 

v_FirstName   VARCHAR2(50);
v_LastName VARCHAR2(50) ;
v_AddressLine1  VARCHAR2(50);
v_City   VARCHAR2(25);
v_StateCode  VARCHAR2(2);
v_ZipCode        VARCHAR2(10);
v_Country        VARCHAR2(50);
v_Phone           VARCHAR2(20);
v_Email      VARCHAR2(100);
v_ReservationID NUMBER(10);
v_ReservationPickUplDate DATE ;
v_R_ReservationStatusID NUMBER(1);
v_VehicleStatusDesc VARCHAR2(50) ;
 
BEGIN 
 SELECT CUSTOMER.FirstName, CUSTOMER.LastName, CUSTOMER.AddressLine1, 
CUSTOMER.City, CUSTOMER.StateCode, CUSTOMER.ZipCode , 
CUSTOMER.Country, CUSTOMER.Phone, CUSTOMER.Email,
RESERVATION. ReservationID, RESERVATION.ReservationPickUplDate,  RESERVATION.R_ReservationStatusID ,
RESERVATIONSTATUS. ReservationStatusDesc
INTO v_FirstName,v_LastName , v_AddressLine1, v_City, 
v_StateCode , v_ZipCode , v_Country, v_Phone   , v_Email ,v_ReservationID,v_ReservationPickUplDate,v_R_ReservationStatusID,v_VehicleStatusDesc
FROM ((CUSTOMER
INNER JOIN RESERVATION ON CUSTOMER.CustomerID = RESERVATION.RESERVATIONID)
INNER JOIN RESERVATIONSTATUS ON RESERVATION.RESERVATIONID = RESERVATIONSTATUS.ReservationStatusID )
WHERE RESERVATION.ReservationID = '1'; 
 DBMS_OUTPUT.PUT_LINE('Customer info: 
 ' ||v_FirstName|| ' | ' ||v_LastName || '|' || v_AddressLine1|| '|' || v_City || '|'
 ||v_StateCode || '|' || v_ZipCode || '|' || v_Phone || '|' || v_Email || '|' || v_ReservationID || '|'
 ||v_ReservationPickUplDate||  '|' || v_R_ReservationStatusID|| '|' || v_VehicleStatusDesc);

 
END usp_Get_reservation_status;


--Second Procedure #5

CREATE OR REPLACE PROCEDURE usp_Find_cargovan 
IS 
v_VehicleID NUMBER;
v_VINNumber VARCHAR2(50);
v_Make VARCHAR2(10);
v_Model VARCHAR2(10);
v_Color VARCHAR2(8);
v_LicensePlateNumber VARCHAR2(16) ;
v_LicensePlateState VARCHAR2(16) ;
v_VehicleStatusID NUMBER(1) ;
v_VehicleStatusDesc VARCHAR2(50);
v_CargoCapacity VARCHAR2(10);


BEGIN 
 SELECT VEHICLE.VehicleID, VEHICLE.VinNumber, VEHICLE.Make, VEHICLE.model, VEHICLE.color, VEHICLE.LicensePlateNumber, 
VEHICLE.licensePlateState, VEHICLE.vehicleStatusID,
VEHICLESTATUS.VehicleStatusDesc,
Cargovan.cargocapacity
INTO v_VehicleID ,
	v_VINNumber ,
	v_Make, 
	v_Model ,
	v_Color ,
	v_LicensePlateNumber,
	v_LicensePlateState,
	v_VehicleStatusID,
	v_VehicleStatusDesc,
	v_CargoCapacity
	
FROM  Vehicle,VEHICLESTATUS,Cargovan
 WHERE Vehicle.VehicleStatusID = VEHICLESTATUS.VehicleStatusID
 AND VEHICLE.VehicleID = CARGOVAN.CarGoVehicleID
 AND cargocapacity  = 
 (SELECT MAX(cargocapacity )
 FROM Cargovan);
 
 
 DBMS_OUTPUT.PUT_LINE('Car info: 
 ' ||v_VehicleID || ' | ' ||v_VINNumber || '|' || v_Make|| '|' || v_Model || 
 '|' || v_Color ||'|' || v_LicensePlateNumber|| '|'|| v_LicensePlateState|| '|'|| v_VehicleStatusID || '|'|| v_VehicleStatusDesc|| '|'|| v_CargoCapacity);
 
END usp_Find_cargovan;


--Second Procedure #6


CREATE OR REPLACE PROCEDURE usp_paying_by_AMEX  
IS 
v_CreditCardNumber VARCHAR2(16) ;
v_OwnerName VARCHAR2(50) ;
v_MerchantName VARCHAR2(50) ;
v_AddressLine1 VARCHAR2(50);

v_AddressLine2  VARCHAR2(50);
v_City VARCHAR2(25);
v_StateCode VARCHAR2(2);
v_Zipcode VARCHAR2(10);
v_Country VARCHAR2(50);
v_CustomerID Number(16);
BEGIN 
 SELECT CREDITCARD.CreditCardNumber, CREDITCARD.OwnerName, CREDITCARD.MerchantName,CREDITCARD. AddressLine1, CREDITCARD.AddressLine2, 
 CREDITCARD.City, CREDITCARD.StateCode, CREDITCARD.Zipcode, CREDITCARD.Country,
 CUSTOMERCREDITCARD.CustomerID
INTO
v_CreditCardNumber ,
v_OwnerName ,
v_MerchantName,
v_AddressLine1 ,

v_AddressLine2 ,
v_City ,
v_StateCode ,
v_Zipcode ,
v_Country ,
v_CustomerID 
	
FROM CREDITCARD
 Left Join CUSTOMERCREDITCARD
 On  CREDITCARD.CreditCardNumber = CUSTOMERCREDITCARD.CreditCardNumber
 Where CREDITCARD.MerchantName LIKE '%AMEX%';
 DBMS_OUTPUT.PUT_LINE('Card info: 
 ' ||v_CreditCardNumber|| ' | ' ||v_OwnerName  || '|' || v_MerchantName|| '|' || v_AddressLine1 || '|'
 ||v_AddressLine2 || '|' || v_City ||'|' || v_StateCode|| '|'|| v_Zipcode|| '|'|| v_Country || '|'|| v_CustomerID);
 
END usp_paying_by_AMEX;

--Second Procedure #7


Select * FROM EMPLOYEE
Where EMPLOYEE.CITY LIKE '%Manhattan%';   

 
CREATE OR REPLACE PROCEDURE usp_who_living_Manhattan 
IS 
v_EmployeeID NUMBER;
v_FirstName VARCHAR2(50) ;
v_LastName VARCHAR2(50)   ;
v_SSNumber NUMBER(9)  ;
v_BirthDate    DATE   ;
v_AddressLine1  VARCHAR2(50) ;    
v_AddressLine2  VARCHAR2(50)  ;   
v_City VARCHAR2(25); 
v_State VARCHAR2(2) ;
v_ZipCode VARCHAR2(10) ;
v_Country VARCHAR2(50) ;
v_EmployeePhone Number(20)  ; 
v_EmployeeJobTitle VARCHAR2(50)   ;
v_EmployeeEmail  VARCHAR2(100)  ;  
v_E_EMPLOYEEUSERACCOUNTID Raw(16)  ;
		
BEGIN 
 SELECT EMPLOYEE.EmployeeID ,
		EMPLOYEE.FirstName ,
		EMPLOYEE.LastName ,
		EMPLOYEE.SSNumber ,
		EMPLOYEE.BirthDate  ,  
		EMPLOYEE.AddressLine1 , 
		EMPLOYEE.AddressLine2 , 
		EMPLOYEE.City ,
		EMPLOYEE.State ,
		EMPLOYEE.ZipCode ,
		EMPLOYEE.Country ,
		EMPLOYEE.EmployeePhone ,
		EMPLOYEE.EmployeeJobTitle ,
		EMPLOYEE.EmployeeEmail  ,
		EMPLOYEE.E_EMPLOYEEUSERACCOUNTID 
INTO
v_EmployeeID,
v_FirstName ,
v_LastName ,
v_SSNumber ,
v_BirthDate ,  
v_AddressLine1, 
v_AddressLine2 , 
v_City ,  
v_State ,
v_ZipCode, 
v_Country ,
v_EmployeePhone,
v_EmployeeJobTitle,
v_EmployeeEmail  ,
v_E_EMPLOYEEUSERACCOUNTID 
		
	
FROM  EMPLOYEE
 Where EMPLOYEE.CITY LIKE '%Manhattan%';
 DBMS_OUTPUT.PUT_LINE('EMPLOYEE info: 
 ' ||v_EmployeeID|| ' | ' ||v_FirstName  || '|' || v_LastName || '|' || v_SSNumber || '|'
 ||v_AddressLine1 || '|' || v_AddressLine2 ||'|' || v_City|| '|'|| v_State|| '|'  ||v_ZipCode|| '|'|| v_Country || '|' ||v_EmployeePhone||'|'|| v_EmployeeJobTitle|| '|'
 || v_EmployeeEmail || '|'||v_E_EMPLOYEEUSERACCOUNTID );
 
END usp_who_living_Manhattan;
--Second Procedure #8


CREATE OR REPLACE PROCEDURE usp_check_vehicle_Status_By_SeatCapacity(p_MODEL IN VARCHAR2,p_SeatCapacity IN NUMBER)
IS 
v_VehicleID NUMBER;
v_VINNumber VARCHAR2(50);
v_Make VARCHAR2(10);
v_Model VARCHAR2(10);
v_Year VARCHAR2(4);
v_Color VARCHAR2(8);
v_LicensePlateNumber VARCHAR2(16) ;
v_LicensePlateState VARCHAR2(16) ;
v_SeatCapacity NUMBER(2);
v_VehicleStatusID NUMBER(1);
v_VehicleStatusDesc VARCHAR2(50);
BEGIN SELECT
 Vehicle.VehicleID, Vehicle.VINNumber, Vehicle.Make, Vehicle.Model, Vehicle.Year, Vehicle.Color,
Vehicle.LicensePlateNumber,Vehicle. LicensePlateState, Vehicle.SeatCapacity,Vehicle. VehicleStatusID,
VEHICLESTATUS.VehicleStatusDesc

INTO
v_VehicleID,
v_VINNumber ,
v_Make ,
v_Model ,
v_Year ,
v_Color ,
v_LicensePlateNumber ,
v_LicensePlateState ,
v_SeatCapacity ,
v_VehicleStatusID, 
v_VehicleStatusDesc
		
	
FROM Vehicle
FULL OUTER JOIN VEHICLESTATUS
 On  vehicle.vehiclestatusid = VEHICLESTATUS.vehiclestatusid
 Where  vehicle.MODEL LIKE '%'||p_MODEL||'%'and Vehicle.SeatCapacity >=p_SeatCapacity;
 DBMS_OUTPUT.PUT_LINE('Vehicle info: 
 ' ||v_VehicleID|| ' | ' ||v_VINNumber|| '|' || v_Make || '|' || v_Model || '|'
 ||v_Year || '|' || v_Color ||'|' || v_LicensePlateNumber || '|'|| v_LicensePlateState ||'|'|| v_SeatCapacity || '|'  ||v_VehicleStatusID|| '|'|| v_VehicleStatusDesc);
 
END usp_check_vehicle_Status_By_SeatCapacity;

--Second Procedure #9


create or replace PROCEDURE usp_bill_bord_campaign
IS

v_VehicleID NUMBER;
v_VINNumber VARCHAR2(50);
v_Make VARCHAR2(10);
v_Model VARCHAR2(10);
v_Year VARCHAR2(4);
v_Color VARCHAR2(8);
v_LicensePlateNumber VARCHAR2(16) ;
v_LicensePlateState VARCHAR2(16) ;
v_VehicleRentalCategoryID NUMBER(2 );
v_CategoryName VARCHAR(20) ;
v_CategoryDailyRentalRate DECIMAL(8,2);

CURSOR cur_BillBord IS
 
SELECT 
 VEHICLE.VehicleID, VEHICLE.VinNumber, VEHICLE.Make, VEHICLE.model,VEHICLE.Year,VEHICLE.color, VEHICLE.LicensePlateNumber, 
VEHICLE.licensePlateState, 
VEHICLERENTALCATEGORY.vehiclerentalcategoryid,vehiclerentalcategory.categoryname ,vehiclerentalcategory.categorydailyrentalrate
From Vehicle,VEHICLERENTALCATEGORY
Where  VEHICLE .V_VehicleRentalCategoryID=VEHICLERENTALCATEGORY.vehiclerentalcategoryid
 AND CategoryDailyRentalRate  = 
 (SELECT MIN(CategoryDailyRentalRate )
 FROM VEHICLERENTALCATEGORY);

BEGIN

 OPEN cur_BillBord;
 LOOP
 FETCH cur_billbord INTO v_VehicleID, v_VINNumber, v_Make, v_Model, v_Year, v_Color, v_LicensePlateNumber, v_LicensePlateState,v_VehicleRentalCategoryID,
 v_CategoryName,v_CategoryDailyRentalRate;
 EXIT WHEN cur_billbord%NOTFOUND;
 
 DBMS_OUTPUT.PUT_LINE('Vehicle info: 
 ' ||v_VehicleID || ' | ' ||v_VINNumber || '|' || v_Make|| '|' || v_Model || '|'
 ||v_Year || '|' || v_Color ||'|' || v_LicensePlateNumber|| '|'|| v_LicensePlateState|| '|'||v_VehicleRentalCategoryID||'|'||v_CategoryName||'|'||v_CategoryDailyRentalRate);

 END LOOP;
CLOSE cur_BillBord; 
END usp_bill_bord_campaign;


-- Procedure #10
CREATE OR REPLACE PROCEDURE usp_Search_Suv_MAX
IS 
v_VehicleID NUMBER;
v_VINNumber VARCHAR2(50);
v_Make VARCHAR2(10);
v_Model VARCHAR2(10);

v_Color VARCHAR2(8);
v_LicensePlateNumber VARCHAR2(16) ;
v_LicensePlateState VARCHAR2(16) ;
v_TowingCapacity VARCHAR2(8);
BEGIN 
 SELECT VEHICLE.VehicleID, VEHICLE.VinNumber, VEHICLE.Make, VEHICLE.model, VEHICLE.color, VEHICLE.LicensePlateNumber, 
VEHICLE.licensePlateState, 
SUV.TOWINGCAPACITY

INTO
v_VehicleID,
v_VINNumber ,
v_Make ,
v_Model ,

v_Color ,
v_LicensePlateNumber ,
v_LicensePlateState ,

v_TowingCapacity
	
FROM Vehicle,SUV
 WHERE 
 VEHICLE.VehicleID = suv.suvvehicleid
 AND TOWINGCAPACITY  = 
 (SELECT MAX(TOWINGCAPACITY )
 FROM suv);
 DBMS_OUTPUT.PUT_LINE('Vehicle info: 
 ' ||v_VehicleID|| ' | ' ||v_VINNumber|| '|' || v_Make || '|' || v_Model || '|'
   || v_Color ||'|' || v_LicensePlateNumber || '|'|| v_LicensePlateState ||'|'||v_TowingCapacity);
 
END usp_Search_Suv_MAX;


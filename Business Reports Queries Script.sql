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
and VEHICLE.Year= '2015'
;


SELECT Vehicle.VehicleID, VINNumber, Make, Model, Year, Color, LicensePlateNumber, LicensePlateState
FROM VEHICLE
where Make = 'TOYOTA';

SELECT CUSTOMER.FirstName, CUSTOMER.LastName, CUSTOMER.AddressLine1, 
CUSTOMER.City, CUSTOMER.StateCode, CUSTOMER.ZipCode , 
CUSTOMER.Country, CUSTOMER.Phone, CUSTOMER.Email,
CorporateCustomer.CompanyID,
Company. CompanyName
FROM ((CUSTOMER
INNER JOIN CorporateCustomer ON CUSTOMER.CustomerID = CorporateCustomer.C_CustomerID)
INNER JOIN Company ON CorporateCustomer.CompanyID = company.companyid)
where Company.CompanyName ='Ebay'
;

SELECT CUSTOMER.FirstName, CUSTOMER.LastName, CUSTOMER.AddressLine1, 
CUSTOMER.City, CUSTOMER.StateCode, CUSTOMER.ZipCode , 
CUSTOMER.Country, CUSTOMER.Phone, CUSTOMER.Email,
RESERVATION. ReservationID, RESERVATION.ReservationPickUplDate,  RESERVATION.R_ReservationStatusID ,
RESERVATIONSTATUS. ReservationStatusDesc
FROM ((CUSTOMER
INNER JOIN RESERVATION ON CUSTOMER.CustomerID = RESERVATION.RESERVATIONID)
INNER JOIN RESERVATIONSTATUS ON RESERVATION.RESERVATIONID = RESERVATIONSTATUS.ReservationStatusID )
WHERE RESERVATION.ReservationID = '1' 
;
SELECT VEHICLE.VehicleID, VEHICLE.VinNumber, VEHICLE.Make, VEHICLE.model, VEHICLE.color, VEHICLE.LicensePlateNumber, 
VEHICLE.licensePlateState, VEHICLE.vehicleStatusID,
VEHICLESTATUS.VehicleStatusDesc,
Cargovan.cargocapacity
 FROM Vehicle,VEHICLESTATUS,Cargovan
 WHERE Vehicle.VehicleStatusID = VEHICLESTATUS.VehicleStatusID
 AND VEHICLE.VehicleID = CARGOVAN.CarGoVehicleID
 AND cargocapacity  = 
 (SELECT MAX(cargocapacity )
 FROM Cargovan);
 
 
 
 
 
 
 
 SELECT CREDITCARD.CreditCardNumber, CREDITCARD.OwnerName, CREDITCARD.MerchantName,CREDITCARD. AddressLine1, CREDITCARD.AddressLine2, 
 CREDITCARD.City, CREDITCARD.StateCode, CREDITCARD.Zipcode, CREDITCARD.Country,
 CUSTOMERCREDITCARD.CustomerID
 FROM CREDITCARD
 Left Join CUSTOMERCREDITCARD
 On  CREDITCARD.CreditCardNumber = CUSTOMERCREDITCARD.CreditCardNumber
 Where CREDITCARD.MerchantName LIKE '%AMEX%';
 
 
 


Select * FROM EMPLOYEE
Where EMPLOYEE.CITY LIKE '%Manhattan%';   

select Vehicle.VehicleID, Vehicle.VINNumber, Vehicle.Make, Vehicle.Model, Vehicle.Year, Vehicle.Color,
Vehicle.LicensePlateNumber,Vehicle. LicensePlateState, Vehicle.SeatCapacity,Vehicle. VehicleStatusID,
VEHICLESTATUS.VehicleStatusDesc
FROM Vehicle
FULL OUTER JOIN VEHICLESTATUS
 On  vehicle.vehiclestatusid = VEHICLESTATUS.vehiclestatusid
 Where  vehicle.MODEL LIKE '%HIGHLANDER%' and Vehicle.SeatCapacity >=7;
 
 SELECT VEHICLE.VehicleID, VEHICLE.VinNumber, VEHICLE.Make, VEHICLE.model, VEHICLE.color, VEHICLE.LicensePlateNumber, 
VEHICLE.licensePlateState, 
SUV.TOWINGCAPACITY

 FROM Vehicle,SUV
 WHERE 
 VEHICLE.VehicleID = suv.suvvehicleid
 AND TOWINGCAPACITY  = 
 (SELECT MAX(TOWINGCAPACITY )
 FROM suv);
  
 SELECT VEHICLE.VehicleID, VEHICLE.VinNumber, VEHICLE.Make, VEHICLE.model, VEHICLE.color, VEHICLE.LicensePlateNumber, 
VEHICLE.licensePlateState, 
VEHICLERENTALCATEGORY.vehiclerentalcategoryid,vehiclerentalcategory.categorydailyrentalrate,vehiclerentalcategory.categoryname 
From Vehicle,VEHICLERENTALCATEGORY
Where  VEHICLE .V_VehicleRentalCategoryID=VEHICLERENTALCATEGORY.vehiclerentalcategoryid
 AND CategoryDailyRentalRate  = 
 (SELECT MIN(CategoryDailyRentalRate )
 FROM VEHICLERENTALCATEGORY);
 
 
 
SELECT 
Customer.CustomerID,
CUSTOMER.FirstName, CUSTOMER.LastName, CUSTOMER.AddressLine1, 
CUSTOMER.City, CUSTOMER.StateCode, CUSTOMER.ZipCode , 
CUSTOMER.Country, CUSTOMER.Phone, CUSTOMER.Email,
RETAILCUSTOMER.EZPlusID,
EZPLUS.EZPlusRewardsEarnedPoints
From Customer,RETAILCUSTOMER,EZPLUS

Where  Customer.CustomerID=RETAILCUSTOMER.R_CustomerID
and EZPLUS.EZPlusID=RETAILCUSTOMER.EZPlusID
and EZPlusRewardsEarnedPoints =
(SELECT MAX(EZPlusRewardsEarnedPoints)
 FROM EZPLUS);


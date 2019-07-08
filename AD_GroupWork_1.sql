Create Database JamTruckingSystem

use JamTruckingSystem

--*****TABLES****
--**CUSTOMER TABLE****

Create table Customer
(
	TRN int NOT NULL PRIMARY KEY,
	First_Name varchar(50),
	Last_Name varchar(50),
	DOB Date,
	Cust_Address varchar(100),
	Martital_Status varchar(15),
	PhoneNum varchar(11),
	Gender char 
)
 
--drop table Customer
 
--****TRUCK TABLES*****
 
Create table Truck
(
	License_Plate_No varchar(10) NOT NULL PRIMARY KEY,
	Price Money,
	Colour varchar(50),
	Truck_Year int,
	Make varchar(50),
	Model varchar(50),
	Max_Load int,
	Engine_Size varchar(50)
)

--drop table Truck 

--*****CARGO TRUCK TABLE***
create table Cargo
(
	License_No varchar(10) Primary Key,
	Fuel_Type varchar(50),
	No_of_Wheels int,
	CONSTRAINT fk_license FOREIGN KEY (License_No) REFERENCES Truck(License_Plate_No)
)

--drop table Cargo

--***MOVER TRUCK TABLE***

create table Mover
(
	License_Num varchar(10)Primary Key, 
	Seat_Capacity int,
	Max_Clearing_Height int,
	CONSTRAINT fk_lic FOREIGN KEY (License_Num) REFERENCES Truck(License_Plate_No)
)

--drop table Mover 

--****RENT TABLES***

create table Rent
(
	LicenseNum varchar(10),  
	TRN int,
	CONSTRAINT PK_Lic PRIMARY KEY(LicenseNum, TRN),
	CONSTRAINT fk_Lic_No FOREIGN KEY (LicenseNum) REFERENCES Truck(License_Plate_No),
	CONSTRAINT fk_trn FOREIGN KEY (TRN) REFERENCES Customer(TRN)
)

--drop table Rent 

--****EMPLOYEE TABLE****

create table Employee
(
	Employee_ID varchar(20) NOT NULL PRIMARY KEY,
	Emp_First_Name varchar(50),
	Emp_Last_Name varchar(50),
	Position varchar(50),
	Email varchar(50),
	EMP_Address varchar(255),
	Salary money
)
--drop table Employee


--****EMPLOYEE TELEPHONE NUMBER TABLE***

create table Emp_Telephone
(
	Emp_ID varchar(20) Primary Key,
	EMP_Telephone varchar(20),
	CONSTRAINT fk_emp_Id FOREIGN KEY (Emp_ID) REFERENCES Employee(Employee_Id)
)
--drop table Emp_Telephone

--**** ISSUE TABLE*****

create table Issue
(
	License_Num varchar(10), 
	TRN int, 
	Date_Rented date,
	Date_Returned date,
	Emp_ID varchar(20),
	CONSTRAINT PK_issue PRIMARY KEY(License_Num, TRN, Emp_ID),
	constraint fk_employee_id foreign key (Emp_id)references Employee(Employee_ID),
	constraint fk_cust foreign key (TRN)references Customer(TRN)
	 
)

--drop table Issue 

---***** REPAIR SERVICES TABLES****

create table Repair_Service
(
	Emp_ID varchar(20),
	LicenseN varchar(10),
	Cost money,
	Repair_Type varchar(50)
	constraint pk_RepServe Primary Key (LicenseN,Emp_ID),
	constraint fk_Emp_lic foreign key (LicenseN) references Truck(License_Plate_No),
	constraint fk_RepSev foreign key (Emp_ID) references Employee(Employee_ID) 

)					

--drop table Repair_Service

--**** BILL TABLE ****

create table Bill
(
	Reference_No varchar(10)not null Primary Key,
	Bill_Date Date,
	Total_Charge Money,
	Due_Date Date	
)

drop table Bill

--****** RENT BILL TABLE****

Create Table Rent_Bill
(
	Ref_Number varchar(10),
	trn int,
	Constraint pk_RBill Primary Key(Ref_Number, trn),
	Constraint fk_reference Foreign Key(Ref_Number) references Bill(Reference_No),
	Constraint fk_rentb Foreign Key (trn) references Customer(TRN)	
)
DROP TABLE Rent_Bill


--**** SUPPLIER TABLE *****

Create Table Supplier
(
	CompanyName varchar(100) not null  primary key ,
	Parts varchar(50),
	Supplied_Date date,
	Amount Money
)
--drop table Supplier

--***** SUPPLY PARTS TABLE****

Create Table Supply_Parts
(
	LicenseNum varchar(10), 
	CompanyName varchar(100),
	constraint pk_SP_Lic Primary Key(LicenseNum,CompanyName), 
	constraint fk_License_Plate_No Foreign key (LicenseNum)references Truck(License_Plate_No),
	constraint fk_CompanyName Foreign key (CompanyName)references Supplier(CompanyName)
)
--drop table Supply_Parts

--***** REGISTRATION TABLE******

create table Registration
(
	Reg_No varchar(10) primary key,
	--License_No varchar(10),
	Fitness varchar(10) not null,
	Reg_Date date not null,
	Exp_Date date not null,
	--Constraint fk_Reg Foreign Key(License_No) references Truck(License_Plate_No)
)
drop table registration


--****** INSURANCE TABLE******

create table Insurance
(
	Policy_No varchar(50) primary key,
	CompanyName varchar(50) not null,
	Ins_Cost money not null,
	Ins_Type varchar(50)not null,
	Issue_Date date,
	Exp_Date date
)
drop table Insurance

create table Truck_Registration
(
	Reg_Num varchar(10),
	License_No varchar(10),
	Constraint pk_TruckReg Primary Key (Reg_Num, License_No),
	constraint fk_Lic_num foreign key (License_No) references Truck (License_Plate_No),
	constraint fk_truck_reg foreign key (Reg_Num) references Registration (Reg_No)
	
)
select * from Registration

--DROP TABLE Truck_Registration

create table Truck_Insurance 
(
	Policy_No varchar(50) not null,
	License_No varchar(10) not null,
	constraint pk_Policy_lic primary key (Policy_No, License_No),
	constraint fk_Plate_no foreign key (License_No) references Truck (License_Plate_No),
	constraint fk_Pol_no foreign key (Policy_No) references Insurance(Policy_No)
	
)


---***************** STORED PROCEDURES FOR SELECT********

Go
Create procedure sp_select_Customer
(
	@Table nvarchar(5),
	--@ID int,
	@ID varchar(255)
)

as 
begin

if (@Table = 'Cus')
	begin
		Select *
		from Customer
		where @ID = TRN
	end

if (@Table = 'Trk')
	begin
		Select *
		from Truck
		where @ID = License_Plate_No
	end

if (@Table = 'Car')
	begin
		Select *
		from Cargo
		where @ID = TRN
	end

if (@Table = 'Mov')
	begin
		Select *
		from Mover
		where @ID = TRN
	end

if (@Table = 'Ren')
	begin
		Select *
		from Rent
		where @ID = License_Plate_No
	end

if (@Table = 'Emp')
	begin
		Select *
		from Employee
		where @ID = Emp_ID
	end

if (@Table = 'Emt')
	begin
		Select *
		from Emp_Telephone
		where @ID = Emp_ID
	end

if (@Table = 'Iss')
	begin
		Select *
		from Issue
		where @ID = License_Plate_No
	end

if (@Table = 'Trs')
	begin
		Select *
		from Truck_Repair_Service
		where @ID = Repair_Service_No
	end

if (@Table = 'Bil')
	begin
		Select *
		from Bill
		where @ID = Ref_No
	end

if (@Table = 'Spt')
	begin
		Select *
		from Supply_Parts
		where @ID = Supply_Code
	end

if (@Table = 'Sup')
	begin
		Select *
		from Supplier
		where @ID = CompanyName
	end

if (@Table = 'Reg')
	begin
		Select *
		from Registration
		where @ID = Reg_No
	end

if (@Table = 'Ins')
	begin
		Select *
		from Insurance
		where @ID = Policy_No
	end

End			





Go
------STORED PROCEDURES FOR SELECT NUMBER OF(RETURN)

Create procedure sp_Select_No
(
	@Table nvarchar(5)
	--@ID int,
	--@ID varchar(255)
)



as 

Declare @Invalue int;

begin

if (@Table = 'Cus')
	begin
		Set @Invalue= ( Select Count(*) from Customer)
		return @Invalue
		
	end

if (@Table = 'Trk')
	begin
		Set @Invalue= ( Select Count(*) from Truck)
		return @Invalue
		
	end

if (@Table = 'Car')
	begin
		Set @Invalue= ( Select Count(*) from Cargo)
		return @Invalue
		
	end

if (@Table = 'Mov')
	begin
		Set @Invalue= ( Select Count(*) from Mover)
		return @Invalue
		
	end

if (@Table = 'Ren')
	begin
		Set @Invalue= ( Select Count(*) from Rent)
		return @Invalue
		
	end

if (@Table = 'Emp')
	begin
		Set @Invalue= ( Select Count(*) from Employee)
		return @Invalue
		
	end

if (@Table = 'Emt')
	begin
		Set @Invalue= ( Select Count(*) from Emp_Telephone)
		return @Invalue
		
	end

if (@Table = 'Iss')
	begin
		Set @Invalue= ( Select Count(*) from Issue)
		return @Invalue
		
	end


if (@Table = 'Trs')
	begin
		Set @Invalue= ( Select Count(*) from Truck_Repair_Service)
		return @Invalue
		
	end

if (@Table = 'Bil')
	begin
		Set @Invalue= ( Select Count(*) from Bill)
		return @Invalue
		
	end

if (@Table = 'Spt')
	begin
		Set @Invalue= ( Select Count(*) from Supply_Parts)
		return @Invalue
		
	end

if (@Table = 'Sup')
	begin
		Set @Invalue= ( Select Count(*) from Supplier)
		return @Invalue
		
	end

if (@Table = 'Reg')
	begin
		Set @Invalue= ( Select Count(*) from Registration)
		return @Invalue
		
	end

if (@Table = 'Ins')
	begin
		Set @Invalue= ( Select Count(*) from Insurance)
		return @Invalue
		
	end

End		

go 
declare @Results int;
Exec @Results= sp_Select_No Cus;
Select @Results as NumberOfMembers;


----------******* STORED PROCEDURE FOR INSERT ******* ------

--***INSERT PROCEDURE CUSTOMER****

go 
create procedure sp_ins_cus
(
	@TRN int,
	@FisrtName varchar(50),
	@LastName varchar(50),
	@DOB date,
	@Address varchar(100),
	@Marital_status varchar(11),
	@Gender char,
	@Phone varchar(11)
)

as
begin

insert into Customer(TRN, First_Name, Last_Name, DOB, Cust_Address, Martital_Status, Gender, PhoneNum)
values(@TRN,@FisrtName,@LastName,@DOB,@Address,@Marital_status,@Gender,@Phone)

end

Exec sp_ins_cus 12345,'Kelly', 'Anderson', '12/11/1995', '5 Ribbon Avenue, Kingston 10', 'Single','F','345-6510'
Exec sp_ins_cus 12344,'Valrie','Jones','12/10/1985', '7 Mona Road, Kingston 3', 'Divorce', 'F','501-2910'
Exec sp_ins_cus 12359, 'Ray', 'Williams', '10/23/1981', 'District Bush, St. Thomas', 'Single', 'M','660-2848'
Exec sp_ins_cus 12348, 'Zetta', 'Jacobs', '11/14/1968', 'Kenton ByField, St. Catherine','Married', 'F', '990-2110'
Exec sp_ins_cus 12350, 'John', 'Brown', '09/29/1980', 'James River, Portland', 'Married', 'M', '789-0008'
Exec sp_ins_cus 12340, 'Casetta', 'Mills', '08/01/1959', 'Goatland, Westmoreland', 'Widow', 'F', '875-4000'

select * from Customer

--****INSERT PROCEDURE TRUCK*****

go
create procedure sp_ins_trk
(
	@Licence_No varchar(50),
	@Price Money,
	@Colour varchar(50),
	@Truck_Year int,
	@Make varchar(50),
	@Model varchar(50),
	@Max_Load int,
	@Engine_Size varchar(50)	
)
As 
Begin

	Insert into Truck(License_Plate_No, Price, Colour, Truck_Year, Make, Model, Max_Load, Engine_Size)
	Values(@Licence_No, @Price,@Colour,@Truck_Year,@Make, @Model, @Max_Load,@Engine_Size)

End

Exec sp_ins_trk 'AB4000','$12,000','Red',1999,'Freightliner', 'M2106', 66000,'1000CC'
Exec sp_ins_trk 'AB4011', '$12,900','Black',2008, 'Freightliner','Cascadia',60600,'5000CC'
Exec sp_ins_trk 'AB6012', '10,000', 'Yellow', 2009, 'Freightliner','1225D', 50000, '585CC'
Exec sp_ins_trk 'AB7014', '$20,000', 'Pink', 2001, 'Freightliner', 'M2112', 70000, '5000CC'
Exec sp_ins_trk 'AB5055', '$12,400', 'Blue', 1999, 'Freightliner', '1085D', 66000, '1500CC'
Exec sp_ins_trk 'AB6789', '$10,000', 'Orange', 1995, 'Freightliner', '1145D', 40000, '577CC'
Exec sp_ins_trk 'AB9991', '$20,500', 'White', 2009, 'Freightliner',  'M2106', 70000, '5500CC'
Exec sp_ins_trk 'AB8991', '$10,000', 'Green', 2004, 'Freightliner', 'New Cascadia', 45000,'600CC'
Exec sp_ins_trk 'AB2000', '$20,580', 'Gold', 2009, 'Freightliner', 'Cascadia Evolution', 70500, '6000CC'
Exec sp_ins_trk 'AB2001', '$12,000', 'Silver', 1998, 'Freightliner', '1145D Natural Gas', 66000, '1000CC'

SELECT * from Truck


--****INSERT PROCEDURE CARGO TRUCK****
go
create procedure sp_ins_car
(
	@License_No varchar(10),
	@Fuel_Type varchar(255),
	@No_Wheels int	
)
As 
Begin

	Insert into Cargo(License_No, Fuel_Type, No_of_Wheels)
	Values(@License_No,@Fuel_Type, @No_Wheels)

End

Exec sp_ins_car 'AB5055', 'Diesel', 12
EXEC sp_ins_car 'AB6789', 'Gasoline', 12
EXEC sp_ins_car 'AB9991', 'Gasoline', 12
EXEC sp_ins_car 'AB8991', 'Gasoline', 12

select * from Cargo

--*****INSERT PROCEDURE MOVER TRUCK*****
go
create procedure sp_ins_mov
(
	@License_No varchar(10),
	@Capacity int,
	@Max_Height int
)
As 
Begin

	Insert into Mover(License_Num, Seat_Capacity, Max_Clearing_Height)
	Values(@License_No, @Capacity,@Max_Height)

End

Exec sp_ins_mov 'AB4000', 3, 2
Exec sp_ins_mov 'AB4011', 4, 2
Exec sp_ins_mov 'AB6012', 2, 2
Exec sp_ins_mov 'AB7014', 2, 4
Exec sp_ins_mov 'AB2000', 3, 4
Exec sp_ins_mov 'AB2001', 2, 2

SELECT * FROM Mover

--*****INSERT PROCEDURE RENT*****

go
create procedure sp_ins_rent
(
	@License varchar(10),
	@trn int	
)
As 
Begin

	Insert into Rent(LicenseNum, TRN)
	Values(@License, @trn)

End

Exec sp_ins_rent 'AB2001', 12345
Exec sp_ins_rent 'AB4000', 12344
Exec sp_ins_rent 'AB4011', 12359
Exec sp_ins_rent 'AB6012', 12348
Exec sp_ins_rent 'AB7014', 12350
Exec sp_ins_rent 'AB5055', 12350
Exec sp_ins_rent 'AB6789', 12345
Exec sp_ins_rent 'AB9991', 12344
Exec sp_ins_rent 'AB8991', 12359
Exec sp_ins_rent 'AB2000', 12350

SELECT * FROM Rent

--******INSERT PROCEDURE EMPLOYEE*****

go
create procedure sp_ins_Emp
(	
	@Emp_ID varchar(50),
	@Emp_First_Name varchar(50),
	@Emp_Last_Name varchar(50),
	@Emp_Address varchar(50),
	@Position varchar(50),
	@Email varchar(50),
	@Salary varchar(50)
	
)
As 
Begin

	Insert into Employee(Employee_ID, EMP_First_Name, EMP_Last_Name, Emp_Address, Position, Email, Salary)
	Values(@Emp_ID,@Emp_First_Name,@Emp_Last_Name, @Emp_Address, @Position, @Email, @Salary)

End

Exec sp_ins_Emp 'VB110', 'Veronica', 'Byle', '7 PC Avenue, Kgn 10', 'Accountant', 'vb100@jam.com', 70000
Exec sp_ins_Emp 'JB101', 'James', 'Brown', 'Lindo Walk, St. Thomas', 'Manager', 'jb101@jam.com', 100000
Exec sp_ins_Emp 'PB102', 'Pencil', 'Bruce', 'Rubber Way, Portland', 'Mechanic', 'pb102@jam.com', 50000 
Exec sp_ins_Emp 'FW103', 'Flinch', 'Walker', '1 Button Road, Kgn 6', 'Rental Clerk', 'fw103@jam.com',50000
Exec sp_ins_Emp 'DB104', 'Daniel', 'Bloom', '7 Mona Drive, Kgn 6', 'Rental Clerk', 'db104@jam.com', 50000
Exec sp_ins_Emp 'JC105', 'Jammy', 'Clarke', '18 Walkway, Kgn 10', 'Rental Clark', 'jc105@jam.com', 50000
Exec sp_ins_Emp 'KD106', 'Kammy', 'Don', 'Wallen Way, St. Catherine', 'Mechanic', 'kd106@jam.com', 15000
Exec sp_ins_Emp 'LB107', 'Lengend', 'Black', 'Castleton Park, St. Mary', 'Mechanic', 'lb107@jam.com', 15000

select * from Employee

--***INSERT STORE PROCEDURE TELEPHONE***

go
create procedure sp_ins_telephone
(
	@ID varchar(20),
	@Emp_phone varchar(20)
)
As 
Begin

	Insert into Emp_Telephone(Emp_ID, Emp_Telephone)
	Values(@ID, @Emp_phone)

End

Exec sp_ins_telephone 'JC105', '700-1000' 
Exec sp_ins_telephone 'DB104', '984-0000' 
Exec sp_ins_telephone 'FW103', '798-6165'
Exec sp_ins_telephone 'PB102', '999-0001'
Exec sp_ins_telephone 'PB102', '687-7770'
Exec sp_ins_telephone 'PB102', '781-7961'
Exec sp_ins_telephone 'JB101', '701-9988'
Exec sp_ins_telephone 'VB100', '700-1000'
Exec sp_ins_telephone 'VB100', '998-6001'
Exec sp_ins_telephone 'KD106', '981-0009'
Exec sp_ins_telephone 'LB107', '799-1025' 

 select * from Emp_Telephone
 
--*****INSERT PROCEDURE ISSUE**** 

go
create procedure sp_ins_issue
(
	@License varchar(10),
	@TRN int,
	@Rentdate date,
	@returndate date,
	@EmpId varchar(10)
)
As 
Begin

	Insert into Issue(License_Num, TRN, Date_Rented, Date_Returned, Emp_ID)
	Values(@License,@TRN,@Rentdate,@returndate,@EmpId)

End

Exec sp_ins_issue 'AB4000', 12344, '10/25/2016', '10/28/2016', 'FW103'
Exec sp_ins_issue 'AB4011', 12359, '10/10/2016', '10/14/2016', 'FW103'
Exec sp_ins_issue 'AB6012', 12348, '09/05/2016', '09/09/2016', 'DB104'
Exec sp_ins_issue 'AB7401', 12350, '11/07/2016', '11/17/2016', 'JC105'
Exec sp_ins_issue 'AB5055', 12350, '09/01/2016', '09/30/2016', 'JC105'
Exec sp_ins_issue 'AB6789', 12345, '10/07/2016', '10/21/2016', 'JC105'
Exec sp_ins_issue 'AB9991', 12344, '09/19/2016', '09/23/2016', 'DB104'
Exec sp_ins_issue 'AB8991',	12359, '09/20/2016', '09/30/2016', 'VB100'
Exec sp_ins_issue 'AB2000', 12350, '11/01/2016', '11/04/2016', 'PB102'
Exec sp_ins_issue 'AB2001', 12345, '11/14/2016', '11/18/2016', 'JB100'

SELECT * FROM Issue

--****** INSERT PROCEDURE FOR REPAIR SERVICE ******

go
create procedure sp_ins_repair_service
(
	@empId varchar(20),
	@License varchar(10),
	@Cost Money,
	@RepairType varchar(50)
)
As 
Begin

	Insert into Repair_Service( Emp_ID,LicenseN,Cost, Repair_Type)
	Values(@empId,@License, @Cost, @RepairType)

End

Exec sp_ins_repair_service 'JC105','AB4000',15000, 'Service'
Exec sp_ins_repair_service 'PB102', 'AB4011', 5000, 'Repair'
Exec sp_ins_repair_service 'PB102', 'AB5055', 26000, 'Service'
Exec sp_ins_repair_service 'KD106', 'AB8991', 6000, 'Repair'
Exec sp_ins_repair_service 'LB107', 'AB2000', 60000, 'Repair'

SELECT * FROM Repair_Service

--**** INSERT PROCEDURE FOR BILL***

go
 create procedure sp_ins_bill
(
	@Ref_No varchar(10),
	@Billdate Date,
	@Totalcharge Money,
	@Duedate Date
)
As 
Begin

	Insert into Bill(Reference_No, Bill_Date, Total_Charge, Due_Date)
	Values(@Ref_No, @Billdate, @Totalcharge, @Duedate)

End

Exec sp_ins_bill 'BILL404', '10/25/2016', 48000, '10/28/2016'
Exec sp_ins_bill 'BILL405', '10/10/2016', 45000, '10/16/2016'

Exec sp_ins_bill 'BILL406', '09/05/2016', 35600, '09/15/2016'
Exec sp_ins_bill 'BILL407', '11/07/2016', 40100,


--****** INSERT PROCEDURE FOR SUPPLIER ******

go
create procedure sp_ins_supplier
(
	@CompanyName varchar(50),
	@Parts varchar(50),
	@S_Date Date,
	@Amount Money
)
As 
Begin

	Insert into Supplier(CompanyName, Parts, Supplied_Date, Amount)
	Values(@CompanyName,@Parts, @S_Date,@Amount)

End

exec sp_ins_supplier 'Alberta Vehicles', 'Engine', '08/29/2016', 50000
exec sp_ins_supplier 'Freightliner Boss', 'Door Handle', '09/01/2016', 15000
exec sp_ins_supplier 'Tyre Works', 'Tyre', '09/09/2016', 16000
exec sp_ins_supplier 'Jenkins Auto', 'Wind Screen', '10/17/2016', 78000
exec sp_ins_supplier 'Vehicle Trucking', 'Radiator', '10/21/2016', 35500
exec sp_ins_supplier 'Auto Mobile', 'Steering Wheeling', '11/07/2016', 25000

select * from Supplier

--***** INSERT PROCEDURE FOR Supply Part*****

Go
Create procedure sp_ins_supply_parts
(
	@LicenseN varchar(10),
	@CompanyName varchar(50)	
)
As 
Begin

	Insert into Supply_Parts(LicenseNum, CompanyName)
	Values(@LicenseN, @CompanyName)

End

exec sp_ins_supply_parts 'AB4000', 'Alberta Vehicles'
exec sp_ins_supply_parts 'AB9991', 'Freightliner Boss'
exec sp_ins_supply_parts 'AB8991', 'Tyre Works'
exec sp_ins_supply_parts 'AB2001', 'Jenkins Auto'
exec sp_ins_supply_parts 'AB7014', 'Vehicle Trucking'
exec sp_ins_supply_parts 'AB5055', 'Auto Mobile'

select * from Supply_Parts


--****** INSERT PROCEDURE FOR REGISTRATION****

Go
Create Procedure sp_ins_Registration
(
	@reg_no varchar (10),
	--@License_no varchar(10),
	@Fitness varchar(10),
	@Reg_date date,
	@Exp_date date
)
As 
Begin

	Insert into Registration(Reg_No, Fitness, Reg_Date, Exp_Date)
	Values(@reg_no,@Fitness, @Reg_date, @Exp_date)

End

exec sp_ins_Registration 'R6000', 'FIT6970', '01/04/2016', '01/04/2017'
exec sp_ins_Registration 'R6001', 'FIT6911', '01/28/2016', '01/28/2017'
exec sp_ins_Registration 'R6002', 'FIT9816', '06/20/2016', '06/20/2017'
exec sp_ins_Registration 'R6003', 'FIT1099', '01/04/2016', '08/10/2017'

SELECT * FROM Registration

--******* INSERT PROCEDURE FOR INSURANCE ******
go
create procedure sp_ins_Insurance
(
	@Policy_No varchar(50),
	@CompanyName varchar(50),
	@Ins_Cost money,
	@Ins_Type varchar(50),
	@Issue_Date Date,
	@Exp_Date Date
	
)
As 
Begin

insert into Insurance(Policy_No, CompanyName, Ins_Cost, Ins_Type, Issue_Date, Exp_Date)
values(@Policy_No, @CompanyName, @Ins_Cost, @Ins_Type, @Issue_Date, @Exp_Date)

end

exec sp_ins_Insurance 'S112', 'Sagicor', 50000, 'Comprehensive', '01/04/2016', '01/04/2017'
exec sp_ins_Insurance 'VL113', 'Vehicle Life', 35500, 'Third Party', '01/04/2016', '01/04/2017'
exec sp_ins_Insurance 'TS114', 'Truck Stamp', 48500, 'Third Party', '08/10/2016', '08/10/2017'
exec sp_ins_Insurance 'CP115', 'Coverage Party', 69500, 'Comprehensive', '06/20/2016', '06/20/2017'
exec sp_ins_Insurance 'T116', 'Transportation', 79500, 'Comprehensive', '01/25/2016', '01/25/2017'
exec sp_ins_Insurance 'TC117', 'Truck Caribbean', 39500, 'Third Party', '01/29/2016', '01/29/2017'

--****** INSERT PROCEDURE FOR TRUCK INSURANCE***

Go
Create Procedure sp_ins_truck_insurance
(
	@PolicyNo varchar(50),
	@LicenseN varchar(10)
)
As
Begin
	
	Insert into Truck_Insurance(Policy_No, License_No)
	Values(@PolicyNo, @LicenseN)

End

Exec sp_ins_truck_insurance 'S112', 'AB4000';
Exec sp_ins_truck_insurance 'VL113', 'AB4011';
Exec sp_ins_truck_insurance 'VL113', 'AB5055';
Exec sp_ins_truck_insurance 'TS114', 'AB6789';
Exec sp_ins_truck_insurance 'S112', 'AB9991';
Exec sp_ins_truck_insurance 'CP115', 'AB8991';
Exec sp_ins_truck_insurance 'T116', 'AB6012';
Exec sp_ins_truck_insurance 'TC117', 'AB7014';
Exec sp_ins_truck_insurance 'TC117', 'AB2000';
Exec sp_ins_truck_insurance 'CP115', 'AB2001'


--*****INSERT PROCEDURE FOR TRUCK REGISTRATION

GO
Create Procedure sp_ins_truck_Reg
(
	@RegNum varchar(10),
	@LicenseNo varchar(10)
)
As
Begin
	Insert into Truck_Registration(Reg_Num, License_No)
	Values(@RegNum, @LicenseNo)
	
End

Exec sp_ins_truck_Reg 'R6000', 'AB4000'
Exec sp_ins_truck_Reg 'R6000', 'AB4011'
Exec sp_ins_truck_Reg 'R6003', 'AB5055'
Exec sp_ins_truck_Reg 'R6002', 'AB6789'
Exec sp_ins_truck_Reg 'R6002', 'AB9991'
Exec sp_ins_truck_Reg 'R6001', 'AB8991'
Exec sp_ins_truck_Reg 'R6001', 'AB6012'
Exec sp_ins_truck_Reg 'R6000', 'AB7014'
Exec sp_ins_truck_Reg 'R6000', 'AB2000'
Exec sp_ins_truck_Reg 'R6003', 'AB2001'




go
------******** STORED PROCEDURES FOR UPDATE**
create procedure sp_upd_cus
(
	@var1 int,
	@var2 varchar(255)
	--@var3 varchar(255),
	--@var4 date,
	--@var5 varchar(255),
	--@var6 varchar(255)
)

as
begin

Update Customer
Set First_Name=@var2
where TRN=@var1
end

go
create procedure sp_upd_trk
(
	@var1 varchar(255),
	@var2 varchar(255)
	--@var3 varchar(255),
	--@var4 int,
	--@var5 varchar(255),
	--@var6 varchar(255),
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

Update Truck
Set Price=@var2
where License_Plate_No=@var1

end

go
create procedure sp_upd_car
(
	@var1 int,
	@var2 varchar(255)
	--@var3 varchar(255)
	--@var4 int,
	--@var5 varchar(255),
	--@var6 varchar(255),
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

Update Cargo
Set Fuel_Type=@var2
where TRN=@var1

end

go
create procedure sp_upd_mov
(
	@var1 int,
	@var2 int
	--@var3 int
	--@var4 int,
	--@var5 varchar(255),
	--@var6 varchar(255),
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

Update Mover
Set Seat_Capacity=@var2
where TRN=@var1

end

go
create procedure sp_upd_ren
(
	@var1 varchar(255),
	@var2 date
	--@var3 date,
	--@var4 date
	--@var5 varchar(255),
	--@var6 varchar(255),
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

Update Rent
Set Returned_Date=@var2
where License_Plate_No=@var1

end


go
create procedure sp_upd_Emp
(	
	@var1 int,
	@var2 varchar(255)
	--@var3 varchar(255),
	--@var4 varchar(255),
	--@var5 varchar(255),
	--@var6 varchar(255)
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

Update Employee
Set Emp_First_Name=@var2
where Emp_ID=@var1

end

go
create procedure sp_upd_tel
(
	@var1 int,
	@var2 int
	--@var3 varchar(255),
	--@var4 int,
	--@var5 varchar(255),
	--@var6 varchar(255),
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

Update Emp_Telephone
Set EMP_Telephone=@var2
where Emp_ID=@var1

end

go
create procedure sp_upd_ema
(
	@var1 int,
	@var2 varchar(255)
	--@var3 varchar(255),
	--@var4 int,
	--@var5 varchar(255),
	--@var6 varchar(255),
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

Update Emp_Email
Set EMP_Email=@var2
where EMP_Email=@var1

end


go
create procedure sp_upd_iss
(
	@var1 varchar(255),
	@var2 date
	--@var3 date,
	--@var4 date
	--@var5 varchar(255),
	--@var6 varchar(255),
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

Update Issue
Set Date_Returned=@var2
where License_Plate_No=@var1

end

go
create procedure sp_upd_trs
(
	@var1 varchar(255),
	@var2 money
	--@var3 int,
	--@var4 money,
	--@var5 varchar(255)
	--@var6 varchar(255),
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

Update Truck_Repair_Service
Set Cost=@var2
where Repair_Service_No=@var1

end

go
 create procedure sp_upd_bil
(
	@var1 int,
	@var2 money
	--@var3 int,
	--@var4 date,
	--@var5 money
	--@var6 varchar(255),
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

Update Bill
Set Total_Charges=@var2
where Ref_No=@var1
end

go
create procedure sp_upd_sup
(
	@var1 varchar(255),
	@var2 int
	--@var3 date,
	--@var4 int
	--@var5 varchar(255),
	--@var6 varchar(255),
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

Update Supplier
Set Amount=@var2
where CompanyName=@var1

end

go
create procedure sp_upd_reg
(
	@var1 int,
	@var2 varchar(255)
	--@var3 varchar(255),
	--@var4 date,
	--@var5 date
	--@var6 varchar(255),
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

Update Registration
Set Fitness=@var2
where Reg_No=@var1

end


go
create procedure sp_upd_ins
(
	@var1 int,
	@var2 money
	--@var3 money,
	--@var4 varchar(255),
	--@var5 Date,
	--@var6 Date
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

Update Insurance
Set Ins_Cost=@var2
where Policy_No=@var1

end

exec sp_upd_cus 1111, 'Home';
Select * from Customer


go
-------------------------------------------------------------------------------Stored Procedure for Deletion

create procedure sp_del_cus
(
	@var1 int
	--@var2 varchar(255)
	--@var3 varchar(255),
	--@var4 date,
	--@var5 varchar(255),
	--@var6 varchar(255)
)

as
begin

delete from Customer
where TRN=@var1
end

go
create procedure sp_del_trk
(
	@var1 varchar(255)
	--@var2 varchar(255)
	--@var3 varchar(255),
	--@var4 int,
	--@var5 varchar(255),
	--@var6 varchar(255),
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

delete from Truck
where License_Plate_No=@var1

end

go
create procedure sp_del_car
(
	@var1 int
	--@var2 varchar(255)
	--@var3 varchar(255)
	--@var4 int,
	--@var5 varchar(255),
	--@var6 varchar(255),
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

delete from Cargo
where TRN=@var1

end

go
create procedure sp_del_mov
(
	@var1 int
	--@var2 int
	--@var3 int
	--@var4 int,
	--@var5 varchar(255),
	--@var6 varchar(255),
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

delete from Mover
where TRN=@var1

end

go
create procedure sp_del_ren
(
	@var1 varchar(255)
	--@var2 date
	--@var3 date,
	--@var4 date
	--@var5 varchar(255),
	--@var6 varchar(255),
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

delete from Rent
where License_Plate_No=@var1

end


go
create procedure sp_del_Emp
(	
	@var1 int
	--@var2 varchar(255)
	--@var3 varchar(255),
	--@var4 varchar(255),
	--@var5 varchar(255),
	--@var6 varchar(255)
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

delete from Employee
where Emp_ID=@var1

end

go
create procedure sp_del_tel
(
	@var1 int
	--@var2 int
	--@var3 varchar(255),
	--@var4 int,
	--@var5 varchar(255),
	--@var6 varchar(255),
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

delete from Emp_Telephone
where Emp_ID=@var1

end

go
create procedure sp_del_ema
(
	@var1 int
	--@var2 varchar(255)
	--@var3 varchar(255),
	--@var4 int,
	--@var5 varchar(255),
	--@var6 varchar(255),
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

delete from Emp_Email
where EMP_Email=@var1

end


go
create procedure sp_del_iss
(
	@var1 varchar(255)
	--@var2 date
	--@var3 date,
	--@var4 date
	--@var5 varchar(255),
	--@var6 varchar(255),
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

delete from Issue
where License_Plate_No=@var1

end

go
create procedure sp_del_trs
(
	@var1 varchar(255)
	--@var2 money
	--@var3 int,
	--@var4 money,
	--@var5 varchar(255)
	--@var6 varchar(255),
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

delete from Truck_Repair_Service
where Repair_Service_No=@var1

end

go
 create procedure sp_del_bil
(
	@var1 int
	--@var2 money
	--@var3 int,
	--@var4 date,
	--@var5 money
	--@var6 varchar(255),
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

delete from Bill
where Ref_No=@var1
end

go
create procedure sp_del_sup
(
	@var1 varchar(255)
	--@var2 int
	--@var3 date,
	--@var4 int
	--@var5 varchar(255),
	--@var6 varchar(255),
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

delete from Supplier
where CompanyName=@var1

end

go
create procedure sp_del_reg
(
	@var1 int
	--@var2 varchar(255)
	--@var3 varchar(255),
	--@var4 date,
	--@var5 date
	--@var6 varchar(255),
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

delete from Registration
where Reg_No=@var1

end


go
create procedure sp_del_ins
(
	@var1 int
	--@var2 money
	--@var3 money,
	--@var4 varchar(255),
	--@var5 Date,
	--@var6 Date
	--@var7 int,
	--@var8 varchar(255),
	--@var9 int
)

as 
begin

delete from Insurance
where Policy_No=@var1

end

Exec sp_del_cus 1111;
select * from Customer;


go
------------------------------------------------------------------Stored Procedue to Show Output Parameter
Create Procedure sp_out_parame
(
	@var1 int,
	@var2 varchar(255) OUTPUT,
	@var3 varchar(255) OUTPUT
)

as
begin
Set NOCOUNT ON;
Set @var2 = (Select (First_Name) from Customer where TRN=@var1);
Set @var3 = (Select (Last_Name) from Customer where TRN=@var1);


end




go
----------------------------------------------Execution Phase
exec sp_select_Customer Cus, 1111;


declare @Results int;
Exec @Results= sp_Select_No Cus;
Select @Results as NumberOfMembers;

exec sp_ins_cus 1133, 'Next', 'Test', '2014-09-09', 'xxxxxxxxxx', 'O';
Select * From Customer

exec sp_upd_cus 1111, 'Scit';
Select * From Customer

exec sp_del_cus 1133;
Select * From Customer

Declare @var4 int;
Declare @var5 varchar(255);
Declare @var6 varchar(255);

exec sp_out_parame 1111, @var5 OUTPUT, @var6 OUTPUT;

Select @var5 as First_Name, @var6 as Last_Name

Select * From Customer

create trigger Employee_Commission

Create Database JAM_Trucking
Use JAM_Trucking_Company



--***************Question 4(A) - Transactions***************
--***************Without Roll back***************


--This Transaction will allow every employee be associated with a customer
--Therefore EMployee must exist to have a telephone Number (Business Rules #9 - Validation)
Create  Procedure sp_Employee
(
@Emp_ID varchar(20), 
@Fname Varchar(50),
@Lname Varchar(50),
@Position varchar(50),
@Email varchar(50),
@Emp_Address Varchar(50),
@Salary Money,
@Emp_telephone varchar(20)
)
As
BEGIN TRANSACTION Employee

	DECLARE @error_num int;

	Insert Into Employee(Emp_ID, Emp_First_Name, Emp_Last_Name,Position, Emai, Emp_Address, Salary)
	Values
	(@Emp_ID, @Fname, @Lname, @Position, @Email, @Emp_Address, @Salary);

	IF (@@ERROR > 0) 
		BEGIN
			SELECT 'Unexpected error occurred!'
			RETURN 1
		END
COMMIT TRANSACTION

BEGIN TRANSACTION Emp_Telephone

	DECLARE @error_num int;

	Insert Into Emp_Telephone(Emp_ID, Emp_Telephone)
	Values
	(@Emp_ID, @Emp_Telephone);

	IF (@@ERROR > 0) 
		BEGIN
			SELECT 'Unexpected error occurred!'
			RETURN 1
		END
COMMIT TRANSACTION


--This Transaction will allow every suppliers to be associated with insurance
--Therefore a supplier] must exist to have insurnace (Business Rules #9 - Validation)
Create  Procedure sp_Supplier
(
@CompanyName varchar(100), 
@Part Varchar(50),
@S_Date Date,
@Amount integer,
@Policy_No INTEGER, 
@Ins_Cost Money, 
@Ins_type Varchar(255), 
@Ins_Start_Date Date, 
@Ins_Exp_Date Date
)
As
BEGIN TRANSACTION Supplier
	DECLARE @error_num int;

	Insert Into Supplier(CompanyName, Part, S_Date, Amount)
	Values
	(@CompanyName, @Part, @S_Date, @Amount);

	IF (@@ERROR > 0) 
		BEGIN
			SELECT 'Unexpected error occurred!'
			RETURN 1
		END
COMMIT TRANSACTION

BEGIN TRANSACTION Insurance

	DECLARE @error_num int;

	Insert Into Insurance(Policy_No, CompanyName, Ins_Cost, Ins_type, Ins_Start_Date, Ins_Exp_Date)
	Values
	(@Policy_No, @CompanyName, @Ins_Cost, @Ins_type, @Ins_Start_Date, @Ins_Exp_Date);

	IF (@@ERROR > 0) 
		BEGIN
			SELECT 'Unexpected error occurred!'
			RETURN 1
		END
COMMIT TRANSACTION


--This Transaction will allow every bill is issue to a customer
--Therefore a bill must exist for it to be issued (Business Rules #9 - Validation)
Create  Procedure sp_IsssueBill
(
@License_Plate_No Varchar(10), 
@TRN INTEGER, 
@Date_Rented Date, 
@Date_Returned Date, 
@Emp_ID Varchar(20), 
@Due_Date Date,
@Ref_No INTEGER, 
@Bill_Date Date, 
@Total_Charges Money
)
As
BEGIN TRANSACTION Issue
	DECLARE @error_num int;

	Insert Into Issue(License_Plate_No, TRN, Date_Rented, Date_Returned, Emp_ID, Due_Date)
	Values                                                    
	(@License_Plate_No, @TRN, @Date_Rented, @Date_Returned, @Emp_ID, @Due_Date);

	IF (@@ERROR > 0) 
		BEGIN
			SELECT 'Unexpected error occurred!'
			RETURN 1
		END
COMMIT TRANSACTION

BEGIN TRANSACTION Bill
		Insert Into Bill(Ref_No, License_Plate_No, TRN, Bill_Date, Total_Charges)
		Values
		(@Ref_No, @License_Plate_No, @TRN, @Bill_Date, @Total_Charges);
		SELECT @@TRANCOUNT;

		IF (@@ERROR > 0) 
		BEGIN
			SELECT 'Unexpected error occurred!'
			RETURN 1
		END
COMMIT TRANSACTION


--***************Question 4(B) - Transactions***************
--***************Including Roll back***************

--This Transaction will allow JAM Trucking Company to identify if Truck
--exist in their stock whether as a Cargo or a Mover (Business Rules #9 - Validation)
Create Procedure sp_Truck_Stock  
(
@License_Plate_No Varchar(10),
@Price Varchar(50),
@Colour Varchar(50),
@Truck_Year INTEGER,
@Make Varchar(50),
@Model Varchar(50),
@Max_load INTEGER,
@Engine_Size Varchar(50),
@Fuel_Type Varchar(50),
@No_of_Wheels Varchar(50),
@Seat_Capacity Varchar(50),
@Max_Clearing_Heights Varchar(50)
)
AS
BEGIN
	
	BEGIN TRANSACTION Truck
		Insert Into Truck(License_Plate_No, Price, Colour, Truck_Year, Make, Model,Max_load, Engine_Size)
		Values
		(@License_Plate_No, @Price, @Colour, @Truck_Year, @Make, @Model,@Max_load, @Engine_Size);
		SELECT @@TRANCOUNT;

		IF (@@ERROR > 0) 
		BEGIN
			SELECT 'Mover License Plate Number does not Exist!'
			ROLLBACK TRANSACTION
			RETURN 1
		END
	COMMIT TRANSACTION

	BEGIN TRANSACTION Cargo
		Insert Into Cargo(License_Plate_No, Fuel_Type, No_of_Wheels)
		Values
		(@License_Plate_No, @Fuel_Type, @No_of_Wheels);
		SELECT @@TRANCOUNT;

		IF (@@ERROR > 0) 
		BEGIN
			SELECT 'Cargo License Plate Number Exist!'
			ROLLBACK TRANSACTION
			RETURN 1
		END
	COMMIT TRANSACTION

	BEGIN TRANSACTION Mover
		Insert Into Mover(License_Plate_No, Seat_Capacity, Max_Clearing_Heights)
		Values
		(@License_Plate_No, @Seat_Capacity, @Max_Clearing_Heights);
		SELECT @@TRANCOUNT;

		IF (@@ERROR > 0)
		BEGIN
			SELECT 'Mover License Plate Number does not Exist!'
			ROLLBACK TRANSACTION
			RETURN 1
		END
	COMMIT TRANSACTION
END


--This Transaction will allow every Bill to be associated with a customer
--Therefore a customer must exit in order to have a bill(Business Rules #9 - Validation)
Create Procedure sp_Validate_Customer
(
@TRN INTEGER, 
@First_Name Varchar(50), 
@Last_Name Varchar(50), 
@DOB Date, 
@Cust_Address Varchar(255),
@Martial_Status Varchar(15),
@Ref_No INTEGER, 
@License_Plate_No Varchar(50), 
@TRN INTEGER, 
@Bill_Date Date, 
@Total_Charges Money
)
AS
BEGIN

	BEGIN TRANSACTION Customer
		Insert Into Customer(TRN, First_Name, Last_Name, DOB, Cust_Address, Martial_Status)
		Values
		(@TRN, @First_Name, @Last_Name, @DOB, @Cust_Address, @Martial_Status);
		SELECT @@TRANCOUNT;

		IF (@@ERROR > 0) 
		BEGIN
			SELECT 'Unexpected Error occurred!'
			ROLLBACK TRANSACTION
			RETURN 1
		END
	COMMIT TRANSACTION

	BEGIN TRANSACTION Bill
		Insert Into Bill(Ref_No, License_Plate_No, TRN, Bill_Date, Total_Charges)
		Values
		(@Ref_No, @License_Plate_No, @TRN, @Bill_Date, @Total_Charges);
		SELECT @@TRANCOUNT;

		IF (@@ERROR > 0) 
		BEGIN
			SELECT 'Cargo License Plate Number Exist!'
			ROLLBACK TRANSACTION
			RETURN 1
		END
	COMMIT TRANSACTION
END

--***************Question 6 - User Defined Function***************

--A User Defined Function that Calculates a 20% end of year bonus for each Employee
--At Jam Trucking Company (Business Rules #1)
CREATE FUNCTION [DBO].udf_Bonus(@Salary Money)
RETURNS MONEY
AS
BEGIN
	DECLARE @amount Money
	SET @amount = @Salary + (@Salary * 0.20)
	RETURN @amount
END

Select *, [DBO].udf_Bonus(Salary) as Bonus from Employee


--A User Defined Function That Calculate  a 15% Discount given to Customers
--With truck rental bill that cost over $15000 (Business Rules #4)
CREATE FUNCTION [DBO].udf_Discount(@Total_Charges Money)
RETURNS MONEY
AS
BEGIN
	DECLARE @amount Money

	IF(@Total_Charges > 15000)
	BEGIN
		SET @amount = @Total_Charges - (@Total_Charges * 0.15)
		RETURN @amount
	END
END

Select *, [DBO].udf_Discount(Total_Charges) as Discounted_Charge from Bill


--A User Defined Function that calculates the Total Sales for Jam Trucking
--Company on a Daily Basis (Business Rules #8)
CREATE FUNCTION [DBO].udf_TotalSales(@Total_Charges Money, @Bill_Date Date)
RETURNS MONEY
AS
BEGIN
	DECLARE @Total Money;
	IF(@Bill_Date = GETDATE())
	BEGIN
		SET @Total = (SELECT COUNT(@Total_Charges) From Bill);
		RETURN @Total
	END
END

Select *, [DBO].udf_TotalSales(Total_Charges, Bill_Date) as Total_Sales from Bill


--A User Defined Function that charges a Customer a penalty for overdue return date
--a penalty of 10 percentage will be added to Customer bill (Business Rules #3)
CREATE FUNCTION [DBO].udf_Penalty(@TRN INTEGER, @Date_Returned Date, @Due_Date Date)
RETURNS MONEY
AS
BEGIN
	DECLARE @penalty MONEY, @amt MONEY
	Select @amt = Total_Charges FROM Bill where TRN = @TRN

	IF(@Due_Date <> @Date_Returned)
	BEGIN
		SET @penalty = @amt - (@Amt * 0.10)
		RETURN @penalty
	END
END

Select *, [DBO].udf_Penalty(Issue.TRN, Issue.Date_Returned, Issue.Due_Date) as Penalty from Bill;

--triggers
CREATE TRIGGER CustomerTRN
ON Customer INSTEAD OF INSERT
AS
SELECT * FROM inserted

Insert Into Customer(TRN, First_Name, Last_Name, DOB, Cust_Address, Martial_Status)
Values
();
create database CursorTesting

use CursorTesting

create table Consumption (
FuelId int identity(1,1) primary key,
FuelName nvarchar(30),
Liter decimal(10,2)
);

INSERT INTO Consumption (FuelName, Liter)
VALUES
('Diesel', 45.50),
('Petrol', 30.00),
('Octane', 25.75),
('Premium Diesel', 60.20),
('Regular Petrol', 40.00),
('Super Diesel', 55.10),
('Bio Diesel', 33.30),
('Gasoline', 28.90),
('E10 Petrol', 22.50),
('E20 Petrol', 35.75),
('High Octane', 48.00),
('Low Sulfur Diesel', 50.25),
('Marine Diesel', 70.00),
('Aviation Fuel', 85.60),
('Kerosene', 15.40),
('Heating Oil', 65.30),
('Industrial Diesel', 90.10),
('Truck Diesel', 75.55),
('Car Petrol', 38.80),
('Motorbike Petrol', 18.25);

select * from Consumption


--select 1+2

DECLARE @FuelID INT
DECLARE @FuelName NVARCHAR(50)
DECLARE @Liter DECIMAL(10,2)

DECLARE fuel_cursor CURSOR FOR
SELECT FuelID, FuelName, Liter
FROM Consumption

OPEN fuel_cursor

FETCH NEXT FROM fuel_cursor INTO @FuelID, @FuelName, @Liter

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Fuel: ' + @FuelName + ', Liter: ' + CAST(@Liter AS NVARCHAR(10))

    IF @Liter > 50
        UPDATE Consumption
        SET Liter = @Liter * 1.10
        WHERE FuelID = @FuelID
    ELSE
        UPDATE Consumption
        SET Liter = @Liter * 1.05
        WHERE FuelID = @FuelID

    FETCH NEXT FROM fuel_cursor INTO @FuelID, @FuelName, @Liter
END

CLOSE fuel_cursor
DEALLOCATE fuel_cursor


select * from Consumption
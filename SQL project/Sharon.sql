SELECT COUNT(*)FROM Model;
SELECT COUNT(*)FROM Paint;
SELECT COUNT(*)FROM Address;
SELECT COUNT(*)FROM Bicycle;
SELECT COUNT(*)FROM Customer;
SELECT COUNT(*)FROM Store;
SELECT COUNT(*)FROM Part;
SELECT COUNT(*)FROM Employee;
SELECT COUNT(*)FROM Component;
SELECT COUNT(*)FROM Purchase;

-- Part 2
-- 1. The average purchase list price and sale price by state
 SELECT
	   a.state,
	   AVG(p.listprice) AS Avg_list_price,
       AVG(p.saleprice) AS Avg_sale_price
    FROM Purchase p
    JOIN Store s ON p.storeID = s.storeID
    JOIN Address a ON s.addressID = a.addressID
    JOIN Customer c ON p.customerID = c.customerID
    GROUP BY a.state WITH ROLLUP
    ORDER BY Avg_list_price desc;

-- 2. The average list price and sale prices by store
    SELECT
        s.storename,
        AVG(p.listprice) AS Avg_list_price,
        AVG(p.saleprice) AS Avg_sale_price
    FROM Purchase p
    JOIN Store s ON p.storeID = s.storeID
    GROUP BY s.storename
    ORDER BY Avg_list_price desc;
    
-- 2a. The average purchase list price and sales price by store 
WITH State_Avg AS (
    SELECT AVG(listprice) AS TN_Avg_listprice
    FROM Purchase p
    JOIN Store s ON p.StoreID = s.StoreID
    JOIN Address a ON s.AddressID = a.AddressID
    WHERE a.state = 'TN'
)
SELECT s.storeID,
       s.storename, 
       AVG(p.listprice) AS Avg_ListPrice,
       AVG(p.saleprice) AS Avg_SalePrice
FROM Purchase p
JOIN Store s ON p.storeID = s.storeID
JOIN Address a ON s.addressID = a.addressID
WHERE a.state = 'TN'
GROUP BY s.storeID, s.storename
ORDER BY Avg_listprice ASC;


-- TN State Average 
SELECT AVG(listprice) AS TN_Avg_listprice
FROM Purchase p
JOIN Store s ON p.storeID = s.storeID
JOIN Address a ON s.addressID = a.addressID
WHERE a.state = 'TN';

-- TN stores above state average
SELECT a.state,
       s.storename,
       COUNT(s.storename) AS num_of_stores,
	   AVG(listprice) AS Average_ListPrice
FROM Purchase p
JOIN Store s ON p.storeID = s.storeID
JOIN Address a ON s.addressID = a.addressID
WHERE a.state = 'TN'
GROUP BY a.state, s.storename
HAVING AVG(listprice) > (
    SELECT AVG(listprice) 
    FROM Purchase p
    JOIN Store s ON p.storeID = s.storeID
    JOIN Address a ON s.addressID = a.addressID
    WHERE state = 'TN'
)
ORDER BY a.state;
-- 19 stores are above average

-- TN stores below state average
 SELECT 
       a.state,
       s.storename,
       COUNT(s.storename) AS num_of_stores,
       AVG(listprice) AS Average_ListPrice
FROM Purchase p
JOIN Store s ON p.storeID = s.storeID
JOIN Address a ON s.addressID = a.addressID
WHERE a.state = 'TN'
GROUP BY a.state, s.storename
HAVING AVG(listprice) <= (
    SELECT AVG(listprice) 
    FROM Purchase p
	JOIN Store s ON p.storeID = s.storeID
    JOIN Address a ON s.addressID = a.addressID
    WHERE state = 'TN'
)
ORDER BY a.state;
-- 18 stores are below state average

-- 3. The most popular and least popular paint colors
-- The most popular
SELECT pt.colorname, 
       COUNT(b.PaintID) AS PaintCount,
	   SUM(p.saleprice) AS Sale_price
FROM Paint pt
JOIN Bicycle b ON pt.paintID = b.paintID
JOIN Purchase p ON b.serialnumber = p.BicycleSerialNumber
GROUP BY pt.colorname with rollup
ORDER BY PaintCount DESC; 
-- The most popular paint color is Arctic White 

-- The least popular paint color
SELECT pt.colorname, 
       COUNT(b.PaintID) AS PaintCount,
	   SUM(p.saleprice) AS Sale_price
FROM Paint pt
JOIN Bicycle b ON pt.paintID = b.paintID
JOIN Purchase p ON b.serialnumber = p.BicycleSerialNumber
GROUP BY pt.colorname with rollup
ORDER BY PaintCount ASC;
-- The least popular paint color is Candy Stripe

-- 3ai. Store that sells the most of the most popular paint color 
SELECT s.StoreName, 
       COUNT(pt.PaintID) AS paintcount,
       SUM(p.saleprice) AS sumsaleprice
FROM Store s
JOIN Purchase p ON s.StoreID = p.StoreID
JOIN Bicycle b ON p.BicycleSerialNumber = b.SerialNumber
JOIN Paint pt ON b.PaintID = pt.PaintID
WHERE colorname = 'Arctic White'
GROUP BY s.storename
ORDER BY sumsaleprice DESC;
-- Walk-in store sells the most for the most popular color paint


-- 3aii. Store that sells the least of the most popular paint color
SELECT s.storename, 
       COUNT(pt.PaintID) AS paintcount,
       SUM(p.saleprice) AS sumsaleprice
FROM Store s
JOIN Purchase p ON s.storeID = p.storeID
JOIN Bicycle b ON p.bicycleserialnumber = b.serialnumber
JOIN Paint pt ON b.paintID = pt.paintID
WHERE pt.colorname = 'Arctic White'
GROUP BY s.storename
ORDER BY sumsaleprice ASC;
-- The Pedal House store sells the least for the most popular color paint


-- 3bi. Store that sells the most popular of the least popular paint color
SELECT s.storename, 
       COUNT(pt.paintID) AS paintcount,
       SUM(p.saleprice) AS sumsaleprice
FROM Store s
JOIN Purchase p ON s.storeID = p.storeID
JOIN Bicycle b ON p.bicycleserialnumber = b.serialnumber
JOIN Paint pt ON b.paintID = pt.paintID
WHERE pt.colorname = 'Candy Stripe'
GROUP BY s.storename
ORDER BY sumsaleprice DESC;
-- Walk-In store sells the most for the least popular color paint

-- bii. Store that sells the least of the least popular paint color
SELECT s.storename, 
       pt.colorname, 
       SUM(p.saleprice) AS sumsaleprice
FROM Store s
JOIN Purchase p ON s.storeID = p.storeID
JOIN Bicycle b ON p.bicycleserialnumber = b.serialnumber
JOIN Paint pt ON b.paintID = pt.paintID
WHERE pt.colorname = 'Candy Stripe'
GROUP BY s.storename,pt.colorname
ORDER BY sumsaleprice ASC;
-- The stores that sell least for the least popular color paint are Rainbow Cycles, Action Bike Shop, Pedal Shop

-- 4. The most popular part manufacturer
SELECT pr.manufacturername,
       pr.partname, 
       COUNT(c.partID) AS CountPart,
       COUNT(pr.manufacturerName) AS Manufacturer_counts
FROM Part pr
JOIN Component c ON c.partID = pr.partID
GROUP BY pr.manufacturername,pr.partname WITH ROLLUP
ORDER BY countpart DESC;
-- The most popular part manufacturer is Shimano(USA) with part name 'Front Derailleur' is the most popular

-- 4a. States that sell the most of these parts
SELECT a.State,
       pr.partname, 
	   COUNT(c.PartID) AS Count,
       SUM(p.saleprice) AS SumSales
FROM Part pr
JOIN Component c ON c.partID = pr.partID
JOIN Bicycle b ON c.bicycleserialnumber = b.serialnumber
JOIN Purchase p ON b.serialnumber = p.bicycleserialnumber
JOIN Store s ON p.storeID = s.storeID
JOIN Address a ON s.addressID = a.addressID
WHERE pr.manufacturername = 'Shimano (USA)'
AND pr.partName = 'Front Derailleur'
GROUP BY a.state,pr.partname WITH ROLLUP
ORDER BY SumSales DESC;
-- CA state sells the most of the parts 'Front Derailluer'

-- 4b. The states that sell the least of these parts
SELECT a.state, 
       pr.partname,
       SUM(p.saleprice) AS SumSales,
       COUNT(c.PartID) AS Count
FROM Part pr
JOIN Component c ON c.partID = pr.partID
JOIN Bicycle b ON c.bicycleserialnumber = b.serialnumber
JOIN Purchase p ON b.serialnumber = p.bicycleserialnumber
JOIN Store s ON p.storeID = s.storeID
JOIN Address a ON s.addressID = a.addressID
WHERE pr.manufacturername = 'Shimano (USA)'
AND pr.partName = 'Front Derailleur'
GROUP BY a.state, pr.partname , pr.manufacturername WITH ROLLUP
ORDER BY SumSales ASC;
-- DE state sells the least of the popular parts 'Front Derailleur'

-- 4c. The store that sells the most of the most popular part ignoring “Walk-In” and “Direct Sales” 
SELECT pr.partname,
       s.storename,
       SUM(c.Quantity) AS Count,
       SUM(p.saleprice) AS SumSales
FROM Part pr
JOIN Component c ON c.partID = pr.partID
JOIN Bicycle b ON c.bicycleserialnumber = b.serialnumber
JOIN Purchase p ON b.serialnumber = p.bicycleserialnumber
JOIN Store s ON s.storeID = p.storeID
WHERE pr.partname = 'Front Derailleur' 
GROUP BY pr.partname,s.storename
ORDER BY Count DESC;

-- store that sells the most of the popular part 
SELECT s.storename, 
       SUM(c.Quantity) AS Count,
       SUM(p.saleprice)
FROM Part pr
JOIN Component c ON c.partID = pr.partID
JOIN Bicycle b ON c.bicycleserialnumber = b.serialnumber
JOIN Purchase p ON b.serialnumber = p.bicycleserialnumber
JOIN Store s ON s.storeID = p.storeID
WHERE pr.partname = 'Front Derailleur' 
AND s.storename != 'Walk-In' 
AND s.storename != 'Direct Sales'
GROUP BY s.storename
ORDER BY Count DESC;
-- The stores that sells the most excluding Walk-In and Direct Sales stores is Budget Pro Bicycles



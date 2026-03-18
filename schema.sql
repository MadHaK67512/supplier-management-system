-- ============================================================
-- Supplier Management System - PostgreSQL Schema
-- Converted from SQL Server syntax for deployment on Neon.tech
-- Run this entire file in Neon's SQL Editor after creating the DB
-- ============================================================

-- ==================== TABLE CREATION ====================

-- Create Brand Table
CREATE TABLE Brand (
    bName VARCHAR(100),
    bCity VARCHAR(100),
    country VARCHAR(100),
    PRIMARY KEY (bName, bCity)
);

-- Create Supplier Table (SERIAL replaces SQL Server IDENTITY)
CREATE TABLE Supplier (
    sID SERIAL PRIMARY KEY,
    sName VARCHAR(100),
    sEmail VARCHAR(100),
    sTel VARCHAR(20),
    sSalary DECIMAL(10, 2)
);

-- Create Customer Table
CREATE TABLE Customer (
    cID SERIAL PRIMARY KEY,
    cName VARCHAR(100),
    cEmail VARCHAR(100),
    cAddress VARCHAR(255),
    sID INT,
    FOREIGN KEY (sID) REFERENCES Supplier(sID)
);

-- Create BrandStock Table
CREATE TABLE BrandStock (
    bName VARCHAR(100),
    bCity VARCHAR(100),
    iTem VARCHAR(100),
    category VARCHAR(100),
    Price DECIMAL(10, 2),
    Quantity INT,
    PRIMARY KEY (bName, bCity, iTem),
    FOREIGN KEY (bName, bCity) REFERENCES Brand(bName, bCity)
);

-- Create SupplierStock Table
CREATE TABLE SupplierStock (
    sID INT,
    bName VARCHAR(100),
    bCity VARCHAR(100),
    iTem VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (sID, bName, bCity, iTem),
    FOREIGN KEY (sID) REFERENCES Supplier(sID),
    FOREIGN KEY (bName, bCity, iTem) REFERENCES BrandStock(bName, bCity, iTem)
);

-- Create Purchasing Table
CREATE TABLE Purchasing (
    cID INT,
    bName VARCHAR(100),
    bCity VARCHAR(100),
    iTem VARCHAR(100),
    Quantity INT,
    pStatus VARCHAR(20) DEFAULT 'pending',
    PRIMARY KEY (cID, bName, bCity, iTem),
    FOREIGN KEY (cID) REFERENCES Customer(cID),
    FOREIGN KEY (bName, bCity, iTem) REFERENCES BrandStock(bName, bCity, iTem)
);

-- Create LinkedBrand Table
CREATE TABLE LinkedBrand (
    sID INT,
    bName VARCHAR(100),
    bCity VARCHAR(100),
    PRIMARY KEY (sID, bName, bCity),
    FOREIGN KEY (sID) REFERENCES Supplier(sID),
    FOREIGN KEY (bName, bCity) REFERENCES Brand(bName, bCity)
);

-- Create Manager Table
CREATE TABLE Manager (
    mID SERIAL PRIMARY KEY,
    mName VARCHAR(100),
    mEmail VARCHAR(100),
    mTel VARCHAR(20),
    sID INT,
    FOREIGN KEY (sID) REFERENCES Supplier(sID)
);


-- ==================== DATA INSERTION ====================

-- Insert data into Brand table
INSERT INTO Brand (bName, bCity, country) VALUES
    ('Nestle', 'Lahore', 'Pakistan'),
    ('Unilever', 'Karachi', 'Pakistan'),
    ('Engro', 'Islamabad', 'Pakistan'),
    ('Shan Foods', 'Karachi', 'Pakistan'),
    ('National Foods', 'Karachi', 'Pakistan'),
    ('Sufi', 'Lahore', 'Pakistan'),
    ('Mitchell''s', 'Sahiwal', 'Pakistan'),
    ('Gourmet', 'Lahore', 'Pakistan'),
    ('Shezan', 'Lahore', 'Pakistan'),
    ('K&N''s', 'Karachi', 'Pakistan'),
    ('Olper''s', 'Karachi', 'Pakistan'),
    ('Dawn Bread', 'Karachi', 'Pakistan'),
    ('Nurpur', 'Sargodha', 'Pakistan'),
    ('Dalda', 'Karachi', 'Pakistan'),
    ('Bulls Eye', 'Faisalabad', 'Pakistan');

-- Insert data into Supplier table
INSERT INTO Supplier (sName, sEmail, sTel, sSalary) VALUES
    ('Prime Supplies', 'info@prime.com', '+41 21 924 1111', 100000.00),
    ('Universal Distributors', 'info@universal.com', '+44 (0) 20 7822 5252', 120000.00),
    ('Global Traders', 'info@globaltraders.com', '+1 513-983-1100', 110000.00),
    ('Fresh Foods', 'info@freshfoods.com', '+1 404-676-2121', 115000.00),
    ('HealthCare Supplies', 'info@healthcare.com', '+1 914-253-3055', 105000.00),
    ('Agro Supplies', 'info@agro.com', '+1 732-524-0400', 125000.00),
    ('Quality Goods', 'info@qualitygoods.com', '+1 800-627-7852', 130000.00),
    ('Household Supplies', 'info@household.com', '+1 412-456-5700', 115000.00),
    ('Food Distributors', 'info@fooddist.com', '+1 847-943-4000', 110000.00),
    ('Daily Needs', 'info@dailyneeds.com', '+1 269-961-2800', 100000.00),
    ('Grocery World', 'info@groceryworld.com', '+33 (0)1 44 35 20 20', 120000.00),
    ('Organic Foods', 'info@organicfoods.com', '+1 800-245-0577', 105000.00),
    ('Water Supplies', 'info@watersupplies.com', '+41 21 924 1111', 115000.00),
    ('Sweet Treats', 'info@sweettreats.com', '+1 732-764-9300', 110000.00),
    ('Packaging World', 'info@packaging.com', '+27 11 994 5414', 105000.00);

-- Insert data into Customer table
INSERT INTO Customer (cName, cEmail, cAddress, sID) VALUES
    ('Khan Supermarket', 'khan_super@example.com', '123 Main St, Karachi', 1),
    ('Ali Mart', 'alimart@example.com', '456 Market St, Lahore', 2),
    ('Raza Grocers', 'raza_grocers@example.com', '789 High St, Islamabad', 3),
    ('Ahmed Fresh Foods', 'ahmed_fresh@example.com', '321 Garden Rd, Faisalabad', 4),
    ('Hussain Super Mart', 'hussain_super@example.com', '987 Park Ave, Rawalpindi', 5),
    ('Mega Bazaar', 'mega_bazaar@example.com', '654 Center St, Multan', 6),
    ('Family Mart', 'familymart@example.com', '159 Oak St, Peshawar', 7),
    ('Super Savers', 'supersavers@example.com', '852 Elm St, Quetta', 8),
    ('City Supermarket', 'city_super@example.com', '741 Broadway St, Lahore', 9),
    ('Food Express', 'foodexpress@example.com', '369 Maple St, Karachi', 10),
    ('Freshland', 'freshland@example.com', '258 Pine St, Islamabad', 11),
    ('Prime Pantry', 'primepantry@example.com', '963 Cherry St, Lahore', 12),
    ('Gourmet Grocery', 'gourmetgrocery@example.com', '147 Walnut St, Karachi', 13),
    ('Corner Convenience', 'cornerconvenience@example.com', '753 Cedar St, Lahore', 14),
    ('Local Market', 'localmarket@example.com', '369 Oak St, Islamabad', 15);

-- Insert data into BrandStock table
INSERT INTO BrandStock (bName, bCity, iTem, category, Price, Quantity) VALUES
    ('Nestle', 'Lahore', 'Milkpak', 'Dairy', 80.00, 150),
    ('Nestle', 'Lahore', 'Maggi Noodles', 'Food', 40.00, 200),
    ('Unilever', 'Karachi', 'Lifebuoy Soap', 'Personal Care', 50.00, 100),
    ('Unilever', 'Karachi', 'Lipton Yellow Label Tea', 'Beverage', 30.00, 300),
    ('Engro', 'Islamabad', 'Olper''s Milk', 'Dairy', 70.00, 200),
    ('Engro', 'Islamabad', 'Engro Fertilizer', 'Agriculture', 200.00, 50),
    ('Shan Foods', 'Karachi', 'Shan Masala', 'Food', 20.00, 500),
    ('National Foods', 'Karachi', 'National Ketchup', 'Food', 60.00, 150),
    ('Sufi', 'Lahore', 'Sufi Sunflower Oil', 'Cooking Oil', 120.00, 100),
    ('Sufi', 'Lahore', 'Sufi Basmati Rice', 'Rice', 100.00, 80),
    ('Mitchell''s', 'Sahiwal', 'Mitchell''s Jam', 'Food', 150.00, 50),
    ('Gourmet', 'Lahore', 'Gourmet Sweets', 'Confectionery', 200.00, 120),
    ('Shezan', 'Lahore', 'Shezan Mango Juice', 'Beverage', 90.00, 200),
    ('K&N''s', 'Karachi', 'K&N''s Nuggets', 'Frozen Food', 250.00, 70),
    ('Olper''s', 'Karachi', 'Olper''s Cream', 'Dairy', 150.00, 80);

-- Insert data into SupplierStock table
INSERT INTO SupplierStock (sID, bName, bCity, iTem, Quantity) VALUES
    (1, 'Nestle', 'Lahore', 'Milkpak', 50),
    (1, 'Unilever', 'Karachi', 'Lifebuoy Soap', 40),
    (2, 'Nestle', 'Lahore', 'Maggi Noodles', 100),
    (2, 'Engro', 'Islamabad', 'Olper''s Milk', 60),
    (3, 'Shan Foods', 'Karachi', 'Shan Masala', 200),
    (3, 'Sufi', 'Lahore', 'Sufi Sunflower Oil', 50),
    (4, 'Gourmet', 'Lahore', 'Gourmet Sweets', 70),
    (4, 'Shezan', 'Lahore', 'Shezan Mango Juice', 90),
    (5, 'Mitchell''s', 'Sahiwal', 'Mitchell''s Jam', 30),
    (5, 'K&N''s', 'Karachi', 'K&N''s Nuggets', 50),
    (6, 'National Foods', 'Karachi', 'National Ketchup', 80),
    (6, 'Olper''s', 'Karachi', 'Olper''s Cream', 40),
    (7, 'Sufi', 'Lahore', 'Sufi Basmati Rice', 60),
    (7, 'Engro', 'Islamabad', 'Engro Fertilizer', 20),
    (8, 'Gourmet', 'Lahore', 'Gourmet Sweets', 50),
    (8, 'Shezan', 'Lahore', 'Shezan Mango Juice', 70),
    (9, 'Mitchell''s', 'Sahiwal', 'Mitchell''s Jam', 40),
    (9, 'K&N''s', 'Karachi', 'K&N''s Nuggets', 30),
    (10, 'National Foods', 'Karachi', 'National Ketchup', 90),
    (10, 'Olper''s', 'Karachi', 'Olper''s Cream', 30);

-- Insert data into Purchasing table
INSERT INTO Purchasing (cID, bName, bCity, iTem, Quantity, pStatus) VALUES
    (1, 'Nestle', 'Lahore', 'Milkpak', 10, 'completed'),
    (2, 'Unilever', 'Karachi', 'Lifebuoy Soap', 15, 'pending'),
    (3, 'Shan Foods', 'Karachi', 'Shan Masala', 20, 'completed'),
    (4, 'Engro', 'Islamabad', 'Olper''s Milk', 25, 'pending'),
    (5, 'Sufi', 'Lahore', 'Sufi Sunflower Oil', 30, 'completed'),
    (6, 'Gourmet', 'Lahore', 'Gourmet Sweets', 12, 'pending'),
    (7, 'Shezan', 'Lahore', 'Shezan Mango Juice', 18, 'completed'),
    (8, 'Mitchell''s', 'Sahiwal', 'Mitchell''s Jam', 8, 'pending'),
    (9, 'K&N''s', 'Karachi', 'K&N''s Nuggets', 5, 'completed'),
    (10, 'National Foods', 'Karachi', 'National Ketchup', 14, 'pending'),
    (11, 'Nestle', 'Lahore', 'Maggi Noodles', 22, 'completed'),
    (12, 'Sufi', 'Lahore', 'Sufi Basmati Rice', 9, 'pending'),
    (13, 'Engro', 'Islamabad', 'Engro Fertilizer', 4, 'completed'),
    (14, 'Gourmet', 'Lahore', 'Gourmet Sweets', 6, 'pending'),
    (15, 'Shezan', 'Lahore', 'Shezan Mango Juice', 7, 'completed');

-- Insert data into LinkedBrand table
INSERT INTO LinkedBrand (sID, bName, bCity) VALUES
    (1, 'Nestle', 'Lahore'),
    (2, 'Unilever', 'Karachi'),
    (3, 'Engro', 'Islamabad'),
    (4, 'Shan Foods', 'Karachi'),
    (5, 'National Foods', 'Karachi'),
    (6, 'Sufi', 'Lahore'),
    (7, 'Mitchell''s', 'Sahiwal'),
    (8, 'Gourmet', 'Lahore'),
    (9, 'Shezan', 'Lahore'),
    (10, 'K&N''s', 'Karachi'),
    (11, 'Olper''s', 'Karachi'),
    (12, 'Dawn Bread', 'Karachi'),
    (13, 'Nurpur', 'Sargodha'),
    (14, 'Dalda', 'Karachi'),
    (15, 'Bulls Eye', 'Faisalabad');

-- Insert data into Manager table
INSERT INTO Manager (mName, mEmail, mTel, sID) VALUES
    ('John Doe', 'john.doe@example.com', '123-456-7890', 1),
    ('Alice Smith', 'alice.smith@example.com', '987-654-3210', 2),
    ('Robert Johnson', 'robert.johnson@example.com', '555-123-4567', 3),
    ('Emily Brown', 'emily.brown@example.com', '333-999-8888', 4),
    ('Michael Wilson', 'michael.wilson@example.com', '777-555-1234', 5),
    ('Jessica Lee', 'jessica.lee@example.com', '111-222-3333', 6),
    ('David Martinez', 'david.martinez@example.com', '444-777-8888', 7),
    ('Jennifer Taylor', 'jennifer.taylor@example.com', '666-333-1111', 8),
    ('Matthew Thomas', 'matthew.thomas@example.com', '222-444-5555', 9),
    ('Sarah Garcia', 'sarah.garcia@example.com', '888-111-2222', 10),
    ('William Rodriguez', 'william.rodriguez@example.com', '999-888-7777', 11),
    ('Linda Martinez', 'linda.martinez@example.com', '777-444-3333', 12),
    ('Daniel Hernandez', 'daniel.hernandez@example.com', '555-111-2222', 13),
    ('Karen Lopez', 'karen.lopez@example.com', '333-222-1111', 14),
    ('Michael Perez', 'michael.perez@example.com', '222-333-4444', 15);


-- ==================== VIEWS ====================

-- View: brandDetail
CREATE VIEW brandDetail AS
SELECT bName, bCity, country FROM Brand;

-- View: linkedBrandView
CREATE VIEW linkedBrandView AS
SELECT sID, bName, bCity FROM LinkedBrand;

-- View: BrandStockView
CREATE VIEW BrandStockView AS
SELECT bName, bCity, iTem, category, Price, Quantity
FROM BrandStock;

-- View: Supplier_Stock_Info
CREATE VIEW Supplier_Stock_Info AS
SELECT s.sID AS "SID", s.sName, s.sEmail, s.sTel, ss.bName, ss.bCity, ss.iTem, ss.Quantity
FROM Supplier s
INNER JOIN SupplierStock ss ON s.sID = ss.sID;

-- View: Purchase_Details
CREATE VIEW Purchase_Details AS
SELECT p.cID, c.cName, c.cEmail, c.cAddress, p.bName, p.bCity, p.iTem, p.Quantity
FROM Purchasing p
INNER JOIN Customer c ON p.cID = c.cID;

-- View: purchasingView
CREATE VIEW purchasingView AS
SELECT cu.cName, pr.bName, pr.bCity, pr.iTem, bs.category, bs.price, pr.Quantity, pr.pstatus
FROM Purchasing pr
JOIN Customer cu ON pr.cID = cu.cID
JOIN BrandStock bs ON pr.iTem = bs.iTem;

-- View: customerView
CREATE VIEW customerView AS
SELECT cid, cName, cEmail, cAddress, sID FROM Customer;

-- View: Linked_Brands_For_Suppliers
CREATE VIEW Linked_Brands_For_Suppliers AS
SELECT lb.sID, s.sName, s.sEmail, lb.bName, lb.bCity
FROM LinkedBrand lb
INNER JOIN Supplier s ON lb.sID = s.sID;

-- View: Suppliers_In_Company
CREATE VIEW Suppliers_In_Company AS
SELECT sID, sName, sEmail, sTel FROM Supplier;

-- View: Supplier_Customer_Info
CREATE VIEW Supplier_Customer_Info AS
SELECT c.cID, c.cName, c.cEmail, c.cAddress, s.sID
FROM Supplier s
INNER JOIN Customer c ON s.sID = c.sID;

-- View: Pending_Purchasing
CREATE VIEW Pending_Purchasing AS
SELECT p.cID, c.cName AS Customer_Name, p.bName, p.bCity, p.iTem, p.Quantity,
       s.sID, s.sName AS Supplier_Name, s.sEmail AS Supplier_Email
FROM Purchasing p
JOIN Customer c ON p.cID = c.cID
JOIN Supplier s ON c.sID = s.sID
WHERE p.pStatus = 'pending';

-- View: Completed_Purchasing
CREATE VIEW Completed_Purchasing AS
SELECT p.cID, c.cName AS Customer_Name, p.bName, p.bCity, p.iTem, p.Quantity,
       s.sID, s.sName AS Supplier_Name, s.sEmail AS Supplier_Email
FROM Purchasing p
JOIN Customer c ON p.cID = c.cID
JOIN Supplier s ON c.sID = s.sID
WHERE p.pStatus = 'completed';


-- ==================== FUNCTIONS (replaces SQL Server Stored Procedures) ====================

-- Function: GetSupplierStockInfo
CREATE OR REPLACE FUNCTION GetSupplierStockInfo(p_sID INT)
RETURNS TABLE (
    "SID" INT, sName VARCHAR, sEmail VARCHAR, sTel VARCHAR,
    bName VARCHAR, bCity VARCHAR, iTem VARCHAR, Quantity INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM Supplier_Stock_Info WHERE "SID" = p_sID;
END;
$$ LANGUAGE plpgsql;

-- Function: DeleteSupplierStock
CREATE OR REPLACE FUNCTION DeleteSupplierStock(
    p_sID INT, p_bName VARCHAR, p_bCity VARCHAR, p_iTem VARCHAR
) RETURNS VOID AS $$
BEGIN
    DELETE FROM SupplierStock
    WHERE sID = p_sID AND bName = p_bName AND bCity = p_bCity AND iTem = p_iTem;
END;
$$ LANGUAGE plpgsql;

-- Function: DeletePurchasingByCID
CREATE OR REPLACE FUNCTION DeletePurchasingByCID(p_cID INT)
RETURNS VOID AS $$
BEGIN
    DELETE FROM Purchasing WHERE cID = p_cID;
END;
$$ LANGUAGE plpgsql;

-- Function: UpdatePurchasingStatusToCompleted
CREATE OR REPLACE FUNCTION UpdatePurchasingStatusToCompleted(p_cID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE Purchasing SET pStatus = 'completed' WHERE cID = p_cID;
END;
$$ LANGUAGE plpgsql;

-- Function: GetCustomerNamesBySupplierID
CREATE OR REPLACE FUNCTION GetCustomerNamesBySupplierID(p_sID INT)
RETURNS TABLE (cName VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT cv.cName FROM customerView cv WHERE cv.sID = p_sID;
END;
$$ LANGUAGE plpgsql;

-- Function: GetDistinctCitiesByBrandName
CREATE OR REPLACE FUNCTION GetDistinctCitiesByBrandName(p_brandName VARCHAR)
RETURNS TABLE (bCity VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT DISTINCT ss.bCity FROM SupplierStock ss
    WHERE ss.bName ILIKE '%' || p_brandName || '%';
END;
$$ LANGUAGE plpgsql;

-- Function: GetSupplierStockByBrandName
CREATE OR REPLACE FUNCTION GetSupplierStockByBrandName(p_brandName VARCHAR)
RETURNS TABLE (
    sID INT, bName VARCHAR, bCity VARCHAR, iTem VARCHAR, Quantity INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT ss.sID, ss.bName, ss.bCity, ss.iTem, ss.Quantity
    FROM SupplierStock ss WHERE ss.bName ILIKE '%' || p_brandName || '%';
END;
$$ LANGUAGE plpgsql;

-- Function: GetBrandStockByItemName
CREATE OR REPLACE FUNCTION GetBrandStockByItemName(p_itemName VARCHAR)
RETURNS TABLE (
    bName VARCHAR, bCity VARCHAR, iTem VARCHAR,
    category VARCHAR, Price DECIMAL, Quantity INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT bs.bName, bs.bCity, bs.iTem, bs.category, bs.Price, bs.Quantity
    FROM BrandStock bs WHERE bs.iTem ILIKE '%' || p_itemName || '%';
END;
$$ LANGUAGE plpgsql;


-- ==================== VERIFICATION QUERIES ====================
-- Run these after setup to confirm data loaded correctly:
-- SELECT * FROM brand;             -- 15 rows expected
-- SELECT * FROM brandDetail;       -- 15 rows expected
-- SELECT * FROM customerView;      -- 15 rows expected
-- SELECT * FROM purchasingView;    -- 15 rows expected
-- SELECT * FROM Supplier_Stock_Info; -- 20 rows expected
-- SELECT * FROM linkedBrandView;   -- 15 rows expected

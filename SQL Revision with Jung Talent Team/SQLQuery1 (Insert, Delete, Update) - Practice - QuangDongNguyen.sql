--------------------------------------------
-- Practice Zone
--------------------------------------------
--INSERT, UPDATE, CREATE
drop TABLE nhanvien;
CREATE TABLE nhanvien (
ID INT,
Ten VARCHAR(255),
Tuoi INT,
Diachi VARCHAR(255),
Luong FLOAT)

INSERT INTO nhanvien VALUES (1, 'Thanh', 24, 'Haiphong', 2000.00);
INSERT INTO nhanvien (ID, Ten, Tuoi, Diachi, Luong) VALUES (2, 'Loan', 26, 'Hanoi', 1500.00);
INSERT INTO nhanvien VALUES (3, 'Nga', 24, 'Hanami', 2000.00);
INSERT INTO nhanvien VALUES (4, 'Manh', 29, 'Hue', 6500.00);
INSERT INTO nhanvien VALUES (5, 'Huy', 28, 'Hatinh', 8500.00);
INSERT INTO nhanvien VALUES (6, 'Cao', 23, 'HCM', 4500.00);


/*
-- DELETE Statement --
SELECT * FROM nhanvien;
delete nhanvien WHERE nhanvien.Diachi NOT IN ('Hanoi', 'HCM'); --delete where Diachi not in Hanoi and HCM
SELECT * FROM nhanvien;



-- UPDATE Statement --
--Example 1: Update every staff salaries to 5000.
UPDATE nhanvien SET nhanvien.Luong = 5000;
UPDATE nhanvien SET nhanvien.Diachi = 'Hanoi' WHERE nhanvien.Tuoi < 26;
SELECT * FROM nhanvien;
*/



------------------------------------
-- HomeWork:
------------------------------------

-------------------------------------
/*
Question 1: Use different method than UPDATE to update 2 staff members' salaries that have the highest and lowest id in the nhanvien table
into salaries from the table luongmoi
*/
-------------------------------------
--method 1:
drop TABLE luongmoi;

CREATE TABLE luongmoi (
ID INT,
Luong FLOAT);

INSERT INTO luongmoi(ID,Luong) VALUES (1, 2500.00); 
INSERT INTO luongmoi(ID,Luong) VALUES (2, 1900.00); 
INSERT INTO luongmoi(ID,Luong) VALUES (3, 3000.00); 
INSERT INTO luongmoi(ID,Luong) VALUES (4, 7100.00); 
INSERT INTO luongmoi(ID,Luong) VALUES (5, 9500.00); 
INSERT INTO luongmoi(ID, Luong) VALUES(6, 5500.00);

SELECT * FROM nhanvien;
SELECT * FROM luongmoi;
/*
UPDATE nhanvien 
SET nhanvien.Luong = luongmoi.luong 
FROM luongmoi 
WHERE nhanvien.id = luongmoi.id;

SELECT * FROM nhanvien;
*/

--method 2:
UPDATE nhanvien
SET nhanvien.Luong = luongmoi.Luong
FROM luongmoi
WHERE nhanvien.ID = luongmoi.ID AND 
(nhanvien.ID = (SELECT MAX(id) FROM nhanvien) OR nhanvien.ID = (SELECT MIN(id) FROM nhanvien))

SELECT * FROM nhanvien;



-------------------------------------
/*
Question 2: Use different method than UPDATE to update 2 staff members' salaries that have the highest and lowest salaries in the nhanvien table
to salaries from the table luongmoi
*/
-------------------------------------
SELECT * FROM nhanvien;
SELECT * FROM luongmoi;
UPDATE nhanvien
SET nhanvien.Luong = luongmoi.Luong
FROM nhanvien INNER JOIN luongmoi ON nhanvien.ID = luongmoi.ID
WHERE (nhanvien.Luong = (SELECT MAX(luong) FROM nhanvien) OR nhanvien.Luong = (SELECT MIN(nhanvien.Luong) FROM nhanvien));

SELECT * FROM nhanvien;
SELECT * FROM luongmoi;
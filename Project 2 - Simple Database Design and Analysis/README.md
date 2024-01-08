performed by: Quang Dong Nguyen  
provided by: Western Sydney University


# Question 1 - Basic database design and queries  
A small shop wants to create a simple database to keep track of its merchandise prices, buyers and purchase orders.
For simplicity, a merchandise will be recorded for its name and price, a buyer will be recorded for its name,
and order will be recorded for its date and all the items included in the order.  
1. Design a minimum database (a database of only essential attributes) to fulfil this purpose, and draw the ER
diagram for your design. Indicate on the ER diagram the primary keys, additional candidate keys if any, and
the relationship multiplicities. By minimum we mean that you don't need to add anything that is not explicitly
stated in the requirements, unless it's one of your artificially generated keys. For instance, you don't need to
include a telephone number or email address for the entity corresponding to a buyer.  
2. Draw the Global Relation Diagram (GRD) corresponding to the ER diagram in the above, indicating all the
primary keys, additional candidate keys and foreign keys where applicable. The GRD should be in a form
similar to Figure 17.9 (page 554 or 516 for edition 5) of the textbook, but all the attributes should be kept
there too.  
3. Write an SQL script (of statements) that generates all the tables for your designed database.
4. Write an SQL script to insert sufficient records into your tables. Each table should contain no less than 3
records. At least 2 orders should each contain 2 or more items of the ordered merchandise. Screenshots are
required for the records of all the tables.  
5. List all buyers whose name contains your own family name as a substring. Insert sufficient records into your
table/s so that your query returns at least 2 records. (screenshot required).  
6. For a given order (number), write an SQL statement to list all the item names and their corresponding prices
for the order (screenshot required).  
7. List all the orders by their order number, date, and the name of the buyer who places that order (screenshot
required).  


# Question 2 - More on SQL Queries
A DreamHome database has been created according to a case study for a property rental business (see §11.4 at
pages 381-401, or 347-367 for edition 5, of the textbook for the case study). Its (simplified) database schemas
(§6.3 at page 197 or 189 for edition 5) and the relation diagram are given as:  

Branch(branchNo,street,city,postcode)  
Staff(staffNo,fName,lName,position,sex,DOB,salary,branchNo)  
PropertyForRent(propertyNo,street,city,postcode,type,rooms,rent,ownerNo,staffNo,branchNo)  
Client(clientNo,fName,lName,telNo,prefType,maxRent,eMail)  
PrivateOwner(ownerNo,fName,lName,address,telNo,eMail,password)  
Viewing(clientNo,propertyNo,viewDate,comment)  



1. Draw an ER diagram to represent the above table-linking diagram (which is essentially what we would call a
relation diagram). The ER diagram should bear fewer entity types than the number of tables in the above
displayed diagram. That is, the table or tables that essentially represent relationships should be represented as
relationships on the ER diagram, not as entities.
2. Create this set of tables and fill the records by excuting this given SQL script dreamhome.sql. Then use an
UPDATE statement in SQL to modify the staff member "Julie Lee" into your own name and modify his date
of birth (13/6/1975) into a date after 1990s. If you have a team member for this assignment, then also
UPDATE the staff record for staffNo="SL21" by replacing the name "John White" there by that of your
team partner (screenshot required for the resulting Staff table).  
3. Write an SQL statement to list all the client names, the maximum rent they are willing to pay, and their
telephone numbers (screenshot required).  
4. Write an SQL statement to list staff name, position, and the postcode of their branch. The listing should be
ordered according to postcode, and within the same postcode, ordered alphabetically according to the last
name (screenshot required).  
5. Write an SQL statement to list all area postcode, propertyNo, and the staff name responsible for the
management of the property. Sort the output according to postcode (screenshot required).  
6. Write an SQL statement to list all the properties that have been viewed by one or more clients. More
precisely, list the postcode, propertyNo, the street of the property, last name of the staff responsible for this
property, client's last name, and the viewing date. Order the output first by the postcode, then by the street
(screenshot required).  


# Question 3 - Database Modelling - case study:
In this question, you are required to construct a Swimming Database for a swimming club, so that the database
can be used to maintain the listing of excellent performers for different swimming events. The database will record
which top swimmers specialise on which events, and these events include for instance 100m Free, 200m Butterfly,
400m Medley, and 1500m Back for both men and women. The performance listing data kept in the database should
include gender, performance time, swimmer's name, date of birth, title of the swimming competition, date of the
competition, venue, and the ordinal position in that competition. A typical entry of such a listing might contain the data similar to the following

1. Design a minimum database (a database of only essential attributes) to fulfil this purpose, and draw the ER
diagram for your design. Indicate on the ER diagram the primary keys, additional candidate keys if any, and
the relationship multiplicities. You must use the same notation scheme for the ER diagram as the textbook, and
the ER diagram should be strictly in the sense the textbook uses. Briefly explain the roles played by each entity
type and relationship type in your design in terms of the design goals.  
2. Draw the corresponding Global Relation Diagram (GRD), indicating all attributes, primary keys, additional
candidate keys and foreign keys where applicable.  
3. Write a query in SQL to list all swimmers who won the 1st place in any event of a competition for the club.
Each output record should contain the name of the winning swimmer, the name of the competition and the
name of the winning event in that competition. Describe the output also in the form of relational algebra.  
4. Write a query in SQL to list, for all swimmers who won (positioned 1st) at least one event for the club, the
swimmer names and their corresponding winning events. The output should however exclude the case where
the winning event is not registered in the club as one of the swimmer's specialised events.  


# Reference to Essential Reading materials:
Connolly, T. M., & Begg, C. E. (2014). Database systems: A practical approach to design, implementation,
and management (6th ed.). Boston, MA: Pears

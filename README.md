# Library Management System using SQL Project --P2

## Project Overview

**Project Title**: Library Management System   

This project demonstrates the implementation of a Library Management System using SQL. It includes creating and managing tables, performing CRUD operations, and executing advanced SQL queries. The goal is to showcase skills in database design, manipulation, and querying.


## Objectives

1. **Set up the Library Management System Database**: Create and populate the database with tables for branches, employees, members, books, issued status, and return status.
2. **CRUD Operations**: Perform Create, Read, Update, and Delete operations on the data.
3. **CTAS (Create Table As Select)**: Utilize CTAS to create new tables based on query results.
4. **Advanced SQL Queries**: Develop complex queries to analyze and retrieve specific data.

## Project Structure

### 1. Database Setup

- **Database Creation**: Created a database named `library_db`.
- **Table Creation**: Created tables for branches, employees, members, books, issued status, and return status. Each table includes relevant columns and relationships.

```sql
create database library_project;
use library_project;

/*Creating brance table*/
drop table if exists branch;
create table branch(
	branch_id varchar(15) primary key,
	manager_id varchar(15),   
	branch_address varchar(50),
	contact_no varchar(15)
);
select * from branch;


/*Creating employees table*/
drop table if exists employees;
create table employees(
	emp_id varchar(10) primary key,
	emp_name varchar(25),	
	position varchar(15),
	salary	int,
	branch_id varchar(10)  /*FK*/
); 

/*Creating books table*/
drop table if exists books;
create table books(
	isbn varchar(20) primary key,
	book_title varchar(75),
	category varchar(30),
	rental_price float,
	status varchar(15),
	author varchar(35),
	publisher varchar(55)
);
select * from books;
ALTER TABLE books
MODIFY category VARCHAR(20);

/*Creating members table*/
drop table if exists members;
create table members(
	member_id varchar(10) primary key,
	member_name varchar(30),
	member_address varchar(50), 	 
	reg_date date
);


drop table if exists issued_status;
create table issued_status(
	issued_id varchar(15) primary key,
	issued_member_id varchar(10),  /*...FK...*/
	issued_book_name varchar(75),
	issued_date	date,
	issued_book_isbn varchar(30),	/*FK*/	
	issued_emp_id varchar(10)  /*FK*/
);
select * from issued_status;

drop table if exists return_status;
create table return_status(
	return_id varchar(10) primary key,
	issued_id varchar(10),
	return_book_name varchar(75),
	return_date	date,
    return_book_isbn varchar(10)
);

/*  Defining or Assigning the Foreign Key   */
ALTER TABLE issued_status
add constraint fk_members
foreign key  (issued_member_id) REFERENCES members(member_id);

ALTER TABLE issued_status
add constraint fk_book
foreign key  (issued_book_isbn) 
REFERENCES books(isbn);


ALTER TABLE issued_status
add constraint fk_employees
foreign key  (issued_emp_id) 
REFERENCES employees(emp_id);

ALTER TABLE employees
add constraint fk_branch
foreign key  (branch_id) 
REFERENCES branch(branch_id);

ALTER TABLE return_status
add constraint fk_issued_status
foreign key  (issued_id) 
REFERENCES issued_status(issued_id);

```

###Data Insertion 
```sql
use library_project;
INSERT INTO members(member_id, member_name, member_address, reg_date) 
VALUES
('C101', 'Alice Johnson', '123 Main St', '2021-05-15'),
('C102', 'Bob Smith', '456 Elm St', '2021-06-20'),
('C103', 'Carol Davis', '789 Oak St', '2021-07-10'),
('C104', 'Dave Wilson', '567 Pine St', '2021-08-05'),
('C105', 'Eve Brown', '890 Maple St', '2021-09-25'),
('C106', 'Frank Thomas', '234 Cedar St', '2021-10-15'),
('C107', 'Grace Taylor', '345 Walnut St', '2021-11-20'),
('C108', 'Henry Anderson', '456 Birch St', '2021-12-10'),
('C109', 'Ivy Martinez', '567 Oak St', '2022-01-05'),
('C110', 'Jack Wilson', '678 Pine St', '2022-02-25'),
('C118', 'Sam', '133 Pine St', '2024-06-01'),    
('C119', 'John', '143 Main St', '2024-05-01');
SELECT * FROM members;


-- Insert values into each branch table
INSERT INTO branch(branch_id, manager_id, branch_address, contact_no) 
VALUES
('B001', 'E109', '123 Main St', '+919099988676'),
('B002', 'E109', '456 Elm St', '+919099988677'),
('B003', 'E109', '789 Oak St', '+919099988678'),
('B004', 'E110', '567 Pine St', '+919099988679'),
('B005', 'E110', '890 Maple St', '+919099988680');
SELECT * FROM branch;


-- Insert values into each employees table
INSERT INTO employees(emp_id, emp_name, position, salary, branch_id) 
VALUES
('E101', 'John Doe', 'Clerk', 60000.00, 'B001'),
('E102', 'Jane Smith', 'Clerk', 45000.00, 'B002'),
('E103', 'Mike Johnson', 'Librarian', 55000.00, 'B001'),
('E104', 'Emily Davis', 'Assistant', 40000.00, 'B001'),
('E105', 'Sarah Brown', 'Assistant', 42000.00, 'B001'),
('E106', 'Michelle Ramirez', 'Assistant', 43000.00, 'B001'),
('E107', 'Michael Thompson', 'Clerk', 62000.00, 'B005'),
('E108', 'Jessica Taylor', 'Clerk', 46000.00, 'B004'),
('E109', 'Daniel Anderson', 'Manager', 57000.00, 'B003'),
('E110', 'Laura Martinez', 'Manager', 41000.00, 'B005'),
('E111', 'Christopher Lee', 'Assistant', 65000.00, 'B005');
SELECT * FROM employees;


-- Inserting into books table 
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher) 
VALUES
('978-0-553-29698-2', 'The Catcher in the Rye', 'Classic', 7.00, 'yes', 'J.D. Salinger', 'Little, Brown and Company'),
('978-0-330-25864-8', 'Animal Farm', 'Classic', 5.50, 'yes', 'George Orwell', 'Penguin Books'),
('978-0-14-118776-1', 'One Hundred Years of Solitude', 'Literary Fiction', 6.50, 'yes', 'Gabriel Garcia Marquez', 'Penguin Books'),
('978-0-525-47535-5', 'The Great Gatsby', 'Classic', 8.00, 'yes', 'F. Scott Fitzgerald', 'Scribner'),
('978-0-141-44171-6', 'Jane Eyre', 'Classic', 4.00, 'yes', 'Charlotte Bronte', 'Penguin Classics'),
('978-0-307-37840-1', 'The Alchemist', 'Fiction', 2.50, 'yes', 'Paulo Coelho', 'HarperOne'),
('978-0-679-76489-8', 'Harry Potter and the Sorcerers Stone', 'Fantasy', 7.00, 'yes', 'J.K. Rowling', 'Scholastic'),
('978-0-7432-4722-4', 'The Da Vinci Code', 'Mystery', 8.00, 'yes', 'Dan Brown', 'Doubleday'),
('978-0-09-957807-9', 'A Game of Thrones', 'Fantasy', 7.50, 'yes', 'George R.R. Martin', 'Bantam'),
('978-0-393-05081-8', 'A Peoples History of the United States', 'History', 9.00, 'yes', 'Howard Zinn', 'Harper Perennial'),
('978-0-19-280551-1', 'The Guns of August', 'History', 7.00, 'yes', 'Barbara W. Tuchman', 'Oxford University Press'),
('978-0-307-58837-1', 'Sapiens: A Brief History of Humankind', 'History', 8.00, 'no', 'Yuval Noah Harari', 'Harper Perennial'),
('978-0-375-41398-8', 'The Diary of a Young Girl', 'History', 6.50, 'no', 'Anne Frank', 'Bantam'),
('978-0-14-044930-3', 'The Histories', 'History', 5.50, 'yes', 'Herodotus', 'Penguin Classics'),
('978-0-393-91257-8', 'Guns, Germs, and Steel: The Fates of Human Societies', 'History', 7.00, 'yes', 'Jared Diamond', 'W. W. Norton & Company'),
('978-0-7432-7357-1', '1491: New Revelations of the Americas Before Columbus', 'History', 6.50, 'no', 'Charles C. Mann', 'Vintage Books'),
('978-0-679-64115-3', '1984', 'Dystopian', 6.50, 'yes', 'George Orwell', 'Penguin Books'),
('978-0-14-143951-8', 'Pride and Prejudice', 'Classic', 5.00, 'yes', 'Jane Austen', 'Penguin Classics'),
('978-0-452-28240-7', 'Brave New World', 'Dystopian', 6.50, 'yes', 'Aldous Huxley', 'Harper Perennial'),
('978-0-670-81302-4', 'The Road', 'Dystopian', 7.00, 'yes', 'Cormac McCarthy', 'Knopf'),
('978-0-385-33312-0', 'The Shining', 'Horror', 6.00, 'yes', 'Stephen King', 'Doubleday'),
('978-0-451-52993-5', 'Fahrenheit 451', 'Dystopian', 5.50, 'yes', 'Ray Bradbury', 'Ballantine Books'),
('978-0-345-39180-3', 'Dune', 'Science Fiction', 8.50, 'yes', 'Frank Herbert', 'Ace'),
('978-0-375-50167-0', 'The Road', 'Dystopian', 7.00, 'yes', 'Cormac McCarthy', 'Vintage'),
('978-0-06-025492-6', 'Where the Wild Things Are', 'Children', 3.50, 'yes', 'Maurice Sendak', 'HarperCollins'),
('978-0-06-112241-5', 'The Kite Runner', 'Fiction', 5.50, 'yes', 'Khaled Hosseini', 'Riverhead Books'),
('978-0-06-440055-8', 'Charlotte''s Web', 'Children', 4.00, 'yes', 'E.B. White', 'Harper & Row'),
('978-0-679-77644-3', 'Beloved', 'Fiction', 6.50, 'yes', 'Toni Morrison', 'Knopf'),
('978-0-14-027526-3', 'A Tale of Two Cities', 'Classic', 4.50, 'yes', 'Charles Dickens', 'Penguin Books'),
('978-0-7434-7679-3', 'The Stand', 'Horror', 7.00, 'yes', 'Stephen King', 'Doubleday'),
('978-0-451-52994-2', 'Moby Dick', 'Classic', 6.50, 'yes', 'Herman Melville', 'Penguin Books'),
('978-0-06-112008-4', 'To Kill a Mockingbird', 'Classic', 5.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.'),
('978-0-553-57340-1', '1984', 'Dystopian', 6.50, 'yes', 'George Orwell', 'Penguin Books'),
('978-0-7432-4722-5', 'Angels & Demons', 'Mystery', 7.50, 'yes', 'Dan Brown', 'Doubleday'),
('978-0-7432-7356-4', 'The Hobbit', 'Fantasy', 7.00, 'yes', 'J.R.R. Tolkien', 'Houghton Mifflin Harcourt');


select * from books;

-- inserting into issued table
INSERT INTO issued_status(issued_id, issued_member_id, issued_book_name, issued_date, issued_book_isbn, issued_emp_id) 
VALUES
('IS106', 'C106', 'Animal Farm', '2024-03-10', '978-0-330-25864-8', 'E104'),
('IS107', 'C107', 'One Hundred Years of Solitude', '2024-03-11', '978-0-14-118776-1', 'E104'),
('IS108', 'C108', 'The Great Gatsby', '2024-03-12', '978-0-525-47535-5', 'E104'),
('IS109', 'C109', 'Jane Eyre', '2024-03-13', '978-0-141-44171-6', 'E105'),
('IS110', 'C110', 'The Alchemist', '2024-03-14', '978-0-307-37840-1', 'E105'),
('IS111', 'C109', 'Harry Potter and the Sorcerers Stone', '2024-03-15', '978-0-679-76489-8', 'E105'),
('IS112', 'C109', 'A Game of Thrones', '2024-03-16', '978-0-09-957807-9', 'E106'),
('IS113', 'C109', 'A Peoples History of the United States', '2024-03-17', '978-0-393-05081-8', 'E106'),
('IS114', 'C109', 'The Guns of August', '2024-03-18', '978-0-19-280551-1', 'E106'),
('IS115', 'C109', 'The Histories', '2024-03-19', '978-0-14-044930-3', 'E107'),
('IS116', 'C110', 'Guns, Germs, and Steel: The Fates of Human Societies', '2024-03-20', '978-0-393-91257-8', 'E107'),
('IS117', 'C110', '1984', '2024-03-21', '978-0-679-64115-3', 'E107'),
('IS118', 'C101', 'Pride and Prejudice', '2024-03-22', '978-0-14-143951-8', 'E108'),
('IS119', 'C110', 'Brave New World', '2024-03-23', '978-0-452-28240-7', 'E108'),
('IS120', 'C110', 'The Road', '2024-03-24', '978-0-670-81302-4', 'E108'),
('IS121', 'C102', 'The Shining', '2024-03-25', '978-0-385-33312-0', 'E109'),
('IS122', 'C102', 'Fahrenheit 451', '2024-03-26', '978-0-451-52993-5', 'E109'),
('IS123', 'C103', 'Dune', '2024-03-27', '978-0-345-39180-3', 'E109'),
('IS124', 'C104', 'Where the Wild Things Are', '2024-03-28', '978-0-06-025492-6', 'E110'),
('IS125', 'C105', 'The Kite Runner', '2024-03-29', '978-0-06-112241-5', 'E110'),
('IS126', 'C105', 'Charlotte''s Web', '2024-03-30', '978-0-06-440055-8', 'E110'),
('IS127', 'C105', 'Beloved', '2024-03-31', '978-0-679-77644-3', 'E110'),
('IS128', 'C105', 'A Tale of Two Cities', '2024-04-01', '978-0-14-027526-3', 'E110'),
('IS129', 'C105', 'The Stand', '2024-04-02', '978-0-7434-7679-3', 'E110'),
('IS130', 'C106', 'Moby Dick', '2024-04-03', '978-0-451-52994-2', 'E101'),
('IS131', 'C106', 'To Kill a Mockingbird', '2024-04-04', '978-0-06-112008-4', 'E101'),
('IS132', 'C106', 'The Hobbit', '2024-04-05', '978-0-7432-7356-4', 'E106'),
('IS133', 'C107', 'Angels & Demons', '2024-04-06', '978-0-7432-4722-5', 'E106'),
('IS134', 'C107', 'The Diary of a Young Girl', '2024-04-07', '978-0-375-41398-8', 'E106'),
('IS135', 'C107', 'Sapiens: A Brief History of Humankind', '2024-04-08', '978-0-307-58837-1', 'E108'),
('IS136', 'C107', '1491: New Revelations of the Americas Before Columbus', '2024-04-09', '978-0-7432-7357-1', 'E102'),
('IS137', 'C107', 'The Catcher in the Rye', '2024-04-10', '978-0-553-29698-2', 'E103'),
('IS138', 'C108', 'The Great Gatsby', '2024-04-11', '978-0-525-47535-5', 'E104'),
('IS139', 'C109', 'Harry Potter and the Sorcerers Stone', '2024-04-12', '978-0-679-76489-8', 'E105'),
('IS140', 'C110', 'Animal Farm', '2024-04-13', '978-0-330-25864-8', 'E102');

select * from issued_status;

-- inserting into return table
INSERT INTO return_status(return_id, issued_id, return_date) 
VALUES
('RS106', 'IS108', '2024-05-05'),
('RS107', 'IS109', '2024-05-07'),
('RS108', 'IS110', '2024-05-09'),
('RS109', 'IS111', '2024-05-11'),
('RS110', 'IS112', '2024-05-13'),
('RS111', 'IS113', '2024-05-15'),
('RS112', 'IS114', '2024-05-17'),
('RS113', 'IS115', '2024-05-19'),
('RS114', 'IS116', '2024-05-21'),
('RS115', 'IS117', '2024-05-23'),
('RS116', 'IS118', '2024-05-25'),
('RS117', 'IS119', '2024-05-27'),
('RS118', 'IS120', '2024-05-29');
select * from return_status;

SELECT * FROM issued_status;



```

### 2. CRUD Operations

- **Create**: Inserted sample records into the `books` table.
- **Read**: Retrieved and displayed data from various tables.
- **Update**: Updated records in the `employees` table.
- **Delete**: Removed records from the `members` table as needed.

```sql

select * from books;
select * from branch;
select * from employees;
select * from issued_status;
select * from members;
select * from return_status;

						/*CRUD Operations*/
/*Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 
'Harper Lee', 'J.B. Lippincott & Co.')"*/
INSERT INTO books(isbn, book_title, category, rental_price, `status`, author, publisher)
VALUES ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

/*Task 2: Update an Existing Member's Address*/
update members
set member_address='786 Sarmaska St'
where member_id='C101';

/*Task 3: Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121'
 from the issued_status table.*/
 delete from issued_status
 where issued_id='IS121';
 /*TO verify wether it has deleted or not*/
 select * from issued_status where issued_id='IS121';
 

/*Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the
employee with emp_id = 'E101'.*/
SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';

/*If data didn't show properly then first try to find the data or crosscheck*/
SELECT * FROM issued_status ORDER BY issued_id;
SELECT * FROM issued_status limit 30;
SELECT * FROM issued_status WHERE issued_emp_id = 'E101';

/*Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who
 have issued more than one book.*/
select issued_member_id, count(*) AS count
from issued_status
group by 1
having count(*)>1;

		/*3. CTAS (Create Table As Select)*/
/*Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt*/

create table book_cnts
as 
select 
	b.isbn ,
    b.book_title,
    count(ist.issued_id) as no_of_issue
	from  books as b
	join 
	issued_status as ist
on ist.issued_book_isbn=b.isbn
group by 1,2;
/*Here You don't write that code again, Just call this table */
select * from book_cnts;

	
		/*4. Data Analysis & Findings*/
/*Task 7. Retrieve All Books in a Specific Category:*/
            select * from books where category='classic';

/*Task 8: Find Total Rental Income by Category:*/
/*Counting all the books*/
            select category, sum(rental_price) 
            from books
            group by 1;
            
            /*Counting only the renting books*/
            SELECT 
                b.category,
                SUM(b.rental_price),
                COUNT(*)
            FROM 
            issued_status as ist
            JOIN
            books as b
            ON b.isbn = ist.issued_book_isbn
            GROUP BY 1;


/*Task 9-List Members Who Registered in the Last 180 Days:*/
            SELECT * 
            FROM members
            WHERE DATEDIFF( reg_date, CURRENT_DATE()) < 180;

/*Task 10 -List Employees with Their Branch Manager's Name and their branch details:*/
select e1.emp_id, e1.emp_name, e1.position, e1.salary, b.*, e2.emp_name as manager
	from employees as e1
	join
	branch as b 
	on b.branch_id=e1.branch_id
	join
	employees as e2
on b.manager_id=e2.emp_id;

/*Task 11. Create a Table of Books with Rental Price Above a Certain Threshold:*/
            select * from books
            where rental_price>7;

/*Task 12: Retrieve the List of Books Not Yet Returned*/
            select * from return_status;
            select * from issued_status;

SELECT * FROM issued_status as ist
LEFT JOIN
return_status as rs
ON rs.issued_id = ist.issued_id
WHERE rs.return_id IS NULL;

/*Task 12: Retrieve the List of Books Returned*/
            SELECT * FROM issued_status as ist
            LEFT JOIN
            return_status as rs
            ON rs.issued_id = ist.issued_id
            WHERE rs.return_id IS not NULL;

```

## Advanced SQL Operations

```sql
/*Advance Questions*/
select * from  books;
select * from branch;
select * from employees;
select * from issued_status;
select * from members;
select * from return_status;

/*Task 13: Identify Members with Overdue Books
Write a query to identify members who have overdue books (assume a 480-day return period, 480 days because this is very old data and 
I don't want to change date on this data.....). 
Display the member's_id, member's name, book title, issue date, and days overdue.*/



SELECT 
	ist.issued_member_id,
    m.member_name,
    bk.book_title,
    ist.issued_date,
    CURRENT_DATE - ist.issued_date as over_dues_days
FROM issued_status as ist
join
	members as m
on ist.issued_member_id=m.member_id
join 
	books as bk
on ist.issued_book_isbn=bk.isbn
left join 
	return_status as rs
on rs.issued_id = ist.issued_id
WHERE 
	rs.return_date is null 
and
	issued_date >= CURDATE() - INTERVAL 470 DAY
order by 1;


/*Task 14: Update Book Status on Return
Write a query to update the status of books in the books table to "Yes"
when they are returned (based on entries in the return_status table).*/
 
 
 select * from issued_status
 where issued_book_isbn='978-0-451-52994-2';
 
select * from books
where isbn='978-0-451-52994-2';
update books
set status='no'
where isbn='978-0-451-52994-2';

select * from return_status
where issued_id='IS130';

insert into return_status(return_id,issued_id,return_date)
values ('RS125','IS130',current_date());

select * from books
where isbn='978-0-451-52994-2';

update books
set status='yes'
where isbn='978-0-451-52994-2';

DELIMITER $$

CREATE PROCEDURE add_return(
    IN p_return_id VARCHAR(10),
    IN p_issued_id VARCHAR(10)
)
BEGIN
    DECLARE v_isbn VARCHAR(50);
    DECLARE v_book_name VARCHAR(80);

    -- Step 1: Insert return record
    INSERT INTO return_status (return_id, issued_id, return_date)
    VALUES (p_return_id, p_issued_id, CURDATE());

    -- Step 2: Get ISBN and Book Name from issued_status
    SELECT issued_book_isbn, issued_book_name
    INTO v_isbn, v_book_name
    FROM issued_status
    WHERE issued_id = p_issued_id;

    -- Step 3: Update book status in books table
    UPDATE books
    SET status = 'yes'
    WHERE isbn = v_isbn;

    -- Step 4: Simulate RAISE NOTICE (PostgreSQL) using SELECT
    SELECT CONCAT('Thank you for returning the book: ', v_book_name) AS message;

END$$
DELIMITER ;

CALL add_return('RS138', 'IS135');
CALL add_return('RS148', 'IS140');



/*ask 15: Branch Performance Report
Create a query that generates a performance report for each branch, showing the number of books issued,
the number of books returned, and the total revenue generated from book rentals.*/

/*
for each branch--- branch table   ** Connect to employees table 
no. of book issued---- issue table **
no. of book returned--- return table
total revnue--  books table
*/

select br.branch_id,
		br.manager_id,
        count(distinct i.issued_id) as book_issued,
        count(distinct r.return_id) as book_returned,
        IFNULL(SUM(b.rental_price), 0) AS total_revenue
from branch as br
left join employees as emp on br.branch_id=emp.branch_id
left join issued_status as i on i.issued_emp_id=emp.emp_id
left join return_status as r on r.issued_id=i.issued_id
left join books as b on b.isbn=i.issued_book_isbn
group by  br.branch_id, br.manager_id;

SELECT 
    b.branch_id,
    b.manager_id,
    COUNT(ist.issued_id) as number_book_issued,
    COUNT(rs.return_id) as number_of_book_return,
    SUM(bk.rental_price) as total_revenue
FROM issued_status as ist
JOIN  employees as e ON e.emp_id = ist.issued_emp_id
JOIN branch as b ON e.branch_id = b.branch_id
LEFT JOIN return_status as rs ON rs.issued_id = ist.issued_id
JOIN  books as bk ON ist.issued_book_isbn = bk.isbn
GROUP BY 1,2;


/*Task 16: CTAS: Create a Table of Active Members
Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members 
who have issued at least one book in the last 2 months.*/

CREATE TABLE active_members
AS
SELECT * FROM members
WHERE member_id IN
	 (
	SELECT  DISTINCT issued_member_id    
	FROM issued_status 
	WHERE issued_date >= STR_TO_DATE('2024-06-10', '%Y-%m-%d') - INTERVAL 2 MONTH);

select * from active_members;


/*Task 17: Find Employees with the Most Book Issues Processed
Write a query to find the top 3 employees who have processed the most book issues. 
Display the employee name, number of books processed, and their branch.*/

select e.emp_name,b.*, count(ist.issued_id) as no_of_book_issued
from issued_status as ist
join employees as e
on ist.issued_emp_id=e.emp_id
join branch as b
on b.branch_id=e.branch_id
group by 1,2;



```



## Reports

- **Database Schema**: Detailed table structures and relationships.
- **Data Analysis**: Insights into book categories, employee salaries, member registration trends, and issued books.
- **Summary Reports**: Aggregated data on high-demand books and employee performance.

## Conclusion

This project demonstrates the application of SQL skills in creating and managing a library management system. It includes database setup, data manipulation, and advanced querying, providing a solid foundation for data management and analysis.


Thank you for your interest in this project!

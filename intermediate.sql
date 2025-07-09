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













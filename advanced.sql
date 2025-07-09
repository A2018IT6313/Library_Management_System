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




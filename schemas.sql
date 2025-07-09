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
	category varchar(10),
	rental_price float,
	status varchar(15),
	author varchar(35),
	publisher varchar(55)
);
select * from books;

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



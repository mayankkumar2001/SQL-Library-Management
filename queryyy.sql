select * from books;
select * from branch;
select * from employees;
select * from issued_status;
select * from members;
select * from return_status;

-- Project Task

-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

insert into books(isbn,book_title,category,rental_price,status,author,publisher)
values ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.'
);

-- Task 2: Update an Existing Member's Address

update members
set member_address = '125 main street'
where member_id = 'C101';

--Task 3:  Delete the record with issued_id = 'ISI121' from the issued_status table.

delete from issued_status
where issued_id = 'ISI121';

-- Task 4: Select all books issued by the employee with emp_id = 'E101'.
select issued_book_name from issued_status where issued_emp_id = 'E101';

-- Task 5: Use GROUP BY to find members who have issued more than one book.
select issued_emp_id from issued_status group by issued_emp_id having count(issued_id) > 1;

--  Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**
create table book_cnts
as
select 
b.isbn,
b.book_title,
count(ist.issued_id) as no_issued
from books as b
join 
issued_status as ist
on ist.issued_book_isbn = b.isbn
group by 1,2;

select * from book_cnts;

-- Task 7. Retrieve All Books in a Specific Category:

select * from books where category = 'Classic';

--Task 8: Find Total Rental Income by Category:

select b.category,
sum(b.rental_price),count(*)
from books as b
join
issued_status as ist
on ist.issued_book_isbn = b.isbn
group by b.category;

-- List Members Who Registered in the Last 180 Days:

insert into members(member_id,member_name,member_address,reg_date)
values('C120','sam','124 Super street','2026-10-17'),
('C121','john','234 main street','2026-11-01');

select * from members
where reg_date >= current_date - INTERVAL '180 days'


-- List Employees with Their Branch Manager's Name and their branch details:
SELECT 
    e1.emp_id,
    e1.emp_name,
    e1.position,
    e1.salary,
    b.*,
    e2.emp_name as manager
FROM employees as e1
JOIN 
branch as b
ON e1.branch_id = b.branch_id    
JOIN
employees as e2
ON e2.emp_id = b.manager_id

-- Create a Table of Books with Rental Price Above 7 - USD:
create table books_above_7USD
as
select * from books where rental_price > 7;

-- Retrieve the list of books not yet returned.
select * from return_status;
select * from issued_status;

select distinct ist.issued_book_name  from issued_status as ist left join return_status as rs on ist.issued_id = rs.issued_id
where rs.return_id is NULL;


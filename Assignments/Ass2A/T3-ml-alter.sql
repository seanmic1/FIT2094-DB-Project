--****PLEASE ENTER YOUR DETAILS BELOW****
--T3-ml-alter.sql

--Student ID: 32185456
--Student Name: Sean Michael
--Tutorial No: 2

/* Comments for your marker:




*/

-- 3 (a)
ALTER TABLE book_copy ADD bc_status CHAR(1) DEFAULT 'G';

ALTER TABLE book_copy MODIFY (bc_status NOT NULL);

ALTER TABLE book_copy ADD CONSTRAINT bc_status_chk CHECK ( bc_status IN ( 'D', 'G', 'L' ) );

UPDATE book_copy SET bc_status = 'L' WHERE book_call_no = '005.74 C824C' and branch_code = 11;

COMMIT;


-- 3 (b)
ALTER TABLE loan ADD loan_return_branch NUMBER(2) DEFAULT 0;

UPDATE loan SET loan_return_branch = branch_code WHERE loan_return_branch = 0;

COMMIT;


-- 3 (c)

ALTER TABLE branch ADD branch_fiction_manager NUMBER(2) DEFAULT 0;

ALTER TABLE branch MODIFY (branch_fiction_manager NOT NULL);

UPDATE branch SET branch_fiction_manager = man_id WHERE branch_fiction_manager = 0;

ALTER TABLE branch ADD branch_reference_manager NUMBER(2) DEFAULT 0;

ALTER TABLE branch MODIFY (branch_reference_manager NOT NULL);

UPDATE branch SET branch_reference_manager = man_id WHERE branch_reference_manager = 0;



UPDATE branch SET branch_fiction_manager = 12 WHERE branch_code = 10;

COMMIT;





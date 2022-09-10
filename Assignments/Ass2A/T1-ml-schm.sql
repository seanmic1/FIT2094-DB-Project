--****PLEASE ENTER YOUR DETAILS BELOW****
--T1-ml-schm.sql

--Student ID: 32185456
--Student Name: Sean Michael
--Tutorial No: 2

/* Comments for your marker:




*/

-- 1.1 Add Create table statments for the Missing TABLES below
-- Ensure all column comments, and constraints (other than FK's)
-- are included. FK constraints are to be added at the end of this script

-- BOOK_COPY
CREATE TABLE book_copy (
    branch_code         NUMBER(2) NOT NULL,
    bc_id               NUMBER(6) NOT NULL,
    bc_purchase_price   NUMBER(7,2) NOT NULL,
    bc_counter_reserve  CHAR(1) NOT NULL,
    book_call_no        VARCHAR(20) NOT NULL
);

ALTER TABLE book_copy 
    ADD CONSTRAINT bc_counter_reserve_chk CHECK ( bc_counter_reserve IN ( 'Y', 'N' ) );

COMMENT ON COLUMN book_copy.branch_code IS
    'Branch number';
    
COMMENT ON COLUMN book_copy.bc_id IS
    'Book copy identifier unique within each branch';
    
COMMENT ON COLUMN book_copy.bc_purchase_price IS
    'Book copy purchase price';

COMMENT ON COLUMN book_copy.bc_counter_reserve IS
    'Book copy flag to indicate whether it is placed on counter reserve - (Y)es/(N)o';

COMMENT ON COLUMN book_copy.book_call_no IS
    'Books call number - identifies a book';
    
ALTER TABLE book_copy ADD CONSTRAINT book_copy_pk PRIMARY KEY ( branch_code, bc_id);

-- LOAN
CREATE TABLE loan (
    branch_code NUMBER(2) NOT NULL,
    bc_id NUMBER(6) NOT NULL,
    loan_date_time DATE NOT NULL,
    loan_due_date DATE NOT NULL,
    loan_actual_return_date DATE,
    bor_no NUMBER(6)
);

COMMENT ON COLUMN loan.branch_code IS
    'Branch number';

COMMENT ON COLUMN loan.bc_id IS
    'Book copy identifier';
    
COMMENT ON COLUMN loan.loan_date_time IS
    'Loan start date and time';

COMMENT ON COLUMN loan.loan_due_date IS
    'Loan return due date';
    
COMMENT ON COLUMN loan.loan_actual_return_date IS
    'Loan actual return date';
    
COMMENT ON COLUMN loan.bor_no IS
    'Borrower identifier';
    
ALTER TABLE loan add CONSTRAINT loan_pk PRIMARY KEY (branch_code, bc_id, loan_date_time);

-- RESERVE
CREATE TABLE reserve (
    reserve_id NUMBER(6) NOT NULL,
    branch_code NUMBER(2) NOT NULL,
    bc_id NUMBER(6) NOT NULL,
    reserve_date_time_placed DATE NOT NULL,
    bor_no NUMBER(6) NOT NULL
);

COMMENT ON COLUMN reserve.reserve_id IS
    'Reserve identifier unique across all branches';

COMMENT ON COLUMN reserve.branch_code IS
    'Branch number';
    
COMMENT ON COLUMN reserve.bc_id IS
    'Book copy identifier';

COMMENT ON COLUMN reserve.reserve_date_time_placed IS
    'Date and time reserve was placed';

COMMENT ON COLUMN reserve.bor_no IS
    'Borrower identifier';

ALTER TABLE reserve ADD CONSTRAINT reserve_uq UNIQUE (branch_code, bc_id, reserve_date_time_placed);

ALTER TABLE reserve ADD CONSTRAINT reserve_pk PRIMARY KEY (reserve_id);

-- Add all missing FK Constraints below here

ALTER TABLE book_copy
    ADD CONSTRAINT branch_bc FOREIGN KEY (branch_code)
        REFERENCES branch (branch_code);
        
ALTER TABLE book_copy
    ADD CONSTRAINT book_detail_bc FOREIGN KEY (book_call_no)
        REFERENCES book_detail (book_call_no);
        
ALTER TABLE loan
    ADD CONSTRAINT bc_loan FOREIGN KEY (branch_code, bc_id)
        REFERENCES book_copy (branch_code, bc_id);
        
ALTER TABLE loan
    ADD CONSTRAINT bor_loan FOREIGN KEY (bor_no)
        REFERENCES borrower (bor_no);

ALTER TABLE reserve
    ADD CONSTRAINT bc_reserve FOREIGN KEY (branch_code, bc_id)
        REFERENCES book_copy (branch_code, bc_id);

ALTER TABLE reserve
    ADD CONSTRAINT bor_reserve FOREIGN KEY (bor_no)
        REFERENCES borrower (bor_no);





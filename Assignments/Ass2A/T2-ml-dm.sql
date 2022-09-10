--****PLEASE ENTER YOUR DETAILS BELOW****
--T2-ml-dm.sql

--Student ID: 32185456
--Student Name: Sean Michael
--Tutorial No: 2

/* Comments for your marker:




*/

-- 2 (b) (i)
INSERT INTO book_detail VALUES (
    '005.74 C824C',
    'Database Systems: Design, Implementation, and Management',
    'R',
    793,
    to_date('2019','YYYY'),
    13
);



INSERT INTO book_copy VALUES (
    (select branch_code from branch where branch_contact_no = '0395413120'),
    (select max(bc_id)+1 from book_copy where branch_code = (select branch_code from branch where branch_contact_no = '0395413120') group by branch_code),
    120,
    'N',
    '005.74 C824C'
);


INSERT INTO book_copy VALUES (
    (select branch_code from branch where branch_contact_no = '0395601655'),
    (select max(bc_id)+1 from book_copy where branch_code = (select branch_code from branch where branch_contact_no = '0395601655') group by branch_code),
    120,
    'N',
    '005.74 C824C'
);

INSERT INTO book_copy VALUES (
    (select branch_code from branch where branch_contact_no = '0395461253'),
    (select max(bc_id)+1 from book_copy where branch_code = (select branch_code from branch where branch_contact_no = '0395461253') group by branch_code),
    120,
    'N',
    '005.74 C824C'
);

COMMIT;

-- 2 (b) (ii)
DROP SEQUENCE borrower_seq;
CREATE SEQUENCE borrower_seq
INCREMENT BY 1
START WITH 100;

DROP SEQUENCE reserve_seq;
CREATE SEQUENCE reserve_seq
INCREMENT BY 1
START WITH 100;

COMMIT;

-- 2 (b) (iii)

INSERT INTO borrower VALUES (
    borrower_seq.nextval,
    'Ada',
    'Lovelace',
    'Somestreet',
    'Somesuburb',
    '1234',
    (select branch_code from branch where branch_contact_no = '0395413120')
);


INSERT INTO reserve VALUES (
    reserve_seq.nextval,
    (select branch_code from book_copy where branch_code = 10 and book_call_no = '005.74 C824C'),
    (select bc_id from book_copy where branch_code = 10 and book_call_no = '005.74 C824C'),
    to_date('14/09/2021 03:30','DD/MM/YYYY HH24:MI'),
    (select bor_no from borrower where bor_fname = 'Ada' and bor_lname = 'Lovelace')
);

COMMIT;

-- 2 (b) (iv)
INSERT INTO loan VALUES (
    (SELECT branch_code FROM reserve where bor_no = 100 and reserve_date_time_placed = to_date('14/09/2021 03:30','DD/MM/YYYY HH:MI')),
    (SELECT bc_id FROM reserve where bor_no = 100 and reserve_date_time_placed = to_date('14/09/2021 03:30','DD/MM/YYYY HH:MI')),
    to_date('21/09/2021 12:30','DD/MM/YYYY HH24:MI'),
    to_date('21/09/2021','DD/MM/YYYY') + 14,
    null,
    (SELECT bor_no FROM reserve where bor_no = 100 and reserve_date_time_placed = to_date('14/09/2021 03:30','DD/MM/YYYY HH:MI'))
);

DELETE FROM reserve WHERE bor_no = 100 and reserve_date_time_placed = to_date('14/09/2021 03:30','DD/MM/YYYY HH:MI');

COMMIT;


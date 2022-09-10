--****PLEASE ENTER YOUR DETAILS BELOW****
--T2-ml-insert.sql

--Student ID: 32185456
--Student Name: Sean Michael
--Tutorial No: 2

/* Comments for your marker:




*/

-- 2 (a) Load the BOOK_COPY, LOAN and RESERVE tables with your own
-- test data following the data requirements expressed in the brief

INSERT INTO book_copy VALUES (
    11,
    1,
    30,
    'N',
    '005.756 G476F'
);

INSERT INTO book_copy VALUES (
    11,
    2,
    30,
    'N',
    '005.756 G476F'
);

INSERT INTO book_copy VALUES (
    12,
    1,
    30,
    'Y',
    '005.756 G476F'
);

INSERT INTO book_copy VALUES (
    13,
    1,
    100,
    'N',
    '005.432 L761P'
);

INSERT INTO book_copy VALUES (
    13,
    2,
    23.50,
    'N',
    '823.914 H219A'
);

INSERT INTO book_copy VALUES (
    12,
    2,
    70.04,
    'N',
    '823.914 A211H'
);

INSERT INTO book_copy VALUES (
    12,
    3,
    70.04,
    'Y',
    '005.756 G476F'
);

INSERT INTO book_copy VALUES (
    13,
    3,
    200,
    'Y',
    '005.74 D691D'
);

INSERT INTO book_copy VALUES (
    11,
    3,
    10,
    'N',
    '112.6 S874D'
);

INSERT INTO book_copy VALUES (
    10,
    1,
    80,
    'N',
    '823.914 H219A'
);

--select * from book_copy ORDER BY branch_code, bc_id;

-- not completed
INSERT INTO loan VALUES (
    11,
    1,
    TO_DATE('01/06/2021 12:00','DD/MM/YYYY HH24:MI'),
    TO_DATE('01/06/2021','DD/MM/YYYY')+14,
    null,
    3
);

-- returned late
INSERT INTO loan VALUES (
    13,
    2,
    TO_DATE('02/06/2021 14:00','DD/MM/YYYY HH24:MI'),
    TO_DATE('02/06/2021','DD/MM/YYYY')+14,
    TO_DATE('18/06/2021','DD/MM/YYYY'),
    2
);

-- completed
INSERT INTO loan VALUES (
    10,
    1,
    TO_DATE('05/06/2021 14:05','DD/MM/YYYY HH24:MI'),
    TO_DATE('05/06/2021','DD/MM/YYYY')+14,
    TO_DATE('10/06/2021','DD/MM/YYYY'),
    1
);

-- completed
INSERT INTO loan VALUES (
    11,
    2,
    TO_DATE('14/07/2021 11:00','DD/MM/YYYY HH24:MI'),
    TO_DATE('14/07/2021','DD/MM/YYYY')+14,
    TO_DATE('16/07/2021','DD/MM/YYYY'),
    4
);

-- completed
INSERT INTO loan VALUES (
    13,
    1,
    TO_DATE('20/06/2021 22:45','DD/MM/YYYY HH24:MI'),
    TO_DATE('20/06/2021','DD/MM/YYYY')+14,
    TO_DATE('29/06/2021','DD/MM/YYYY'),
    5
);

-- completed
INSERT INTO loan VALUES (
    12,
    2,
    TO_DATE('01/07/2021 13:00','DD/MM/YYYY HH24:MI'),
    TO_DATE('01/07/2021','DD/MM/YYYY')+14,
    TO_DATE('02/07/2021','DD/MM/YYYY'),
    1
);

-- completed
INSERT INTO loan VALUES (
    11,
    3,
    TO_DATE('03/08/2021 16:00','DD/MM/YYYY HH24:MI'),
    TO_DATE('03/08/2021','DD/MM/YYYY')+14,
    TO_DATE('11/08/2021','DD/MM/YYYY'),
    2
);

-- completed
INSERT INTO loan VALUES (
    11,
    2,
    TO_DATE('08/06/2020 09:30','DD/MM/YYYY HH24:MI'),
    TO_DATE('08/06/2020','DD/MM/YYYY')+14,
    TO_DATE('21/06/2020','DD/MM/YYYY'),
    3
);

-- completed
INSERT INTO loan VALUES (
    11,
    3,
    TO_DATE('08/06/2020 12:15','DD/MM/YYYY HH24:MI'),
    TO_DATE('08/06/2020','DD/MM/YYYY')+14,
    TO_DATE('12/06/2020','DD/MM/YYYY'),
    4
);

-- not completed
INSERT INTO loan VALUES (
    10,
    1,
    TO_DATE('02/09/2021 09:00','DD/MM/YYYY HH24:MI'),
    TO_DATE('02/09/2021','DD/MM/YYYY')+14,
    null,
    5
);

INSERT INTO reserve VALUES (
    1,
    11,
    1,
    TO_DATE('05/10/2021 09:00','DD/MM/YYYY HH24:MI'),
    4
);

INSERT INTO reserve VALUES (
    2,
    11,
    1,
    TO_DATE('06/10/2021 10:00','DD/MM/YYYY HH24:MI'),
    2
);

COMMIT;


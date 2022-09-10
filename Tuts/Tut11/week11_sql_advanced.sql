/*
Databases Week 11 Tutorial
week11_sql_advanced.sql

student id: 
student name:
last modified date:

*/

/* 1.  Find the number of scheduled classes assigned to each staff member 
for each semester in 2019. If the number of classes is 2 then this 
should be labelled as a correct load, more than 2 as an overload 
and less than 2 as an underload. Include the staff id, staff first name, 
staff last name, semester, number of scheduled classes and load in the listing. 
Sort the list by decreasing order of the number of scheduled classes 
and when the number of classes is the same, sort by increasing order 
of staff id then by the semester. */
SELECT
    s.staffid,
    s.stafffname,
    s.stafflname,
    x.semester,
    COUNT(*) as "NUMBERCLASSES",
    CASE --NUMBERCLASSES
        WHEN COUNT(*) = 2 THEN 'Correct load'
        WHEN COUNT(*) < 2 THEN 'Underload'
        WHEN COUNT(*) > 2 THEN 'Overload'
    END AS load
FROM
    Uni.staff  s 
JOIN 
    Uni.schedclass x
ON 
    s.staffid = x.staffid
WHERE
    to_char(ofyear, 'YYYY')  = 2019 
GROUP BY
    s.staffid,
    s.stafffname,
    s.stafflname,
    x.semester 
ORDER BY
    NUMBERCLASSES DESC,
    staffid ASC,
    semester ASC;



/* 2. Display the unit code and unit name for units that do not have a prerequisite. 
Order the list in increasing order of unit code. 

There are many approaches that you can take in writing an SQL statement to answer this query. 
You can use the SET OPERATORS, OUTER JOIN and a SUBQUERY. 
Write SQL statements based on all three approaches.*/

/* Using outer join */
SELECT 
    u.unitcode,
    unitname--, count(has_prereq_of)
FROM
    uni.unit u
    LEFT OUTER JOIN uni.prereq p
    on u.unitcode = p.unitcode
group by u.unitcode, unitname
having count(has_prereq_of) = 0
ORDER BY 
    unitcode;



/* Using set operator MINUS */
SELECT unitcode,unitname 
    FROM uni.unit u
WHERE unitcode IN
    (SELECT unitcode FROM uni.unit
        MINUS
    SELECT unitcode FROM UNI.prereq)      
ORDER BY 
    unitcode;
-- or another way,
select 
       unitcode,
       unitname
from 
       uni.unit 

                   minus 
                   select unitcode, unitname from uni.prereq join unit using(unitcode)
order by 
       unitcode;




/* Using subquery */
SELECT unitcode,unitname 
    FROM uni.unit u
WHERE 
    NOT EXISTS (
        SELECT
            NULL
        FROM 
            uni.prereq p
        WHERE
            u.unitcode = p.unitcode
            )
ORDER BY 
    unitcode;
-- or another way
select 
       unitcode,
       unitname
from 
       uni.unit
where 
       (unitcode) not in (select unitcode from uni.prereq)
order by 
       unitcode;


/* 3. List the unit code, year, semester, number of enrolments 
and the average mark for each unit offering. 
Include offerings without any enrolment in the list. 
Round the average to 2 digits after the decimal point. 
If the average result is 'null', display the average as 0.00. 
All values must be shown with two decimal digits. 
Order the list in increasing order of average mark. */



/* 4. List all units offered in semester 2 2019 which do not have any enrolment. 
Include the unit code, unit name, and the chief examiner's name in the list. 
Order the list based on the unit code. */



/* 5. List the id and full name of students who are enrolled in both ‘Introduction to databases’ 
and ‘Introduction to computer architecture and networks’ (note: both unit names are unique)
in semester 1 2020. Order the list by the student id.*/



/* 6. Given that the payment rate for a tutorial is $42.85 per hour 
and the payment rate for a lecture is $75.60 per hour, 
calculate the weekly payment per type of class for each staff member in semester 1 2020. 
In the display, include staff id, staff name, type of class (lecture or tutorial), 
number of classes, number of hours (total duration), 
and weekly payment (number of hours * payment rate). 
Order the list by increasing order of staff id and for a given staff id by type of class.*/


    
/* 7. Given that the payment rate for a tutorial is $42.85 per hour 
and the payment rate for a lecture is $75.60 per hour, 
calculate the total weekly payment (the sum of both tutorial and lecture payments) 
for each staff member in semester 1 2020. 
In the display, include staff id, staff name, total weekly payment for tutorials, 
total weekly payment for lectures and the total weekly payment. 
If the payment is null, show it as $0.00. 
Order the list by increasing order of staff id.*/

select schedclass.staffid, count(clduration)*75.60 as lecture_pay from uni.schedclass inner join uni.staff on schedclass.staffid = staff.staffid where (ofyear = to_date('01/01/2020','dd/mm/yyyy') and cltype = 'L') group by schedclass.staffid;
select schedclass.staffid, count(clduration)*42.85 as tutorial_pay from uni.schedclass inner join uni.staff on schedclass.staffid = staff.staffid where (ofyear = to_date('01/01/2020','dd/mm/yyyy') and cltype = 'T') group by schedclass.staffid;

select staffid, lecture_pay, tutorial_pay from 
    (select schedclass.staffid, count(clduration)*75.60 as lecture_pay from uni.schedclass where (ofyear = to_date('01/01/2020','dd/mm/yyyy') and cltype = 'L') group by schedclass.staffid)
    natural join
    (select schedclass.staffid, count(clduration)*42.85 as tutorial_pay from uni.schedclass where (ofyear = to_date('01/01/2020','dd/mm/yyyy') and cltype = 'T') group by schedclass.staffid);
    
select staff.staffid, stafffname || ' ' || stafflname as staff_name, NVL(lecture_pay,0.00) as lecture_pay, NVL(tutorial_pay,0.00) as tutorial_pay, NVL(lecture_pay+tutorial_pay,0.00) as total_pay from (select staffid, lecture_pay, tutorial_pay from 
    (select schedclass.staffid, count(clduration)*75.60 as lecture_pay from uni.schedclass where (ofyear = to_date('01/01/2020','dd/mm/yyyy') and cltype = 'L') group by schedclass.staffid)
    natural join
    (select schedclass.staffid, count(clduration)*42.85 as tutorial_pay from uni.schedclass where (ofyear = to_date('01/01/2020','dd/mm/yyyy') and cltype = 'T') group by schedclass.staffid))
    u
    right outer join uni.staff on staff.staffid = u.staffid
    order by staffid;

-- another students solution
SELECT 
	Staffid,
	stafffname || '' || stafflname		AS staffname,
'Lecture' as type,
COUNT(cltype)	AS no_of_class,
SUM(clduration)	AS total_hours,
to_char(75.60 * SUM(clduration))        AS weeklypayment 
FROM
	uni.staff join uni.schedclass using (staffid)
WHERE 
	semester = 1 AND to_char(ofyear, 'yyyy') = 2020 AND cltype = 'L'
GROUP BY 
    staffid,
    stafffname,
    stafflname,
    cltype

union

SELECT 
	Staffid,
	stafffname || '' || stafflname		AS staffname,
    'Tutorial' as type,
    COUNT(cltype)	AS no_of_class,
    SUM(clduration)	AS total_hours,
    to_char(42.85 * SUM(clduration))        AS weeklypayment 
FROM
	uni.staff join uni.schedclass using (staffid)
WHERE 
	semester = 1 AND to_char(ofyear, 'yyyy') = 2020 AND cltype = 'T'
GROUP BY 
    staffid,
    stafffname,
    stafflname,
    cltype
    
      order by staffid, type;


    
/* 8. Assume that all units are worth 6 credit points each, 
calculate each student’s Weighted Average Mark (WAM) and GPA. 
Please refer to these Monash websites: https://www.monash.edu/exams/results/wam 
and https://www.monash.edu/exams/results/gpa for more information about WAM and GPA respectively. 
Do not include NULL, WH or DEF grade in the calculation.

Include student id, student full name (in a 40 characters wide column headed “Student Full Name�?), 
WAM and GPA in the display. Order the list by descending order of WAM then descending order of GPA.
If two students have the same WAM and GPA, order them by their respective id.
*/
SELECT
    studid,
    rpad(studfname
         || ' '
         || studlname, 40, ' ')      AS "Student Full Name",
    to_char((SUM(
        CASE
            WHEN unitcode LIKE 'FIT1%' THEN
                mark * 3
            ELSE
                mark * 6
        END
    )) /(SUM(
        CASE
            WHEN unitcode LIKE 'FIT1%' THEN
                3
            ELSE
                6
        END
    )),
            90.99)              AS wam,
    to_char(SUM(
        CASE
            WHEN grade = 'HD'  THEN
                24
            WHEN grade = 'D'   THEN
                18
            WHEN grade = 'C'   THEN
                12
            WHEN grade = 'P'   THEN
                6
            WHEN grade = 'N'   THEN
                1.8
        END
    ) /(COUNT(*) * 6),
            '0.99')             AS gpa
FROM
         uni.student

    NATURAL JOIN uni.enrolment
WHERE
    grade NOT IN ( 'WH', 'DEF' )
    AND grade IS NOT NULL
GROUP BY
    studid,
    studfname,
    studlname
ORDER BY
    wam DESC,
    gpa DESC;







SELECT * FROM drone.drone order by drone_pur_price desc;

-- wrong lel SELECT cust_fname, cust_lname, cust_phone FROM drone.CUSTOMER JOIN drone.cust_train ON CUST_ID WHERE CUST_TRAIN JOIN TRAINING_COURSE ON  ;

SELECT cust_fname || ' ' ||cust_lname as cust_name, cust_phone from drone.training_course tc join drone.cust_train ct on (tc.train_code = ct.train_code and tc.traincourse_date = ct.traincourse_date) 
                                       join drone.customer c on c.cust_id = ct.cust_id
                                       where trainer_id = 1
                                       order by cust_name;

SELECT to_char(sysdate, 'dd-Mon-yyyy hh:mi:ss PM') from dual;
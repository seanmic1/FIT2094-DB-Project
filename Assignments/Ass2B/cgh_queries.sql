--****PLEASE ENTER YOUR DETAILS BELOW****
--cgh_queries.sql

--Student ID: 32185456
--Student Name: Sean Michael
--Tutorial No: 2

/* Comments for your marker:




*/


/*
    Q1
*/
SELECT doctor_title,
    doctor_fname,
    doctor_lname,
    doctor_phone
    FROM cgh.doctor_speciality
    NATURAL JOIN cgh.doctor
    NATURAL JOIN cgh.speciality
    WHERE upper(spec_description) = 'ORTHOPEDIC SURGERY'
    ORDER BY doctor_lname, doctor_fname;


/*
    Q2
*/
select item_code, 
    item_description, 
    item_stock, 
    cc_title 
    from cgh.item
    natural join cgh.costcentre
    where item_stock > 50 and lower(item_description) like '%disposable%'
    order by item_code;


/*
    Q3
*/
select patient_id, 
    trim(leading ' ' from patient_fname || ' ' || patient_lname) as patient_name, 
    to_char(adm_date_time, 'DD-MM-YY HH24:MI') as adm_date_time,
    doctor_title || '. ' || trim(leading ' ' from doctor_fname || ' ' || doctor_lname) as doctor_name 
    from cgh.admission
    natural join cgh.doctor
    natural join cgh.patient
    where adm_date_time between to_date('11-09-21 10:00','DD-MM-YY HH24:MI') and to_date('14-09-21 18:00','DD-MM-YY HH24:MI')
    order by adm_date_time;


/*
    Q4
*/
select proc_code, 
    proc_name, 
    proc_description, 
    to_char(proc_std_cost,'$9999.99') as proc_std_cost 
    from cgh.procedure
    where proc_std_cost < (select round(avg(proc_std_cost),2) from cgh.procedure)
    order by proc_std_cost desc;



/*
    Q5
*/
select patient.patient_id, 
    patient.patient_lname, 
    patient.patient_fname, 
    to_char(patient.patient_dob,'dd-mm-yy') as patient_dob, 
    adm_count 
    from 
    (
        select patient_id, count(adm_no) as adm_count
        from cgh.admission 
        group by patient_id
    ) admission
    left join cgh.patient 
    on patient.patient_id = admission.patient_id
    where adm_count > 2
    order by adm_count desc, patient.patient_dob;

/*
    Q6
*/

select adm_no,
    patient.patient_id,
    patient.patient_fname,
    patient.patient_lname, 
    floor(adm_discharge - adm_date_time) || ' days ' ||
    trim(leading ' ' from to_char(mod(adm_discharge - adm_date_time,1)*24, '990.9')) || ' hrs' as length_of_stay 
    from cgh.admission
    left join cgh.patient
    on patient.patient_id = admission.patient_id
    where 
    adm_discharge is not null
    and
    adm_discharge - adm_date_time > (
        select avg(adm_discharge - adm_date_time)
            from cgh.admission
            where adm_discharge is not null)
    order by adm_no;



/*
    Q7
*/
select procedure.proc_code, 
    proc_name,  
    proc_description,
    proc_time,
    proc_std_cost,
    round(avg_pat_cost - proc_std_cost,2) as proc_price_differential 
    from (
        select proc_code, avg(adprc_pat_cost) as avg_pat_cost 
        from cgh.adm_prc
        group by proc_code
    ) avgs
    left join cgh.procedure
    on procedure.proc_code = avgs.proc_code
    order by proc_code;
    


/*
    Q8
*/
select procedure.proc_code,
    procedure.proc_name,
    NVL(item.item_code,'---') as item_code,
    NVL(item.item_description,'---') as item_description,
    NVL(to_char(max_qty_used),'---') as max_qty_used
    from (select 
        item_code, 
        proc_code, 
        max(it_qty_used) max_qty_used
        from cgh.item_treatment
        left join cgh.adm_prc
        on item_treatment.adprc_no = adm_prc.adprc_no
        group by proc_code, item_code) a
    right join cgh.procedure
    on procedure.proc_code = a.proc_code
    left join cgh.item
    on item.item_code = a.item_code
    order by proc_name, item_code;


/*
    Q9a (FIT2094 only) or Q9b (FIT3171 only)
*/
select 
    distinct a.proc_code,
    procedure.proc_name,
    NVL(to_char(perform_dr_id),'---') as perform_dr_id,
    NVL(trim(trim(leading '.' from doctor.doctor_title || '. ' || doctor.doctor_fname || ' ' || doctor.doctor_lname)),'Technician') as doctor_name,
    to_char(max_pat_cost, '$9990.99') as max_pat_cost
    from (select proc_code, 
        max(adprc_pat_cost) as max_pat_cost 
        from cgh.adm_prc
        group by proc_code) a
    left join cgh.adm_prc
        on a.proc_code = adm_prc.proc_code and a.max_pat_cost = adm_prc.adprc_pat_cost
    left join cgh.procedure
        on a.proc_code = procedure.proc_code
    left join cgh.doctor
        on perform_dr_id = doctor.doctor_id
    order by proc_code, perform_dr_id;
    
    


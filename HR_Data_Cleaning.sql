SELECT * FROM project.hr;
use project;

Alter table hr
change column ï»¿id emp_id varchar(20) Null;

Describe hr;

Select birthdate from hr;

/* Update is not allowed as the safe mode is on so we need to close it*/

set sql_safe_updates=0;

Update hr
set birthdate = Case
	when birthdate like '%/%' then date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
	when birthdate like '%-%' then date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
	else Null
end ;

Alter table hr
modify column birthdate date;

Update hr
set hire_date = Case
	when hire_date like '%/%' then date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
	when hire_date like '%-%' then date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
	else Null
end ;

select hire_date from hr;

/* here %h shows value in hour,i shows value in minutes and s shows value in seconds . And the Y of year should always be capital*/
update hr
set termdate = date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate!='';

select termdate from hr;

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

UPDATE HR
SET termdate='0000-00-00'
where termdate='';

update hr
set termdate = date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NULL;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

ALTER TABLE hr ADD COLUMN AGE INT;

select * from hr;

update hr 
set age=timestampdiff(Year,birthdate,CURDATE()); 

select birthdate , age from hr;

select count(*) from hr where age<18;

 
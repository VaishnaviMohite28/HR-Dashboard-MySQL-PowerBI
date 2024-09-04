-- HR DAAT QUESTIONS 
-- 1. WHAT IS THE GENDER BREAKDOWN OF EMPLOYEES IN THE COMPANY ?

SELECT gender,COUNT(*) AS COUNT
FROM hr
WHERE age>=18 and termdate='0000-00-00'
group by gender;


-- 2. WHAT IS THE RACE /ETHENTICITY BREAKDOWN OF EMPLOYEES IN THE COMPANY ?

SELECT race,COUNT(*) AS COUNT
FROM hr
WHERE age>=18 and termdate='0000-00-00'
group by race
order by count(*) desc;

-- 3.WHAT IS THE AGE DISTRIBUTION OF EMPLOYEES IN THE COMPANY ?

select min(age) as youngest, max(age) as oldest from hr
WHERE age>=18 and termdate='0000-00-00';

select 
 case
	when age>=18 and age<=24 then '18-24'
    when age>=25 and age<=34 then '25-34'
    when age>=35 and age<=44 then '35-44'
    when age>=45 and age<=54 then '45-54'
    when age>=55 and age<=64 then '55-64'
	else '65+'
 end as age_group,
 count(*) as count
 from hr
 WHERE age>=18 and termdate='0000-00-00'
 group by age_group
 order by age_group;
 
 select 
 case
	when age>=18 and age<=24 then '18-24'
    when age>=25 and age<=34 then '25-34'
    when age>=35 and age<=44 then '35-44'
    when age>=45 and age<=54 then '45-54'
    when age>=55 and age<=64 then '55-64'
	else '65+'
 end as age_group,gender,
 count(*) as count
 from hr
 WHERE age>=18 and termdate='0000-00-00'
 group by age_group,gender
 order by age_group,gender;
 

-- 4.HOW MANY EMPLOYEES WORK AT THE HEADQUARTERS VERSUS THE REMOTE LOCATION ?

select location,count(*) as count from hr
where age>=18 and termdate='0000-00-00' 
group by location;

-- 5.WHAT IS THE AVERAGE LENGTH OF EMPLOYMENT FOR EMPLOYEES WHO HAVE BEEN TERMINATED? 

select round(avg(datediff(termdate,hire_date))/365,0) as avg_length_employment
from hr
where termdate<=curdate() and termdate<>'0000-00-00' and age>=18;

-- 6.HOW DOES GENDER DISTRIBUTION VARY ACROSS DEPARTMENTS AND JOB TITLES ?

select department ,gender,count(*) as count 
from hr
WHERE age>=18 and termdate='0000-00-00'
group by department,gender
order by department;

-- 7.WHAT IS THE DISTRIBUTION OF JOB TITLES ACROSS THE COMPANY ?

select jobtitle,count(*) as count 
from hr
WHERE age>=18 and termdate='0000-00-00'
group by jobtitle
order by jobtitle desc;

-- 8.WHICH DEPARTMNET HAS THE HIGHEST TURN OVER RATE ?

select department,total_count,terminated_count ,terminated_count/total_count as termination_rate
from(select department,count(*) as total_count,
sum(case when termdate<>'0000-00-00' and termdate<=curdate() then 1 else 0 end) as terminated_count
from hr
where age>=18 
group by department )
as subquery
order by termination_rate desc

-- 9.WHAT IS THE DISTRIBUTION OF EMPLOYEES ACROSS LOCATIONS BY CITY AND STATE ?

select location ,location_city ,location_state ,count(*) as count
from hr
WHERE age>=18 and termdate='0000-00-00'
group by location,location_city,location_state;

select location_state ,count(*) as count
from hr
WHERE age>=18 and termdate='0000-00-00'
group by location_state
order by count desc;

select location_city ,count(*) as count
from hr
WHERE age>=18 and termdate='0000-00-00'
group by location_city
order by count desc;

-- 10.HOW HAS THE COMPANYS EMPLOYEE COUNT CHANGED OVER TIME BASED ON HIRE AND TERM DATES?

select Year,
hires,
hire_terminations as net_change,
round((hire_terminations)/hires*100, 2) as net_change_percent
from(
	select
		Year(hire_date) as Year,
		count(*) as hires,
		SUM(case when termdate <>'0000-00-00'and termdate<=curdate() then 1 else 0 end) as hire_terminations
		from hr
		where age>=18
		group by year(hire_date)
		)as subquery
order by year asc;


-- 11.WHAT IS THE TENTURE DISTRIBUTION FOR EACH DEPARTMENT ?

select department,round(avg(datediff(termdate,hire_date)/365),0) as avg_tenure
from hr
where termdate<= curdate() and termdate<>'0000-00-00' and age>=18
group by department;
--사원중 부서배치받지 못한 사원(사번, 이름, 부서번호)을 출력하시오
select employee_id, first_name, department_id
from employees
where department_id IS NULL;


--사원의 사번, 이름, 부서번호, 부서명을 출력하시오 (null값이 나오지 않음)
select employee_id, first_name, d.department_id, department_name
from employees e JOIN departments d ON (e.department_id = d.department_id);



--사원의 사번, 이름, 부서번호, 부서명을 출력하시오. 단, 부서가 없는 사원도 출력하시오. (null값도 나옴.)
select employee_id, first_name, d.department_id, department_name
from employees e left OUTER JOIN departments d ON (e.department_id = d.department_id)
order by employee_id;


--사원의 사번, 이름, 부서번호, 부서명을 출력하시오. 단, 부서가 없는 사원도 출력하시오. (null값도 나옴.)
select employee_id, first_name, d.department_id, department_name
from employees e, departments d
where e.department_id = d.department_id(+)
order by employee_id;


--지역ID와 도시명을 출력하시오
select location_id, city
from locations;



--부서ID와 지역 ID를 출력하시오
select department_id, l.location_id
from departments d JOIN locations l ON d.location_id = l.location_id;


--도시에 속한 부서명을 출력하시오
select city, department_name
from  departments d JOIN locations l ON (d.location_id = l.location_id);


--도시에 속한 부서명을 출력하시오. 부서가 없는 도시도 출력하시오 // 표준표기법
select city, department_name
from  departments d right JOIN locations l ON (d.location_id = l.location_id);
                              --null값을 가진 도시도 출력하겠음

--도시에 속한 부서명을 출력하시오. 부서가 없는 도시도 출력하시오 // 오라클 전용 표기법
select city, department_name
from  departments d, locations l
where d.location_id(+) = l.location_id; --값이 부족한 쪽에 (+)표시



--사원의 사번, 이름, 부서번호, 부서명을 출력하시오. 
--단, 부서가 없는 사원도 출력하고, 사원이 없는 부서도 모두 출력하시오 // 
select department_id, department_name
from departments;

select employee_id, d. department_id, department_name
from employees e full JOIN departments d ON (e.department_id = d.department_id);


select employee_id, first_name, d.department_id, department_name
from employees e left OUTER JOIN departments d ON (e.department_id = d.department_id)
order by employee_id;


select (select
from   (select
where






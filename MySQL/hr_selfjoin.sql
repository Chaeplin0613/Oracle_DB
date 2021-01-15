











--<SELF JOIN>
--사원의 사번, 이름, 관리자번호, 관리자이름을 출력하시오
select e.employee_id 사번, e.first_name 이름,
       m.employee_id 관리자번호, m.first_name 관리자이름
from employees e JOIN employees m ON e.manager_id = m.employee_id
ORDER BY e.employee_id;

--'Davis'사원과 같은 부서에 근무하는 사원들을 출력하시오
select e.employee_id, e.last_name, e.department_id
from employees e JOIN employees davis ON (e.department_id = davis.department_id)
where davis.last_name = 'Davies';
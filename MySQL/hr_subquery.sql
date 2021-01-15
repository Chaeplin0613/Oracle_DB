--부서별 부서id, 최대급여를 출력.
select department_id, TO_CHAR(max(salary),'999,999,999')
from employees
group by department_id
order by department_id;


--부서별 최대급여를 받는 사원의 사번, 이름, 급여
--(----  1 -----)  (-----  2  ------)

--최대급여를 출력하시오(1)
select max(salary) from employees;

--최대급여를 받는 사원의 사번, 이름, 급여를 출력하시오 
--(1) 최대급여계산
--(2) (1)과 같은 급여를 받는 사원의 정보출력
select employee_id, first_name, salary
from employees
where salary = (select max(salary) from employees);
-- 이콜( = ) 은 결과를 한개

--부서별 최대급여를 받는 사원의 사번, 이름, 급여를 출력하시오
--(1) 부서별 최대급여계산: 결과가 어려행을 반환. 일반비교연산자사용안됨(IN, ANY, ALL은 가능, 여러행 반환시)
--(2) (1)과 같은 급여를 받는 사원의 정보출력
select employee_id, first_name, salary, department_id
from employees
where salary in (select max(salary) 
                 from employees 
                 group by department_id)
order by department_id, salary;


--부서별 최대급여를 받는 사원의 사번, 이름, 급여를 출력하시오
--1) 부서별 최대급여계산된 부서번호와 최대급여를 반환: 여러행반환, 여러컬럼반환
select employee_id, first_name, salary, department_id
from employees
where (department_id, salary) IN (select department_id, max(salary) 
                                    from employees 
                                    group by department_id)
order by department_id;
--where절 비교 컬럼개수와 서브쿼리의 컬럼 개수를 맞춰줘야 한다.



select *
from employees
where exists (select department_id
                from departments
                where department_id = 100);
--exists_서브쿼리 조건: 부서번호가 100이 있으면 다 출력하라


--인라인뷰
--사원의 사번, 입사일, 급여를 출력하시오
select employee_id, hire_date, salary
from employees;

--오라클 제공 의사컬럼: rownum (행번호를 알려줌)
--사원의 사번, 입사일, 급여를 출력하시오
select rownum, employee_id, hire_date, salary
from employees;
    




--사원의 사번, 입사일, 급여를 출력하시오, 내림차순 적용
select rownum, employee_id, hire_date, salary
from employees
order by salary desc;
--rownum이 먼저 만들어진 다음에 정렬을 적용했기 때문에 뒤죽박죽 되는거다.


--select 처리순서: from -> where -> group by -> having -> select -> order by
--사원의 사번, 입사일, 급여를 출력하시오, 급여가 많은 사원부터 출력하시오
--행번호는 급여많은 순서대로 1씩 증가한다.(정렬 먼저 한 후에 행번호 발급)
select rownum, employee_id, hire_date, salary --select서브쿼리: 스칼라 서브쿼리
from (select employee_id, hire_date, salary --from서브쿼리: 인라인뷰
        from employees
        order by salary desc);

--별칭 지정
select rownum, emps.* --select서브쿼리: 스칼라 서브쿼리
from (select employee_id, hire_date, salary --from서브쿼리: 인라인뷰
        from employees
        order by salary desc)emps;



--사원의 사번, 입사일, 급여를 출력하시오, 급여가 많은 사원부터 출력하시오
--행번호는 급여많은 순서대로 1씩 증가한다.(정렬 먼저 한 후에 행번호 발급)
--행번호가 1~10인 사원들을 출력하시오.가
select rownum, emps.* --select서브쿼리: 스칼라 서브쿼리
from (select employee_id, hire_date, salary --from서브쿼리: 인라인뷰
        from employees
        order by salary desc emps
where rowunm between 1 and 10;

--사원의 사번, 입사일, 급여를 출력하시오, 급여가 많은 사원부터 출력하시오
--행번호는 급여많은 순서대로 1씩 증가한다.(정렬 먼저 한 후에 행번호 발급)
--행번호가 11~20인 사원들을 출력하시오.
select rownum, emps.* --select서브쿼리: 스칼라 서브쿼리
from (select employee_id, hire_date, salary --from서브쿼리: 인라인뷰
        from employees
        order by salary desc emps
where rowunm between 11 and 20;
-------------------------------------------------------------------

--사원의 사번, 입사일, 급여를 출력하시오, 급여가 많은 사원부터 출력하시오
--행번호는 급여많은 순서대로 1씩 증가한다.(정렬 먼저 한 후에 행번호 발급)
--행번호가 1~5인 사원들을 출력하시오.
--★★★★★중요 
select * -- *표는 rownum, employee_id, hire_date, salary
from (select rownum r, emps.*
    from (select employee_id, hire_date, salary --from서브쿼리: 인라인뷰
            from employees
            order by salary desc) emps)
where r between 1 and 5; --인라인뷰 컬럼을 쓰려면 별칭을 사용하면 된다.


------------------------------------------------------------
--스칼라 쿼리
--사원의 사번, 급여, 부서번호, 부서명을 출력하시오
select employee_id, salary, department_id, --projection
    (select department_name 
    from departments 
    where department_id = employees.department_id) 
from employees; --selection
--------------------------------------------------------------
--111번 사원의 급여보다 많은 급여를 받는 같은 부서의 사원의 사번, 급여, 부서번호를 출력하시오.
select employee_id, salary, department_id
from employees
where (department_id, salary) > (select department_id, salary 
                from employees 
                where employee_id=111); --(x) 안 되는 문법이다.
--서브쿼리에 컬럼이 1개보다 많으면 일반연산자 >, <, =를 못쓰고
--in, any 등을 써야한다.
--------------------------------------------------------------
--상호연관서브쿼리(퍼포먼스가 조금 떨어짐)
select employee_id, salary, department_id, first_name
from employees e
where salary > (select salary 
                from employees e111
                where employee_id=111
                AND e.department_id = e111.department_id);

--------------------------------------------------------------
--exists 연산자 ★★★★★
--사원이 있는 부서들을 출력하시오
select *
from departments
where exists
    (select department_id 
    from employees
    where department_id = 90
    ); --사원이 존재하는 부서를 출력하라라는 뜻.

--not exists 연산자 ★★★★★
--사원이 없는 부서들을 출력하시오
select *
from departments
where not exists
    (select department_id 
    from employees
    where department_id = departments.department_id
    ); --사원이 존재하지 않는 부서들을 출력하라는 뜻
    
--------------------------------------
--NULL값을 갖는 SUBQUERY, distinct(중복값 제거)
--짝수번 사원의 부서번호와 부서명을 출력하시오
select department_id, department_name
from departments
where department_id
        in(select distinct department_id --null 포함
        from employees 
        where mod(employee_id,2)=0); --10건
    
select department_id, department_name
from departments
where department_id
        not in(select distinct department_id --null 포함
        from employees 
        where mod(employee_id,2)=0); --0건
        
    
    
select department_id, department_name
from departments
where department_id
        not in(select distinct nvl(department_id,0) --null 포함
        from employees 
        where mod(employee_id,2)=0);    
    --짝수번 사원이 근무하지 않는 부서일 뿐이지 홀수 사원이 근무하는 부서라 생각하면 안 된다.
    
    
------------------------------------------------------------------------------------------------------------
--1.관리자급여보다 많은 급여를 받는 사원의 사번, 성명, 급여, 관리자번호, 관리자성명, 관리자급여를 출력하시오        // 절반해결 

select 
    e.employee_id 사번, 
    e.first_name||' '||e.last_name 성명,
    e.salary,
    m.manager_id,
    m.first_name||' '||m.last_name 관리자성명,
    m.salary
from employees e JOIN employees m ON (e.manager_id = m.employee_id)
where e.salary > m.salary;

--강사님
SELECT 
    e.employee_id 사번, 
    e.first_name 성명,
    e.salary 사원급여,
    m.employee_id 관리자번호, 
    m.first_name 관리자성명,
    m.salary 관리자급여
FROM employees e JOIN employees m ON (e.manager_id = m.employee_id)
WHERE e.salary > m.salary; 


------------------------------------------------------------------------------------------------------------
--2.사원과 관리자가 다른부서에서 근무하는 사원들의 사번, 성명, 부서명, 관리자번호, 관리자성명, 관리자부서명을 출력하시오      // 절반해결
select 
    e.employee_id 사번,
    e.first_name 성명,
    d.department_name 부서명,
    m.employee_id 관리자번호,
    m.first_name 관리자성명,
    md.department_name 관리자부서명 
from employees e 
    JOIN employees m ON (e.manager_id = m.employee_id)   
    JOIN departments d ON (e.department_id = d.department_id)
    JOIN departments md ON (d.department_id = md.department_id)
where e.department_id <> m.department_id;


--강사님 
SELECT e.employee_id 사번
     , e.first_name||' '||e.last_name 성명
     , ed.department_name "부서명"
     , e.manager_id 관리자번호
     , m.first_name||' '||m.last_name 관리자성명
     , md.department_name "관리자부서명"
FROM employees e
     JOIN employees m ON (e.manager_id = m.employee_id )
     JOIN departments ed ON (e.department_id = ed.department_id)
     JOIN departments md ON (m.department_id = md.department_id)
WHERE ed.department_id <> md.department_id;




------------------------------------------------------------------------------------------------------------
--3.사원들의 사번, 이름, 부서ID, 부서명,도시명을 출력하시오(SUBQUERY사용)       // 절반해결 
select 
    e.employee_id, 
    e.first_name, 
    d.department_id, 
    d.department_name 부서명, 
    l.city 도시명
from employees e JOIN departments d ON (e.department_id = d.department_id)
                 JOIN locations l ON (d.location_id = l.location_id);



--3.사원들의 사번, 이름, 부서ID, 부서명,도시명을 출력하시오(SUBQUERY사용)       // 절반해결 





--서브쿼리
SELECT employee_id, first_name, department_id,
    (SELECT department_name 
    FROM departments d
    WHERE d.department_id = e.department_id)부서명,
        (SELECT city
        FROM locations
        WHERE location_id =(SELECT location_id 
                            FROM departments
                            WHERE e.department_id = department_id)) 도시명                   
FROM employees e;




------------------------------------------------------------------------------------------------------------
--4.성이 'Davies'인 사원과 같은 부서에 근무하는 사원들의 사번, 성, 이름을 출력하시오. 단(AND) Davies사원정보는 출력하지 않는다.(SUBQUERY사용)     // 해결완료
select employee_id, last_name, first_name
from employees
where department_id = (select department_id
                        from employees
                        where last_name LIKE 'Davies') AND last_name <> 'Davies';


SELECT employee_id 사번,
       last_name 성,
       first_name 이름
FROM employees e
WHERE department_id = (SELECT department_id
                       FROM employees
                       WHERE last_name = 'Davies')
      AND last_name <> 'Davies';

------------------------------------------------------------------------------------------------------------
--5.부서명이 'Sales'부서의 평균급여보다 많은 급여를 받는 'Sales'부서의 사원의 사번, 급여 출력하시오.(SUBQUERY사용)

 --IN = or 개념으로 다 가져온다는 뜻
select *
from employees e, departments d
where 
    e.department_id = d.department_id 
    AND (salary > (select avg(salary) from employees where department_id 
    IN (select department_id from departments where department_name = 'Sales'))) 
    AND d.department_name = 'Sales';

--작업처리순서 
 --1) select * from
 --2) where조건
 --3) table세팅
 
  SELECT department_id, employee_id, salary
FROM employees 
WHERE department_id = (SELECT department_id 
                       FROM departments 
                       WHERE department_name='Sales')
AND salary > (SELECT AVG(salary) FROM employees
                     WHERE department_id = 
                       (SELECT department_id 
                        FROM departments 
                        WHERE department_name='Sales'));
                        
--상호연관서브쿼리로 해결
SELECT department_id, employee_id, salary
FROM employees maine
WHERE department_id = (SELECT department_id 
                       FROM departments 
                       WHERE department_name='Sales')
AND salary > (SELECT AVG(salary) FROM employees
                     WHERE department_id = 
                            maine.department_id);




------------------------------------------------------------------------------------------------------------
--6.'Seattle', 'Toronto'도시에  근무하는 사원들의 도시명, 사번, 이름, 부서ID, 부서명을 출력하시오.
--(SUBQUERY사용)
select 
    l.city, 
    e.employee_id, 
    e.first_name, 
    d.department_name
from 
    employees e, 
    departments d, 
    locations l
where l.city IN ('Seattle', 'Toronto') 
    And e.department_id = d.department_id 
    And d.location_id=l.location_id;
--복수 테이블에서는 join 을 반드시 해줘야 한다.


SELECT employee_id, first_name, department_id
      ,(SELECT department_name FROM departments d
        WHERE d.department_id = e.department_id)
      ,(SELECT city
        FROM locations
        WHERE location_id =(SELECT location_id 
                            FROM departments
                            WHERE department_id = e.department_id)
        )        
FROM employees e
WHERE department_id IN (SELECT department_id
                       FROM departments
                       WHERE location_id IN (SELECT location_id
                                             FROM locations
                                             WHERE city IN('Seattle', 'Toronto')
                                             )
                       );



desc employees;





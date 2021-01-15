select empno
from emp; --14건

select deptno
from dept; --4건










--오라클 전용 JOIN 표기법
select empno, ename, emp.deptno, dname, loc
from emp, dept
where emp.deptno = dept.deptno;

--ANSI 표준 JOIN 표기법
select empno, ename, emp.deptno, dname, loc
from emp JOIN dept ON emp.deptno = dept.deptno;

--NATURAL JOIN 표기법 
select empno, ename, deptno, dname, loc
from emp NATURAL JOIN dept;

select empno,ename, deptno, dname, loc
from emp JOIN dept USING (deptno); --USING을 이용하여 특정 셀만 JOIN 시키겠다는 뜻







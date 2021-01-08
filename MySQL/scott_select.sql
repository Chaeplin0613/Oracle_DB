














SELECT empno, sal
FROM emp;

SELECT * --프로젝션
FROM EMP; --셀렉션








-------컬럼 별칭 주기
SELECT empno 사번, ename, sal 급여
FROM emp;

-------컬럼 별칭주기 2
SELECT empno "사원 번호", ename, sal AS 급여
FROM emp;

-------컬럼값 결합연산자 ||(파이프)
SELECT EMPNO||ENAME||SAL
FROM EMP;

-------컬럼값 결합연산자 ||(파이프) 별칭붙여넣기
SELECT EMPNO||ENAME||SAL"사번과 이름과 급여"
FROM EMP;

--SQL에서의 문자열 리터럴과 날짜형 리터럴은 작은따옴표(' ')를 사용한다. EX) 'HELLO', '21/05/07'
SELECT EMPNO||'_'||ENAME||'_'||SAL"사번과 이름과 급여"
FROM EMP;


--산술연산자 : +, -, *, / 나머지값을 구하는 연산자는 없지만 MOD()함수를 쓰면 된다.

--2로 나눈 나머지 값을 반환
SELECT empno, MOD(empno, 2), ename, sal, sal*12
FROM emp;

--------------------------

SELECT deptno
FROM emp; --14건 출력


--중복값 제거하기
SELECT DISTINCT deptno
FROM emp; --3건 출력


--급여 내림차순으로 정렬시키기
SELECT empno, ename, sal
FROM emp
ORDER BY sal DESC;            --DESC: 내림차순



--급여가 내림차순으로 정렬하다가 급여값이 같을 때 이름을 오름차순으로 정렬시키기
SELECT empno, ename, sal
FROM emp
ORDER BY sal DESC, ename ASC;            --ASC: 오름차순                             //순서에 따라 우선순위가 매겨지는건지?

--------------------------------------------------------------
--SELECT 구문 처리 순서: 
--                   셀렉션                             프로젝션
---    [ FROM -> WHERE -> GROUP BY -> HAVING ]->[ SELECT -> ORDER BY]
--SELECT
--FROM
--[
--WHERE
--GROUP BY
--HAVING
--ORDER BY
--] 괄호안은 생략가능

--ORDER BY 구문에서 별칭으로 내림차순 사용하기
SELECT empno, ename, sal "급여"
FROM emp
ORDER BY 급여 DESC, ename;


--ORDER BY에서 프로젝션에 참여하지 않은 컬럼사용가능
SELECT empno, ename
FROM emp
ORDER BY sal DESC;


--ORDER BY에서 프로젝션에 참여한 컬럼순번을 사용가능
SELECT empno, ename, sal
FROM emp
ORDER BY 3 DESC;        --프로젝션에 참여한 첫번째 컬럼, 즉 empno를 의미
--DB에서는 인덱스가 무조건 1부터 시작함
 
 --WHERE 절 : 조건에 만족하는 행을 셀렉션
 --비교연산자 : >, >=, <, <=, = SQL에서는 대입이라는 개념이 없고 같다를 표현할 때에는 = 하나만 쓴다
 --논리연산자 : AND, OR, NOT

 --급여가 1250인 사원의 사번, 이름, 급여를 출력하시오
SELECT empno, ename, sal
FROM emp
WHERE sal=1250;

--급여가 1250보다 많은(초과) 사원의 사번,이름,급여를 출력하시오. 단 급여가 많은 사원부터 출력한다.
SELECT empno, ename, sal
FROM emp
WHERE sal>1250
ORDER BY sal DESC;


--급여가 1500이상 3000이하의 사원의 사번,이름,급여를 출력하시오. 단 급여 내림차순으로 정렬한다.
SELECT empno, ename, sal
FROM emp
WHERE sal>=1500 AND sal<=3000
ORDER BY sal DESC;

--급여가 1500이상 3000이하의 사원의 사번,이름,급여를 출력하시오. 단 급여 내림차순으로 정렬한다. 
--AND연산의 대상이 동일한 경우와 비교값이 이상, 이하인 경우 BETWEEN 사용가능
SELECT empno, ename, sal
FROM emp
WHERE sal BETWEEN 1500 AND 3000 --1500이상 3000이하라는 뜻
ORDER BY sal DESC;

--급여가 1500미만 3000초과의 사원의 사번,이름,급여를 출력하시오. 단 급여 내림차순으로 정렬한다. 
--AND연산의 대상이 동일한 경우와 비교값이 이상, 이하인 경우 BETWEEN 사용가능하고 NOT으로 묶을 수 있음
SELECT empno, ename, sal
FROM emp
WHERE NOT sal BETWEEN 1500 AND 3000 --1500미만과 3000초과라는 뜻
ORDER BY sal DESC;


--급여가 1500미만 3000초과인 사번,이름,급여를 출력하시오.ver1 단 급여 내림차순으로 정렬한다.
SELECT empno, ename, sal
FROM emp
WHERE sal<1500 OR sal>3000
ORDER BY sal DESC;


--급여가 1500미만 3000초과인 사번,이름,급여를 출력하시오.ver2 단 급여 내림차순으로 정렬한다.
SELECT empno, ename, sal
FROM emp
WHERE NOT(sal<1500 OR sal>3000)
ORDER BY sal DESC;

-----------------------------
--부서번호가 10번이거나 30번인 사원의 사번,이름,급여,부서번호 출력하시오ver1
SELECT empno, ename, sal, deptno
FROM emp
WHERE deptno = 10 OR deptno = 30
ORDER BY sal DESC;

--부서번호가 10번이거나 30번인 사원의 사번,이름,급여,부서번호 출력하시오ver2
SELECT empno, ename, sal, deptno
FROM emp
WHERE deptno IN(10, 30)
ORDER BY sal DESC;




--부서번호가 10번이거나 30번인 사원들중 급여가 1500이상 3000이하인 사원 사번,이름,급여,부서번호 출력하시오_강사님
SELECT empno, ename, sal, deptno
FROM emp
WHERE (deptno=10 OR deptno=30) AND (sal >= 1500 AND sal <= 3000);


--부서번호가 10번이거나 30번인 사원들중 급여가 1500이상 3000이하인 사원 사번,이름,급여,부서번호 출력하시오_채플린
SELECT empno, ename, sal, deptno
FROM emp
WHERE (deptno IN(10, 30)) AND (sal BETWEEN 1500 AND 3000)
ORDER BY sal DESC;


--사원의 직무(JOB)를 출력하시오

SELECT empno, job
FROM emp;



--'MAN' 단어를 포함한 직무를 갖는 사원의 사번과 직무를 출력하시오
SELECT empno, job
FROM emp
WHERE job LIKE '%MAN%'; --job컬럼에 MAN을 찾아라. %어떤 단어가 와도 상관없이 검색


--'MAN' 단어를 포함한 직무를 갖는 사원의 사번과 직무를 출력하시오
SELECT empno, job
FROM emp
WHERE job LIKE 'MAN%';



--직무가 SALES로 시작하고 8단어로 구성된 사원의 사번, 직무를 출력하시오
SELECT empno, JOB
FROM emp
WHERE job LIKE 'SALES___';


--사번과 입사일자를 출력하시오
SELECT empno, hiredate
FROM emp;


--입사일자가 81년도인 사원의 사번과 입사일자를 출력 ver1
SELECT empno, hiredate
FROM emp
WHERE hiredate LIKE '81%';


--입사일자가 81년도인 사원의 사번과 입사일자를 출력 ver2
SELECT empno, hiredate
FROM emp
WHERE hiredate>='81/01/01' AND hiredate<='81/12/31';


--입사일자가 81년도인 사원의 사번과 입사일자를 출력 ver3
SELECT empno, hiredate
FROM emp
WHERE hiredate BETWEEN '81/01/01' AND '81/12/31';


--NULL관련 연산자: IS NULL, IS NOT NULL 연산자로 비교해야함
--DB에서 NULL은 아무값도 아니다
SELECT empno, sal, comm
FROM emp;

--수당이 없는 사원의 사번,급여,수당을 출력하시오
SELECT empno, sal, comm
FROM emp
WHERE comm IS NULL;      --comm이 NULL값인 자료를 찾아라


--집합연산자
--10번 부서사원과 30번 부서사원의 사번, 부서번호를 출력하시오.
SELECT empno, deptno
FROM emp
WHERE deptno = 10
UNION
SELECT empno, deptno
FROM emp
WHERE deptno = 30;

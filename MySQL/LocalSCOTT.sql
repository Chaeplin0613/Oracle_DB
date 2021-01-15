SELECT empno, sal
FROM emp;

SELECT *  --프로젝션
FROM emp; --셀렉션
---------------------
--컬럼별칭주기
SELECT empno AS "사번 번호", ename, sal 급여
FROM emp;
---------------------------------
--컬럼값  결합연산자  ||
SELECT empno || ename ||sal
FROM emp;

SELECT empno || ename ||sal "사번과 이름과 급여"
FROM emp;

--SQL의 문자열리터널, 날짜리터럴은 '를 사용한다 ex) 'helllo', '21/05/08'
SELECT empno ||'-'|| ename ||'-' || sal  "사번과 이름과 급여"
FROM emp;
----------------------------------
--산술연산자 : +, -, *, / 
--나머지값구하는 함수 : MOD()
SELECT empno, MOD (empno, 2), ename, sal, sal*12
FROM emp;
---------------------------------
SELECT DISTINCT deptno
FROM emp;   --3건
--조건에 만족해서 가져 오는 것을 셀렉션이다
---------------------------------
--*프로젝션 정렬하기, 오더바이문법
SELECT empno, ename, sal        --ASC는 Ascending에 약자 "오름차순" 을 뜻한다
FROM emp                        --오름차순(ASC)이나 내림차순(DESC)
ORDER BY sal DESC, ename ASC;   --DESC는 descending에 약자 "내림차순"  을 뜻한다  급여가 많은순서대로보여준다
                                --단, 급여가 같으면 이름을 사전순으로 출력한다  내림차순은 사전의 역순이다
----------------------------------
SELECT구문 처리 순서 :[FROM -> WHERE -> GROUP BY -> HAVING] -> [SELECT -> ORDER BY]
------------------------------------------------------------------------------- 
SELECT
FROM
[
WHERE
GROUP BY
HAVING
ORDER BY
]
--ORDER BY 에서 별칭사용가능
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
ORDER BY 3 DESC;  --디비에서는 어떤 디비건 무조건 인덱스가 1부터이다
                  --자바언어에서는 0부터 시작한다 
------------------------------------
--WHERE절 : 조건에 만족하는 행을 셀렉션
--비교연산자 : >, >=, <, <=, =  SQL에서늬 이콜 = 연산다는 무조건 같다는 표시이다
--논리연산다 : AND, OR, NOT

--급여가 1250인 사원의 사번, 이름, 급여를 출력하시오
--SELECT구문은 독립적으로 사용불가능하고 FROM절과 항상 같이 사용된다
SELECT empno, ename, sal
FROM emp
WHERE sal = 1250;

--급여가 1250보다 많은 사원의 사번,이름,급여를 출력하시오 단, 급여가 많은 사원부터 출력하시오
SELECT empno, ename, sal
FROM emp
WHERE sal > 1250
ORDER BY sal DESC;

-------------------------------------------------
--급여가 1250보다 많은 사원의 사번,이름,급여를 출력하시오 단, 급여가 적은 사원부터 출력하시오
SELECT empno, ename, sal
FROM emp
WHERE sal > 1250
ORDER BY sal ASC;
-----------------------------------------------
--급여가 1500이상 3000이하인 모든 사원의 사번,이름,급여를 출력하시오 단, 급여가 많은 사원부터 출력하시오
SELECT empno, Ename, sal
FROM emp
WHERE NOT (sal >= 1500 AND sal <= 3000)  --NOT 는 반대의 결과를 출력해준다 이것은 아래문제와 내용이 같다
ORDER BY sal DESC;
------------------------------------------------
--급여가 1500미만 3000초과인 모든 사원의 사번,이름,급여를 출력하시오 단, 급여가 많은 사원부터 출력하시오
SELECT empno, Ename, sal
FROM emp
WHERE sal < 1500 OR sal > 3000 
ORDER BY sal DESC;
-----------------------------------------------
--급여가 1500이상 3000이하인 모든 사원의 사번,이름,급여를 출력하시오 단, 급여가 많은 사원부터 출력하시오
SELECT empno, Ename, sal
FROM emp
WHERE sal >= 1500 AND sal <= 3000
ORDER BY sal DESC;
----------------------------------------
--BETWEEN 연산자로 AND 연산의 값을 똑같이 출력이 가능하다.
SELECT empno, Ename, sal
FROM emp
WHERE sal BETWEEN 1500 AND 3000
ORDER BY sal DESC;
-----------------------------------------------
--급여가 1500이상 3000이하인 모든 사원의 사번,이름,급여를 출력하시오 단, 급여가 많은 사원부터 출력하시오
SELECT empno, Ename, sal
FROM emp
WHERE NOT (sal >= 1500 AND sal <= 3000)  --NOT 는 반대의 결과를 출력해준다 이것은 아래문제와 내용이 같다
ORDER BY sal DESC;
----------------------------------------------
--급여가 1500이상 3000이하인 모든 사원의 사번,이름,급여를 출력하시오 단, 급여가 많은 사원부터 출력하시오
SELECT empno, Ename, sal
FROM emp
WHERE NOT sal BETWEEN 1500 AND 3000  -- BETWEEN 연산자로 NOT을 같이사용하여 코드를 깔끔하게 만들어줄수있다
ORDER BY sal DESC;                   -- 출력값은 동일하다. BETWEEN 연산자 안에는 AND 라는 개념이 들어가 있다
------------------------------------------------
--부서번호가 10, 30번인 사원의 사번, 이름, 급여, 부서번호를 출력하시오
SELECT empno, ename, sal, deptno
FROM emp
WHERE deptno=10 OR deptno=30;  -- 이부분을 IN 연산자 로 바꿔줄수도있다
------------------------------------------------
--부서번호가 10, 30번인 사원의 사번, 이름, 급여, 부서번호를 출력하시오
SELECT empno, ename, sal, deptno
FROM emp
WHERE deptno IN ( 10 , 30 ); -- IN 연산자 안에는 OR 라는 개념이 들어가있다
----------------------------------------------------
--부서번호가 10,30번인 사원의
--급여가 1500이상 3000이하인 사원들의 사번, 이름, 급여를 출력하세요.
SELECT empno, ename, sal, deptno
FROM emp
WHERE (deptno=10 OR deptno=30)
    AND (sal >= 1500 AND sal <= 3000)
ORDER BY sal DESC;
----------------------------------------------------
--부서번호가 10,30번인 사원의
--급여가 1500이상 3000이하인 사원들의 사번, 이름, 급여를 출력하세요.
SELECT empno, ename, sal, deptno
FROM emp
WHERE deptno IN  (10,30)
    AND sal BETWEEN 1500 AND 3000;           -- 바로위에 코드를 IN연산자와 BETWEEN 연산자로 바꾸어 깔끔하게 만들어놓은것
ORDER BY sal DESC;                           -- 출력값은 같다
----------------------------------------------------
--사원의 직무를 출력하시오.
SELECT empno, job
FROM emp;
--'MAN'단어를 포함한 직무를 갖는 사우너의 사번, 직무를 출력하시오.
SELECT empno, job
FROM emp
WHERE job LIKE '%MAN%';  --MAN 이라는 단어 앞뒤로 % 를 붙이면 앞뒤로 어떤것이와도 상관없다 라는뜻이다.
                        -- MAN 이라는 단어를 포함하고있으면서 앞 중간 뒤 어디와도 좋다고 보여지는것이다.
--'MAN'단어를 포함한 직무를 갖는 사우너의 사번, 직무를 출력하시오.
SELECT empno, job
FROM emp
WHERE job LIKE 'MAN%'; --'%MAN'; 
--------------------------------------
--직무중 CLERK SALESMAN MANAGER ANALYST PRESIDENT
--직무중 SALES로 시작하고 8단어로 구성된 사원의 사번, 직무를 출력하시오.
SELECT empno, job
FROM emp
--WHERE job LIKE 'SALES___';     -- -언더바 를  총 출력하고자 하는 직업 뒤에 3개를 붙혀놓으면 8자리문자가 되기떄문에
                               -- SALESMAN 이 출력된ek
WHERE job LIKE 'SALES_'; -- 이것을 출력하게 되면 출력 값이 보이지않는다 
----------------------------------------------------
--사번과 입사일자를 출력하시오
SELECT empno, hiredate
FROM emp;

--입사일자가 81년도인 사원의 사번과,입사일자를 출력하시오
SELECT empno,hiredate
FROM emp
WHERE hiredate LIKE '81%';  --입사일자를 ㅣIKE연산자로 표현 한 것이다 
                            --LIKE연산자가 퍼포먼스가 떨어지기떄문에 잘 사용을하지않는다 

--입사일자가 81년도인 사원의 사번과,입사일자를 출력하시오
SELECT empno, hiredate
FROM emp
WHERE hiredate BETWEEN '81/01/01' AND '81/12/31'; --BETWEEN 연산자로 표현 한것이다
---------------------------------------------------------------
--NULL관련 연산자 : IS NULL, ID NOT NULL
--NILL은 아무값도 아니다
SELECT empno, sal, comm
FROM emp

-- 수당이 없는 사원의 사번, 급여, 수당을 출력하시오 
SELECT empno, sal, comm --IS NULL 연산으로 난 수당이 없는 사람이야를 표현할때 써준다.
FROM emp
WHERE comm IS NULL;  -- WHERE conn = null;  이렇게 그냥 NULL만 쓰면 출력이 불가능하다
                     -- WHERE comm IS NULL;  이렇게 IS NULL을 같이 써주어야한다
---------------------------------------------------------------
--집합연산자
--10부서사원과 30번부서사원의 사번, 부서번호 를 출력하시오
SELECT empno, deptno
FROM emp
WHERE deptno = 10 
UNION                         --중복안함
SELECT empno, deptno
FROM emp
WHERE deptno = 30; 















SELECT empno, sal
FROM emp;

SELECT *  --프로젝션
FROM emp; --셀렉션
---------------------
--컬럼별칭주기
SELECT empno AS "사번 번호", ename, sal 급여
FROM emp;
---------------------------------
--컬럼값  결합연산자  ||
SELECT empno || ename ||sal
FROM emp;

SELECT empno || ename ||sal "사번과 이름과 급여"
FROM emp;

--SQL의 문자열리터널, 날짜리터럴은 '를 사용한다 ex) 'helllo', '21/05/08'
SELECT empno ||'-'|| ename ||'-' || sal  "사번과 이름과 급여"
FROM emp;
----------------------------------
--산술연산자 : +, -, *, / 
--나머지값구하는 함수 : MOD()
SELECT empno, MOD (empno, 2), ename, sal, sal*12
FROM emp;
---------------------------------
SELECT DISTINCT deptno
FROM emp;   --3건
--조건에 만족해서 가져 오는 것을 셀렉션이다
---------------------------------
--*프로젝션 정렬하기, 오더바이문법
SELECT empno, ename, sal        --ASC는 Ascending에 약자 "오름차순" 을 뜻한다
FROM emp                        --오름차순(ASC)이나 내림차순(DESC)
ORDER BY sal DESC, ename ASC;   --DESC는 descending에 약자 "내림차순"  을 뜻한다  급여가 많은순서대로보여준다
                                --단, 급여가 같으면 이름을 사전순으로 출력한다  내림차순은 사전의 역순이다
----------------------------------
SELECT구문 처리 순서 :[FROM -> WHERE -> GROUP BY -> HAVING] -> [SELECT -> ORDER BY]
------------------------------------------------------------------------------- 
SELECT
FROM
[
WHERE
GROUP BY
HAVING
ORDER BY
]
--ORDER BY 에서 별칭사용가능
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
ORDER BY 3 DESC;  --디비에서는 어떤 디비건 무조건 인덱스가 1부터이다
                  --자바언어에서는 0부터 시작한다 
------------------------------------
--WHERE절 : 조건에 만족하는 행을 셀렉션
--비교연산자 : >, >=, <, <=, =  SQL에서늬 이콜 = 연산다는 무조건 같다는 표시이다
--논리연산다 : AND, OR, NOT

--급여가 1250인 사원의 사번, 이름, 급여를 출력하시오
--SELECT구문은 독립적으로 사용불가능하고 FROM절과 항상 같이 사용된다
SELECT empno, ename, sal
FROM emp
WHERE sal = 1250;

--급여가 1250보다 많은 사원의 사번,이름,급여를 출력하시오 단, 급여가 많은 사원부터 출력하시오
SELECT empno, ename, sal
FROM emp
WHERE sal > 1250
ORDER BY sal DESC;

-------------------------------------------------
--급여가 1250보다 많은 사원의 사번,이름,급여를 출력하시오 단, 급여가 적은 사원부터 출력하시오
SELECT empno, ename, sal
FROM emp
WHERE sal > 1250
ORDER BY sal ASC;
-----------------------------------------------
--급여가 1500이상 3000이하인 모든 사원의 사번,이름,급여를 출력하시오 단, 급여가 많은 사원부터 출력하시오
SELECT empno, Ename, sal
FROM emp
WHERE NOT (sal >= 1500 AND sal <= 3000)  --NOT 는 반대의 결과를 출력해준다 이것은 아래문제와 내용이 같다
ORDER BY sal DESC;
------------------------------------------------
--급여가 1500미만 3000초과인 모든 사원의 사번,이름,급여를 출력하시오 단, 급여가 많은 사원부터 출력하시오
SELECT empno, Ename, sal
FROM emp
WHERE sal < 1500 OR sal > 3000 
ORDER BY sal DESC;
-----------------------------------------------
--급여가 1500이상 3000이하인 모든 사원의 사번,이름,급여를 출력하시오 단, 급여가 많은 사원부터 출력하시오
SELECT empno, Ename, sal
FROM emp
WHERE sal >= 1500 AND sal <= 3000
ORDER BY sal DESC;
----------------------------------------
--BETWEEN 연산자로 AND 연산의 값을 똑같이 출력이 가능하다.
SELECT empno, Ename, sal
FROM emp
WHERE sal BETWEEN 1500 AND 3000
ORDER BY sal DESC;
-----------------------------------------------
--급여가 1500이상 3000이하인 모든 사원의 사번,이름,급여를 출력하시오 단, 급여가 많은 사원부터 출력하시오
SELECT empno, Ename, sal
FROM emp
WHERE NOT (sal >= 1500 AND sal <= 3000)  --NOT 는 반대의 결과를 출력해준다 이것은 아래문제와 내용이 같다
ORDER BY sal DESC;
----------------------------------------------
--급여가 1500이상 3000이하인 모든 사원의 사번,이름,급여를 출력하시오 단, 급여가 많은 사원부터 출력하시오
SELECT empno, Ename, sal
FROM emp
WHERE NOT sal BETWEEN 1500 AND 3000  -- BETWEEN 연산자로 NOT을 같이사용하여 코드를 깔끔하게 만들어줄수있다
ORDER BY sal DESC;                   -- 출력값은 동일하다. BETWEEN 연산자 안에는 AND 라는 개념이 들어가 있다
------------------------------------------------
--부서번호가 10, 30번인 사원의 사번, 이름, 급여, 부서번호를 출력하시오
SELECT empno, ename, sal, deptno
FROM emp
WHERE deptno=10 OR deptno=30;  -- 이부분을 IN 연산자 로 바꿔줄수도있다
------------------------------------------------
--부서번호가 10, 30번인 사원의 사번, 이름, 급여, 부서번호를 출력하시오
SELECT empno, ename, sal, deptno
FROM emp
WHERE deptno IN ( 10 , 30 ); -- IN 연산자 안에는 OR 라는 개념이 들어가있다j
----------------------------------------------------
--부서번호가 10,30번인 사원의
--급여가 1500이상 3000이하인 사원들의 사번, 이름, 급여를 출력하세요.
SELECT empno, ename, sal, deptno
FROM emp
WHERE (deptno=10 OR deptno=30)
    AND (sal >= 1500 AND sal <= 3000)
ORDER BY sal DESC;

----------------------------------------------------
--부서번호가 10,30번인 사원의
--급여가 1500이상 3000이하인 사원들의 사번, 이름, 급여를 출력하세요.
SELECT empno, ename, sal, deptno
FROM emp
WHERE deptno IN  (10,30)
    AND sal BETWEEN 1500 AND 3000;           -- 바로위에 코드를 IN연산자와 BETWEEN 연산자로 바꾸어 깔끔하게 만들어놓은것
ORDER BY sal DESC;                           -- 출력값은 같다
----------------------------------------------------
--사원의 직무를 출력하시오.
SELECT empno, job
FROM emp;
--'MAN'단어를 포함한 직무를 갖는 사우너의 사번, 직무를 출력하시오.
SELECT empno, job
FROM emp
WHERE job LIKE '%MAN%';  --MAN 이라는 단어 앞뒤로 % 를 붙이면 앞뒤로 어떤것이와도 상관없다 라는뜻이다.
                        -- MAN 이라는 단어를 포함하고있으면서 앞 중간 뒤 어디와도 좋다고 보여지는것이다.
--'MAN'단어를 포함한 직무를 갖는 사우너의 사번, 직무를 출력하시오.
SELECT empno, job
FROM emp
WHERE job LIKE 'MAN%'; --'%MAN'; 
--------------------------------------
--직무중 CLERK SALESMAN MANAGER ANALYST PRESIDENT
--직무중 SALES로 시작하고 8단어로 구성된 사원의 사번, 직무를 출력하시오.
SELECT empno, job
FROM emp
--WHERE job LIKE 'SALES___';     -- -언더바 를  총 출력하고자 하는 직업 뒤에 3개를 붙혀놓으면 8자리문자가 되기떄문에
                               -- SALESMAN 이 출력된ek
WHERE job LIKE 'SALES_'; -- 이것을 출력하게 되면 출력 값이 보이지않는다 
----------------------------------------------------
--사번과 입사일자를 출력하시오
SELECT empno, hiredate
FROM emp;

--입사일자가 81년도인 사원의 사번과,입사일자를 출력하시오
SELECT empno,hiredate
FROM emp
WHERE hiredate LIKE '81%';  --입사일자를 ㅣIKE연산자로 표현 한 것이다 
                            --LIKE연산자가 퍼포먼스가 떨어지기떄문에 잘 사용을하지않는다 

--입사일자가 81년도인 사원의 사번과,입사일자를 출력하시오
SELECT empno, hiredate
FROM emp
WHERE hiredate BETWEEN '81/01/01' AND '81/12/31'; --BETWEEN 연산자로 표현 한것이다
---------------------------------------------------------------
--NULL관련 연산자 : IS NULL, IS NOT NULL
--NILL은 아무값도 아니다
SELECT empno, sal, comm
FROM emp;

-- 수당이 없는 사원의 사번, 급여, 수당을 출력하시오 
SELECT empno, sal, comm --IS NULL 연산으로 난 수당이 없는 사람이야를 표현할때 써준다.
FROM emp
WHERE comm IS NOT NULL;  -- WHERE conn = null;  이렇게 그냥 NULL만 쓰면 출력이 불가능하다
                     -- WHERE comm IS NULL;  이렇게 IS NULL을 같이 써주어야한다
---------------------------------------------------------------
--집합연산자
--10부서사원과 30번부서사원의 사번, 부서번호 를 출력하시오
SELECT empno, deptno
FROM emp
WHERE deptno = 10 
UNION                         --중복안함
SELECT empno, deptno
FROM emp
WHERE deptno = 30; 

-- 사원의 이름중 'E'를 포함하는 사원의 사번, 이름을 출력하시오. 단 이름을 사전순으로 출력한다
-- 1) LIKE 연산자 사용, 2) INSTR 함수사용, 3) SUBSTR 함수사용

-- 1) LIKE 연산자는 가급적 쓰지 말자.
select empno, ename
from emp
where ename LIKE '___E%' --4번째 글자가 E인 경우, 만약 E가 들어간 이름을 찾는 거라면 %E% 로 표현하면 된다.
ORDER BY ename;


-- 2) INSTR 함수사용
select empno, ename
from emp
WHERE INSTR(ename, 'E') = 4 --'글자'가 최초로 나타나는 위치를 숫자로 반환
ORDER BY ename;


-- 3) SUBSTR 함수사용
select empno, ename
from emp
WHERE SUBSTR(ename, 4, 1) = 'e'; --대소문자 구분함


select empno, ename 
from emp
where substr(ename, 4, 1) = 'E'; --대소문자 구분함 

-- REPLACE와 TRANSLATE 는 동일한 기능을 하는 함
--SELECT '010-1234-5678' AS REPLACE_BEFORE,
--    REPLACE('010-1234-5678', '-', ' ') AS REPLACE_1,
--    REPLACE('010-1234-5678', '-') AS REPLACE_2,
--FROM DUAL;


--SQLPlus에서는 null값이 빈칸으로 보임
    --각 사원의 급여, 수당, 실급여를 출력하시오. 실급여는 급여+수당
SELECT sal, comm, sal+NVL(comm, 0)
FROM emp;

--각 사원의 급여, 수당, 실급여를 출력하시오. 실급여는 총10자리로 표현하되 앞에 빈공간은 #으로 채우시오.
SELECT sal "급여", comm AS 수당, LPAD(sal+NVL(comm,0), 10, '#') AS 실급여
FROM emp;


--<날짜관련 함수>
--오늘 날짜, 어제, 내일 날짜를 출력하시오
SELECT SYSDATE, SYSDATE-1, SYSDATE+1
FROM dual; --dual테이블은 테스트 테이블임


--오늘 날짜 기준 3개월 후, 3개월 전
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3), ADD_MONTHS(SYSDATE, -3)
FROM dual;

--'20/12/08'일부터 오늘까지의 일수를 출력하시오
--문자를 날짜로 자료형 변환이 필요!
SELECT SYSDATE, SYSDATE-'20/12/08'
FROM dual;

--'20/12/08'일부터 오늘까지의 일수를 출력하시오
--문자를 날짜로 자료형 변환이 필요! '20/12/08 은 0시 0분 0초로 인식
SELECT SYSDATE, SYSDATE-TO_DATE('20/12/08')
FROM dual;

--사원의 입사일을 출력하시오
SELECT hiredate
from emp;

--사원의 입사일, 근무일수, 근무개월수를 출력하시오, hiredate 컬럼 자체가 날짜 타입이기 때문에 TO_DATE 함수를 사용할 필요 없음
SELECT 
    '입사일: '||hiredate 입사일,  
    round(sysdate-hiredate)||'일' 근무일수, 
    round(MONTHS_BETWEEN(SYSDATE,HIREDATE))||'개월' 근무개월수,
    trunc(MONTHS_BETWEEN(SYSDATE,HIREDATE))||'개월' 근무개월수
from emp;


--돌아오는 토요일의 날짜를 출력하시오
SELECT NEXT_DAY(SYSDATE, '토')
FROM dual;


--이달의 마지막 일자와 다음달의 마지막 일자를 출력하시오
SELECT 
    LAST_DAY(SYSDATE),
    LAST_DAY(ADD_MONTHS(SYSDATE, 1)),
    LAST_DAY('21/02/01')
FROM dual;

SELECT 1+'1'
FROM dual;

SELECT 1||'1'
from dual;

select empno, hiredate
from emp
where hiredate between '82/01/01' and '82/12/31'; --문자가 날짜로 자동형변환 됐음

SELECT 1234567890,
    TO_CHAR(1234567890,'999,999,999,999') -- 뒤는 형식
FROM dual;

SELECT 1234567890,
    TO_CHAR(1234567890,'999,999,999,999'), -- 콤마뒤는 형식
    TO_CHAR(1234567890, 'L999,999,999,999'),
    TO_CHAR(1234567890, '000,000,000,000')
FROM dual;


--각 사원의 급여, 수당, 실급여를 출력하시오. 실급여는 급여+수당
--실급여는 3자리마다 ,를 출력한다.

SELECT sal, comm, TO_CHAR(sal+NVL(comm, 0),'999,999,999,999')
FROM emp;



--문자 -> 숫자로 형변환 TO_NUMBER()
SELECT 
    TO_NUMBER('123'), 
    TO_NUMBER('1,234','9,999') --9,999 패턴을 걷어내겠다라는 뜻
FROM dual;



--날짜 -> 문자로 형변환 TO_CHAR()
SELECT 
    TO_CHAR(SYSDATE, 'YYYY'),
    TO_CHAR(SYSDATE, 'MM-DD HH24:MI:SS DAY')
FROM dual;

--21년 12월 25일의 요일을 출력하시오
SELECT
    TO_CHAR(TO_DATE('21/06/13'), 'DAY')
FROM dual;

select sal 급여, comm 수당,  sal+comm 급여와수당
from emp;


SELECT sal 급여, comm 수당, sal+NVL(comm, 0) 급여와수당
FROM emp;

--수당을 받는 사원은 '수당받음'을 출력하고
--수당을 안받는 사원을 '수당안받음'을 출력하시오
SELECT empno, ename, comm, NVL2(comm, '수당받음'||' '||TO_CHAR(comm,'999,999')||'달러', '수당안받음')
FROM emp
ORDER BY comm; --null값은 숫자 뒤에 오게됨



--사원중 직무가 MANAGER인 사원은 급여를 10% 증가하여 출력하고
--      직무가 SALESMAN인 사원은 급여를 50% 증가하여 출력하시오

SELECT 
    empno, 
    ename, job 직무, sal 현재급여,
    DECODE(job, 'MANAGER', SAL*1.1, 'SALESMAN', SAL*1.5, sal) 예상급여  
    --             매니저는 1.1,           세일즈맨은 1.5, 그외는 그냥 급여
FROM emp
ORDER BY 예상급여;

select
    empno,
    ename, job, sal,
    decode(job, 'MANAGER', sal*1.1, 'SALESMAN', sal*1.5, sal)
from emp
order by 5;

SELECT empno, job, sal,
    CASE job WHEN 'MANAGER' THEN sal*1.1
             WHEN 'SALESMAN' THEN sal*1.5
             else sal
    END 예상급여인상2
FROM emp;



--사원의 급여가 3000이상이면 A등급, 1000이상이면 B등급,  1000미만이면 C등급으로 출력하시오
SELECT empno, sal,
    CASE 
    WHEN sal>=3000 THEN 'A등급'
    WHEN sal>=1000 THEN 'B등급'
    else 'C등급'
    END 
FROM emp;


select empno, sal,
    case
    when sal>=3000 then 'a'
    when sal>=1000 then 'b'
    else 'c'
    end
from emp;


--사원들의 총사원수, 총급여, 평균급여, 최대급여값, 최소급여값
SELECT 
    COUNT(empno)총사원수, SUM(sal)총급여, TRUNC(AVG(sal),0)평균급여, MAX(sal)최대급여, MIN(sal)최소급여
FROM emp;

--수당받는 총사원수
SELECT 
    COUNT(comm), COUNT(*)
FROM emp;



SELECT hiredate, COUNT(*)
FROM emp
GROUP BY hiredate
ORDER BY hiredate;


--부서별 부서번호, 총급여를 출력하시오
SELECT deptno, SUM(sal), MAX(sal), MIN(sal), AVG(sal)
FROM emp
GROUP BY deptno;


--GROUP BY 는 UNION과 같다.
SELECT COUNT(*), SUM(sal)
FROM emp
WHERE deptno=30;


------------------------

--입사년도별 입사자수
SELECT COUNT(*), TO_CHAR(hiredate, 'yyyy')
FROM emp
GROUP BY TO_CHAR(hiredate,'yyyy')
ORDER BY TO_CHAR(hiredate,'yyyy') ASC;

--입사년도별 입사자수
SELECT SUBSTR(TO_CHAR(hiredate, 'YY'),1,2)||'년도' 년도, COUNT(*)||'명' 입사자수
FROM emp
GROUP BY SUBSTR(TO_CHAR(hiredate,'YY'),1,2);

--입사월별 입사자수
SELECT  COUNT(*)||'명' 직원수, TO_CHAR(hiredate,'MM')||'월' 입사월
FROM EMP
GROUP BY TO_CHAR(hiredate,'MM')
ORDER BY 2; --2번째 컬럼 순으로 정렬하겠다.


--입사월별 입사자수, 단 1월이 01이 아니라 1월로 출력 
SELECT  COUNT(*)||'명' 직원수, LTRIM(TO_CHAR(hiredate,'MM')||'월',0) 입사월
FROM EMP
GROUP BY TO_CHAR(hiredate,'MM')
ORDER BY TO_CHAR(hiredate, 'MM'); 

--입사월별 입사자수, 단 1월이 01이 아니라 1월로 출력 
SELECT TO_NUMBER(TO_CHAR(hiredate, 'MM'))||'월' 입사월, COUNT(*)
FROM emp
GROUP BY TO_NUMBER(TO_CHAR(hiredate, 'MM'))
ORDER BY TO_NUMBER(TO_CHAR(hiredate, 'MM'));

--급여가 2,000이상인 사원의 부서별 사원수를 출력하시오 // 사원의급여(개인)별 WHERE절을 이용해야함
SELECT deptno, COUNT(*)
FROM emp
WHERE sal>=2000
GROUP BY deptno;



--부서별 평균급여가 1,500이상인 부서들의 사원수를 출력하시오 // 부서(그룹)별 조건이므로 HAVING절을 이용해야함
SELECT deptno, COUNT(*), ROUND(AVG(sal))
FROM emp
GROUP BY deptno
HAVING AVG(sal) >= 2000;


--125페이지 1번문제
select *
from emp
where ename LIKE '%S';


--125페이지 2번문제
select empno, ename, job, sal, deptno
from emp
where  deptno=30 AND job LIKE 'SALESMAN';


--125페이지 3번문제
select empno, ename, sal, deptno
from emp
where (deptno BETWEEN 20 AND 30) AND sal > 2000;


--125페이지 4번문제
select *
from emp
where sal>3000 OR sal<2000;


--125페이지 5번문제
select ename, empno, sal, deptno
from emp
where deptno = 30 and (ename LIKE '%E%') AND (sal>2000 or sal<1000);


--125페이지 6번문제
SELECT *
FROM emp
WHERE comm IS NULL
  AND MGR IS NOT NULL
  AND JOB IN('MANAGER', 'CLERK')
  AND ename not LIKE '_L%';
  
  
select ename, upper(ename), lower(ename), initcap(ename)
from emp;

select *
from emp
where upper(ename) = upper('scott');

select * from emp where upper(ename) like upper('%scott%');

select upper(ename)
from emp;


select ename, length(ename)
from emp
where length(ename) >= 6;

select length('한글'), LENGTHB('한글')
from dual;

select *
from emp
where length(job)>=6;

select job, substr(job,1,2), substr(job,3,2), substr(job,1)
from emp;

select ename, substr(ename,3)
from emp;

select job,
        -length(job),
        substr(job, -length(job)),
        substr(job, -length(job), 2),
        substr(job, -3)
from emp;




--자동형변환
SELECT 1+'1'
from dual;


--자동형변환

SELECT 1||'1'
FROM dual;

select trunc(avg(sal),0), '10' as deptno from emp where deptno = 10
union all
select avg(sal), '20' as deptno from emp where deptno = 20
union all
select trunc(avg(sal),0), '30' as deptno from emp where deptno = 30;


select deptno, job, count(*)
from emp
group by job, rollup(deptno);



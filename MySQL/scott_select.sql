














SELECT empno, sal
FROM emp;

SELECT * --��������
FROM EMP; --������








-------�÷� ��Ī �ֱ�
SELECT empno ���, ename, sal �޿�
FROM emp;

-------�÷� ��Ī�ֱ� 2
SELECT empno "��� ��ȣ", ename, sal AS �޿�
FROM emp;

-------�÷��� ���տ����� ||(������)
SELECT EMPNO||ENAME||SAL
FROM EMP;

-------�÷��� ���տ����� ||(������) ��Ī�ٿ��ֱ�
SELECT EMPNO||ENAME||SAL"����� �̸��� �޿�"
FROM EMP;

--SQL������ ���ڿ� ���ͷ��� ��¥�� ���ͷ��� ��������ǥ(' ')�� ����Ѵ�. EX) 'HELLO', '21/05/07'
SELECT EMPNO||'_'||ENAME||'_'||SAL"����� �̸��� �޿�"
FROM EMP;


--��������� : +, -, *, / ���������� ���ϴ� �����ڴ� ������ MOD()�Լ��� ���� �ȴ�.

--2�� ���� ������ ���� ��ȯ
SELECT empno, MOD(empno, 2), ename, sal, sal*12
FROM emp;

--------------------------

SELECT deptno
FROM emp; --14�� ���


--�ߺ��� �����ϱ�
SELECT DISTINCT deptno
FROM emp; --3�� ���


--�޿� ������������ ���Ľ�Ű��
SELECT empno, ename, sal
FROM emp
ORDER BY sal DESC;            --DESC: ��������



--�޿��� ������������ �����ϴٰ� �޿����� ���� �� �̸��� ������������ ���Ľ�Ű��
SELECT empno, ename, sal
FROM emp
ORDER BY sal DESC, ename ASC;            --ASC: ��������                             //������ ���� �켱������ �Ű����°���?

--------------------------------------------------------------
--SELECT ���� ó�� ����: 
--                   ������                             ��������
---    [ FROM -> WHERE -> GROUP BY -> HAVING ]->[ SELECT -> ORDER BY]
--SELECT
--FROM
--[
--WHERE
--GROUP BY
--HAVING
--ORDER BY
--] ��ȣ���� ��������

--ORDER BY �������� ��Ī���� �������� ����ϱ�
SELECT empno, ename, sal "�޿�"
FROM emp
ORDER BY �޿� DESC, ename;


--ORDER BY���� �������ǿ� �������� ���� �÷���밡��
SELECT empno, ename
FROM emp
ORDER BY sal DESC;


--ORDER BY���� �������ǿ� ������ �÷������� ��밡��
SELECT empno, ename, sal
FROM emp
ORDER BY 3 DESC;        --�������ǿ� ������ ù��° �÷�, �� empno�� �ǹ�
--DB������ �ε����� ������ 1���� ������
 
 --WHERE �� : ���ǿ� �����ϴ� ���� ������
 --�񱳿����� : >, >=, <, <=, = SQL������ �����̶�� ������ ���� ���ٸ� ǥ���� ������ = �ϳ��� ����
 --�������� : AND, OR, NOT

 --�޿��� 1250�� ����� ���, �̸�, �޿��� ����Ͻÿ�
SELECT empno, ename, sal
FROM emp
WHERE sal=1250;

--�޿��� 1250���� ����(�ʰ�) ����� ���,�̸�,�޿��� ����Ͻÿ�. �� �޿��� ���� ������� ����Ѵ�.
SELECT empno, ename, sal
FROM emp
WHERE sal>1250
ORDER BY sal DESC;


--�޿��� 1500�̻� 3000������ ����� ���,�̸�,�޿��� ����Ͻÿ�. �� �޿� ������������ �����Ѵ�.
SELECT empno, ename, sal
FROM emp
WHERE sal>=1500 AND sal<=3000
ORDER BY sal DESC;

--�޿��� 1500�̻� 3000������ ����� ���,�̸�,�޿��� ����Ͻÿ�. �� �޿� ������������ �����Ѵ�. 
--AND������ ����� ������ ���� �񱳰��� �̻�, ������ ��� BETWEEN ��밡��
SELECT empno, ename, sal
FROM emp
WHERE sal BETWEEN 1500 AND 3000 --1500�̻� 3000���϶�� ��
ORDER BY sal DESC;

--�޿��� 1500�̸� 3000�ʰ��� ����� ���,�̸�,�޿��� ����Ͻÿ�. �� �޿� ������������ �����Ѵ�. 
--AND������ ����� ������ ���� �񱳰��� �̻�, ������ ��� BETWEEN ��밡���ϰ� NOT���� ���� �� ����
SELECT empno, ename, sal
FROM emp
WHERE NOT sal BETWEEN 1500 AND 3000 --1500�̸��� 3000�ʰ���� ��
ORDER BY sal DESC;


--�޿��� 1500�̸� 3000�ʰ��� ���,�̸�,�޿��� ����Ͻÿ�.ver1 �� �޿� ������������ �����Ѵ�.
SELECT empno, ename, sal
FROM emp
WHERE sal<1500 OR sal>3000
ORDER BY sal DESC;


--�޿��� 1500�̸� 3000�ʰ��� ���,�̸�,�޿��� ����Ͻÿ�.ver2 �� �޿� ������������ �����Ѵ�.
SELECT empno, ename, sal
FROM emp
WHERE NOT(sal<1500 OR sal>3000)
ORDER BY sal DESC;

-----------------------------
--�μ���ȣ�� 10���̰ų� 30���� ����� ���,�̸�,�޿�,�μ���ȣ ����Ͻÿ�ver1
SELECT empno, ename, sal, deptno
FROM emp
WHERE deptno = 10 OR deptno = 30
ORDER BY sal DESC;

--�μ���ȣ�� 10���̰ų� 30���� ����� ���,�̸�,�޿�,�μ���ȣ ����Ͻÿ�ver2
SELECT empno, ename, sal, deptno
FROM emp
WHERE deptno IN(10, 30)
ORDER BY sal DESC;




--�μ���ȣ�� 10���̰ų� 30���� ������� �޿��� 1500�̻� 3000������ ��� ���,�̸�,�޿�,�μ���ȣ ����Ͻÿ�_�����
SELECT empno, ename, sal, deptno
FROM emp
WHERE (deptno=10 OR deptno=30) AND (sal >= 1500 AND sal <= 3000);


--�μ���ȣ�� 10���̰ų� 30���� ������� �޿��� 1500�̻� 3000������ ��� ���,�̸�,�޿�,�μ���ȣ ����Ͻÿ�_ä�ø�
SELECT empno, ename, sal, deptno
FROM emp
WHERE (deptno IN(10, 30)) AND (sal BETWEEN 1500 AND 3000)
ORDER BY sal DESC;


--����� ����(JOB)�� ����Ͻÿ�

SELECT empno, job
FROM emp;



--'MAN' �ܾ ������ ������ ���� ����� ����� ������ ����Ͻÿ�
SELECT empno, job
FROM emp
WHERE job LIKE '%MAN%'; --job�÷��� MAN�� ã�ƶ�. %� �ܾ �͵� ������� �˻�


--'MAN' �ܾ ������ ������ ���� ����� ����� ������ ����Ͻÿ�
SELECT empno, job
FROM emp
WHERE job LIKE 'MAN%';



--������ SALES�� �����ϰ� 8�ܾ�� ������ ����� ���, ������ ����Ͻÿ�
SELECT empno, JOB
FROM emp
WHERE job LIKE 'SALES___';


--����� �Ի����ڸ� ����Ͻÿ�
SELECT empno, hiredate
FROM emp;


--�Ի����ڰ� 81�⵵�� ����� ����� �Ի����ڸ� ��� ver1
SELECT empno, hiredate
FROM emp
WHERE hiredate LIKE '81%';


--�Ի����ڰ� 81�⵵�� ����� ����� �Ի����ڸ� ��� ver2
SELECT empno, hiredate
FROM emp
WHERE hiredate>='81/01/01' AND hiredate<='81/12/31';


--�Ի����ڰ� 81�⵵�� ����� ����� �Ի����ڸ� ��� ver3
SELECT empno, hiredate
FROM emp
WHERE hiredate BETWEEN '81/01/01' AND '81/12/31';


--NULL���� ������: IS NULL, IS NOT NULL �����ڷ� ���ؾ���
--DB���� NULL�� �ƹ����� �ƴϴ�
SELECT empno, sal, comm
FROM emp;

--������ ���� ����� ���,�޿�,������ ����Ͻÿ�
SELECT empno, sal, comm
FROM emp
WHERE comm IS NULL;      --comm�� NULL���� �ڷḦ ã�ƶ�


--���տ�����
--10�� �μ������ 30�� �μ������ ���, �μ���ȣ�� ����Ͻÿ�.
SELECT empno, deptno
FROM emp
WHERE deptno = 10
UNION
SELECT empno, deptno
FROM emp
WHERE deptno = 30;

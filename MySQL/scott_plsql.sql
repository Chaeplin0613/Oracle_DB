set serveroutput on

/*declare
    v_num number := 123;
begin
    dbms_output.put_line(v_num);
end;


declare
    v_emp_no emp.empno%type; /*--v_emp_no의 타입이 emp테이블의 empno의 타입과 같게 참조하겠다는 뜻
    v_emp emp%rowtype; --emp테이블의 전체 모든 컬럼을 가져오면서 컬럼이름과 타입도 그대로 쓰겠다. 하지만, emp_no는 앞에서 별도로 선했기기 때문에 제외시킨다.
begin
    v_emp_no := 999;
    v_emp.empno := 100;
    v_emp.ename := 'TEST';
    v_emp.sal := 1000;
    dbms_output.put_line(v_emp_no);
    dbms_output.put_line(v_emp.empno);
    dbms_output.put_line(v_emp.ename || ',' ||v_emp.sal);
end;
*/

--------------------------
/
declare
    v_num number := 10;
begin
    if mod(v_num, 2) = 1 then
    dbms_output.put_line('홀수입니다.');
    else
    dbms_output.put_line('짝수입니다.');
    end if;




if v_num > 10 then
    dbms_output.put_line('10보다 큽니다');
elsif v_num > 5 then --else if 아니고 elsif 라고 써야함
    dbms_output.put_line('5보다 큽니다.');
else
    dbms_output.put_line('5이하입니다.');
end if;

end;

/


/
DECLARE
    v_num number := 10;
    
begin
    case mod(v_num,2)
        when 0 then
        dbms_output.put_line('짝수');
        
        else
        dbms_output.put_line('홀수');
        
    end case;
end;
/




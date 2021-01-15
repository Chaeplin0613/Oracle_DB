----------------------------
--테이블 제거: customer테이블 제거 
drop table customer;


--customer 테이블 생성 
create table customer(
    id varchar2(5),
    pwd varchar2(5),
    name varchar2(15)
    );
    
--테이블 구조변경--
--컬럼추가: zipcode char(5)  //5바이트라는 뜻
alter table customer
add zipcode char(5);

--컬럼추가: addr varchar2(10)      // 10바이트라는 뜻
alter table customer
add addr varchar2(10);

--컬럼 이름변경: addr 에서 addr1로 
alter table customer
rename column addr to addr1;

--컬럼 자료형, 길이변경 (modify)
alter table customer
modify addr1 varchar2(30);

--컬럼추가
alter table customer
add test number;

--컬럼제거
alter table customer
drop column test;



--고객자료추가: 정상자료
insert into customer(id,pwd,name) values ('id1','p1','n1');

--고객조회
select * from customer;

--고객자료추가: 비정상자료
insert into customer(id,pwd,name) values ('id1','p1','n1');

--고객자료 삭제
delete from customer where id = 'id1';


--1. PRIMARY KEY 제약조건 설정하기
--primary key : NOT NULL + UNIQUE
alter table customer
add constraint customer_id_pk PRIMARY KEY(id);
        --     테이블명과 동일_컬럼명_제약조건종류


--고객자료추가: 정상자료
insert into customer(id,pwd,name) values ('id1','p1','n1');

--고객조회
select * from customer;

--고객자료추가: 비정상자료
insert into customer(id,pwd,name) values ('id1','p1','n1'); --에러발생 


--고객자료추가: 비정상자료
insert into customer(id,pwd,name) values (null,'p1','n1'); --에러발생 

--고객자료추가: 비정상자료
insert into customer(id,pwd,name) values ('','p1','n1'); --에러발생 
-- ''도 null값임 / null도 null값 / 'null'은 문자고 null값 아님

------------------------------------------------------

--2. NOT NULL 제약조건 설정하기

--비정상자료 추가(pw=null)
insert into customer(id,pwd,name) values ('id2','','n1');



--비정상자료 삭제
delete from customer where id = 'id2';

--NOT NULL 제약조건
alter table customer
modify pwd not null;

----------------------------
--3. FOREGIN KEY 제약조건: 부모엔터티의 pk를 자식엔터티에서 참조 
--주문테이블생성: order_info 
create table order_info( --order_info 테이블
    order_no NUMBER,
    order_id VARCHAR2(5),
    order_dt DATE);
--주문자료 추가: 비정상자료(고객에 없는 id999를 추가하기 때문, 현재는 id1고객만 있음)
insert into order_info (order_no, order_id, order_dt)
    values(1,'id999',SYSDATE);

select * from order_info;

delete from order_info where order_id = 'id1';


--포린키는 자식에다 설정 
alter table order_info            --자식 order_id가           --부모 id키를 참조하겠다는 뜻 
add constraint order_info_id_fk FOREIGN KEY (order_id) REFERENCES customer(id);



----------------------------
--4. CHECK 제약조건: 값의 범위, 종류를 지정할 수 있는 제약조건
--고객자료 추가: 비정상자료(비번이 1자리인 경우)
insert into customer (id, pwd, name)
values ('id2','p','n1'); --ok

select * from customer;

delete from customer where id = 'id2';

alter table customer
add constraint customer_pwd_ck CHECK (length(pwd) > 1);




----------------------------
--상품테이블 생성: product
create table product(                                       --컬럼레벨 제약조건 설정
 
    --prod_no VARCHAR2(5) --컬럼생성 자료형(default 'test' / constraint 제약조건 이름 / 제약조건 종류
    prod_no varchar2(5) constraint product_no_pk primary key, --컬럼레벨 제약조건 설정
    prod_name varchar2(50) constraint prodcut_name_nn NOT NULL,--NOT NULL제약조건은 반드시 컬럼레벨로만 설정가능 
                        --|         생략가능 부분       |--
    prod_price number(7), --자릿수가 7개라는 뜻 9,999,999까지 표현가능
    constraint product_price_ck CHECK(prod_price >= 0)); --테이블 레벨 제약조건 (컬럼행에서 아닌 뒤에서 조건을 설정하는 것)

drop table product; --product 테이블 삭제

--1. 테이블 생성하면서 컬럼레벨 또는 테이블레벨로 제약조건 설정할 수 있고
--2. 이미 테이블이 만들어져 있다면 alter table로 구조바꾸면서 제약조건 추가, 변경 등을 할 수 있다.

----------------------------------------------------
--주문상세테이블에 order_no컬럼에 PRIMARY KEY 제약조건 추가

alter table order_info
add constraint order_no_pk PRIMARY KEY(order_no);
--테이블레벨 제약조건

--order_info 테이블에 주문자 order_id에 NOT NULL 제약조건 추가
alter table order_info
modify order_id NOT NULL;
--NOT NULL 은 modify 로 컬럼레벨 제약조건을 설정해야함 
----------------------------------------------------
desc order_info;

SELECT * FROM    ALL_CONSTRAINTS
WHERE    TABLE_NAME = 'ORDER_INFO';
----------------------------------------------------
--주문상세 테이블 생성: order_line
create table order_line(
    order_no NUMBER,
    order_prod_no varchar2(5) NOT NULL,
    order_quantity NUMBER(2) NOT NULL, --2자리수 = 99개
--테이블레벨 제약조건 설정
constraint order_line_no_prod_no_pk PRIMARY KEY(order_no, order_prod_no), -- 복합키 만드는 방법(컬럼레벨은 안 되고 테이블 레벨에서만 가능)
constraint order_line_order_quantity_ck CHECK(order_quantity >= 1),
constraint order_line_order_no_kf FOREIGN KEY (order_no) REFERENCES order_info(order_no),
constraint order_line_order_prod_no_kf FOREIGN KEY (order_prod_no) REFERENCES product(prod_no));


SELECT * FROM    ALL_CONSTRAINTS
WHERE    TABLE_NAME = 'order_line';

------------------------------------------여기까지가 DLL 구문-----------------------------
alter table order_info
modify order_dt default SYSDATE; --날짜를 별도로 지정하지 않으면 디폴트값으로 오늘날짜가 선택됨

select *
from order_info;

insert into order_info (order_no, order_id) values(2, 'id1');









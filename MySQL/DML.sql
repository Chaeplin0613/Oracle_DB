--DML: 
--데이터 추가
insert into customer(id, pwd, name, zipcode, addr1)
values ('id2', 'p2', 'n2', '12345', '6층');

insert into customer(id, pwd, name)
values ('id3', 'p3', 'n3');

select * from customer;

insert into customer
values ('id4', 'p4', 'n4', '12345', 'KOSTA');

insert into customer
values ('id5', 'p5', 'n5', '',null);

--고객테이블의 구조변경(이미 null값이 들어있는 컬럼의 구조를 not null로 주기) -> 에러발생함, zipcode 컬럼에 이미 not null이 들어있기 때문에 
alter table customer
modify zipcode not null ; --zipcode 컬럼의 구조를 not null 로 변경하기 

--고객테이블의 이미 저장된 자료의 자릿수보다 작은자리수로 변경 안 됨!
alter table customer
modify addr1 varchar2(3); -- (x)




--데이터 수정
update customer 
set zipcode = '00700'-- 다른 컬럼추가 , 컬러명 = 값
where id = 'id1';
--id1고객의 우편번호가 기존 null값에서 12345로 변경 

select * from customer;

select * from product;







--데이터 삭제

select * from order_info;

--자식엔터티에서 참조되는 부모엔터티는 삭제불가!
delete customer
where id LIKE '%1%'; -- 자식인 order_info 에서 customer테이블을 참조하고 있기 때문에 오류가 발생한다.

delete customer
where id = 'id5';

select * from customer;
--------------------------------------------

create table customer_copy --customer_copy는 사본, create 는 ddl구문 
as select * from customer where id IN ('id1','id2','id3'); --customer는 원본 

select * from customer_copy;

--DML에서 서브쿼리 사용 SUBQUERY
insert into customer_copy
select * from customer where id = 'id4';

update customer_copy
set name = 'AAA', addr1=(select addr1 from customer where id = 'id1');

delete customer_copy
where id = (select id from customer where name = 'n2');  --원본 customer에서 이름n2에 해당하는 아이디값이랑 사본에서의 아이디값이랑 일치하면 삭제


select * from customer;
select * from product;
select * from order_info;
select * from order_line;


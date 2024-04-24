# 김연아 고객의 전화번호를 찾으시오.
select phone from customer where name="김연아";

# 모든 도서의 이름과 가격을 검색하시오.
select bookname, price from book;

# 가격이 20000원 미만인 도서를 검색하시오.
select bookname, price from book where price < 20000;

# 가격이 10000원 이상 20000원 이하인 도서를 검색하시오.
select bookname, price from book where price between 10000 and 20000; 

# 도서 이름에 '축구'가 포함된 출판사를 검색하시오.
select bookname, publisher from book where bookname like "%축구%";

# 도서이름의 왼쪽 두 번째 위치에 '구'라는 문자열을 갖는 도서를 검색하시오.
select bookname from book where bookname like "_구%";

# 도서를 가격의 내림차순으로 검색하시오. 만약 가격이 같다면 출판사의 오름차순으로 검색한다.
select * from book order by price desc, publisher asc;

# 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
select custid, sum(saleprice) from orders group by custid having custid=2;

# 마당서점의 도서판매 건수를 구하시오.
select count(*) from orders;

# 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오.
select count(*), sum(saleprice) from orders group by custid;

# 가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오. 단 두 권 이상 구매한 고객만 구한다.
select custid, count(*) from orders where saleprice >= 8000 group by custid having count(*)>=2;

# 3글자 이상 야로 시작하고 해로 끝나는 책을 검색하시오.
select bookname from book where bookname like "야%해";

# 야로 시작하고 최소 3글자 이상인 책 검색하시오.
select bookname from book where bookname like "야__%";

# 축구가 들어간것을 빼고 검색하시오.
select bookname from book where bookname not like "%축구%";

# 주문된 도서별로 고객의 수와 총 판매액을 구한다.
select bookid, count(distinct custid), sum(saleprice) from orders group by bookid;

# 요일별로 주문된 횟수와 총합을 구하고 그 총합의 역순으로 정렬하여 검색하시오.
select dayname(orderdate), count(*), sum(saleprice) from orders group by dayname(orderdate) order by sum(saleprice) desc;

# 두번이상 주문된 책을 검색하시오.
select bookid, count(*) from orders group by bookid having count(*) >= 2;

# 세번 이상 주문한 고객별로 주문 횟수와 가장비싼주문도서를 구하시오.
select custid, count(*), max(saleprice) from orders group by custid having count(*)>=3;

# 위 상태에서 가장 비싼주문을 찾는다.
select custid, count(*), max(saleprice) from orders group by custid having count(*)>=3 order by max(saleprice) desc limit 1;

# 고객의 이름을 검색하고 고객이 주문한 각 도서의 주문 가격을 검색하시오.(only from where,  not inner join)
select c.name, o.orderid from customer c, orders o where c.custid = o.custid;
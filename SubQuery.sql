# 마당서점의 고객별 판매액을 보이시오.(고객이름과 판매액을 출력)
select (select c.name from customer c where c.custid = o.custid), sum(o.saleprice) from orders o group by o.custid;

# 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
select b1.bookname from book b1 where b1.price > (select avg(b2.price) from book b2 where b2.publisher = b1.publisher);

# 고객번호가 2 이하인 고객의 판매액을 보이시오(고객이름과 고객별 판매액 출력)
select (select c.name from customer c where c.custid=o.custid), sum(o.saleprice) from orders o where o.custid <= 2 group by o.custid;

# 대한민국에 거주하는 고객에게 판매된 도서의 고객별 판매액을 구하시오(any)
select o.custid, sum(o.saleprice) from orders o where o.custid = any(select c.custid from customer c where c.address like "%대한민국%") group by o.custid;

# 마당회사의 customer 레포트를 매번 매달 작성하고 싶다. (사용자 수, 주문 고객 수, 총 주문건수, 평균 주문금액, 총 주문금액)
select count(*), (select count(distinct custid) from orders), (select count(*) from orders), (select avg(saleprice) from orders), (select sum(saleprice) from orders) from customer;

# 마당서점의 고객이름과 고객별 판매액을 검색하는데 서브쿼리와 상관쿼리를 이용하시오.
select (select c.name from customer c where c.custid=o.custid), sum(o.saleprice) from orders o group by o.custid;

# 출판사 별로 출판사의 평균도서 가격보다 비싼 도서를 구하시오.
## 1) 인라인 뷰
select b1.bookname from book b1, (select publisher, avg(price) as "avg_price" from book group by publisher) new_book where new_book.publisher = b1.publisher and b1.price > new_book.avg_price; 

## 2) 스칼라 서브쿼리
select b1.bookname, (select b2.publisher from book b2 where b2.publisher = b1.publisher group by b2.publisher having b1.price > avg(b2.price)) from book b1;
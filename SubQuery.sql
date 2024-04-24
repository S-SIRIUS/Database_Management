# 가장 비싼 도서의 이름을 검색하시오.
select b.bookname, b.price from book b where b.price = (select max(b2.price) from book b2);

# 도서를 구매한 적이 있는 고객의 이름을 검색하시오.
select c.name from customer c where c.custid in (select o.custid from orders o);

# 대한미디어에서 출판한 도서를 구매한 고객의 이름을 보이시오.
select c.name from customer c where c.custid in (select o.custid from orders o where o.bookid in (select b.bookid from book b where b.publisher = "대한미디어"));

# 마당서점의 고객별 판매액을 보이시오.
select c.custid, (select sum(o.saleprice) from orders o where c.custid=o.custid) from customer c group by c.custid;

# 출판사별로 출판사의 평균 도서가격보다 비싼 도서를 구하시오.
select b1.bookname from book b1 where b1.price > (select avg(b2.price) from book b2 where b2.publisher = b1.publisher);

# 고객번호가 2 이하인 고객의 판매액을 보이시오(고객이름과 고객별 판매액 출력)
select c.name, (select sum(o.saleprice) from orders o where o.custid = c.custid) from customer c where c.custid <= 2 group by c.custid;

# 평균주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
select o.orderid, o.saleprice from orders o where o.saleprice <= (select avg(o2.saleprice) from orders o2);

# 각 고객의 평균주문금액보다 큰 금액의 주문내역에 대해서 주문번호, 고객번호, 금액을 보이시오.
select o.orderid, o.custid, o.saleprice from orders o where o.saleprice > (select avg(o2.saleprice) from orders o2 where o2.custid = o.custid);

# 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오.
select sum(o.saleprice) from orders o where o.custid in (select c.custid from customer c where c.address Like "%대한민국%");

# 3번 고객이 주문한 도서의 최고 금액보다 더 비산 도서를 구입한 주문의 주문번호와 금액을 보이시오.(ALL/ANY를 사용)
select o.orderid, o.saleprice from orders o where o.saleprice > ALL(select o2.saleprice from orders o2 where o2.custid=3);

# EXISTS 연산자로 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
select sum(o.saleprice) from orders o where EXISTS(select * from customer c where c.address like "%대한민국%" and o.custid = c.custid);

# EXISTS 연산자로 주문이 있는 고객의 이름과 주소를 보이시오.
select c.name, c.address from customer c where EXISTS (select * from orders o where o.custid = c.custid);

# 대한민국에 거주하는 고객의 이름과 도서를 주문한 고객의 이름을 보이시오.
select c.name from customer c where c.address like "%대한민국%" union select c.name from customer c where c.custid in (select o.custid from orders o);

# 대한민국에 거주하는 고객의 이름에서 도서를 주문한 고객의 이름을 뺴고 보이시오.
select c.name from customer c where c.address like "%대한민국%" and c.name not in(select c.name from customer c where c.custid in (select o.custid from orders o));

# 대한민국에서 거주하는 고객 중 도서를 주문한 고객의 이름을 보이시오.
select c.name from customer c where c.address like "%대한민국%" and c.name in(select c.name from customer c where c.custid in (select o.custid from orders o));

# 주문이 있는 고객의 이름과 주소를 구하시오(EXISTS사용)
select c.name, c.address from customer c where EXISTS(select * from orders o where o.custid = c.custid);

# 대한민국에 거주하는 고객에게 판매된 도서의 고객별 판매액을 구하시오.(any 사용)
select o.custid, sum(o.saleprice) from orders o where o.custid = any(select c.custid from customer c where c.address like "%대한민국%") group by o.custid;

# 마당회사의 customer 레포트를 매번 매달 작성하고 싶다. (사용자 수, 주문 고객 수, 총 주문건수, 평균 주문금액, 총 주문금액)
select count(*), (select count(distinct o.custid) from orders o), (select count(*) from orders o), (select avg(saleprice) from orders o), (select sum(saleprice) from orders o) from customer;

# 마당서점의 고객이름과 고객별 판매액을 검색하는데 서브쿼리와 상관쿼리를 이용하여라.
select c.name, (select sum(o.saleprice) from orders o where o.custid=c.custid) from customer c group by c.custid;

# 출판사별로 출판사의 평균도서 가격보다 비산 도서를 구하시오.
## 1) 인라인 뷰
select b1.bookname from (select publisher, avg(b2.price) as "avg_newbook" from book b2 group by b2.publisher) newbook, book b1 where b1.publisher = newbook.publisher and b1.price > newbook.avg_newbook;

## 2) 스칼라 서브쿼리
select b1.bookname, b1.price, (select b2.publisher from book b2 where b1.publisher = b2.publisher group by b2.publisher having b1.price>avg(b2.price)) from book b1;
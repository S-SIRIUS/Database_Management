# 고객과 고객의 주문에 관한 데이터를 모두 보이시오.
select * from orders o, customer c where c.custid = o.custid;

# 고객과 고객의 주문에 관한 데이터를 고객번호 순으로 정렬하여 보이시오
select * from orders o, customer c where c.custid = o.custid order by c.custid;

# 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
select c.name, o.saleprice from customer c inner join orders o on c.custid = o.custid;

# 고객별로 주문한 모든 도서의 총 판매액을 구하고 고객별로 정렬하시오.
select c.custid, c.name, sum(o.saleprice) from customer c inner join orders o on c.custid = o.custid group by c.custid order by c.custid;

# 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
select c.name, b.bookname from customer c inner join orders o on o.custid = c.custid inner join book b on b.bookid = o.bookid;

# 가격이 20000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
select c.name, b.bookname from customer c inner join orders o on o.custid = c.custid inner join book b on b.bookid = o.bookid where b.price = 20000;

# 도서를 구매하지 앟은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.
select c.custid, c.name, o.saleprice from customer c left join orders o on c.custid = o.custid;

# 주문된 도서의 이름을 검색하고, 책의 주문가격, 주문날짜를 검색 + 정가와 주문금액의 차이도 보이시오.
select b.bookname, o.saleprice, o.orderdate, abs(o.saleprice - b.price) from book b inner join orders o on b.bookid = o.bookid;

# 고객별로 주문한 평균 판매액을 검색하되 고객이름별로 정렬하시오.
select o.custid, c.name, avg(o.saleprice) from orders o inner join customer c on c.custid=o.custid group by o.custid order by c.name;

# 주문을 한적이 없는 고객의 이름을 구하시오.
select c.name from customer c left join orders o on c.custid = o.custid where o.custid is null;

# 주문을 했건 안했던 모든 고객의 정보를 고객별 주문 총액과 함께 검색하시오.(단 주문한 적이 없는 고객은 주문 총액을 0으로 보여주어야함)
select c.custid, c.name, ifnull(sum(o.saleprice),0) from customer c left join orders o on c.custid = o.custid group by c.custid;

# 3번이상 주문한 고객의 이름과 그들이 얼마의 기간동안 몇건을 주문했는지 검색하시오.
select c.name, count(*), datediff(max(orderdate), min(orderdate)) from customer c inner join orders o on c.custid= o.custid group by c.custid having count(*) >= 3;

# 마당 서점에서 회원가입을 하지않고 물건을 주문한 비회원 구입인 주문의 건을 검색하시오.
select * from orders o left join customer c on c.custid = o.custid where c.custid is null;

# 모든 고객의 이름과 모든 책의 이름을 한꺼번에 검색하시오.
select c.name from customer c union select b.bookname from book b;

# 주문이 된 적이 없는 책을 포함하여 책의 이름과 각 책의 총 주문 가격을 구하시오.(단 bookid로 정렬하시오)
select b.bookname, sum(o.saleprice) from book b left join orders o on b.bookid = o.bookid group by b.bookid order by b.bookid;

# 대한미디어에서 출판한 도서를 구입한 고객의 이름을 검색하시오.
select c.name, b.publisher from customer c, orders o, book b where c.custid = o.custid and b.bookid = o.bookid and b.publisher like "대한미디어";

# 가장 비싸게 주문된 도서의 이름을 검색하시오.
#(서브쿼리)
select b.bookname, o.saleprice from book b inner join orders o on o.bookid = b.bookid where o.saleprice = (select max(o2.saleprice) from orders o2);
#(order by)
select b.bookname, o.saleprice from book b inner join orders o on o.bookid = b.bookid order by o.saleprice desc limit 1;

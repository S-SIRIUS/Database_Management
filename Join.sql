# 고객과 고객의 주문에 관한 데이터를 모두 보이시오.
select * from orders o, customer c where o.custid=c.custid;


# 가장 비싸게 주문된 도서의 이름을 검색하시오.
select b.bookname, o.saleprice from book b inner join orders o on b.bookid = o.bookid order by saleprice desc limit 1; 

select b.bookname, o.saleprice from book b, orders o where b.bookid = o.bookid and o.saleprice = (select max(saleprice) from orders);
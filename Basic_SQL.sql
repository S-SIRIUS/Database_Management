# 주문된 도서별로 고객의 수와 총 판매액을 구한다.
select bookid, count(distinct custid) as "주문수", sum(saleprice) as "총액" from orders group by bookid;
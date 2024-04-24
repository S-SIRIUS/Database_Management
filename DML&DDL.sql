# 테이블 생성
create table NewBook(
	bookid INTEGER,
    bookname VARCHAR(20),
    publisher VARCHAR(20),
    price INTEGER);

create table NewBook(
	bookid INTEGER,
    bookname VARCHAR(20),
    publisher VARCHAR(20),
    price INTEGER,
    PRIMARY KEY(bookname, publisher));
    
create table NewBook(
	bookid INTEGER,
    bookname VARCHAR(20) NOT NULL,
    publisher VARCHAR(20) UNIQUE,
    price INTEGER DEFAULT 10000 CHECK(price>=1000),
    PRIMARY KEY(bookname, publisher));
    
create table NewCustomer(
	custid INTEGER PRIMARY KEY,
    name VARCHAR(40),
    address VARCHAR(40),
    phone VARCHAR(30));

create table NewOrders(
	orderid INTEGER PRIMARY KEY,
    custid INTEGER NOT NULL,
    bookid INTEGER NOT NULL,
    saleprice INTEGER,
    orderdate DATE,
    foreign key (custid) references NewCustomer(custid) on delete cascade);


alter table NewBook add isbn VARCHAR(13);

alter table NewBook modify isbn INTEGER;

alter table NewBook drop column isbn;

alter table NewBook modify bookid INTEGER NOT NULL;

alter table NewBook add PRIMARY KEY(bookid);

drop table NewBook;

insert into Book(bookname, publisher, price) VALUES("스포츠의학", "한솔의학서적", 99000);

insert into Book(bookname, publisher, price) select * from imported_book;

update customer set address = "대한민국 부산" where custid=5;

update book set publisher= (select publisher from imported_book where bookid=21) where bookid=14;

delete from book where bookid=11;

delete from customer;

 

    
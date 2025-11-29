
-- create database banh;
use banh;
DROP TABLE IF EXISTS bill;
DROP TABLE IF EXISTS booking;
DROP TABLE IF EXISTS banhImages;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS banhs;

create table banhs(
	banhId int primary key auto_increment, -- mã banh
    banhName varchar(255), -- tên(số) banh
    price float, -- gia banh
    sale float, -- giảm giá
    description varchar(255)
);

insert into banhs values
(null, "Bánh Mousse Măng Cụt Nâu", 500000, 10,"Giảm giá 10%"),
(null, "Bánh Mousse", 350000, 15,"Giảm giá 15%"),
(null, "Bánh Chuối Socola", 50000, 20,"Giảm giá 20%"),
(null, "Rainbow Macaron", 50000, 0,""),
(null, "La Dolce Set", 100000, 0,""),
(null, "Bánh Su Kem", 15000, 0,""),
(null, "Red Velvet Cookies", 55000, 0,""),
(null, "Langue De Chat Cookies", 45000,0 ,""),
(null, "Sweet Lady - Sét 16 Bánh", 350000, 0,"");


create table banhImages(
	banhImageId int primary key auto_increment,
    banhId int,
    imgURL varchar(255),
    foreign key (banhId) references banhs(banhId)
);

insert into banhImages values
(null, 1, "https://cailonuong.com/wp-content/uploads/2025/05/CLN090535548-1.jpg"),
(null, 2, "https://cailonuong.com/wp-content/uploads/2024/04/Khong-cat_2x3_08-1.jpg"),
(null, 3, "https://cailonuong.com/wp-content/uploads/2024/01/banhnuong1009-1.jpg"),
(null, 4, "https://file.hstatic.net/1000104153/file/z5020148405532_6d7bfe55ab9224529d00000fe337b62a_31af378c30124301b91dd7e5f8c5648d_1024x1024.jpg"),
(null, 5, "https://file.hstatic.net/1000104153/file/z4841165954190_4a8fe363db45afe4fe8154196e872653_4e27ce786bfa46d4be0d414da597237f_2048x2048.jpg"),
(null, 6, "https://file.hstatic.net/1000104153/file/z4841148330202_8c3357dbdba84e8b5bd2b5ec6e5009fa_4fa6f725e9be49d1b194b690aceccb91_2048x2048.jpg"),
(null, 7, "https://file.hstatic.net/1000104153/file/z6204584848933_508f77f1c9cd6a248497519d482b7a25_2048x2048.jpg"),
(null, 8, "https://file.hstatic.net/1000104153/file/z4841147453160_184916c87496b90c608754d1791f8859_8367018402334b7ba9fb69997ad4dd00_2048x2048.jpg"),
(null, 9, "https://cailonuong.com/wp-content/uploads/2025/10/3-2.jpg");

create table customers(
	customerId int primary key auto_increment,
    customerName varchar(255), 
    email varchar(255), 
    tel varchar(255),
    address varchar(255)
);


create table booking(
	bookId int primary key auto_increment,
    customerId int,
    banhId int,
    quantity int default 1,
    note varchar(255),
    foreign key (customerId) references customers(customerId),
    foreign key (banhId) references banhs(banhId)
);

create table bill(
	billId int primary key auto_increment,
    bookId int,
    totalPrice float,
    foreign key (bookId) references booking(bookId)
);

ALTER TABLE customers ADD COLUMN password VARCHAR(255);



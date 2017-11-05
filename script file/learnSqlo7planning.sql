--THỰC HIỆN TẠO CÁC BẢNG MÔ TẢ HỆ THỐNG NGÂN HÀNG
--Bảng lưu trữ tài khoản ngân hàng. Mỗi khách hàng có thể đăng ký nhiều tài khoản, mỗi tài khoản tương ứng với một loại hình sản phẩm cung cấp bởi ngân hàng.
create table ACCOUNT (
        ACCOUNT_ID int identity not null,
        AVAIL_BALANCE float,--số dư tài khoản
        CLOSE_DATE datetime,--ngày đóng tài khoản
        LAST_ACTIVITY_DATE datetime,--giao dịch cuối cùng
        OPEN_DATE datetime not null,--ngày mở tài khoản
        PENDING_BALANCE float,
        STATUS varchar(10),
        CUST_ID int,
        OPEN_BRANCH_ID int not null,--mã chi nhánh ngân hàng
        OPEN_EMP_ID int not null,--mã nhân viên ngân hàng
        PRODUCT_CD varchar(10) not null,
        primary key (ACCOUNT_ID)
    );
--Bảng lưu thông tin các lần giao dịch với ngân hàng của một tài khoản nào đó.
create table ACC_TRANSACTION (
        TXN_ID numeric(19,0) identity not null,--mã giao dịch
        AMOUNT float not null,--số tiền giao dịch
        FUNDS_AVAIL_DATE datetime not null,
        TXN_DATE datetime not null,-- gày giao dịch
        TXN_TYPE_CD varchar(10),--loại giao dịch
        ACCOUNT_ID int,--id tài khoản giao dịch
        EXECUTION_BRANCH_ID int,--mã chi nhánh ngân hàng giao dịch
        TELLER_EMP_ID int,--số điện thoại nhân viên ngân hàng
        primary key (TXN_ID)
    );
--Bảng lưu thông tin chi nhánh ngân hàng
 create table BRANCH (
        BRANCH_ID int identity not null,
        ADDRESS varchar(30),
        CITY varchar(20),
        NAME varchar(20) not null,
        STATE varchar(10),
        ZIP_CODE varchar(12),--mã chi nhánh ngân hàng
        primary key (BRANCH_ID)
    );
--Bảng thông tin kinh doanh
   create table BUSINESS (
        INCORP_DATE datetime,
        NAME varchar(255) not null,
        STATE_ID varchar(10) not null,
        CUST_ID int not null,
        primary key (CUST_ID)
    );
--Bảng mô tả thông tin khác hàng
 create table CUSTOMER (
        CUST_ID int identity not null,
        ADDRESS varchar(30),
        CITY varchar(20),
        CUST_TYPE_CD varchar(1) not null,
        FED_ID varchar(12) not null,
        POSTAL_CODE varchar(10),
        STATE varchar(20),
        primary key (CUST_ID)
    );
--Bảng mô tả thông tin phòng ban của ngân hàng
create table DEPARTMENT (
        DEPT_ID int identity not null,
        NAME varchar(20) not null,
        primary key (DEPT_ID)
    );
--Bảng mô tả nhân viên ngân hàng
create table EMPLOYEE (
        EMP_ID int identity not null,
        END_DATE datetime,
        FIRST_NAME varchar(20) not null,
        LAST_NAME varchar(20) not null,
        START_DATE datetime not null,
        TITLE varchar(20),
        ASSIGNED_BRANCH_ID int,
        DEPT_ID int,
        SUPERIOR_EMP_ID int,
        primary key (EMP_ID)
    );
--Bảng mô tả thông tin cá nhân
create table INDIVIDUAL (
        BIRTH_DATE datetime,
        FIRST_NAME varchar(30) not null,
        LAST_NAME varchar(30) not null,
        CUST_ID int not null,
        primary key (CUST_ID)
    );
--Bảng mô tả thông tin Officer
create table OFFICER (
        OFFICER_ID int identity not null,
        END_DATE datetime,
        FIRST_NAME varchar(30) not null,
        LAST_NAME varchar(30) not null,
        START_DATE datetime not null,
        TITLE varchar(20),
        CUST_ID int,
        primary key (OFFICER_ID)
    );
--Bảng mô tả thông tin dịch vụ ngân hàng
create table PRODUCT (
        PRODUCT_CD varchar(10) not null,
        DATE_OFFERED datetime,
        DATE_RETIRED datetime,
        NAME varchar(50) not null,
        PRODUCT_TYPE_CD varchar(255),
        primary key (PRODUCT_CD)
    );
--Bảng mô tả các loại dịch vụ ngân hàng
 create table PRODUCT_TYPE (
        PRODUCT_TYPE_CD varchar(255) not null,
        NAME varchar(50),
        primary key (PRODUCT_TYPE_CD)
    );
--THỰC HIỆN TẠO KHÓA NGOẠI RÀNG BUỘC GIỮA CÁC BẢNG
--Bảng Account liên kết với bảng khác khàng thông qua khóa ngoại CUST_ID trong bảng Account
 alter table ACCOUNT 
        add constraint ACCOUNT_CUSTOMER_FK 
        foreign key (CUST_ID) 
        references CUSTOMER;
--Bảng Account liên kết với bảng chi nhánh ngân hàng thông qua khóa ngoại OPEN_BRANCH_ID trong bảng Account
alter table ACCOUNT 
        add constraint ACCOUNT_BRANCH_FK 
        foreign key (OPEN_BRANCH_ID) 
        references BRANCH;
--Bảng Account liên két với bảng nhân viên thông qua khóa ngoại OPEN_EMP_ID trong bảng Account
alter table ACCOUNT 
        add constraint ACCOUNT_EMPLOYEE_FK 
        foreign key (OPEN_EMP_ID) 
        references EMPLOYEE;
--Bảng Account liên kết với bảng sản phẩm dịch vụ của ngân hàng thông qua khóa ngoại trong bảng Account
alter table ACCOUNT 
        add constraint ACCOUNT_PRODUCT_FK 
        foreign key (PRODUCT_CD) 
        references PRODUCT;
--Bảng phiên giao dịch liên kết với bảng Account thông qua khóa ngoại trong bảng ACC_TRANSACTION
alter table ACC_TRANSACTION 
        add constraint ACC_TRANSACTION_ACCOUNT_FK 
        foreign key (ACCOUNT_ID) 
        references ACCOUNT;
--Bảng phiên giao dịch liên kết với bảng chi nhánh ngân hàng thông qua khóa ngoại trong bảng ACC_TRANSACTION
alter table ACC_TRANSACTION 
        add constraint ACC_TRANSACTION_BRANCH_FK 
        foreign key (EXECUTION_BRANCH_ID) 
        references BRANCH;
--Bảng phiên giao dịch liên kết với bảng nhân viên ngân hàng thông qua khóa ngoại trong bảng ACC_TRANSACTION
alter table ACC_TRANSACTION 
        add constraint ACC_TRANSACTION_EMPLOYEE_FK 
        foreign key (TELLER_EMP_ID) 
        references EMPLOYEE;
--Bảng BUSINESS liên kết với bảng CUSTOMER thông qua khóa ngoại trong bảng BUSINESS(CUST_ID)
alter table BUSINESS 
        add constraint BUSINESS_EMPLOYEE_FK 
        foreign key (CUST_ID) 
        references CUSTOMER;
--Bảng EMPLOYEE liên kết với bảng BRANCH thông qua khóa ngoại trong bảng EMPLOYEE(ASSIGNED_BRANCH_ID)
alter table EMPLOYEE 
        add constraint EMPLOYEE_BRANCH_FK 
        foreign key (ASSIGNED_BRANCH_ID) 
        references BRANCH;
--Bảng EMPLOYEE liên kết với bảng DEPARTMENT thông qua khóa ngoại trong bảng EMPLOYEE(DEPT_ID)
alter table EMPLOYEE 
        add constraint EMPLOYEE_DEPARTMENT_FK 
        foreign key (DEPT_ID) 
        references DEPARTMENT
--Bảng EMPLOYEE liên kết với bảng EMPLOYEE thông qua khóa ngoại trong bảng EMPLOYEE(DEPT_ID)
alter table EMPLOYEE 
        add constraint EMPLOYEE_EMPLOYEE_FK 
        foreign key (SUPERIOR_EMP_ID) 
        references EMPLOYEE;
--Bảng INDIVIDUAL liên kết với bảng CUSTOMER thông qua khóa ngoại trong bảng INDIVIDUAL(CUST_ID)
alter table INDIVIDUAL 
        add constraint INDIVIDUAL_CUSTOMER_FK 
        foreign key (CUST_ID) 
        references CUSTOMER;
--Bảng OFFICER liên kết với bảng CUSTOMER thông qua khóa ngoại trong bảng CUSTOMER(CUST_ID)
alter table OFFICER 
        add constraint OFFICER_CUSTOMER_FK 
        foreign key (CUST_ID) 
        references CUSTOMER;
--Bảng PRODUCT liên kết với bảng PRODUCT_TYPE thông qua khóa ngoại trong bảng PRODUCT(PRODUCT_TYPE_CD)
alter table PRODUCT 
        add constraint PRODUCT_PRODUCT_TYPE_FK 
        foreign key (PRODUCT_TYPE_CD) 
        references PRODUCT_TYPE;
--THỰC HIỆN INSERT DỮ LIỆU VÀO BẢNG
--Thêm mới dữ liệu vào bảng Department
-- Disable 
SET IDENTITY_INSERT department  ON;
insert into department (dept_id, name)
values (1, 'Operations');
---------------------
insert into department (dept_id, name)
values (2, 'Loans');
---------------------
insert into department (dept_id, name)
values (3, 'Administration');

insert into department (dept_id, name)
values (4, 'IT');
-- Enable
SET IDENTITY_INSERT department  OFF;
--Thêm mới dữ liệu vào bảng Branch
SET IDENTITY_INSERT branch  ON;
---------------------
insert into branch (branch_id, name, address, city, state, Zip_Code)
values (1, 'Headquarters', '3882 Main St.', 'Waltham', 'MA', '02451');
---------------------
insert into branch (branch_id, name, address, city, state, Zip_Code)
values (2, 'Woburn Branch', '422 Maple St.', 'Woburn', 'MA', '01801');
---------------------
insert into branch (branch_id, name, address, city, state, Zip_Code)
values (3, 'Quincy Branch', '125 Presidential Way', 'Quincy', 'MA', '02169');
---------------------
insert into branch (branch_id, name, address, city, state, Zip_Code)
values (4, 'So. NH Branch', '378 Maynard Ln.', 'Salem', 'NH', '03079');

SET IDENTITY_INSERT branch  OFF;
--Thêm mới dữ liệu vào bảng Employee
SET IDENTITY_INSERT employee  ON;
---------------------
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (1, 'Michael', 'Smith', Convert(Datetime,'2001-06-22',120),
 --Chọn ra mã phòng ban từ bảng phòng ban có tên phòng ban là addministration => sau đó add vào bảng nhân viên
  (select dept_id from department where name = 'Administration'),
  'President', 
  --Chọn ra mã chi nhánh ngân hàng từ bảng chi nhánh ngân hàng có tên chi nhánh là Headquarters => sau đó add vào bảng nhân viên
  (select branch_id from branch where name = 'Headquarters'));
---------------------
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (2, 'Susan', 'Barker',Convert(Datetime, '2002-09-12',120), 
  (select dept_id from department where name = 'Administration'), 
  'Vice President', 
  (select branch_id from branch where name = 'Headquarters'));
---------------------
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (3, 'Robert', 'Tyler',Convert(Datetime, '2000-02-09',120),
  (select dept_id from department where name = 'Administration'), 
  'Treasurer', 
  (select branch_id from branch where name = 'Headquarters'));
---------------------
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (4, 'Susan', 'Hawthorne',Convert(Datetime, '2002-04-24',120), 
  (select dept_id from department where name = 'Operations'), 
  'Operations Manager', 
  (select branch_id from branch where name = 'Headquarters'));
---------------------
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (5, 'John', 'Gooding',Convert(Datetime, '2003-11-14',120), 
  (select dept_id from department where name = 'Loans'), 
  'Loan Manager', 
  (select branch_id from branch where name = 'Headquarters'));
---------------------
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (6, 'Helen', 'Fleming',Convert(Datetime, '2004-03-17',120), 
  (select dept_id from department where name = 'Operations'), 
  'Head Teller', 
  (select branch_id from branch where name = 'Headquarters'));
---------------------
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (7, 'Chris', 'Tucker',Convert(Datetime, '2004-09-15',120), 
  (select dept_id from department where name = 'Operations'), 
  'Teller', 
  (select branch_id from branch where name = 'Headquarters'));
---------------------
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (8, 'Sarah', 'Parker',Convert(Datetime, '2002-12-02',120), 
  (select dept_id from department where name = 'Operations'), 
  'Teller', 
  (select branch_id from branch where name = 'Headquarters'));
---------------------
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (9, 'Jane', 'Grossman',Convert(Datetime, '2002-05-03',120), 
  (select dept_id from department where name = 'Operations'), 
  'Teller', 
  (select branch_id from branch where name = 'Headquarters'));
---------------------
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (10, 'Paula', 'Roberts',Convert(Datetime, '2002-07-27',120), 
  (select dept_id from department where name = 'Operations'), 
  'Head Teller', 
  (select branch_id from branch where name = 'Woburn Branch'));
---------------------
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (11, 'Thomas', 'Ziegler',Convert(Datetime, '2000-10-23',120), 
  (select dept_id from department where name = 'Operations'), 
  'Teller', 
  (select branch_id from branch where name = 'Woburn Branch'));
---------------------
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (12, 'Samantha', 'Jameson',Convert(Datetime, '2003-01-08',120), 
  (select dept_id from department where name = 'Operations'), 
  'Teller', 
  (select branch_id from branch where name = 'Woburn Branch'));
---------------------
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (13, 'John', 'Blake',Convert(Datetime, '2000-05-11',120), 
  (select dept_id from department where name = 'Operations'), 
  'Head Teller', 
  (select branch_id from branch where name = 'Quincy Branch'));
---------------------
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (14, 'Cindy', 'Mason',Convert(Datetime, '2002-08-09',120), 
  (select dept_id from department where name = 'Operations'), 
  'Teller', 
  (select branch_id from branch where name = 'Quincy Branch'));
---------------------
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (15, 'Frank', 'Portman',Convert(Datetime, '2003-04-01',120), 
  (select dept_id from department where name = 'Operations'), 
  'Teller', 
  (select branch_id from branch where name = 'Quincy Branch'));
---------------------
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (16, 'Theresa', 'Markham',Convert(Datetime, '2001-03-15',120), 
  (select dept_id from department where name = 'Operations'), 
  'Head Teller', 
  (select branch_id from branch where name = 'So. NH Branch'));
---------------------
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (17, 'Beth', 'Fowler',Convert(Datetime, '2002-06-29',120), 
  (select dept_id from department where name = 'Operations'), 
  'Teller', 
  (select branch_id from branch where name = 'So. NH Branch'));
---------------------
insert into employee (emp_id, First_Name, Last_Name, start_date, 
  dept_id, title, assigned_branch_id)
values (18, 'Rick', 'Tulman',Convert(Datetime, '2002-12-12',120), 
  (select dept_id from department where name = 'Operations'), 
  'Teller', 
  (select branch_id from branch where name = 'So. NH Branch'));
SET IDENTITY_INSERT employee  OFF;
-- create data for self-referencing foreign key 'superior_emp_id' 
create   table emp_tmp(emp_id int, first_name varchar (20), last_name varchar (20)); 
update employee set superior_emp_id =
 (select emp_id from emp_tmp where Last_Name = 'Smith' and First_Name = 'Michael')
where ((Last_Name = 'Barker' and First_Name = 'Susan')
  or (Last_Name = 'Tyler' and First_Name = 'Robert'));
---------------------
update employee set superior_emp_id =
 (select emp_id from emp_tmp where Last_Name = 'Tyler' and First_Name = 'Robert')
where Last_Name = 'Hawthorne' and First_Name = 'Susan';
---------------------
update employee set superior_emp_id =
 (select emp_id from emp_tmp where Last_Name = 'Hawthorne' and First_Name = 'Susan')
where ((Last_Name = 'Gooding' and First_Name = 'John')
  or (Last_Name = 'Fleming' and First_Name = 'Helen')
  or (Last_Name = 'Roberts' and First_Name = 'Paula') 
  or (Last_Name = 'Blake' and First_Name = 'John') 
  or (Last_Name = 'Markham' and First_Name = 'Theresa')); 
---------------------
update employee set superior_emp_id =
 (select emp_id from emp_tmp where Last_Name = 'Fleming' and First_Name = 'Helen')
where ((Last_Name = 'Tucker' and First_Name = 'Chris') 
  or (Last_Name = 'Parker' and First_Name = 'Sarah') 
  or (Last_Name = 'Grossman' and First_Name = 'Jane'));  
---------------------
update employee set superior_emp_id =
 (select emp_id from emp_tmp where Last_Name = 'Roberts' and First_Name = 'Paula')
where ((Last_Name = 'Ziegler' and First_Name = 'Thomas')  
  or (Last_Name = 'Jameson' and First_Name = 'Samantha'));   
---------------------
update employee set superior_emp_id =
 (select emp_id from emp_tmp where Last_Name = 'Blake' and First_Name = 'John')
where ((Last_Name = 'Mason' and First_Name = 'Cindy')   
  or (Last_Name = 'Portman' and First_Name = 'Frank'));    
---------------------
update employee set superior_emp_id =
 (select emp_id from emp_tmp where Last_Name = 'Markham' and First_Name = 'Theresa')
where ((Last_Name = 'Fowler' and First_Name = 'Beth')   
  or (Last_Name = 'Tulman' and First_Name = 'Rick'));    
drop table emp_tmp;
--Thêm mới dữ liệu vào bảng loại Product
---------------------
insert into product_type (product_type_cd, name)
values ('ACCOUNT','Customer Accounts');
---------------------
insert into product_type (product_type_cd, name)
values ('LOAN','Individual and Business Loans');
---------------------
insert into product_type (product_type_cd, name)
values ('INSURANCE','Insurance Offerings');
--Thêm mới dữ liệu vào bảng loại Product
insert into product (product_cd, name, product_type_cd, date_offered)
values ('CHK','checking account','ACCOUNT',Convert(Datetime,'2000-01-01',120));
---------------------
insert into product (product_cd, name, product_type_cd, date_offered)
values ('SAV','savings account','ACCOUNT',Convert(Datetime,'2000-01-01',120));
---------------------
insert into product (product_cd, name, product_type_cd, date_offered)
values ('MM','money market account','ACCOUNT',Convert(Datetime,'2000-01-01',120));
---------------------
insert into product (product_cd, name, product_type_cd, date_offered)
values ('CD','certificate of deposit','ACCOUNT',Convert(Datetime,'2000-01-01',120));
---------------------
insert into product (product_cd, name, product_type_cd, date_offered)
values ('MRT','home mortgage','LOAN',Convert(Datetime,'2000-01-01',120));
---------------------
insert into product (product_cd, name, product_type_cd, date_offered)
values ('AUT','auto loan','LOAN',Convert(Datetime,'2000-01-01',120));
---------------------
insert into product (product_cd, name, product_type_cd, date_offered)
values ('BUS','business line of credit','LOAN',Convert(Datetime,'2000-01-01',120));
---------------------
insert into product (product_cd, name, product_type_cd, date_offered)
values ('SBL','small business loan','LOAN',Convert(Datetime,'2000-01-01',120));
-- residential customer data(Địa chỉ khách hàng)
SET IDENTITY_INSERT customer ON;
---------------------
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (1, '111-11-1111', 'I', '47 Mockingbird Ln', 'Lynnfield', 'MA', '01940');
---------------------
insert into individual (cust_id, First_Name, Last_Name, birth_date)
select cust_id, 'James', 'Hadley', Convert(Datetime,'1972-04-22',120) from customer
where fed_id = '111-11-1111';
---------------------
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (2, '222-22-2222', 'I', '372 Clearwater Blvd', 'Woburn', 'MA', '01801');
---------------------
insert into individual (cust_id, First_Name, Last_Name, birth_date)
select cust_id, 'Susan', 'Tingley', Convert(Datetime,'1968-08-15',120) from customer
where fed_id = '222-22-2222';
---------------------
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (3, '333-33-3333', 'I', '18 Jessup Rd', 'Quincy', 'MA', '02169');
---------------------
insert into individual (cust_id, First_Name, Last_Name, birth_date)
select cust_id, 'Frank', 'Tucker',Convert(Datetime, '1958-02-06',120) from customer
where fed_id = '333-33-3333';
---------------------
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (4, '444-44-4444', 'I', '12 Buchanan Ln', 'Waltham', 'MA', '02451');
---------------------
insert into individual (cust_id, First_Name, Last_Name, birth_date)
select cust_id, 'John', 'Hayward',Convert(Datetime,'1966-12-22',120) from customer
where fed_id = '444-44-4444';
---------------------
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (5, '555-55-5555', 'I', '2341 Main St', 'Salem', 'NH', '03079');
---------------------
insert into individual (cust_id, First_Name, Last_Name, birth_date)
select cust_id, 'Charles', 'Frasier',Convert(Datetime, '1971-08-25',120) from customer
where fed_id = '555-55-5555';
---------------------
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (6, '666-66-6666', 'I', '12 Blaylock Ln', 'Waltham', 'MA', '02451');
---------------------
insert into individual (cust_id, First_Name, Last_Name, birth_date)
select cust_id, 'John', 'Spencer',Convert(Datetime, '1962-09-14',120)from customer
where fed_id = '666-66-6666';
---------------------
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (7, '777-77-7777', 'I', '29 Admiral Ln', 'Wilmington', 'MA', '01887');
---------------------
insert into individual (cust_id, First_Name, Last_Name, birth_date)
select cust_id, 'Margaret', 'Young',Convert(Datetime, '1947-03-19' ,120)from customer
where fed_id = '777-77-7777';
---------------------
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (8, '888-88-8888', 'I', '472 Freedom Rd', 'Salem', 'NH', '03079');
---------------------
insert into individual (cust_id, First_Name, Last_Name, birth_date)
select cust_id, 'Louis', 'Blake',Convert(Datetime, '1977-07-01' ,120)from customer
where fed_id = '888-88-8888';
---------------------
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (9, '999-99-9999', 'I', '29 Maple St', 'Newton', 'MA', '02458');
---------------------
insert into individual (cust_id, First_Name, Last_Name, birth_date)
select cust_id, 'Richard', 'Farley',Convert(Datetime, '1968-06-16',120) from customer
where fed_id = '999-99-9999';
-- corporate customer data 
---------------------
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (10, '04-1111111', 'B', '7 Industrial Way', 'Salem', 'NH', '03079');
---------------------
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (11, '04-2222222', 'B', '287A Corporate Ave', 'Wilmington', 'MA', '01887');
---------------------
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (12, '04-3333333', 'B', '789 Main St', 'Salem', 'NH', '03079');
---------------------
insert into customer (cust_id, fed_id, cust_type_cd,
  address, city, state, postal_code)
values (13, '04-4444444', 'B', '4772 Presidential Way', 'Quincy', 'MA', '02169');
SET IDENTITY_INSERT customer OFF;
--Thêm mới dữ liệu vào bảng Office
SET IDENTITY_INSERT officer ON;
---------------------
insert into business (cust_id, name, state_id, incorp_date)
select cust_id, 'Chilton Engineering', '12-345-678',Convert(Datetime, '1995-05-01',120) from customer
where fed_id = '04-1111111';
---------------------
insert into officer (officer_id, cust_id, First_Name, Last_Name,
  title, start_date)
select 1, cust_id, 'John', 'Chilton', 'President', Convert(Datetime,'1995-05-01',120)
from customer
where fed_id = '04-1111111';
---------------------
insert into business (cust_id, name, state_id, incorp_date)
select cust_id, 'Northeast Cooling Inc.', '23-456-789',Convert(Datetime, '2001-01-01' ,120)from customer
where fed_id = '04-2222222';
---------------------
insert into officer (officer_id, cust_id, First_Name, Last_Name,
  title, start_date)
select 2, cust_id, 'Paul', 'Hardy', 'President',Convert(Datetime, '2001-01-01',120)
from customer
where fed_id = '04-2222222';
---------------------
insert into business (cust_id, name, state_id, incorp_date)
select cust_id, 'Superior Auto Body', '34-567-890',Convert(Datetime, '2002-06-30',120) from customer
where fed_id = '04-3333333';
---------------------
insert into officer (officer_id, cust_id, First_Name, Last_Name,
  title, start_date)
select 3, cust_id, 'Carl', 'Lutz', 'President',Convert(Datetime, '2002-06-30',120)
from customer
where fed_id = '04-3333333';
---------------------
insert into business (cust_id, name, state_id, incorp_date)
select cust_id, 'AAA Insurance Inc.', '45-678-901',Convert(Datetime, '1999-05-01',120) from customer
where fed_id = '04-4444444';
---------------------
insert into officer (officer_id, cust_id, First_Name, Last_Name,
  title, start_date)
select 4, cust_id, 'Stanley', 'Cheswick', 'President',Convert(Datetime, '1999-05-01',120)
from customer
where fed_id = '04-4444444';
SET IDENTITY_INSERT officer OFF;
-- residential account data(thêm mới dữ liệu cho bảng địa account)
---------------------
insert into account ( product_cd, cust_id, open_date,
 + t  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select   a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select top 1 b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Woburn' ) e
  cross join
 (select 'CHK' prod_cd,Convert(Datetime, '2000-01-15',120) open_date,Convert(Datetime, '2005-01-04',120) last_date,
    1057.75 avail, 1057.75 pend  union all
  select 'SAV' prod_cd,Convert(Datetime, '2000-01-15',120) open_date,Convert(Datetime, '2004-12-19',120) last_date,
    500.00 avail, 500.00 pend   union all
  select 'CD' prod_cd,Convert(Datetime, '2004-06-30',120) open_date,Convert(Datetime, '2004-06-30' ,120)last_date,
    3000.00 avail, 3000.00 pend   ) a
where c.fed_id = '111-11-1111';
---------------------
insert into account (  product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select   a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select top 1  b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Woburn' ) e
  cross join
 (select 'CHK' prod_cd,Convert(Datetime, '2001-03-12',120) open_date,Convert(Datetime, '2004-12-27' ,120)last_date,
    2258.02 avail, 2258.02 pend   union all
  select 'SAV' prod_cd,Convert(Datetime, '2001-03-12',120) open_date,Convert(Datetime, '2004-12-11' ,120)last_date,
    200.00 avail, 200.00 pend   ) a
where c.fed_id = '222-22-2222';
---------------------
insert into account (  product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select   a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select top 1  b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Quincy' ) e
  cross join
 (select 'CHK' prod_cd,Convert(Datetime, '2002-11-23' ,120)open_date,Convert(Datetime, '2004-11-30' ,120)last_date,
    1057.75 avail, 1057.75 pend   union all
  select 'MM' prod_cd,Convert(Datetime, '2002-12-15',120) open_date,Convert(Datetime, '2004-12-05' ,120)last_date,
    2212.50 avail, 2212.50 pend  ) a
where c.fed_id = '333-33-3333';
---------------------
insert into account (  product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select   a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select top 1  b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Waltham' ) e
  cross join
 (select 'CHK' prod_cd,Convert(Datetime, '2003-09-12' ,120)open_date,Convert(Datetime, '2005-01-03' ,120)last_date,
    534.12 avail, 534.12 pend   union all
  select 'SAV' prod_cd,Convert(Datetime, '2000-01-15' ,120)open_date,Convert(Datetime, '2004-10-24',120) last_date,
    767.77 avail, 767.77 pend   union all
  select 'MM' prod_cd,Convert(Datetime, '2004-09-30',120) open_date,Convert(Datetime, '2004-11-11' ,120)last_date,
    5487.09 avail, 5487.09 pend ) a
where c.fed_id = '444-44-4444';
---------------------
insert into account (  product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select   a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select top 1  b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Salem' ) e
  cross join
 (select 'CHK' prod_cd, Convert(Datetime,'2004-01-27' ,120)open_date,Convert(Datetime, '2005-01-05' ,120)last_date,
    2237.97 avail, 2897.97 pend ) a
where c.fed_id = '555-55-5555';
---------------------
insert into account (  product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select   a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select top 1  b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Waltham' ) e
  cross join
 (select 'CHK' prod_cd,Convert(Datetime, '2002-08-24' ,120)open_date,Convert(Datetime, '2004-11-29',120) last_date,
    122.37 avail, 122.37 pend   union all
  select 'CD' prod_cd,Convert(Datetime, '2004-12-28' ,120)open_date,Convert(Datetime, '2004-12-28',120) last_date,
    10000.00 avail, 10000.00 pend  ) a
where c.fed_id = '666-66-6666';
---------------------
insert into account (  product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select   a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select top 1  b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Woburn' ) e
  cross join
 (select 'CD' prod_cd,Convert(Datetime, '2004-01-12' ,120)open_date, Convert(Datetime,'2004-01-12' ,120)last_date,
    5000.00 avail, 5000.00 pend ) a
where c.fed_id = '777-77-7777';
---------------------
insert into account (  product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select   a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select top 1  b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Salem' ) e
  cross join
 (select 'CHK' prod_cd,Convert(Datetime, '2001-05-23' ,120)open_date,Convert(Datetime, '2005-01-03' ,120)last_date,
    3487.19 avail, 3487.19 pend   union all
  select 'SAV' prod_cd,Convert(Datetime, '2001-05-23' ,120)open_date,Convert(Datetime, '2004-10-12' ,120)last_date,
    387.99 avail, 387.99 pend  ) a
where c.fed_id = '888-88-8888';
---------------------
insert into account (  product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select   a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select top 1  b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Waltham' ) e
  cross join
 (select 'CHK' prod_cd,Convert(Datetime, '2003-07-30',120) open_date,Convert(Datetime, '2004-12-15' ,120)last_date,
    125.67 avail, 125.67 pend   union all
  select 'MM' prod_cd,Convert(Datetime, '2004-10-28' ,120)open_date,Convert(Datetime, '2004-10-28' ,120)last_date,
    9345.55 avail, 9845.55 pend   union all
  select 'CD' prod_cd,Convert(Datetime, '2004-06-30' ,120)open_date,Convert(Datetime, '2004-06-30' ,120)last_date,
    1500.00 avail, 1500.00 pend  ) a
where c.fed_id = '999-99-9999';
-- corporate account data  
---------------------
insert into account (  product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select   a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select top 1  b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Salem' ) e
  cross join
 (select 'CHK' prod_cd,Convert(Datetime, '2002-09-30' ,120)open_date, Convert(Datetime,'2004-12-15' ,120)last_date,
    23575.12 avail, 23575.12 pend   union all
  select 'BUS' prod_cd,Convert(Datetime, '2002-10-01' ,120)open_date,Convert(Datetime, '2004-08-28' ,120)last_date,
    0 avail, 0 pend  ) a
where c.fed_id = '04-1111111';
---------------------
insert into account (  product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select   a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select top 1  b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Woburn' ) e
  cross join
 (select 'BUS' prod_cd,Convert(Datetime, '2004-03-22',120) open_date,Convert(Datetime, '2004-11-14',120) last_date,
    9345.55 avail, 9345.55 pend ) a
where c.fed_id = '04-2222222';
---------------------
insert into account (  product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select   a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select top 1  b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Salem' ) e
  cross join
 (select 'CHK' prod_cd,Convert(Datetime, '2003-07-30',120) open_date,Convert(Datetime, '2004-12-15' ,120)last_date,
    38552.05 avail, 38552.05 pend ) a
where c.fed_id = '04-3333333';
---------------------
insert into account (  product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select   a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join 
 (select top 1  b.branch_id, e.emp_id 
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Quincy' ) e
  cross join
 (select 'SBL' prod_cd,Convert(Datetime, '2004-02-22',120) open_date,Convert(Datetime, '2004-12-17',120) last_date,
    50000.00 avail, 50000.00 pend ) a
where c.fed_id = '04-4444444';
-- ======================================================================== 
-- ======= ACC_TRANSACTION.
-- ========================================================================

-- put $100 in all checking/savings accounts on date account opened  
---------------------
insert into Acc_transaction (  txn_date, account_id, txn_type_cd,
  amount, funds_avail_date)
select   a.open_date, a.account_id, 'CDT', 100, a.open_date
from account a
where a.product_cd IN ('CHK','SAV','CD','MM');
--When you create the new database you specify the location. For example:
--USE [master]
--GO

--    CREATE DATABASE [AdventureWorks] ON  PRIMARY 
--    ( NAME = N'AdventureWorks_Data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\AdventureWorks_Data.mdf' , SIZE = 167872KB , MAXSIZE = UNLIMITED, FILEGROWTH = 16384KB )
--     LOG ON 
--    ( NAME = N'AdventureWorks_Log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\AdventureWorks_Log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 16384KB )
--    GO
----The syntax for the CREATE TABLE statement in SQL Server (Transact-SQL) is:

--CREATE TABLE table_name
--( 
--  column1 datatype [ NULL | NOT NULL ],
--  column2 datatype [ NULL | NOT NULL ],
--  ...
--);
use TOTN
go
create table suppliers(
	supplier_id int not null,
	supplier_name char(50) not null,
	contact_name char(50)
);
alter table suppliers add primary key(supplier_id)

create table employee(
	employee_id int not null,
	last_name varchar(50) not null,
	first_name varchar(50) not null,
	salary money
);
--Primary Keys
create table pk_create_tbl(
	pk_cre_tbl_id int primary key,
	pk_cre_tbl_name varchar(50) not null
);
create table pk_create_tbl2(
	pk_cre_tbl_id int not null,
	pk_cre_tbl_name varchar(50) not null,
	constraint primary_kye primary key(pk_cre_tbl_id)
);
create table pk_alter_tbl(
	pk_cre_tbl_id int not null,
	pk_cre_tbl_name varchar(50) not null
);
alter table pk_alter_tbl add constraint pk_prima  primary key(pk_cre_tbl_name);
--alter table pk_create_tbl2 add constraint pk_prima  primary key(pk_cre_tbl_id,pk_cre_tbl_name); failse
--ALTER TABLE Statement
--ALTER TABLE table_name
--  ADD column_name column-definition;
alter table suppliers add phone_number int not null
--Add multiple columns in table
--ALTER TABLE table_name
--  ADD column_1 column-definition,
--      column_2 column-definition,
--      ...
--      column_n column_definition;
alter table employee 
	add date_of_birth date,
	phone_number int,
	home_address varchar(100)
--Modify column in table
--ALTER TABLE table_name
--  ALTER COLUMN column_name column_type;
alter table employee
	alter column home_address varchar(150);
--Drop column in table
--ALTER TABLE table_name
--  DROP COLUMN column_name;
alter table employee
	drop column phone_number;
--Rename column in table
--sp_rename 'table_name.old_column_name', 'new_column_name', 'COLUMN';
use TOTN
go
sp_RENAME  'employee.last_name', 'namelast', 'COLUMN';
--Rename table
--sp_rename 'old_table_name', 'new_table_name';
sp_RENAME 'pk_create_tbl', 'pk_create_table'
--DROP TABLE Statement
create table drop_table(
	col_num1 int primary key,
	col_num2 varchar(50)
);
--DROP TABLE table_name;
drop table drop_table;
--Thao tác với khóa ngoại
create table bomon(
	mabomon char(10) primary key,
	tenbomon nvarchar(100) not null default N'Tên bộ môn'
);
go
create table lop(
	malop char(10) primary key,
	tenlop nvarchar(1000) not null default N'Tên lớp'
);
go
create table hocsinh(
	mahocsinh char(10) primary key,
	tenhocsinh nvarchar(100) not null,
	ngaysinh date,
	sex bit,
	diachi nvarchar(150)
);
--Tạo khóa ngoại sau khi tạo bảng
alter table hocsinh add malop char(10) not null;
alter table hocsinh add foreign key(malop) references lop(malop);
--Đặt tên cho khóa ngoại
alter table hocsinh add constraint fk_hocsinh_lop foreign key(malop) references lop(malop);
go
create table giaovien(
	magiaovien char(10) primary key,
	tengiaovien nvarchar(100) not null,
	diachi nvarchar(100),
	ngaysinh date,
	sex bit,
	mabomon char(10) not null,
	 -- Tạo khóa ngoại ngay khi tạo bảng
	foreign key(mabomon) references bomon(mabomon)
);
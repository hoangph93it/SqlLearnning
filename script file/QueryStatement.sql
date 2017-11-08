use learnSQLo7planning
--SQL Distinct
-- Truy vấn sản phẩm (Sản phẩm dịch vụ của Ngân hàng)
-- Cột mã sản phẩm, tên và kiểu sản phẩm.
select pro_type.PRODUCT_CD, pro_type.NAME, pro_type.PRODUCT_TYPE_CD 
from PRODUCT pro_type;
-- Truy vấn các kiểu sản phẩm  (Product_Type_Cd) trong bảng Product.
-- Dữ liệu là nhiều, nhưng trùng nhau.
select pro_type.PRODUCT_TYPE_CD 
from PRODUCT pro_type
-- Cần sử dụng Distinct để loại bỏ việc trùng lặp.
select distinct pro_type_cd.PRODUCT_TYPE_CD 
from PRODUCT pro_type_cd;
--WHERE Clause
select * from PRODUCT pro 
where pro.PRODUCT_TYPE_CD='LOAN'
--Select top statment
SELECT TOP(10) PERCENT WITH TIES pro_type.PRODUCT_CD, pro_type.NAME, pro_type.PRODUCT_TYPE_CD 
FROM PRODUCT pro_type 
WHERE pro_type.PRODUCT_TYPE_CD='LOAN' 
ORDER BY pro_type.PRODUCT_CD;
--Select into statement
select emp.EMP_ID as contact_id, emp.FIRST_NAME, emp.LAST_NAME into emp_contact 
from EMPLOYEE emp where emp.EMP_ID <=10;
----------
select* from emp_contact;
--And Condition
select emp.EMP_ID, emp.FIRST_NAME, emp.LAST_NAME , emp.DEPT_ID
from EMPLOYEE emp
where emp.FIRST_NAME like 'S%' AND emp.DEPT_ID=1;
-----
select emp.EMP_ID, emp.FIRST_NAME, emp.LAST_NAME , emp.DEPT_ID
from EMPLOYEE emp
where (emp.FIRST_NAME like 'S%' OR emp.FIRST_NAME like 'P%') AND emp.DEPT_ID=1;
--IN Conditon
select  emp.EMP_ID, emp.FIRST_NAME, emp.LAST_NAME 
from EMPLOYEE emp
where emp.FIRST_NAME IN('Susan','Paula','Helen');
--BETWEEN Condition
select emp.EMP_ID, emp.FIRST_NAME, emp.LAST_NAME
from EMPLOYEE emp
where (emp.EMP_ID BETWEEN 5 AND 10);
-- Câu lệnh này tìm kiếm các nhân viên bắt đầu vào làm việc trong 1 khoảng thời gian
-- xác định trong mệnh đề where.
-- 03-05-2002 ==> 09-08-2002  (Theo dd-MM-yyyy)
Select Emp.Emp_Id,
	Emp.First_Name,
	Emp.Last_Name,
	Emp.Start_Date, 
    Convert(Varchar, Emp.Start_Date,105) Start_Date_Vn
-- Hàm Convert(Varchar, <Date>, 105) chuyển Date thành Varchar dạng DD-MM-YYYY
-- Đây là hàm của SQLServer. không dùng cho DB khác.
From Employee Emp
Where(Emp.Start_Date Between Convert(Datetime, '03-05-2002',105) And Convert(Datetime,'09-08-2002',105));
-- Hàm Convert(Datetime, <Varchar>, 105) chuyển text dạng DD-MM-YYYY sang Datetime
-- (Đây là hàm của SQLServer, có thể ko có trên các DB khác)
--Wildcard special character
select cus.CUST_ID, cus.FED_ID, cus.ADDRESS
from CUSTOMER cus
where cus.FED_ID like '%-__-%';
--Order by Clause
select pro.NAME, pro.PRODUCT_CD, pro.PRODUCT_TYPE_CD
from PRODUCT pro
order by pro.PRODUCT_TYPE_CD desc, pro.NAME asc
----
select emp.EMP_ID, emp.FIRST_NAME, emp.LAST_NAME, emp.START_DATE
from EMPLOYEE emp
where emp.FIRST_NAME like 'S%'
order by emp.START_DATE desc
--Group By Clause
select acc.ACCOUNT_ID,acc.PRODUCT_CD, acc.AVAIL_BALANCE, acc.PENDING_BALANCE
from ACCOUNT acc;
--Xem tổng số tài khoản với tổng số tiền và số tiền trung bình của mỗi loại sản phảm dịch vụ
select acc.PRODUCT_CD, COUNT(acc.PRODUCT_CD) as Count_Acc, SUM(acc.AVAIL_BALANCE) Sum_AVAIL_BALANCE, AVG(acc.AVAIL_BALANCE) as avg_AVAIL_BALANCE
from ACCOUNT acc
group by acc.PRODUCT_CD;
--Having Clause
select acc.PRODUCT_CD, COUNT(acc.PRODUCT_CD) as Count_Acc, SUM(acc.AVAIL_BALANCE) Sum_AVAIL_BALANCE, AVG(acc.AVAIL_BALANCE) as avg_AVAIL_BALANCE
from ACCOUNT acc
group by acc.PRODUCT_CD
having COUNT(acc.PRODUCT_CD) >3;
---
select acc.PRODUCT_CD, COUNT(acc.PRODUCT_CD) as Count_Acc, SUM(acc.AVAIL_BALANCE) Sum_AVAIL_BALANCE, AVG(acc.AVAIL_BALANCE) as avg_AVAIL_BALANCE
from ACCOUNT acc
where acc.OPEN_BRANCH_ID =1
group by acc.PRODUCT_CD
having COUNT(acc.PRODUCT_CD) >1;
-- Trèn 1 dòng dữ liệu vào bảng Acc_Trasaction
-- Cột Txn_ID tự động được sinh ra.
-- (Txn_ID không tham gia vào trong câu Insert)
-- Current_Timestamp là hàm của SQLServer lấy ra giờ hệ thống (System Date)
-- Current_Timestamp : Giờ hiện tại.
Insert Into Acc_Transaction
  (Amount
  ,Funds_Avail_Date
  ,Txn_Date
  ,Txn_Type_Cd
  ,Account_Id
  ,Execution_Branch_Id
  ,Teller_Emp_Id)
Values
  (100 -- Amount
  ,Current_Timestamp -- Funds_Avail_Date
  ,Current_Timestamp -- Txn_Date
  ,'CDT' -- Txn_Type_Cd
  ,2 -- Account_Id
  ,Null -- Execution_Branch_Id
  ,Null -- Teller_Emp_Id
   );
   -- Txn_Id tự sinh ra (Không cần phải tham gia vào câu Insert)
-- Trèn nhiều dòng dữ liệu vào bảng Acc_Transaction
-- Lấy dữ liệu từ câu Select.
 
Insert Into Acc_Transaction
 ( Txn_Date
 ,Account_Id
 ,Txn_Type_Cd
 ,Amount
 ,Funds_Avail_Date)
 Select Acc.Open_Date -- Txn_Date
       ,Acc.Account_Id -- Account_Id
       ,'CDT' -- Txn_Type_Cd
       ,200 -- Amount
       ,Acc.Open_Date -- Funds_Avail_Date
 From   Account Acc
 Where  Acc.Product_Cd = 'CD';
 --Update Statement
 select acc.ACCOUNT_ID, acc.PRODUCT_CD, acc.AVAIL_BALANCE, acc.PENDING_BALANCE, acc.CUST_ID
 from ACCOUNT acc
 where acc.CUST_ID=1;
 ----
 update ACCOUNT
 set AVAIL_BALANCE = AVAIL_BALANCE+ 2*AVAIL_BALANCE/100, PENDING_BALANCE=PENDING_BALANCE+2*PENDING_BALANCE/100
 where CUST_ID=1;
 --Delete Statement
 select * from ACC_TRANSACTION acc_tr
 order by acc_tr.TXN_ID desc
 ----
 delete from ACC_TRANSACTION
 where TXN_ID in(25,26);
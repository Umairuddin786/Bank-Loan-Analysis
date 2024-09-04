create database Bank_loan;
use bank_loan;
CREATE TABLE loan_data (
    id INT PRIMARY KEY,
    address_state VARCHAR(150),
    application_type VARCHAR(150),
    emp_length VARCHAR(150),
    emp_title VARCHAR(150),
    grade CHAR(1),
    home_ownership VARCHAR(150),
    issue_date DATE,
    last_credit_pull_date DATE,
    last_payment_date DATE,
    loan_status VARCHAR(150),
    next_payment_date DATE,
    member_id INT,
    purpose VARCHAR(150),
    sub_grade VARCHAR(150),
    term VARCHAR(150),
    verification_status VARCHAR(150),
    annual_income DECIMAL(10, 2),
    dti DECIMAL(5, 2),
    installment DECIMAL(10, 2),
    int_rate DECIMAL(5, 4),
    loan_amount DECIMAL(10, 2),
    total_acc INT,
    total_payment DECIMAL(10, 2)
);
select * from loan_data;
# Kpi's of summary 
# Total Application
select count(id) as Total_Loan_Applications from loan_data ;

# MTD Loan Applications
select count(id) as Total_Loan_Applications from loan_data
where month(issue_date) = 12;

# PMTD Loan Applications
select count(id) as Total_Applications from loan_data
where month(issue_date) = 11;

# Total Funnded Amount
 select sum(loan_amount) as Total_Funnded_Amount from loan_data;
 
 # MTD Total Funded Amount
 select sum(loan_Amount) as Total_Funnded_Amount from loan_data
 where month(issue_date) = 12;
 
 # PMTD Total Funnded Amount
 select sum(loan_Amount) as Total_Funnded_Amount from loan_data
 where month(issue_date) = 11;
 
 # Total Amount Recived
 select sum(total_payment) as Total_Ammount_Collected from loan_data;
 
 # MTD Total Amount Recived
 select sum(total_Payment) as Total_Amount_Collected from loan_data
 where month(issue_date) = 12;
 
 # PMTD Total Amount Recived
 select sum(total_Payment) as Total_Amount_Collected from loan_data
 where month(issue_date) = 11;
 
 # Avg Interest Rate
 select avg(int_rate)*100 as Avg_Interest_Rate from loan_data;
 
 # MTD Avg Interest Rate
 select avg(int_rate) *100 as Avg_Interest_Rate from loan_data
 where month(issue_date) = 12 ;
 
 # PMTD Avg Interest Rate
 select avg(int_rate)*100 as Avg_Interest_Rate from loan_data
 where month(issue_date) = 11;
 
 # Avg DTI
 select avg(dti)*100 as Avg_Dti from loan_data;
 
 # MTD AVG Dti
 select avg(dti)*100 as Avg_Dti from loan_data
 where month(issue_date) = 12;
 
 # PMTD Avg Dti
 select avg(dti)*100 as Avg_Dti from loan_data
 where month(issue_date) = 11;
 
 # Good Loan Issued
 
 # Good loans Percentage
select (count(case when loan_status = 'Fully Paid' or loan_status = 'current' then id end)*100)/
count(id) as Good_Loan_Percentage
from loan_data;

# Good loans Applications
select count(id) as Good_Loan_Applications
from loan_data
where loan_status = "Fully Paid" or loan_status = "Current";

# Good Loan Funnded Amount
select sum(loan_Amount) as Good_Loan_Funnded_Amount
from loan_data
where loan_status = 'Fully Paid' or loan_status = 'current';

# Good Loan Total Amount Recived
select sum(total_Payment) as Good_Loan_Total_Amount_Recived
from loan_data
where loan_status = 'Fully Paid' or loan_status = 'current';


# Bad Loan Issued

# Bad Loan Percentage
select (count(case when loan_status = 'Charged Off' then id end)*100.0)/
count(id) as Bad_Loan_Percentage
from loan_data;

# Bad Loan Appplications
select count(id) As Bad_Loan_Applications
from loan_data
where loan_status = 'Charged off';

# Bad Loan Funnded Amount
select sum(loan_amount) as Bad_Loan_Funded_Amount
from loan_data
where loan_status = 'Charged off';

# Bad Loan Amount Recived
select sum(total_payment) as Bad_Loan_Recived_Amount
from loan_data
where loan_status = 'Charged off';

# Loan Status
select loan_status,
count(id) as Loan_count,
sum(total_payment) as Total_Amount_Recived,
sum(loan_amount)as Total_Funded_Amount,
avg(int_rate*100) as Interest_Rate,
avg(Dti*100) as DTI
from loan_data
group by loan_status
order by Total_Funded_Amount desc;

# MTD
select loan_Status,
sum(Loan_amount) as MTD_Total_Funded_Amount,
sum(total_Payment) as MTD_Total_Recived_Amount
from loan_data
group by loan_status;

# B . Bank loan Report overview

# Month
select month(issue_date) as Month_Number,
monthname(issue_date) as Month_Name,
count(id) as Total_Applications,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Recived_Amount
from loan_data
group by Month_Number, Month_Name
order by Month_Number;

# State
select address_state as State,
count(id) as Total_Applications,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Recived_Amount
from loan_data
group by state
order by state;

# Term 
select term as Term,
count(id) as Total_Applications,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Recived_Amount
from loan_data
group by term
order by term;

# Employee Length
select emp_length as Employee_Length,
count(id) as Total_Applications,
sum(loan_Amount) as Total_Funded_Amount,
sum(total_Payment)as Total_Recived_Amount
from loan_data
group by employee_length
order by employee_length;

# purpose
select purpose as Purpose,
count(id) as Total_Applications,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Recived_Amount
from loan_data
group by purpose
order by purpose;

# Home Owner Ship 
select home_ownership as Home_OwnerShip,
count(id) as Total_Applications,
sum(loan_Amount) as Total_Funded_Amount,
sum(total_payment) as Total_Recived_Amount
from loan_data
group by home_ownership
order by home_ownership;
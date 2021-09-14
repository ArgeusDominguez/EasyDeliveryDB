----------------------------------------------------------------
--Create tables for db
CREATE TABLE EMPLOYEE
(
    employee_id VARCHAR(4) NOT NULL PRIMARY KEY,
    fname VARCHAR(20) NOT NULL,
    m_initial VARCHAR(1),
    lname VARCHAR(20) NOT NULL,
    address VARCHAR(30) NOT NULL,
    gender VARCHAR(6),
    dob DATE NOT NULL,
    CHECK CHK_AGE CHECK ( dob > DATE'1900-01-01' AND dob < DATE'2005-05-03')
)

CREATE TABLE PHONE_NUMBERS
(
    e_id VARCHAR(4) NOT NULL,
    phone_number VARCHAR(10) NOT NULL,
    PRIMARY KEY (e_id, phone_number),
    CONSTRAINT FK_PhoneEmp FOREIGN KEY (e_id) REFERENCES EMPLOYEE(employee_id)
)

CREATE TABLE STAFF
(
    emp_id VARCHAR(4) NOT NULL PRIMARY KEY,
    start_date DATE NOT NULL,
    CONSTRAINT FK_StaffEmp FOREIGN KEY (emp_id) REFERENCES EMPLOYEE(employee_id)
)

CREATE TABLE AREA_MANAGER
(
    emp_id VARCHAR(4) NOT NULL PRIMARY KEY,
    start_date DATE NOT NULL,
    area VARCHAR(20) NOT NULL,
    CONSTRAINT FK_AmEmp FOREIGN KEY (emp_id) REFERENCES EMPLOYEE(employee_id)
)

CREATE TABLE DELIVERY_DRIVER
(
    emp_id VARCHAR(4) NOT NULL PRIMARY KEY,
    sup_id VARCHAR(4) NOT NULL,
    start_date DATE,
    CONSTRAINT FK_DrvSup FOREIGN KEY (sup_id) REFERENCES AREA_MANAGER(employee_id),
    CONSTRAINT FK_DrvEmp FOREIGN KEY (emp_id) REFERENCES EMPLOYEE(employee_id)
)

CREATE TABLE VEHICLE
(
    plate_num VARCHAR(12) NOT NULL PRIMARY KEY,
    make VARCHAR(20) NOT NULL,
    model VARCHAR(20) NOT NULL,
    color VARCHAR(12),
    d_id VARCHAR(4) NOT NULL,
    CONSTRAINT FK_VehicleDriver FOREIGN KEY (d_id) REFERENCES DELIVERY_DRIVER(emp_id)
)

CREATE TABLE RESTAURANT
(
    address VARCHAR(40) NOT NULL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    dst VARCHAR(5) NOT NULL,
    det VARCHAR(5) NOT NULL,
    business_phone VARCHAR(12) NOT NULL,
    contract_start_date DATE NOT NULL,
    a_manager NOT NULL,
    CONSTRAINT FK_Rest_AreaManager FOREIGN KEY (a_manager) REFERENCES AREA_MANAGER (emp_id)
)

CREATE TABLE REST_TYPE
(
    radd VARCHAR(40) NOT NULL,
    type VARCHAR(20) NOT NULL,
    PRIMARY KEY (radd,type),
    CONSTRAINT FK_RestType FOREIGN KEY (radd) REFERENCES RESTAURANT (address)
)

CREATE TABLE REST_PROMO
(
    promo_number VARCHAR(12) NOT NULL PRIMARY KEY,
    description VARCHAR(60) NOT NULL,
    radd VARCHAR(40) NOT NULL,
    CONSTRAINT FK_RestPromo FOREIGN KEY (radd) REFERENCES RESTAURANT (address)
)

CREATE TABLE CUSTOMER
(
    customer_id VARCHAR(4) NOT NULL PRIMARY KEY,
    c_fname VARCHAR(20) NOT NULL,
    c_mi VARCHAR(1),
    c_lname VARCHAR(20) NOT NULL,
    join_date DATE NOT NULL,
    c_address VARCHAR(40),
    c_phone VARCHAR(12) NOT NULL
)

CREATE TABLE SILVER_MEMBER
(
    c_id VARCHAR(4) NOT NULL,
    issuer VARCHAR(4) NOT NULL,
    issue_date DATE NOT NULL,
    CONSTRAINT FK_SmStaff FOREIGN KEY (issuer) REFERENCES STAFF (emp_id),
    CONSTRAINT FK_SmCust FOREIGN KEY (c_id) REFERENCES CUSTOMER (customer_id)
)

CREATE TABLE CUST_ORDER
(
    order_id VARCHAR(4) NOT NULL,
    total_balance NUMBER(7,2) NOT NULL,
    customer VARCHAR(4) NOT NULL,
    rest VARCHAR(40) NOT NULL,
    d_vehicle VARCHAR(12) NOT NULL,
    payment VARCHAR(4) NOT NULL,
    promo VARCHAR(12) NOT NULL,
    CONSTRAINT FK_OrderCust FOREIGN KEY (customer) REFERENCES CUSTOMER (customer_id),
    CONSTRAINT FK_OrderRest FOREIGN KEY (rest) REFERENCES RESTAURANT (address),
    CONSTRAINT FK_OrderVehicle FOREIGN KEY (d_vehicle) REFERENCES VEHICLE (plate_num),
    CONSTRAINT FK_OrderPayment FOREIGN KEY (payment) REFERENCES PAYMENT (p_confirm_num),
    CONSTRAINT FK_OrderPromo FOREIGN KEY (promo) REFERENCES REST_PROMO (promo_number)
)

CREATE TABLE ITEMS
(
    o_id VARCHAR(4) NOT NULL,
    item VARCHAR(20) NOT NULL,
    quantity SMALLINT NOT NULL,
    PRIMARY KEY (o_id,item),
    CONSTRAINT FK_ItemsOrder FOREIGN KEY (o_id) REFERENCES CUST_ORDER(order_id) 
)

CREATE TABLE PAYMENT
(
    p_confirm_num VARCHAR(4) NOT NULL PRIMARY KEY,
    ptype VARCHAR(15) NOT NULL,
    ptime TIMESTAMP NOT NULL
)
----------------------------------------------------------------
--Insertion statments to populate tables

--AREA_MANAGER
Insert into EASYD.AREA_MANAGER (EMP_ID,START_DATE,AREA) values ('E999',to_date('05-JUN-12','DD-MON-RR'),'Dallas');
Insert into EASYD.AREA_MANAGER (EMP_ID,START_DATE,AREA) values ('E459',to_date('04-JUL-11','DD-MON-RR'),'Jeferton');
Insert into EASYD.AREA_MANAGER (EMP_ID,START_DATE,AREA) values ('E667',to_date('20-AUG-10','DD-MON-RR'),'Miami');

--CUSTOMER
Insert into EASYD.CUSTOMER (CUSTOMER_ID,C_FNAME,C_MI,C_LNAME,JOIN_DATE,C_ADDRESS,C_PHONE) values ('C567','Charles',null,'Bone',to_date('24-FEB-21','DD-MON-RR'),'1234 ABC St, Dallas','909-090-9090');
Insert into EASYD.CUSTOMER (CUSTOMER_ID,C_FNAME,C_MI,C_LNAME,JOIN_DATE,C_ADDRESS,C_PHONE) values ('C117','John',null,'Chief',to_date('01-JUN-20','DD-MON-RR'),'420 Sunshine Way, Miami','117-117-1117');
Insert into EASYD.CUSTOMER (CUSTOMER_ID,C_FNAME,C_MI,C_LNAME,JOIN_DATE,C_ADDRESS,C_PHONE) values ('C420','Snopp',null,'Dogg',to_date('20-APR-18','DD-MON-RR'),'420 Mlg Ave, Los Angeles','420-420-4200');
Insert into EASYD.CUSTOMER (CUSTOMER_ID,C_FNAME,C_MI,C_LNAME,JOIN_DATE,C_ADDRESS,C_PHONE) values ('C385','John',null,'Galt',to_date('06-JAN-21','DD-MON-RR'),'990 Illuminati Blvd, Dallas','212-121-2121');
Insert into EASYD.CUSTOMER (CUSTOMER_ID,C_FNAME,C_MI,C_LNAME,JOIN_DATE,C_ADDRESS,C_PHONE) values ('C999','Nine',null,'Nine',to_date('09-SEP-09','DD-MON-RR'),'9999 Ninety Nine St, Jeferton','999-999-9999');
Insert into EASYD.CUSTOMER (CUSTOMER_ID,C_FNAME,C_MI,C_LNAME,JOIN_DATE,C_ADDRESS,C_PHONE) values ('C777','Seven','S','Seven',to_date('07-JUL-07','DD-MON-RR'),'777 Heavan Way, Miami','777-777-7777');
Insert into EASYD.CUSTOMER (CUSTOMER_ID,C_FNAME,C_MI,C_LNAME,JOIN_DATE,C_ADDRESS,C_PHONE) values ('C840','Eight','H','Forty',to_date('08-APR-21','DD-MON-RR'),'840 Eight Blvd, Jeferton','840-840-8408');
Insert into EASYD.CUSTOMER (CUSTOMER_ID,C_FNAME,C_MI,C_LNAME,JOIN_DATE,C_ADDRESS,C_PHONE) values ('C556','Colt',null,'Browning',to_date('05-APR-21','DD-MON-RR'),'556 Velocity St, Dallas','556-556-5556');
Insert into EASYD.CUSTOMER (CUSTOMER_ID,C_FNAME,C_MI,C_LNAME,JOIN_DATE,C_ADDRESS,C_PHONE) values ('C308','David',null,'Winchester',to_date('10-APR-21','DD-MON-RR'),'308 High Velocity St, Miami','308-308-3083');
Insert into EASYD.CUSTOMER (CUSTOMER_ID,C_FNAME,C_MI,C_LNAME,JOIN_DATE,C_ADDRESS,C_PHONE) values ('C767','Kyle','H','Brofloski',to_date('18-APR-21','DD-MON-RR'),'4242 South Park Blvd, Jeferton','235-961-0416');

--CUST_ORDER
Insert into EASYD.CUST_ORDER (ORDER_ID,TOTAL_BALANCE,CUSTOMER,REST,D_VEHICLE,PAYMENT,PROMO) values ('O123',42.42,'C999','3440 Frontage Rd, Jeferton','ABC1010','P433','50PCT');
Insert into EASYD.CUST_ORDER (ORDER_ID,TOTAL_BALANCE,CUSTOMER,REST,D_VEHICLE,PAYMENT,PROMO) values ('O456',12.52,'C117','76 Beach St, Miami','STX1209','P123','FREEFRIES');
Insert into EASYD.CUST_ORDER (ORDER_ID,TOTAL_BALANCE,CUSTOMER,REST,D_VEHICLE,PAYMENT,PROMO) values ('O789',3.5,'C767','890 Business Park, Jeferton','AAA8989','P321',null);
Insert into EASYD.CUST_ORDER (ORDER_ID,TOTAL_BALANCE,CUSTOMER,REST,D_VEHICLE,PAYMENT,PROMO) values ('O244',234.99,'C999','12098 Alamo Ave, Jeferton','AAA8989','P991',null);
Insert into EASYD.CUST_ORDER (ORDER_ID,TOTAL_BALANCE,CUSTOMER,REST,D_VEHICLE,PAYMENT,PROMO) values ('O969',89.03,'C385','3008 McPherson St, Dallas','COW9977','P999',null);
Insert into EASYD.CUST_ORDER (ORDER_ID,TOTAL_BALANCE,CUSTOMER,REST,D_VEHICLE,PAYMENT,PROMO) values ('O124',30.98,'C117','76 Beach St, Miami','STX1209','P323','30PCT');
Insert into EASYD.CUST_ORDER (ORDER_ID,TOTAL_BALANCE,CUSTOMER,REST,D_VEHICLE,PAYMENT,PROMO) values ('O998',400.12,'C999','890 Business Park, Jeferton','AAA8989','P987',null);
Insert into EASYD.CUST_ORDER (ORDER_ID,TOTAL_BALANCE,CUSTOMER,REST,D_VEHICLE,PAYMENT,PROMO) values ('O545',17.98,'C385','3008 McPherson St, Dallas','COW9977','P669',null);
Insert into EASYD.CUST_ORDER (ORDER_ID,TOTAL_BALANCE,CUSTOMER,REST,D_VEHICLE,PAYMENT,PROMO) values ('O777',56.99,'C777','8096 Sun Blvd, Miami','ETH6969','P001','KING');
Insert into EASYD.CUST_ORDER (ORDER_ID,TOTAL_BALANCE,CUSTOMER,REST,D_VEHICLE,PAYMENT,PROMO) values ('O110',6,'C117','8096 Sun Blvd, Miami','ETH6969','P117','KING');
Insert into EASYD.CUST_ORDER (ORDER_ID,TOTAL_BALANCE,CUSTOMER,REST,D_VEHICLE,PAYMENT,PROMO) values ('O009',950.99,'C117','8096 Sun Blvd, Miami','ETH6969','P941',null);
Insert into EASYD.CUST_ORDER (ORDER_ID,TOTAL_BALANCE,CUSTOMER,REST,D_VEHICLE,PAYMENT,PROMO) values ('O001',2000,'C385','3008 McPherson St, Dallas','COW9977','P911',null);
Insert into EASYD.CUST_ORDER (ORDER_ID,TOTAL_BALANCE,CUSTOMER,REST,D_VEHICLE,PAYMENT,PROMO) values ('O040',12.33,'C117','99 Orange Ave, Miami','RTR2010','P650',null);
Insert into EASYD.CUST_ORDER (ORDER_ID,TOTAL_BALANCE,CUSTOMER,REST,D_VEHICLE,PAYMENT,PROMO) values ('O961',54.09,'C117','99 Orange Ave, Miami','STX1209','P909',null);
Insert into EASYD.CUST_ORDER (ORDER_ID,TOTAL_BALANCE,CUSTOMER,REST,D_VEHICLE,PAYMENT,PROMO) values ('O437',66.77,'C117','8096 Sun Blvd, Miami','RTR2010','P772','KING');
Insert into EASYD.CUST_ORDER (ORDER_ID,TOTAL_BALANCE,CUSTOMER,REST,D_VEHICLE,PAYMENT,PROMO) values ('O925',9.89,'C117','76 Beach St, Miami','ABC1010','P003',null);
Insert into EASYD.CUST_ORDER (ORDER_ID,TOTAL_BALANCE,CUSTOMER,REST,D_VEHICLE,PAYMENT,PROMO) values ('O640',120.99,'C117','99 Orange Ave, Miami','ABC1010','P019',null);
Insert into EASYD.CUST_ORDER (ORDER_ID,TOTAL_BALANCE,CUSTOMER,REST,D_VEHICLE,PAYMENT,PROMO) values ('O130',242.42,'C117','8096 Sun Blvd, Miami','RTR2010','P884',null);
Insert into EASYD.CUST_ORDER (ORDER_ID,TOTAL_BALANCE,CUSTOMER,REST,D_VEHICLE,PAYMENT,PROMO) values ('O567',10.99,'C117','890 Business Park, Jeferton','RTR2010','P771',null);

--DELIVERY_DRIVER
Insert into EASYD.DELIVERY_DRIVER (EMP_ID,SUP_ID,START_DATE) values ('E444','E999',to_date('05-FEB-19','DD-MON-RR'));
Insert into EASYD.DELIVERY_DRIVER (EMP_ID,SUP_ID,START_DATE) values ('E100','E459',to_date('12-FEB-18','DD-MON-RR'));
Insert into EASYD.DELIVERY_DRIVER (EMP_ID,SUP_ID,START_DATE) values ('E337','E667',to_date('22-MAR-03','DD-MON-RR'));
Insert into EASYD.DELIVERY_DRIVER (EMP_ID,SUP_ID,START_DATE) values ('E880','E667',to_date('27-JUL-11','DD-MON-RR'));

--EMPLOYEE
Insert into EASYD.EMPLOYEE (EMPLOYEE_ID,FNAME,M_INITIAL,LNAME,ADDRESS,GENDER,DOB) values ('123','Jameis',null,'Winston','6969 Palm Way, Tampa Bay','Male',to_date('02-MAY-05','DD-MON-RR'));
Insert into EASYD.EMPLOYEE (EMPLOYEE_ID,FNAME,M_INITIAL,LNAME,ADDRESS,GENDER,DOB) values ('E696','John',null,'Cena','777 Invisible Ave, Los Angeles','Male',to_date('18-AUG-99','DD-MON-RR'));
Insert into EASYD.EMPLOYEE (EMPLOYEE_ID,FNAME,M_INITIAL,LNAME,ADDRESS,GENDER,DOB) values ('E444','Jenny','M','Silverman','321 8th St, Dallas','Female',to_date('19-OCT-77','DD-MON-RR'));
Insert into EASYD.EMPLOYEE (EMPLOYEE_ID,FNAME,M_INITIAL,LNAME,ADDRESS,GENDER,DOB) values ('E100','Caitlyn',null,'Jenner','999 Balibu Way, Malibu',null,to_date('14-JUN-21','DD-MON-RR'));
Insert into EASYD.EMPLOYEE (EMPLOYEE_ID,FNAME,M_INITIAL,LNAME,ADDRESS,GENDER,DOB) values ('E459','Tom',null,'Peters','166 Long Island Blvd, Jeferton','Male',to_date('19-JAN-00','DD-MON-RR'));
Insert into EASYD.EMPLOYEE (EMPLOYEE_ID,FNAME,M_INITIAL,LNAME,ADDRESS,GENDER,DOB) values ('E337','Ian',null,'Black','4544 Wilky Way, Fort Worth','Male',to_date('28-FEB-01','DD-MON-RR'));
Insert into EASYD.EMPLOYEE (EMPLOYEE_ID,FNAME,M_INITIAL,LNAME,ADDRESS,GENDER,DOB) values ('E667','Tammy',null,'Rai','69 Sixty Nine, Miami','Female',to_date('09-SEP-04','DD-MON-RR'));
Insert into EASYD.EMPLOYEE (EMPLOYEE_ID,FNAME,M_INITIAL,LNAME,ADDRESS,GENDER,DOB) values ('E880','Vito',null,'Devito','10201 9th Blvd, Philidelphia','Male',to_date('02-NOV-51','DD-MON-RR'));
Insert into EASYD.EMPLOYEE (EMPLOYEE_ID,FNAME,M_INITIAL,LNAME,ADDRESS,GENDER,DOB) values ('E999','Fred',null,'Small','2119 Ave Mexicanos, Dallas','Female',to_date('22-MAR-89','DD-MON-RR'));

--ITEMS
Insert into EASYD.ITEMS (O_ID,ITEM,QUANTITY) values ('O123','Mole Sauce',3);
Insert into EASYD.ITEMS (O_ID,ITEM,QUANTITY) values ('O123','Cherry Sauce',2);
Insert into EASYD.ITEMS (O_ID,ITEM,QUANTITY) values ('O456','Big Mac',1);
Insert into EASYD.ITEMS (O_ID,ITEM,QUANTITY) values ('O456','Fries',1);
Insert into EASYD.ITEMS (O_ID,ITEM,QUANTITY) values ('O789','Large Plate',1);
Insert into EASYD.ITEMS (O_ID,ITEM,QUANTITY) values ('O244','Large Plate',20);
Insert into EASYD.ITEMS (O_ID,ITEM,QUANTITY) values ('O969','NEw York Strip',1);
Insert into EASYD.ITEMS (O_ID,ITEM,QUANTITY) values ('O969','Tenderloin',1);
Insert into EASYD.ITEMS (O_ID,ITEM,QUANTITY) values ('O969','Baked Potato',1);
Insert into EASYD.ITEMS (O_ID,ITEM,QUANTITY) values ('O969','Whiskey',3);
Insert into EASYD.ITEMS (O_ID,ITEM,QUANTITY) values ('O124','Big Mac',2);
Insert into EASYD.ITEMS (O_ID,ITEM,QUANTITY) values ('O124','Cheeseburger',4);
Insert into EASYD.ITEMS (O_ID,ITEM,QUANTITY) values ('O998','Large Plate',30);
Insert into EASYD.ITEMS (O_ID,ITEM,QUANTITY) values ('O545','Sirloin',1);
Insert into EASYD.ITEMS (O_ID,ITEM,QUANTITY) values ('O777','Whopper',7);
Insert into EASYD.ITEMS (O_ID,ITEM,QUANTITY) values ('O777','Large Coke',3);
Insert into EASYD.ITEMS (O_ID,ITEM,QUANTITY) values ('O110','Jr Whopper',3);
Insert into EASYD.ITEMS (O_ID,ITEM,QUANTITY) values ('O009','Mega Whopper',300);
Insert into EASYD.ITEMS (O_ID,ITEM,QUANTITY) values ('O009','Jr Whooper',12);
Insert into EASYD.ITEMS (O_ID,ITEM,QUANTITY) values ('O009','Large Coke',2);
Insert into EASYD.ITEMS (O_ID,ITEM,QUANTITY) values ('O001','Golden Calf',1);

--PAYMENT
Insert into EASYD.PAYMENT (P_CONFIRM_NUM,PTYPE,PTIME) values ('P123','Credit Card',to_timestamp('27-APR-21 08.49.11.521000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into EASYD.PAYMENT (P_CONFIRM_NUM,PTYPE,PTIME) values ('P321','Debit Card',to_timestamp('25-APR-21 09.49.44.544000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into EASYD.PAYMENT (P_CONFIRM_NUM,PTYPE,PTIME) values ('P433','Gift Card',to_timestamp('29-APR-21 03.50.07.191000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into EASYD.PAYMENT (P_CONFIRM_NUM,PTYPE,PTIME) values ('P991','Credit Card',to_timestamp('30-APR-21 07.20.58.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into EASYD.PAYMENT (P_CONFIRM_NUM,PTYPE,PTIME) values ('P999','Debit Card',to_timestamp('14-APR-21 04.20.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into EASYD.PAYMENT (P_CONFIRM_NUM,PTYPE,PTIME) values ('P323','Gift Card',to_timestamp('01-MAY-21 04.52.50.240000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into EASYD.PAYMENT (P_CONFIRM_NUM,PTYPE,PTIME) values ('P987','Credit Card',to_timestamp('18-MAR-21 01.42.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into EASYD.PAYMENT (P_CONFIRM_NUM,PTYPE,PTIME) values ('P669','Cash',to_timestamp('13-APR-21 09.15.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into EASYD.PAYMENT (P_CONFIRM_NUM,PTYPE,PTIME) values ('P001','Cash',to_timestamp('28-JAN-21 02.36.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into EASYD.PAYMENT (P_CONFIRM_NUM,PTYPE,PTIME) values ('P117','Debit Card',to_timestamp('06-APR-21 12.12.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into EASYD.PAYMENT (P_CONFIRM_NUM,PTYPE,PTIME) values ('P941','Debit Card',to_timestamp('20-APR-21 09.55.29.056000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into EASYD.PAYMENT (P_CONFIRM_NUM,PTYPE,PTIME) values ('P911','Cash',to_timestamp('08-AUG-19 01.14.15.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into EASYD.PAYMENT (P_CONFIRM_NUM,PTYPE,PTIME) values ('P650','Cash',to_timestamp('01-MAY-21 04.53.27.858000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into EASYD.PAYMENT (P_CONFIRM_NUM,PTYPE,PTIME) values ('P909','Cash',to_timestamp('01-MAY-21 04.53.34.717000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into EASYD.PAYMENT (P_CONFIRM_NUM,PTYPE,PTIME) values ('P772','Credit Card',to_timestamp('01-MAY-21 04.53.38.567000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into EASYD.PAYMENT (P_CONFIRM_NUM,PTYPE,PTIME) values ('P003','Debit Card',to_timestamp('01-MAY-21 04.53.43.560000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into EASYD.PAYMENT (P_CONFIRM_NUM,PTYPE,PTIME) values ('P019','Cash',to_timestamp('06-APR-21 09.43.27.738000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into EASYD.PAYMENT (P_CONFIRM_NUM,PTYPE,PTIME) values ('P884','Cash',to_timestamp('01-MAY-21 02.32.48.095000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into EASYD.PAYMENT (P_CONFIRM_NUM,PTYPE,PTIME) values ('P771','Cash',to_timestamp('30-APR-21 09.57.32.080000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into EASYD.PAYMENT (P_CONFIRM_NUM,PTYPE,PTIME) values ('P333','Food Stamps',to_timestamp('12-MAR-21 06.17.48.951000000 PM','DD-MON-RR HH.MI.SSXFF AM'));

--PHONE_NUMBERS
Insert into EASYD.PHONE_NUMBERS (E_ID,PHONE_NUMBER) values ('123','715-263-1300');
Insert into EASYD.PHONE_NUMBERS (E_ID,PHONE_NUMBER) values ('123','715-263-7724');
Insert into EASYD.PHONE_NUMBERS (E_ID,PHONE_NUMBER) values ('123','715-263-9541');
Insert into EASYD.PHONE_NUMBERS (E_ID,PHONE_NUMBER) values ('E100','281-779-8080');
Insert into EASYD.PHONE_NUMBERS (E_ID,PHONE_NUMBER) values ('E337','414-751-1423');
Insert into EASYD.PHONE_NUMBERS (E_ID,PHONE_NUMBER) values ('E444','951-351-3200');
Insert into EASYD.PHONE_NUMBERS (E_ID,PHONE_NUMBER) values ('E459','406-496-5132');
Insert into EASYD.PHONE_NUMBERS (E_ID,PHONE_NUMBER) values ('E459','631-323-4616');
Insert into EASYD.PHONE_NUMBERS (E_ID,PHONE_NUMBER) values ('E459','777-777-7777');
Insert into EASYD.PHONE_NUMBERS (E_ID,PHONE_NUMBER) values ('E459','999-888-7777');
Insert into EASYD.PHONE_NUMBERS (E_ID,PHONE_NUMBER) values ('E667','270-525-2036');
Insert into EASYD.PHONE_NUMBERS (E_ID,PHONE_NUMBER) values ('E667','773-964-6066');
Insert into EASYD.PHONE_NUMBERS (E_ID,PHONE_NUMBER) values ('E696','562-253-8323');
Insert into EASYD.PHONE_NUMBERS (E_ID,PHONE_NUMBER) values ('E880','801-241-0309');
Insert into EASYD.PHONE_NUMBERS (E_ID,PHONE_NUMBER) values ('E999','650-799-1139');

--RESTAURANT
Insert into EASYD.RESTAURANT (ADDRESS,NAME,DST,DET,BUSINESS_PHONE,CONTRACT_START_DATE,A_MANAGER) values ('3008 McPherson St, Dallas','Bubba''s Steak','2:00','11:00','623-345-677',to_date('30-MAR-16','DD-MON-RR'),'E999');
Insert into EASYD.RESTAURANT (ADDRESS,NAME,DST,DET,BUSINESS_PHONE,CONTRACT_START_DATE,A_MANAGER) values ('890 Business Park, Jeferton','Gulivers','9:00','9:00','999-111-7777',to_date('28-AUG-20','DD-MON-RR'),'E459');
Insert into EASYD.RESTAURANT (ADDRESS,NAME,DST,DET,BUSINESS_PHONE,CONTRACT_START_DATE,A_MANAGER) values ('3440 Frontage Rd, Jeferton','Saucemans','12:00','9:00','987-654-1234',to_date('08-FEB-21','DD-MON-RR'),'E459');
Insert into EASYD.RESTAURANT (ADDRESS,NAME,DST,DET,BUSINESS_PHONE,CONTRACT_START_DATE,A_MANAGER) values ('12098 Alamo Ave, Jeferton','Saucemans','12:00','9:00','123-456-7890',to_date('13-JAN-21','DD-MON-RR'),'E459');
Insert into EASYD.RESTAURANT (ADDRESS,NAME,DST,DET,BUSINESS_PHONE,CONTRACT_START_DATE,A_MANAGER) values ('76 Beach St, Miami','McDonalds','6:00','11:00','435-453-4533',to_date('29-OCT-18','DD-MON-RR'),'E667');
Insert into EASYD.RESTAURANT (ADDRESS,NAME,DST,DET,BUSINESS_PHONE,CONTRACT_START_DATE,A_MANAGER) values ('99 Orange Ave, Miami','McDonalds','6:00','11:00','989-989-9988',to_date('30-MAY-20','DD-MON-RR'),'E667');
Insert into EASYD.RESTAURANT (ADDRESS,NAME,DST,DET,BUSINESS_PHONE,CONTRACT_START_DATE,A_MANAGER) values ('8096 Sun Blvd, Miami','Burger King','4:00','10:00','727-727-7277',to_date('31-MAY-21','DD-MON-RR'),'E667');
Insert into EASYD.RESTAURANT (ADDRESS,NAME,DST,DET,BUSINESS_PHONE,CONTRACT_START_DATE,A_MANAGER) values ('9999 Test Ave, Testing','Test Rest','1:00','1:00','999-999-8888',to_date('02-JUN-21','DD-MON-RR'),'E999');

--REST_PROMO
Insert into EASYD.REST_PROMO (PROMO_NUMBER,DESCRIPT,RADD) values ('50PCT','50% off first order','3440 Frontage Rd, Jeferton');
Insert into EASYD.REST_PROMO (PROMO_NUMBER,DESCRIPT,RADD) values ('FREEFRIES','Free fries when you order any entree','76 Beach St, Miami');
Insert into EASYD.REST_PROMO (PROMO_NUMBER,DESCRIPT,RADD) values ('KING','Free Jr Whopper','8096 Sun Blvd, Miami');
Insert into EASYD.REST_PROMO (PROMO_NUMBER,DESCRIPT,RADD) values ('30PCT','30% off any order','76 Beach St, Miami');

--REST_TYPE
Insert into EASYD.REST_TYPE (RADD,TYPE) values ('12098 Alamo Ave, Jeferton','Saucery');
Insert into EASYD.REST_TYPE (RADD,TYPE) values ('3008 McPherson St, Dallas','Bar');
Insert into EASYD.REST_TYPE (RADD,TYPE) values ('3008 McPherson St, Dallas','Steakhouse');
Insert into EASYD.REST_TYPE (RADD,TYPE) values ('3440 Frontage Rd, Jeferton','Saucery');
Insert into EASYD.REST_TYPE (RADD,TYPE) values ('76 Beach St, Miami','Fast Food');
Insert into EASYD.REST_TYPE (RADD,TYPE) values ('8096 Sun Blvd, Miami','Fast Food');
Insert into EASYD.REST_TYPE (RADD,TYPE) values ('890 Business Park, Jeferton','Buffet');
Insert into EASYD.REST_TYPE (RADD,TYPE) values ('890 Business Park, Jeferton','Fast Food');
Insert into EASYD.REST_TYPE (RADD,TYPE) values ('99 Orange Ave, Miami','Fast Food');

--SILVER_MEMBER
Insert into EASYD.SILVER_MEMBER (C_ID,ISSUER,ISSUE_DATE) values ('C420','123',to_date('06-FEB-21','DD-MON-RR'));
Insert into EASYD.SILVER_MEMBER (C_ID,ISSUER,ISSUE_DATE) values ('C767','E696',to_date('29-APR-21','DD-MON-RR'));
Insert into EASYD.SILVER_MEMBER (C_ID,ISSUER,ISSUE_DATE) values ('C308','E696',to_date('29-APR-21','DD-MON-RR'));
Insert into EASYD.SILVER_MEMBER (C_ID,ISSUER,ISSUE_DATE) values ('C556','123',to_date('27-APR-21','DD-MON-RR'));

--STAFF
Insert into EASYD.STAFF (EMP_ID,START_DATE) values ('123',to_date('05-APR-05','DD-MON-RR'));
Insert into EASYD.STAFF (EMP_ID,START_DATE) values ('E696',to_date('27-OCT-15','DD-MON-RR'));

--VEHICLE
Insert into EASYD.VEHICLE (PLATE_NUM,MAKE,MODEL,COLOR,D_ID) values ('COW9977','Ford','F150','Gray','E444');
Insert into EASYD.VEHICLE (PLATE_NUM,MAKE,MODEL,COLOR,D_ID) values ('AAA8989','Chevy','Malibu','White','E100');
Insert into EASYD.VEHICLE (PLATE_NUM,MAKE,MODEL,COLOR,D_ID) values ('ABC1010','Honda','Accord','Blue','E100');
Insert into EASYD.VEHICLE (PLATE_NUM,MAKE,MODEL,COLOR,D_ID) values ('ETH6969','Toyota','Corolla','Pink','E880');
Insert into EASYD.VEHICLE (PLATE_NUM,MAKE,MODEL,COLOR,D_ID) values ('RTR2010','Ford','Focus','Green','E880');
Insert into EASYD.VEHICLE (PLATE_NUM,MAKE,MODEL,COLOR,D_ID) values ('STX1209','Tesla','Model S','Red','E337');
Insert into EASYD.VEHICLE (PLATE_NUM,MAKE,MODEL,COLOR,D_ID) values ('DAG1947','Dodge','1500','Black','E100');

----------------------------------------------------------------
--Views for part D

--1a. Find top 3 customers that have spent the most the past year from today
CREATE VIEW TOP3_AGGREGATE_CUSTOMERS AS
SELECT c_fname FIRST, c_lname LAST, customer CUSTOMER_ID, SUM(total_balance) TOTAL_SPENT
FROM CUSTOMER, CUST_ORDER, PAYMENT
WHERE customer = customer_id AND payment = p_confirm_num 
AND TRUNC(ptime) > add_months(trunc(sysdate), -12)
GROUP BY c_fname, c_lname, customer
ORDER BY SUM(total_balance) DESC
FETCH FIRST 3 ROWS ONLY;

--1b. Find top 3 customers that have the largest order from the past year
CREATE VIEW TOP3_LARGEST_ORDERS AS
SELECT c_fname FIRST, c_lname LAST, total_balance TOTAL_ORDER_AMOUNT
FROM CUSTOMER, CUST_ORDER, PAYMENT
WHERE customer = customer_id AND payment = p_confirm_num 
AND TRUNC(ptime) > add_months(trunc(sysdate), -12)
GROUP BY c_fname, c_lname, total_balance
ORDER BY total_balance DESC
FETCH FIRST 3 ROWS ONLY;

--2. Find the restaurant types with the most orders from the past year
CREATE VIEW TOP_RESTAURANT_TYPE  AS
SELECT t.type RESTAURANT_TYPE, COUNT(t.type) NUMBER_OF_ORDERS 
FROM CUST_ORDER O, REST_TYPE T, RESTAURANT R, PAYMENT P 
WHERE o.rest = r.address AND t.radd = r.address AND o.payment = p.p_confirm_num
AND TRUNC(p.ptime) > add_months(trunc(sysdate), -12)
GROUP BY t.type
ORDER BY COUNT(t.type) DESC
FETCH FIRST 1 ROWS ONLY;

--3. Find potential silver member customers that have more than 10 orders in a month
CREATE VIEW POTENTIAL_SILVER_MEMBERS AS
SELECT co.customer, c.c_fname, c.c_lname, c.join_date, c.c_address, c.c_phone
FROM CUSTOMER C, CUST_ORDER CO, PAYMENT P
WHERE NOT EXISTS ( SELECT *
                   FROM SILVER_MEMBER S
                   WHERE co.customer = c.customer_id
                   AND co.customer = s.c_id
                 )
AND c.customer_id = co.customer AND co.payment = p.p_confirm_num
AND TRUNC(p.ptime) > add_months(trunc(sysdate), -1)
GROUP BY co.customer, c.c_fname, c.c_lname, c.join_date, c.c_address, 
c.c_phone
HAVING COUNT(co.order_id) > 10
ORDER BY COUNT(co.order_id) DESC;

--4. Find area manager with most contract in working area from the past year
CREATE VIEW BEST_AREA_MANAGER AS
SELECT e.employee_id, e.fname FIRST, e.m_initial MIDDLE, e.lname LAST, e.address, e.gender, e.dob, a.area
FROM EMPLOYEE E, AREA_MANAGER A, RESTAURANT R
WHERE e.employee_id = a.emp_id AND r.a_manager = e.employee_id
AND TRUNC(r.contract_start_date) > add_months(trunc(sysdate), -12)
GROUP BY e.employee_id, e.fname, e.m_initial, e.lname, e.address,e.gender, e.dob, a.area
ORDER BY COUNT(e.employee_id) DESC
FETCH FIRST 1 ROWS ONLY;

---------------------------------------------------------------- 
--Queries for part E

--1.
SELECT e.fname FIRST, e.m_initial MIDDLE, e.lname LAST, COUNT(e.employee_id) NUMBER_OF_DELIVERERS
FROM EMPLOYEE E, AREA_MANAGER A, DELIVERY_DRIVER D
WHERE a.emp_id = e.employee_id AND d.sup_id = a.emp_id 
GROUP BY e.fname, e.m_initial, e.lname
ORDER BY COUNT(e.employee_id) DESC
FETCH FIRST 1 ROWS ONLY;

--2.
SELECT FLOOR(CAST(COUNT(psm.customer) AS DECIMAL) / COUNT(DISTINCT psm.customer)) "Average number of orders placed by potential 
silver members"
FROM potential_silver_members psm, CUST_ORDER CO
WHERE psm.customer = co.customer;

--3.
SELECT DISTINCT C.*, r.name
FROM top_restaurant_type trt, CUSTOMER C, CUST_ORDER CO, RESTAURANT R, REST_TYPE RT
WHERE trt.RESTAURANT_TYPE = rt.type 
AND r.address = rt.radd AND co.customer = c.customer_id AND co.rest = r.address
ORDER BY c.customer_id;

--4.
SELECT c.*, s.issue_date "Silver Member card issue date"
FROM CUSTOMER C, SILVER_MEMBER S
WHERE s.c_id = c.customer_id
AND c.join_date > add_months(s.issue_date, -1);

--5.
SELECT e.fname First, e.lname Last, COUNT(e.employee_id) "Number of orders delivered in last month"
FROM EMPLOYEE E, DELIVERY_DRIVER D, VEHICLE V, CUST_ORDER C, PAYMENT P
WHERE c.d_vehicle = v.plate_num
AND v.d_id = d.emp_id AND e.employee_id = d.emp_id AND c.payment = p.p_confirm_num
AND TRUNC(p.ptime) > add_months(trunc(sysdate), -1)
GROUP BY e.fname, e.lname
ORDER BY COUNT(e.employee_id) DESC;

--6.
SELECT r.address, r.name, r.dst, r.det, r.business_phone, r.contract_start_date, r.a_manager AREA_MANAGER, COUNT(r.address) PROMOS_OFFERED 
FROM RESTAURANT R, CUST_ORDER C, REST_PROMO P, PAYMENT P
WHERE r.address = c.rest AND r.address = p.radd AND c.promo = p.promo_number AND p.p_confirm_num = c.payment
AND TRUNC(p.ptime) > add_months(trunc(sysdate), -1)
GROUP BY r.address, r.name, r.dst, r.det, r.business_phone, r.contract_start_date, r.a_manager
ORDER BY COUNT(r.address) DESC;

--7.
SELECT CUSTOMER_ID ,C_FNAME ,C_MI, C_LNAME, JOIN_DATE, C_ADDRESS, C_PHONE
FROM CUSTOMER C, CUST_ORDER CO, RESTAURANT R, REST_TYPE T
WHERE co.customer = c.customer_id AND r.address = co.rest AND t.radd = r.address AND t.type = 'Fast Food'
GROUP BY CUSTOMER_ID, C_FNAME, C_MI, C_LNAME, JOIN_DATE,
C_ADDRESS, C_PHONE
HAVING COUNT(DISTINCT(r.address)) = (SELECT *
                                     FROM NUM_FAST_FOOD);

--8.
SELECT r.name RESTAURANT_NAME, r.address, co.total_balance, c.*
FROM RESTAURANT R, CUSTOMER C, CUST_ORDER CO
WHERE co.customer = c.customer_id AND co.rest = r.address
ORDER BY r.name;

--9.
SELECT area, rank
FROM (SELECT area, DENSE_RANK() OVER (PARTITION BY num_rest ORDER BY area) AS rank FROM NUMBER_OF_REST_AREA)
WHERE rank = 1;

--10.
SELECT r.name RESTAURANT_NAME, r.address, r.dst, r.det
FROM MOST_POPULAR_RESTAURANT_MONTH MP, RESTAURANT R
WHERE r.address = MP.restaurant;

----------------------------------------------------------------
--Extra Views

CREATE VIEW NUM_FAST_FOOD AS
SELECT COUNT(*) fast_food_number
FROM RESTAURANT R, REST_TYPE T
WHERE r.address = t.radd AND t.type = 'Fast Food';

CREATE VIEW NUMBER_OF_REST_AREA AS
SELECT a.area, COUNT(a.area) NUM_REST
FROM RESTAURANT R, AREA_MANAGER A
WHERE r.a_manager = a.emp_id
GROUP BY a.area;

CREAtE VIEW MOST_POPULAR_RESTAURANT_MONTH AS
SELECT r.address RESTAURANT
FROM RESTAURANT R, CUST_ORDER C, PAYMENT P
WHERE r.address = c.rest AND c.payment = p.p_confirm_num
AND TRUNC(p.ptime) > add_months(trunc(sysdate), -1)
GROUP BY r.address
ORDER BY COUNT(r.address) DESC
FETCH FIRST 1 ROWS ONLY;

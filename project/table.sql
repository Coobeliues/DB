CREATE TABLE VENDOR(
    vendorID integer primary key NOT NULL,
    productt varchar(99) not null,
    amount int not null,
    p_price int not null,
    foreign key (vendorID) references Product(product_ID),
    foreign key (vendorID) references BRAND(bID),
    FOREIGN KEY (vendorID) references STORE(storeID)
);

CREATE TABLE purchases(
    pID int,
    date timestamp,
    storeID int,
    amount int,
    price int,
    total_sum int,
    foreign key (pID) references product(product_ID),
    foreign key (storeID) references store(storeID)
);

CREATE TABLE BRAND(
    bID int primary key not null,
    b_name char(95)
);
drop table subb;
drop table sbp;
CREATE TABLE subb (
    sbID int primary key not null,
    bId int,
    sb_name char(95),
    FOREIGN KEY (bId) references BRAND(bID)
);
CREATE TABLE sbp (
    sbpID int primary key not null,
    sId int,
    sbproduct_n char(95),
    foreign key (sId) references subb(sbID)
);

CREATE TABLE PRODUCTtype(
    type_id int primary key not null,
    type typpes
);
CREATE TYPE typpes as(
    t_name char(95),
    t_class char(95)
);

CREATE TABLE Product(
    product_ID integer primary key NOT NULL,
    p_name char(95),
    FOREIGN KEY (product_ID) references PRODUCTtype(type_id)
);
drop table prod_in_store;
CREATE TABLE prod_in_store(
    p_id int,
    store_id int,
    amount int,
    price int,
    p_size integer NOT NULL,
    p_packaging text,
    p_definition text,
    --FOREIGN KEY (p_id) references product(product_ID),
    FOREIGN KEY (store_id) references STORE(storeID)
);
drop table store;
CREATE TABLE STORE(
    storeID integer primary key NOT NULL,
    Address text unique not null,
    working_t working_h,
    FOREIGN KEY (storeID) references REGULARcustomers(rCustomerID)
);
CREATE TYPE working_h as (
    open_t time,
    close_t time
);
drop table regularcustomers;
CREATE TABLE REGULARcustomers(
    rCustomerID int primary key,
    age int,
    additional_inf text,
    birth_date date not null,
    full_name text not null
    --foreign key (rCustomerID) references receipt(rID)
);
CREATE FUNCTION age() RETURNS TRIGGER
AS $$
    BEGIN
        UPDATE REGULARcustomers
        SET age = floor((current_date-new.birth_date)/365.25)
        WHERE rCustomerID = new.rCustomerID;
        RETURN new;
    end;
    $$ LANGUAGE plpgsql;
CREATE TRIGGER tr_age AFTER INSERT ON REGULARcustomers
    FOR EACH ROW EXECUTE PROCEDURE age();

CREATE TABLE phone_number(
    ph_id integer NOT NULL,
    id integer,
    PRIMARY KEY (ph_id, id),
    FOREIGN KEY (id) REFERENCES REGULARcustomers(rCustomerID) ON DELETE CASCADE,
    phone_number numeric
);


CREATE TABLE ONLINEshopping(
    order_num int UNIQUE not null,
    FOREIGN KEY (order_num) references REGULARcustomers(rCustomerID),
    address text not null,
    loginss VARCHAR (55) UNIQUE,
    passwordsss char (95)
);
drop table customers;
CREATE TABLE CUSTOMERS(
    order_n int unique,
    FOREIGN KEY (order_n) references STORE(storeID)
);

DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

CREATE INDEX product_name ON product(p_name);
CREATE INDEX upc ON product(product_ID);
CREATE INDEX brand_n ON brand(bID);
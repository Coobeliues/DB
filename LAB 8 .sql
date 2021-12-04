

------------------
-------------------
-----insert into prod_in_store (p_id, store_id, amount, price, p_size, p_packaging, p_definition) values (1, 1, 81, 30, 47, null, null);
-- CREATE TABLE purchases(
--     pID int,
--     date timestamp,
--     storeID int,
--     amount int,
--     price int,
--     total_sum int,
--     foreign key (pID) references product(product_ID),
--     foreign key (storeID) references store(storeID)
-- );
do
$$
    begin
        INSERT INTO purchases VALUES (1, current_timestamp, 1, 5, 5, 0);
        update purchases set total_sum = purchases.price * purchases.amount where purchases.pID = 1;

    end;
$$;

-- CREATE INDEX product_name ON product(p_name);
-- CREATE INDEX upc ON product(product_ID);
-- CREATE INDEX brand_n ON brand(bID);
-- select purchases.pID, purchases.storeID, sum(purchases.amount), Product.p_name
-- from purchases, product where storeID=1 and purchases.pID=product.product_ID
-- group by purchases.pID, product.p_name, purchases.storeID
-- order by sum(purchases.amount) desc
-- limit 20;

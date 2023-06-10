-- CREATE OR REPLACE FUNCTION noCollidingDiscounts()
-- RETURNS TRIGGER AS $$ 
-- BEGIN
--     IF (SELECT * FROM idprojekt.discounts d
--     WHERE ((d.start_date <= NEW.start_date AND NEW.start_date <= d.end_date)
--     OR (d.start_date <= NEW.end_date AND NEW.end_date <= d.end_date))
--     AND d.discount_id = NEW.discount_id
--     LIMIT 1) IS NOT NULL THEN RETURN NULL;
--     END IF;
-- END; $$ LANGUAGE plpgsql;

--Blokowanie dodawania dwoch discountow na jeden
--produkt w pokrywajacym sie przedziale czasowym
CREATE OR REPLACE FUNCTION noCollidingDiscounts()
RETURNS TRIGGER AS $$
DECLARE 
    s DATE;
    e DATE;
BEGIN
    s = (SELECT start_date FROM idProjekt.discounts WHERE discount_id = NEW.discount_id);
    e = (SELECT end_date FROM idProjekt.discounts WHERE discount_id = NEW.discount_id);
    IF (
        SELECT COUNT(*) FROM idProjekt.discounted_products dp 
        NATURAL JOIN idProjekt.discounts d
        WHERE dp.product_id = NEW.product_id 
        AND ((d.start_date <= s AND s <= d.end_date) 
        OR (d.start_date <= e AND e <= d.end_date)) 
    ) > 0 THEN RETURN NULL; END IF;
    RETURN NEW;
END; $$ LANGUAGE plpgsql;

CREATE TRIGGER discountsCheck BEFORE INSERT
ON idprojekt.discounted_products 
FOR EACH ROW EXECUTE PROCEDURE noCollidingDiscounts();

-- Dodawanie krotek przy Update na price history
-- Najpierw musimy przekminic czy nie zmienic na timestamp

-- CREATE OR REPLACE FUNCTION onPriceHistoryUpdate()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     INSERT INTO idprojekt.price_history VALUES 
--     (NEW.product_id, NEW.price, CURRENT_DATE);
--     RETURN OLD;
-- END; $$ LANGUAGE plpgsql;

-- CREATE TRIGGER priceHistoryUpdate BEFORE UPDATE
-- ON idprojekt.price_history 
-- FOR EACH ROW EXECUTE PROCEDURE onPriceHistoryUpdate();
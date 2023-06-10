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
CREATE OR REPLACE FUNCTION idprojekt.noCollidingDiscounts()
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
FOR EACH ROW EXECUTE PROCEDURE idprojekt.noCollidingDiscounts();

-- Dodanie gry powoduje usuniecie z wish listy
CREATE OR REPLACE FUNCTION idprojekt.deleteFromWishList()
RETURNS TRIGGER AS $$ BEGIN
    DELETE FROM idProjekt.wish_list
    WHERE user_id = NEW.user_id AND product_id = NEW.product_id;
    RETURN NEW;
END; $$ LANGUAGE plpgsql;

CREATE TRIGGER onGameBuy BEFORE INSERT
ON idprojekt.users_products 
FOR EACH ROW EXECUTE PROCEDURE idprojekt.deleteFromWishList();

--Do wish_listy nie mozna dodac posiadanej gry
CREATE OR REPLACE FUNCTION idprojekt.wishListCheck()
RETURNS TRIGGER AS $$ BEGIN
    IF (SELECT COUNT(*) FROM idprojekt.users_products up 
    WHERE up.user_id = NEW.user_id AND up.product_id = NEW.product_id)
     > 0 THEN RETURN NULL; END IF;
    RETURN NEW;
END; $$ LANGUAGE plpgsql;

CREATE TRIGGER onWishListAdd BEFORE INSERT
ON idprojekt.wish_list 
FOR EACH ROW EXECUTE PROCEDURE idprojekt.wishListCheck();
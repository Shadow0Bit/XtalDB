-- (person ID) -> list of friends' IDs
CREATE OR REPLACE FUNCTION FriendsOf(userID INT)
RETURNS TABLE(friendID INT) AS $$ BEGIN
    RETURN QUERY(
    SELECT CASE
    WHEN user1_ID = userID THEN user2_ID
    ELSE user1_ID END friendID
    FROM idprojekt.friends WHERE 
    user1_ID = userID OR user2_ID = userID);
END; $$ LANGUAGE plpgsql;

-- tu chyba zle znizke nalicza ???
-- cos z data nie tak ??? dziwna sprawa
-- (product ID) -> cena (ze zniżką)
CREATE OR REPLACE FUNCTION PriceOf(productID INT)
RETURNS MONEY AS $$ 
DECLARE price MONEY;
BEGIN
    price = COALESCE((SELECT ph.price 
    FROM idprojekt.price_history ph WHERE
    ph.product_id = productID 
    ORDER BY date_of_change DESC LIMIT 1), '0$');

    price = price * (1 - COALESCE((SELECT discount  
    FROM idprojekt.discounts d NATURAL JOIN 
    idprojekt.discounted_products dp
    WHERE dp.product_id = productID AND
    d.start_date <= CURRENT_DATE AND CURRENT_DATE <= d.end_date LIMIT 1
    ), 0)::NUMERIC/100);

    RETURN price;
END; $$ LANGUAGE plpgsql;

--(user ID) -> list of user's products' ids
CREATE OR REPLACE FUNCTION usersProducts(userID INT)
RETURNS TABLE(productID INT) AS $$ BEGIN
RETURN QUERY(
    SELECT up.product_id FROM idprojekt.users_products up
    WHERE up.user_id = userID
);
END; $$ LANGUAGE plpgsql;

-- (userID, productID) -> list of user's achievemnts in the game
CREATE OR REPLACE FUNCTION usersAchievementsIn(userID INT, productID INT)
RETURNS TABLE(achievement_id INT) AS $$ BEGIN
RETURN QUERY(
    SELECT a.achievement_id FROM idprojekt.achievements a
    NATURAL JOIN idprojekt.user_achievements ua
    WHERE ua.user_id = userID AND a.product_id = productID
);
END; $$ LANGUAGE plpgsql;

-- (productID) ->  Most information needed for making a game page
CREATE OR REPLACE FUNCTION productInfo(productID INT)
RETURNS TABLE(name VARCHAR(64), quota INT, release_date DATE,
publisher_name VARCHAR(64), description TEXT, price MONEY) AS $$ BEGIN
RETURN QUERY(
    SELECT p.name, p.quota, p.release_date, d.developer_name, 
    de.description, PriceOf(product_id)  
    FROM idprojekt.products p JOIN idprojekt.developers d
    ON(d.developer_id = p.product_id) NATURAL JOIN idprojekt.descriptions de
    WHERE p.product_id = productID
); END; $$ LANGUAGE plpgsql;

-- (productID) -> Array of supported systems
CREATE OR REPLACE FUNCTION supportedSystems(productID INT)
RETURNS VARCHAR(64)[] AS $$ BEGIN
    RETURN ARRAY(SELECT system_name FROM 
    idprojekt.product_systems ps NATURAL JOIN idprojekt.systems
    WHERE ps.product_id = productID); 
END; $$ LANGUAGE plpgsql; 

-- (productID) -> Array of developers
CREATE OR REPLACE FUNCTION developersOf(productID INT)
RETURNS VARCHAR(64)[] AS $$ BEGIN
    RETURN ARRAY(SELECT developer_name FROM 
    idprojekt.products_developers pd 
    NATURAL JOIN idprojekt.developers
    WHERE pd.product_id = productID); 
END; $$ LANGUAGE plpgsql; 

-- (gameID) -> list of this game's DLCs
CREATE OR REPLACE FUNCTION DLCsOF(gameID INT)
RETURNS TABLE(product_id INT) AS $$ BEGIN
    RETURN QUERY(
        SELECT dlc_id FROM idprojekt.dlcs d
        WHERE d.game_id = gameID
    );
END; $$ LANGUAGE plpgsql; 

-- (gameID) -> Array of generes
CREATE OR REPLACE FUNCTION genresOf(gameID INT)
RETURNS VARCHAR(32)[] AS $$ BEGIN
    RETURN ARRAY(SELECT genre_name FROM 
    idprojekt.game_genre gg 
    NATURAL JOIN idprojekt.genres
    WHERE gg.game_id = gameID); 
END; $$ LANGUAGE plpgsql;

-- (product_id) -> List of NOT HIDDEN Achievements' id's
CREATE OR REPLACE FUNCTION achievementsIn(gameID INT)
RETURNS TABLE(achievement_id INT) AS $$ BEGIN
    RETURN QUERY(
        SELECT a.achievement_id FROM idprojekt.achievements a
        WHERE product_id = gameID AND NOT hidden
    );
END; $$ LANGUAGE plpgsql;

-- (achievementID) -> Achievement name
CREATE OR REPLACE FUNCTION achievementName(achievementID INT)
RETURNS VARCHAR(64) AS $$ BEGIN
    RETURN (SELECT a.achievement_name FROM 
    idprojekt.achievements a 
    WHERE a.achievement_id =  achievementID); 
END; $$ LANGUAGE plpgsql;

-- (achievementID) -> Achievement description
CREATE OR REPLACE FUNCTION achievementDescription(achievementID INT)
RETURNS VARCHAR(255) AS $$ BEGIN
    RETURN (SELECT a.description FROM 
    idprojekt.achievements a 
    WHERE a.achievement_id =  achievementID); 
END; $$ LANGUAGE plpgsql;

-- (userID, gameID) -> List of user's achievements' id's (query)
CREATE OR REPLACE FUNCTION userAchievements(userID INT, gameID INT)
RETURNS TABLE(achievement_id INT) AS $$ BEGIN
    RETURN QUERY(
        SELECT a.achievement_id FROM idprojekt.achievements a
        NATURAL JOIN idprojekt.user_achievements ua
        WHERE product_id = gameID
        AND user_id = userID
    );
END; $$ LANGUAGE plpgsql;

-- (productID) -> mean of reviews' scores
CREATE OR REPLACE FUNCTION meanReviewScoreOf(productID INT)
RETURNS NUMERIC AS $$ BEGIN
RETURN (
    SELECT AVG(r.score::NUMERIC) FROM idprojekt.reviews r
    WHERE product_id = productID
);
END; $$ LANGUAGE plpgsql;

-- (productID) -> review count
CREATE OR REPLACE FUNCTION reviewCountOf(productID INT)
RETURNS INT AS $$ BEGIN
RETURN (
    SELECT COUNT(*) FROM idprojekt.reviews r
    WHERE product_id = productID
);
END; $$ LANGUAGE plpgsql;

-- (productID) -> list of all review descriptions
CREATE OR REPLACE FUNCTION reviewsOf(productID INT)
RETURNS TABLE(user_id INT, score SMALLINT, description VARCHAR(255)) AS $$ BEGIN
RETURN QUERY(
    SELECT r.user_id, r.score, r.description 
    FROM idprojekt.reviews r
    WHERE product_id = productID
);
END; $$ LANGUAGE plpgsql;

-- -- (userID) -> List of user's products' ids (query)
-- CREATE OR REPLACE FUNCTION userProducts(userID INT)
-- RETURNS TABLE(product_id INT) AS $$ BEGIN
--     RETURN QUERY(
--         SELECT up.product_id FROM idprojekt.users_products up
--         WHERE user_id = userID
--     );
-- END; $$ LANGUAGE plpgsql;


-- (productID, userID) -> gameTime
CREATE OR REPLACE FUNCTION gameTimeIn(productID INT, userID INT)
RETURNS INT AS $$
DECLARE ans INT;
BEGIN
ans = (
    SELECT up.game_time FROM idprojekt.users_products up
    WHERE product_id = productID
    AND user_id = userID
);
IF ans IS NULL THEN ans = 0; END IF;
RETURN ans;
END; $$ LANGUAGE plpgsql;

-- (userID) -> wishList ids
CREATE OR REPLACE FUNCTION wishList(userID INT)
RETURNS TABLE(product_id INT) AS $$ BEGIN
    RETURN QUERY(
        SELECT wl.product_id FROM idprojekt.wish_list wl
        WHERE user_id = userID
    );
END; $$ LANGUAGE plpgsql;
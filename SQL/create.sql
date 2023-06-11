CREATE SCHEMA IF NOT EXISTS idprojekt;

CREATE  TABLE idprojekt.descriptions ( 
	description_id       serial  NOT NULL  ,
	description          text NOT NULL  ,
	CONSTRAINT pk_descriptions PRIMARY KEY ( description_id )
 );

CREATE  TABLE idprojekt.developers ( 
	developer_id         serial  NOT NULL  ,
	developer_name       varchar(64)  NOT NULL  ,
	CONSTRAINT pk_developers PRIMARY KEY ( developer_id )
 );

CREATE  TABLE idprojekt.discounts ( 
	discount_id          serial  NOT NULL  ,
	discount             smallint  NOT NULL  ,
	start_date           date DEFAULT CURRENT_DATE NOT NULL  ,
	end_date             date  NOT NULL  ,
	CONSTRAINT pk_discounts PRIMARY KEY ( discount_id ),
	CHECK(start_date <= end_date)
 );


CREATE  TABLE idprojekt.genres ( 
	genre_id             serial  NOT NULL  ,
	genre_name           varchar(32)  NOT NULL  ,
	CONSTRAINT pk_genres PRIMARY KEY ( genre_id )
 );

CREATE  TABLE idprojekt.products ( 
	product_id           serial  NOT NULL  ,
	name                 varchar(64)  NOT NULL  ,
	quota                integer  NOT NULL  ,
	release_date         date DEFAULT CURRENT_DATE NOT NULL  ,
	publisher_id         integer  NOT NULL  ,
	description_id       integer    ,
	CONSTRAINT pk_products PRIMARY KEY ( product_id ),
	CONSTRAINT fk_products_descriptions FOREIGN KEY ( description_id ) REFERENCES idprojekt.descriptions( description_id )   ,
	CONSTRAINT fk_products_developers FOREIGN KEY ( publisher_id ) REFERENCES idprojekt.developers( developer_id )   
 );

CREATE  TABLE idprojekt.products_developers ( 
	product_id           integer  NOT NULL  ,
	developer_id         integer  NOT NULL  ,
	CONSTRAINT fk_products_developers_products FOREIGN KEY ( product_id ) REFERENCES idprojekt.products( product_id )   ,
	CONSTRAINT fk_products_developers_developers FOREIGN KEY ( developer_id ) REFERENCES idprojekt.developers( developer_id )   
 );

CREATE  TABLE idprojekt.systems ( 
	system_id            serial  NOT NULL  ,
	system_name          varchar(64)  NOT NULL  ,
	CONSTRAINT pk_systems PRIMARY KEY ( system_id )
 );

CREATE  TABLE idprojekt.users ( 
	user_id              serial  NOT NULL  ,
	username             varchar(64)  NOT NULL  ,
	email                varchar(64)  NOT NULL  ,
	"password"           varchar(256)  NOT NULL  ,
	wallet               money DEFAULT 0 NOT NULL  ,
	CONSTRAINT pk_users PRIMARY KEY ( user_id )
 );

CREATE  TABLE idprojekt.users_products ( 
	user_id              integer  NOT NULL  ,
	product_id           integer  NOT NULL  ,
	transaction_date     date DEFAULT CURRENT_DATE NOT NULL  ,
	game_time            decimal DEFAULT 0 NOT NULL  ,
	CONSTRAINT fk_users_products_users FOREIGN KEY ( user_id ) REFERENCES idprojekt.users( user_id )   ,
	CONSTRAINT fk_users_products_products FOREIGN KEY ( product_id ) REFERENCES idprojekt.products( product_id )   
 );

CREATE  TABLE idprojekt.wish_list ( 
	user_id              integer  NOT NULL  ,
	product_id           integer  NOT NULL  ,
	CONSTRAINT fk_wish_list_users FOREIGN KEY ( user_id ) REFERENCES idprojekt.users( user_id )   ,
	CONSTRAINT fk_wish_list_products FOREIGN KEY ( product_id ) REFERENCES idprojekt.products( product_id ),
	PRIMARY KEY(user_id, product_id)  
 );

CREATE  TABLE idprojekt.achievements ( 
	achievement_id       serial  NOT NULL  ,
	product_id           integer  NOT NULL  ,
	achievement_name     varchar(64)  NOT NULL  ,
	description          varchar(255) DEFAULT ' ' NOT NULL  ,
	hidden               boolean DEFAULT false NOT NULL  ,
	CONSTRAINT pk_achievements PRIMARY KEY ( achievement_id ),
	CONSTRAINT fk_achievements_products FOREIGN KEY ( product_id ) REFERENCES idprojekt.products( product_id )   
 );

CREATE  TABLE idprojekt.discounted_products ( 
	discount_id          integer  NOT NULL  ,
	product_id           integer  NOT NULL  ,
	CONSTRAINT fk_discounted_products_discounts FOREIGN KEY ( discount_id ) REFERENCES idprojekt.discounts( discount_id )   ,
	CONSTRAINT fk_discounted_products_products FOREIGN KEY ( product_id ) REFERENCES idprojekt.products( product_id )   
 );

CREATE  TABLE idprojekt.friends ( 
	user1_id             integer  NOT NULL  ,
	user2_id             integer  NOT NULL  ,
	CONSTRAINT fk_friends_users FOREIGN KEY ( user2_id ) REFERENCES idprojekt.users( user_id )   ,
	CONSTRAINT fk_friends_users_0 FOREIGN KEY ( user1_id ) REFERENCES idprojekt.users( user_id )   ,
	CHECK(user1_id < user2_id)
 );

CREATE  TABLE idprojekt.games ( 
	game_id              integer  NOT NULL  ,
	-- genre_id             integer    ,
	CONSTRAINT pk_games PRIMARY KEY ( game_id ),
	CONSTRAINT fk_games_products FOREIGN KEY ( game_id ) REFERENCES idprojekt.products( product_id )   
 );

CREATE  TABLE idprojekt.price_history ( 
	product_id           integer  NOT NULL  ,
	price                money DEFAULT 0 NOT NULL  ,
	date_of_change       date DEFAULT CURRENT_DATE NOT NULL  ,
	CONSTRAINT fk_price_history_products FOREIGN KEY ( product_id ) REFERENCES idprojekt.products( product_id )   
 );

CREATE  TABLE idprojekt.product_systems ( 
	product_id           integer  NOT NULL  ,
	system_id            integer  NOT NULL  ,
	CONSTRAINT fk_product_systems_systems FOREIGN KEY ( system_id ) REFERENCES idprojekt.systems( system_id )   ,
	CONSTRAINT fk_product_systems_products FOREIGN KEY ( product_id ) REFERENCES idprojekt.products( product_id )   
 );

CREATE  TABLE idprojekt.reviews ( 
	product_id           integer  NOT NULL  ,
	user_id              integer  NOT NULL  ,
	score                smallint  NOT NULL  ,
	description          varchar(255)    ,
	CONSTRAINT fk_reviews_users FOREIGN KEY ( user_id ) REFERENCES idprojekt.users( user_id )   ,
	CONSTRAINT fk_reviews_products FOREIGN KEY ( product_id ) REFERENCES idprojekt.products( product_id ),  
	CHECK(0 <= score AND score <= 10)
 );

CREATE  TABLE idprojekt.user_achievements ( 
	user_id              integer  NOT NULL  ,
	achievement_id       integer  NOT NULL  ,
	CONSTRAINT fk_user_achievements_users FOREIGN KEY ( user_id ) REFERENCES idprojekt.users( user_id )   ,
	CONSTRAINT fk_user_achievements_achievements FOREIGN KEY ( achievement_id ) REFERENCES idprojekt.achievements( achievement_id )   
 );

CREATE  TABLE idprojekt.dlcs ( 
	dlc_id               integer  NOT NULL  ,
	game_id              integer  NOT NULL  ,
	CONSTRAINT pk_dlc PRIMARY KEY ( dlc_id ),
	CONSTRAINT fk_dlcs_products FOREIGN KEY ( dlc_id ) REFERENCES idprojekt.products( product_id )   ,
	CONSTRAINT fk_dlcs_games FOREIGN KEY ( game_id ) REFERENCES idprojekt.games( game_id )   
 );

CREATE  TABLE idprojekt.game_genre ( 
	genre_id             integer  NOT NULL  ,
	game_id              integer  NOT NULL  ,
	CONSTRAINT unq_game_genre_game_id UNIQUE ( game_id, genre_id ) ,
	CONSTRAINT fk_game_genre_genres FOREIGN KEY ( genre_id ) REFERENCES idprojekt.genres( genre_id )   ,
	CONSTRAINT fk_game_genre_games FOREIGN KEY ( game_id ) REFERENCES idprojekt.games( game_id )   
 );

COMMENT ON COLUMN idprojekt.discounts.discount IS 'discount in %';

COMMENT ON COLUMN idprojekt.products.product_id IS 'product id';

COMMENT ON COLUMN idprojekt.users_products.game_time IS 'game time in minutes';

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




-- (person ID) -> list of friends' IDs
CREATE OR REPLACE FUNCTION idprojekt.FriendsOf(userID INT)
RETURNS TABLE(friendID INT) AS $$ BEGIN
    RETURN QUERY(
    SELECT CASE
    WHEN user1_ID = userID THEN user2_ID
    ELSE user1_ID END friendID
    FROM idprojekt.friends WHERE 
    user1_ID = userID OR user2_ID = userID);
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION idprojekt.NonFriendsOf(userID INT)
RETURNS TABLE(user_id INT) AS $$ BEGIN
    RETURN QUERY(
    SELECT u.user_id FROM idprojekt.users u
    WHERE u.user_id NOT IN ((
        SELECT CASE
        WHEN user1_ID = userID THEN user2_ID
        ELSE user1_ID END friendID
        FROM idprojekt.friends WHERE 
        user1_ID = userID OR user2_ID = userID)
    )
    );
END; $$ LANGUAGE plpgsql;

-- tu chyba zle znizke nalicza ???
-- cos z data nie tak ??? dziwna sprawa
-- (product ID) -> cena (ze zniżką)
CREATE OR REPLACE FUNCTION idprojekt.PriceOf(productID INT)
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
CREATE OR REPLACE FUNCTION idprojekt.usersProducts(userID INT)
RETURNS TABLE(productID INT) AS $$ BEGIN
RETURN QUERY(
    SELECT up.product_id FROM idprojekt.users_products up
    WHERE up.user_id = userID
);
END; $$ LANGUAGE plpgsql;

-- (userID, productID) -> list of user's achievemnts in the game
CREATE OR REPLACE FUNCTION idprojekt.usersAchievementsIn(userID INT, productID INT)
RETURNS TABLE(achievement_id INT) AS $$ BEGIN
RETURN QUERY(
    SELECT a.achievement_id FROM idprojekt.achievements a
    NATURAL JOIN idprojekt.user_achievements ua
    WHERE ua.user_id = userID AND a.product_id = productID
);
END; $$ LANGUAGE plpgsql;

-- (productID) ->  Most information needed for making a game page
CREATE OR REPLACE FUNCTION idprojekt.productInfo(productID INT)
RETURNS TABLE(name VARCHAR(64), quota INT, release_date DATE,
publisher_name VARCHAR(64), description TEXT, price MONEY) AS $$ BEGIN
RETURN QUERY(
    SELECT p.name, p.quota, p.release_date, d.developer_name, 
    de.description, idprojekt.PriceOf(product_id)  
    FROM idprojekt.products p JOIN idprojekt.developers d
    ON(d.developer_id = p.product_id) NATURAL JOIN idprojekt.descriptions de
    WHERE p.product_id = productID
); END; $$ LANGUAGE plpgsql;

-- (productID) -> Array of supported systems
CREATE OR REPLACE FUNCTION idprojekt.supportedSystems(productID INT)
RETURNS VARCHAR(64)[] AS $$ BEGIN
    RETURN ARRAY(SELECT system_name FROM 
    idprojekt.product_systems ps NATURAL JOIN idprojekt.systems
    WHERE ps.product_id = productID); 
END; $$ LANGUAGE plpgsql; 

-- (productID) -> Array of developers
CREATE OR REPLACE FUNCTION idprojekt.developersOf(productID INT)
RETURNS VARCHAR(64)[] AS $$ BEGIN
    RETURN ARRAY(SELECT developer_name FROM 
    idprojekt.products_developers pd 
    NATURAL JOIN idprojekt.developers
    WHERE pd.product_id = productID); 
END; $$ LANGUAGE plpgsql; 

-- (gameID) -> list of this game's DLCs
CREATE OR REPLACE FUNCTION idprojekt.DLCsOF(gameID INT)
RETURNS TABLE(product_id INT) AS $$ BEGIN
    RETURN QUERY(
        SELECT dlc_id FROM idprojekt.dlcs d
        WHERE d.game_id = gameID
    );
END; $$ LANGUAGE plpgsql; 

-- (gameID) -> Array of generes
CREATE OR REPLACE FUNCTION idprojekt.genresOf(gameID INT)
RETURNS VARCHAR(32)[] AS $$ BEGIN
    RETURN ARRAY(SELECT genre_name FROM 
    idprojekt.game_genre gg 
    NATURAL JOIN idprojekt.genres
    WHERE gg.game_id = gameID); 
END; $$ LANGUAGE plpgsql;

-- (product_id) -> List of NOT HIDDEN Achievements' id's
CREATE OR REPLACE FUNCTION idprojekt.achievementsIn(gameID INT)
RETURNS TABLE(achievement_id INT) AS $$ BEGIN
    RETURN QUERY(
        SELECT a.achievement_id FROM idprojekt.achievements a
        WHERE product_id = gameID AND NOT hidden
    );
END; $$ LANGUAGE plpgsql;

-- (achievementID) -> Achievement name
CREATE OR REPLACE FUNCTION idprojekt.achievementName(achievementID INT)
RETURNS VARCHAR(64) AS $$ BEGIN
    RETURN (SELECT a.achievement_name FROM 
    idprojekt.achievements a 
    WHERE a.achievement_id =  achievementID); 
END; $$ LANGUAGE plpgsql;

-- (achievementID) -> Achievement description
CREATE OR REPLACE FUNCTION idprojekt.achievementDescription(achievementID INT)
RETURNS VARCHAR(255) AS $$ BEGIN
    RETURN (SELECT a.description FROM 
    idprojekt.achievements a 
    WHERE a.achievement_id =  achievementID); 
END; $$ LANGUAGE plpgsql;

-- (userID, gameID) -> List of user's achievements' id's (query)
CREATE OR REPLACE FUNCTION idprojekt.userAchievements(userID INT, gameID INT)
RETURNS TABLE(achievement_id INT) AS $$ BEGIN
    RETURN QUERY(
        SELECT a.achievement_id FROM idprojekt.achievements a
        NATURAL JOIN idprojekt.user_achievements ua
        WHERE product_id = gameID
        AND user_id = userID
    );
END; $$ LANGUAGE plpgsql;

-- (productID) -> mean of reviews' scores
CREATE OR REPLACE FUNCTION idprojekt.meanReviewScoreOf(productID INT)
RETURNS NUMERIC AS $$ BEGIN
RETURN (
    SELECT AVG(r.score::NUMERIC) FROM idprojekt.reviews r
    WHERE product_id = productID
);
END; $$ LANGUAGE plpgsql;

-- (productID) -> review count
CREATE OR REPLACE FUNCTION idprojekt.reviewCountOf(productID INT)
RETURNS INT AS $$ BEGIN
RETURN (
    SELECT COUNT(*) FROM idprojekt.reviews r
    WHERE product_id = productID
);
END; $$ LANGUAGE plpgsql;

-- (productID) -> list of all review descriptions
CREATE OR REPLACE FUNCTION idprojekt.reviewsOf(productID INT)
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
CREATE OR REPLACE FUNCTION idprojekt.gameTimeIn(productID INT, userID INT)
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
CREATE OR REPLACE FUNCTION idprojekt.wishList(userID INT)
RETURNS TABLE(product_id INT) AS $$ BEGIN
    RETURN QUERY(
        SELECT wl.product_id FROM idprojekt.wish_list wl
        WHERE user_id = userID
    );
END; $$ LANGUAGE plpgsql;





-- widok dla sklepu
CREATE VIEW idprojekt.productIDview AS 
SELECT product_id, name FROM idprojekt.products
ORDER BY name;

-- Insert descriptions
INSERT INTO idprojekt.descriptions (description_id, description)
SELECT i, 'lorem ipsum' || i
FROM generate_series(1, 50) AS i;

-- Insert game genres
INSERT INTO idprojekt.genres (genre_id, genre_name)
VALUES
  (DEFAULT, 'platform'),
  (DEFAULT, 'strategy'),
  (DEFAULT, 'action'),
  (DEFAULT, 'adventure'),
  (DEFAULT, 'role-playing'),
  (DEFAULT, 'simulation'),
  (DEFAULT, 'puzzle'),
  (DEFAULT, 'sports'),
  (DEFAULT, 'racing'),
  (DEFAULT, 'shooter'),
  (DEFAULT, 'fighting'),
  (DEFAULT, 'sandbox');

-- Insert developers
INSERT INTO idprojekt.developers (developer_id, developer_name)
VALUES
  (DEFAULT, 'developer1'),
  (DEFAULT, 'developer2'),
  (DEFAULT, 'developer3'),
  (DEFAULT, 'developer4'),
  (DEFAULT, 'developer5'),
  (DEFAULT, 'developer6'),
  (DEFAULT, 'developer7'),
  (DEFAULT, 'developer8'),
  (DEFAULT, 'developer9'),
  (DEFAULT, 'developer10'),
  (DEFAULT, 'developer11'),
  (DEFAULT, 'developer12'),
  (DEFAULT, 'developer13'),
  (DEFAULT, 'developer14'),
  (DEFAULT, 'developer15'),
  (DEFAULT, 'developer16'),
  (DEFAULT, 'developer17'),
  (DEFAULT, 'developer18'),
  (DEFAULT, 'developer19'),
  (DEFAULT, 'developer20'),
  (DEFAULT, 'developer21'),
  (DEFAULT, 'developer22'),
  (DEFAULT, 'developer23'),
  (DEFAULT, 'developer24'),
  (DEFAULT, 'developer25'),
  (DEFAULT, 'developer26'),
  (DEFAULT, 'developer27'),
  (DEFAULT, 'developer28'),
  (DEFAULT, 'developer29'),
  (DEFAULT, 'developer30');

  -- Insert products
INSERT INTO idprojekt.products
VALUES
  (DEFAULT, 'product1', 100, '2022-01-15', 1, 1),
  (DEFAULT, 'product2', 200, '2022-02-28', 2, 2),
  (DEFAULT, 'product3', 150, '2022-03-10', 3, 3),
  (DEFAULT, 'product4', 120, '2022-04-05', 4, 4),
  (DEFAULT, 'product5', 180, '2022-05-20', 5, 5),
  (DEFAULT, 'product6', 90, '2022-06-07', 6, 6),
  (DEFAULT, 'product7', 250, '2022-07-12', 7, 7),
  (DEFAULT, 'product8', 170, '2022-08-25', 8, 8),
  (DEFAULT, 'product9', 140, '2022-09-03', 9, 9),
  (DEFAULT, 'product10', 300, '2022-10-18', 10, 10),
  (DEFAULT, 'product11', 110, '2022-11-29', 1, 11),
  (DEFAULT, 'product12', 190, '2022-12-08', 2, 12),
  (DEFAULT, 'product13', 160, '2023-01-22', 3, 13),
  (DEFAULT, 'product14', 130, '2023-02-14', 4, 14),
  (DEFAULT, 'product15', 220, '2023-03-05', 5, 15),
  (DEFAULT, 'product16', 80, '2023-04-19', 6, 16),
  (DEFAULT, 'product17', 280, '2023-05-11', 7, 17);

-- Generate game entries
INSERT INTO idprojekt.games (game_id)
VALUES
  (1),
  (2),
  (3),
  (4),
  (5),
  (6);

  -- Insert dlcs
INSERT INTO idprojekt.dlcs 
VALUES
  (7, 1),
  (8, 2),
  (9, 3),
  (10, 4),
  (11, 5),
  (12, 6),
  (13, 6),
  (14, 6),
  (15, 1),
  (16, 2),
  (17, 3);

  -- Insert game_genre
INSERT INTO idprojekt.game_genre (game_id, genre_id)
VALUES
  (1, 1),
  (1, 2),
  (2, 3),
  (2, 4),
  (3, 5),
  (3, 6),
  (4, 7),
  (4, 8),
  (5, 9),
  (5, 10),
  (6, 11),
  (6, 7);


-- Insert product_developers
INSERT INTO idprojekt.products_developers (product_id, developer_id)
VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5),
  (6, 6),
  (7, 7),
  (8, 8),
  (9, 9),
  (10, 10),
  (11, 11),
  (12, 12),
  (13, 13),
  (14, 14),
  (15, 15),
  (16, 16),
  (17, 17);

-- Insert systems
  insert into idprojekt.systems values
(DEFAULT, 'Linux'),
(DEFAULT, 'Windows'),
(DEFAULT, 'MacOS');

-- Insert product_systems
INSERT INTO idprojekt.product_systems (product_id, system_id)
VALUES
  (1, 1),
  (1, 2),
  (2, 1),
  (3, 1),
  (4, 2),
  (4, 3),
  (5, 2),
  (6, 1),
  (7, 1),
  (8, 3),
  (9, 2),
  (10, 1),
  (11, 1),
  (11, 2),
  (11, 3),
  (12, 2),
  (13, 1),
  (14, 3),
  (15, 1),
  (16, 2),
  (17, 1);
  -- Insert discounts
INSERT INTO idprojekt.discounts
VALUES
  (DEFAULT, 10, '2022-01-01', '2022-01-31'),
  (DEFAULT, 20, '2022-02-01', '2022-02-28'),
  (DEFAULT, 15, '2022-03-01', '2022-03-31'),
  (DEFAULT, 25, '2022-04-01', '2022-04-30'),
  (DEFAULT, 12, '2022-05-01', '2022-05-31'),
  (DEFAULT, 18, '2022-06-01', '2022-06-30'),
  (DEFAULT, 30, '2022-07-01', '2022-07-31'),
  (DEFAULT, 10, '2022-08-01', '2022-08-31'),
  (DEFAULT, 22, '2022-09-01', '2022-09-30'),
  (DEFAULT, 15, '2022-10-01', '2022-10-31'),
  (DEFAULT, 27, '2022-11-01', '2022-11-30'),
  (DEFAULT, 20, '2022-12-01', '2022-12-31'),
  (DEFAULT, 12, '2023-01-01', '2023-01-31'),
  (DEFAULT, 25, '2023-02-01', '2023-02-28'),
  (DEFAULT, 18, '2023-03-01', '2023-03-31'),
  (DEFAULT, 30, '2023-04-01', '2023-04-30'),
  (DEFAULT, 15, '2023-05-01', '2023-05-31'),
  (DEFAULT, 22, '2023-06-01', '2023-06-30'),
  (DEFAULT, 20, '2023-07-01', '2023-07-31'),
  (DEFAULT, 10, '2023-08-01', '2023-08-31');

  -- Insert discounted products
INSERT INTO idprojekt.discounted_products (discount_id, product_id)
VALUES
  (1, 1),
  (1, 1),
  (1, 3),
  (2, 2),
  (2, 4),
  (3, 4),
  (3, 5),
  (4, 6),
  (5, 7),
  (5, 7),
  (6, 7),
  (6, 8),
  (7, 9),
  (7, 9),
  (8, 9),
  (8, 10),
  (9, 11),
  (9, 11),
  (10, 12),
  (11, 13),
  (11, 14),
  (12, 14),
  (12, 15),
  (13, 16),
  (13, 17);

  -- Generate price history
INSERT INTO idprojekt.price_history 
VALUES
  (1, 10, '2021-03-10'),
  (1, 12, DEFAULT),
  (2, 15, '2021-03-10'),
  (3, 8, '2021-03-10'),
  (4, 33, '2021-03-10'),
  (4, 20, '2022-03-10'),
  (5, 17, '2022-03-10'),
  (6, 15, '2022-03-10'),
  (7, 25, '2022-04-10'),
  (8, 18, '2022-05-10'),
  (9, 22, '2022-06-10'),
  (10, 30, '2022-07-10'),
  (11, 12, '2022-08-10'),
  (12, 28, '2022-09-10'),
  (13, 19, '2022-10-10'),
  (14, 21, '2022-11-10'),
  (15, 16, '2022-12-10'),
  (16, 24, '2023-01-10'),
  (17, 27, '2023-02-10'),
  (1, 11, '2023-03-10'),
  (1, 13, '2023-04-10'),
  (2, 16, '2023-05-10'),
  (3, 9, '2023-06-10');

  -- Generate users
INSERT INTO idprojekt.users
VALUES
  (DEFAULT, 'user1', 'user1@mail.com', 'haslo123!', 3),
  (DEFAULT, 'user2', 'user2@mail.com', 'password', DEFAULT),
  (DEFAULT, 'user3', 'user3@mail.com', 'haslo123!', 10),
  (DEFAULT, 'user4', 'user4@mail.com', 'password123', 5),
  (DEFAULT, 'user5', 'user5@mail.com', 'pass1234', 20),
  (DEFAULT, 'user6', 'user6@mail.com', 'qwerty', 15),
  (DEFAULT, 'user7', 'user7@mail.com', 'abc123', 8),
  (DEFAULT, 'user8', 'user8@mail.com', 'testpass', 12),
  (DEFAULT, 'user9', 'user9@mail.com', 'secure123', 25),
  (DEFAULT, 'user10', 'user10@mail.com', '123456', 30),
  (DEFAULT, 'user11', 'user11@mail.com', 'passpass', 7),
  (DEFAULT, 'user12', 'user12@mail.com', 'hello123', 18),
  (DEFAULT, 'user13', 'user13@mail.com', 'password1', 10),
  (DEFAULT, 'user14', 'user14@mail.com', 'test123', 5),
  (DEFAULT, 'user15', 'user15@mail.com', 'qwerty123', 15),
  (DEFAULT, 'user16', 'user16@mail.com', 'abc1234', 8),
  (DEFAULT, 'user17', 'user17@mail.com', 'passpass123', 12),
  (DEFAULT, 'user18', 'user18@mail.com', 'testpass123', 25),
  (DEFAULT, 'user19', 'user19@mail.com', 'secure1234', 30),
  (DEFAULT, 'user20', 'user20@mail.com', '12345678', 7);

-- Generate friends
INSERT INTO idprojekt.friends
VALUES
  (1, 2),
  (2, 3),
  (1, 3),
  (1, 4),
  (3, 5),
  (4, 6),
  (6, 7),
  (7, 8),
  (9, 10),
  (11, 12),
  (13, 14),
  (15, 16),
  (17, 18),
  (19, 20),
  (2, 4),
  (3, 5),
  (6, 8),
  (9, 11),
  (13, 15),
  (17, 19),
  (2, 6),
  (3, 7),
  (4, 8),
  (5, 9),
  (6, 10),
  (7, 11),
  (8, 12),
  (9, 13),
  (10, 14),
  (11, 15),
  (12, 16),
  (13, 17),
  (14, 18),
  (15, 19),
  (16, 20),
  (1, 10),
  (2, 9),
  (3, 8),
  (4, 7),
  (5, 6),
  (11, 20),
  (12, 19),
  (13, 18),
  (14, 17),
  (15, 16);

  -- Generate wish list
INSERT INTO idprojekt.wish_list (user_id, product_id)
VALUES
  (1, 1),
  (1, 2),
  (1, 3),
  (1, 4),
  (1, 5),
  (2, 6),
  (2, 7),
  (2, 8),
  (2, 9),
  (2, 10),
  (3, 11),
  (3, 12),
  (3, 13),
  (3, 14),
  (3, 15),
  (4, 16),
  (4, 17);

-- Generate wish list 5 - 20
INSERT INTO idprojekt.wish_list (user_id, product_id)
VALUES
  -- User 5
  (5, 1), (5, 2), (5, 3), (5, 4), (5, 5),
  -- User 6
  (6, 6), (6, 7), (6, 8), (6, 9), (6, 10),
  -- User 7
  (7, 11), (7, 12), (7, 13), (7, 14), (7, 15),
  -- User 8
  (8, 16), (8, 17),
  -- User 9
  (9, 1), (9, 2), (9, 3), (9, 4), (9, 5),
  -- User 10
  (10, 6), (10, 7), (10, 8), (10, 9), (10, 10),
  -- User 11
  (11, 11), (11, 12), (11, 13), (11, 14), (11, 15),
  -- User 12
  (12, 16), (12, 17),
  -- User 13
  (13, 1), (13, 2), (13, 3), (13, 4), (13, 5),
  -- User 14
  (14, 6), (14, 7), (14, 8), (14, 9), (14, 10),
  -- User 15
  (15, 11), (15, 12), (15, 13), (15, 14), (15, 15),
  -- User 16
  (16, 16), (16, 17),
  -- User 17
  (17, 1), (17, 2), (17, 3), (17, 4), (17, 5),
  -- User 18
  (18, 6), (18, 7), (18, 8), (18, 9), (18, 10),
  -- User 19
  (19, 11), (19, 12), (19, 13), (19, 14), (19, 15),
  -- User 20
  (20, 16), (20, 17);

-- Generate users' products data
INSERT INTO idprojekt.users_products 
VALUES
  -- User 1
  (1, 3, '2022-03-10', 20),
  -- User 2
  (2, 1, DEFAULT, 0),
  -- User 3
  (3, 2, '2022-03-11', 25),
  -- User 4
  (4, 2, '2020-03-10', 1000),
  (4, 5, '2020-03-10', 1000),
  (4, 6, '2020-03-10', 1000),
  (4, 1, '2022-04-10', 20),
  -- User 5
  (5, 1, '2023-05-15', 30),
  (5, 7, '2023-06-01', 25),
  -- User 6
  (6, 4, '2023-05-18', 15),
  (6, 9, '2023-06-02', 20),
  (6, 10, '2023-06-05', 10),
  -- User 7
  (7, 2, '2023-05-20', 20),
  (7, 8, '2023-06-03', 15),
  (7, 11, '2023-06-07', 25),
  -- User 8
  (8, 3, '2023-05-22', 25),
  (8, 9, '2023-06-04', 20),
  (8, 12, '2023-06-08', 15),
  -- User 9
  (9, 5, '2023-05-25', 30),
  (9, 10, '2023-06-06', 10),
  (9, 13, '2023-06-09', 20),
  -- User 10
  (10, 1, '2023-05-28', 30),
  (10, 7, '2023-06-01', 25),
  (10, 14, '2023-06-10', 15),
  -- User 11
  (11, 4, '2023-06-02', 15),
  (11, 9, '2023-06-03', 20),
  (11, 15, '2021-10-08', 10),
  -- User 12
  (12, 2, '2022-12-05', 20),
  (12, 8, '2021-11-07', 15),
  (12, 16, '2021-10-12', 30),
  -- User 13
  (13, 3, '2022-12-08', 25),
  (13, 10, '2022-11-09', 10),
  (13, 17, '2021-10-13', 20),
  -- User 14
  (14, 5, '2022-12-11', 30),
  (14, 11, '2021-11-14', 25),
  -- User 15
  (15, 1, '2022-12-15', 30),
  (15, 7, '2022-11-17', 25),
  (15, 12, '2021-10-20', 15),
  -- User 16
  (16, 4, '2022-12-18', 15),
  (16, 9, '2022-11-19', 20),
  (16, 13, '2021-10-22', 20),
  -- User 17
  (17, 2, '2022-12-21', 20),
  (17, 8, '2021-11-24', 15),
  (17, 14, '2021-10-26', 30),
  -- User 18
  (18, 3, '2022-12-23', 25),
  (18, 10, '2022-11-25', 10),
  (18, 15, '2021-10-28', 15),
  -- User 19
  (19, 5, '2022-12-26', 30),
  (19, 11, '2021-11-29', 25),
  (19, 16, '2021-10-31', 20),
  -- User 20
  (20, 1, '2022-12-30', 30),
  (20, 7, '2021-11-02', 25),
  (20, 17, '2021-10-04', 20);

  -- Generate reviews
INSERT INTO idprojekt.reviews 
VALUES
  (1, 3, 6, 'Nice game with great graphics and gameplay.'),
  (2, 1, 2, 'Disappointed with the lack of features.'),
  (4, 2, 10, 'This is the best game I have ever played! Highly recommended.'),
  (5, 7, 8, 'Enjoyable experience with immersive storyline.'),
  (7, 12, 4, 'The game has potential, but needs more polishing.'),
  (9, 16, 9, 'Absolutely amazing! The visuals and soundtrack are top-notch.'),
  (11, 5, 7, 'Solid gameplay mechanics and interesting level design.'),
  (14, 9, 5, 'Average game with nothing particularly outstanding.'),
  (17, 14, 9, 'One of the best games I have played in recent years.');

  -- Generate achievements
INSERT INTO idprojekt.achievements
VALUES
  (DEFAULT, 1, 'Master Explorer', 'Discover all hidden locations in the game.', false),
  (DEFAULT, 1, 'Speed Runner', 'Complete the game in under 3 hours.', false),
  (DEFAULT, 2, 'Legendary Warrior', 'Defeat the final boss on the highest difficulty.', false),
  (DEFAULT, 3, 'Collector', 'Collect all unique items in the game.', true),
  (DEFAULT, 3, 'Master of Strategy', 'Win 100 multiplayer matches.', false),
  (DEFAULT, 3, 'Unstoppable Force', 'Achieve a 50-kill streak in a single game.', false),
  (DEFAULT, 4, 'Puzzle Solver', 'Solve all complex puzzles in the game.', false),
  (DEFAULT, 5, 'Shadow Walker', 'Finish the game without being detected by enemies.', true),
  (DEFAULT, 5, 'Stealth Assassin', 'Eliminate 50 enemies silently.', false),
  (DEFAULT, 5, 'Master Thief', 'Steal valuable artifacts from 10 guarded locations.', false),
  (DEFAULT, 6, 'Champion of the Arena', 'Win all arena battles and become the champion.', false),
  (DEFAULT, 6, 'Gladiator', 'Achieve a flawless victory in 10 consecutive arena battles.', false),
  (DEFAULT, 7, 'Treasure Hunter', 'Find and open all hidden chests in the game.', false),
  (DEFAULT, 8, 'Master Crafter', 'Craft the rarest and most powerful item in the game.', false),
  (DEFAULT, 8, 'Blacksmith Apprentice', 'Upgrade any weapon to its maximum level.', false),
  (DEFAULT, 9, 'Daredevil', 'Perform death-defying stunts and jumps in the game.', false),
  (DEFAULT, 10, 'Racing Champion', 'Win the championship in all available racing events.', false),
  (DEFAULT, 11, 'Survivalist', 'Survive for 7 consecutive days in the wilderness.', false),
  (DEFAULT, 11, 'Explorer', 'Discover all hidden locations in the game world.', false),
  (DEFAULT, 11, 'Master Angler', 'Catch 100 different types of fish.', false),
  (DEFAULT, 11, 'Champion of the Arena', 'Defeat all opponents and become the arena champion.', false),
  (DEFAULT, 12, 'Legendary Hero', 'Complete all epic quests and save the world.', false),
  (DEFAULT, 12, 'Master Enchanter', 'Enchant an item with the most powerful enchantment.', false),
  (DEFAULT, 12, 'Archmage', 'Reach the highest level of mastery in magic skills.', false),
  (DEFAULT, 13, 'Legendary Explorer', 'Uncover all hidden treasures in the vast open world.', false),
  (DEFAULT, 13, 'Master Thief', 'Steal valuable artifacts from heavily guarded locations.', false),
  (DEFAULT, 13, 'Shadow Assassin', 'Eliminate 100 enemies without being detected.', false),
  (DEFAULT, 13, 'Mastery of Stealth', 'Complete the game without ever being seen by enemies.', true),
  (DEFAULT, 14, 'Master Builder', 'Construct and upgrade all available buildings in the game.', false),
  (DEFAULT, 14, 'City Planner', 'Create a thriving city with a population of 10,000.', false),
  (DEFAULT, 15, 'Puzzle Master', 'Solve all intricate puzzles and riddles scattered throughout the game.', false),
  (DEFAULT, 15, 'Mind Bender', 'Manipulate the environment and objects using psychic abilities.', false),
  (DEFAULT, 15, 'Telekinetic Powerhouse', 'Throw and manipulate objects weighing over 1000 pounds.', false),
  (DEFAULT, 16, 'Master Alchemist', 'Brew the most potent potions with rare ingredients.', false),
  (DEFAULT, 16, 'Herbologist', 'Gather and identify 50 different types of rare herbs.', false),
  (DEFAULT, 16, 'Elixir of Immortality', 'Create a potion that grants eternal life.', true),
  (DEFAULT, 17, 'Legendary Commander', 'Lead your army to victory in all major battles.', false),
  (DEFAULT, 17, 'Tactician', 'Employ advanced strategies to defeat powerful enemies.', false),
  (DEFAULT, 17, 'Warrior of Justice', 'Defeat the final boss and restore peace to the realm.', false);

  -- Generate user achievements for users 1 to 10
INSERT INTO idprojekt.user_achievements (user_id, achievement_id)
VALUES
  (1, 1),
  (1, 3),
  (1, 5),
  (2, 2),
  (2, 6),
  (3, 4),
  (4, 1),
  (4, 3),
  (4, 4),
  (4, 5),
  (4, 6),
  (5, 2),
  (5, 4),
  (6, 1),
  (6, 5),
  (6, 6),
  (7, 1),
  (7, 2),
  (7, 3),
  (8, 4),
  (8, 6),
  (9, 1),
  (9, 3),
  (9, 5),
  (9, 6),
  (10, 2),
  (10, 4),
  (10, 5),
  (11, 1),
  (11, 2),
  (12, 3),
  (12, 4),
  (12, 5),
  (13, 1),
  (13, 3),
  (13, 4),
  (13, 6),
  (14, 2),
  (14, 5),
  (14, 6),
  (15, 1),
  (15, 3),
  (15, 4),
  (15, 5),
  (16, 2),
  (16, 4),
  (16, 6),
  (17, 1),
  (17, 2),
  (17, 3),
  (17, 5),
  (18, 2),
  (18, 3),
  (18, 4),
  (19, 1),
  (19, 4),
  (20, 3),
  (20, 5),
  (20, 6);
-- insert into idprojekt.descriptions values
-- (DEFAULT, 'lorem ipsum'),
-- (DEFAULT, 'lorem ipsum2'),
-- (DEFAULT, 'lorem ipsum3'),
-- (DEFAULT, 'lorem ipsum4'),
-- (DEFAULT, 'lorem ipsum5'),
-- (DEFAULT, 'lorem ipsum6');

-- insert into idprojekt.genres values
-- (DEFAULT, 'platform'),
-- (DEFAULT, 'strategy');

-- insert into idprojekt.developers values
-- (DEFAULT, 'pub1'),
-- (DEFAULT, 'pub2'),
-- (DEFAULT, 'pub3'),
-- (DEFAULT, 'dev1'),
-- (DEFAULT, 'dev2');

-- insert into idprojekt.products values
-- (DEFAULT, 'gra1', 256, '2000-04-30', 1, 1),
-- (DEFAULT, 'gra2', 128, '1999-03-30', 2, 2),
-- (DEFAULT, 'gra3', 44, '2022-02-22', 3, 3);

-- insert into idprojekt.games values
-- (1),
-- (2),
-- (3);

-- insert into idprojekt.products values
-- (DEFAULT, 'dlc1', 64, '2001-01-01', 1, 4),
-- (DEFAULT, 'dlc2', 36, '2023-04-30', 2, 5),
-- (DEFAULT, 'dlc3', 45, '2023-03-30', 2, 6);

-- insert into idprojekt.dlcs values
-- (4, 1),
-- (5, 2),
-- (6, 2);

-- insert into idprojekt.game_genre values
-- (1, 1),
-- (1, 2),
-- (2, 3);

-- insert into idprojekt.products_developers values
-- (1, 1),
-- (2, 2),
-- (3, 3),
-- (4, 2),
-- (5, 3);

-- insert into idprojekt.systems values
-- (DEFAULT, 'Linux'),
-- (DEFAULT, 'Windows'),
-- (DEFAULT, 'MacOS');

-- insert into idprojekt.product_systems values
-- (1, 1),
-- (1, 2),
-- (2, 1),
-- (3, 1),
-- (4, 2),
-- (4, 3),
-- (5, 2),
-- (6, 1);

-- insert into idprojekt.discounts values
-- (DEFAULT, 10, '2023-01-10', '2023-03-10'),
-- (DEFAULT, 10, DEFAULT, '2024-05-01'),
-- (DEFAULT, 10, '2024-01-10', '2024-03-10');

-- insert into idprojekt.discounted_products values
-- (1, 1),
-- (2, 1),
-- (3, 5),
-- (3, 6);

-- insert into idprojekt.price_history values
-- (1, 10, '2021-03-10'),
-- (1, 12, DEFAULT),
-- (2, 15, '2021-03-10'),
-- (3, 8, '2021-03-10'),
-- (4, 33, '2021-03-10'),
-- (4, 20, '2022-03-10'),
-- (5, 17, '2022-03-10'),
-- (6, 15, '2022-03-10');

-- insert into idprojekt.users values
-- (DEFAULT, 'user1', 'user1@mail.com', 'haslo123!', 3),
-- (DEFAULT, 'user2', 'user2@mail.com', 'password', DEFAULT),
-- (DEFAULT, 'user3', 'user3@mail.com', 'haslo123!', 10),
-- (DEFAULT, 'admin', 'admin@steam.com', 'admin', 1000);

-- insert into idprojekt.friends values
-- (1, 2),
-- (2, 3),
-- (1, 3),
-- (1, 4);

-- insert into idprojekt.wish_list values
-- (1, 1),
-- (1, 2),
-- (2, 1),
-- (3, 3);

-- insert into idprojekt.users_products values
-- (1, 3, '2022-03-10', 20),
-- (2, 1, DEFAULT, 0),
-- (3, 2, '2022-03-11', 25),
-- (4, 2, '2020-03-10', 1000),
-- (4, 5, '2020-03-10', 1000),
-- (4, 6, '2020-03-10', 1000),
-- (4, 1, '2022-04-10', 20);

-- insert into idprojekt.reviews values
-- (1, 3, 6, 'nice'),
-- (2, 1, 2, 'bad'),
-- (4, 2, 10, 'best game ever');

-- insert into idprojekt.achievements values
-- (DEFAULT, 1, 'ach1', DEFAULT, false),
-- (DEFAULT, 2, 'ach2', 'desc', false),
-- (DEFAULT, 2, 'ach3', DEFAULT, false),
-- (DEFAULT, 2, 'ach4', 'lorem ipsum', true),
-- (DEFAULT, 3, 'ach5', 'hidden', true),
-- (DEFAULT, 5, 'ach6', DEFAULT, false);

-- insert into idprojekt.user_achievements values
-- (1, 5),
-- (2, 1),
-- (4, 2),
-- (4, 3),
-- (4, 4),
-- (4, 6);
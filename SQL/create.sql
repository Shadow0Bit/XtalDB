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
	CONSTRAINT fk_friends_users_0 FOREIGN KEY ( user1_id ) REFERENCES idprojekt.users( user_id )   
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

insert into idprojekt.descriptions values
(DEFAULT, 'lorem ipsum'),
(DEFAULT, 'lorem ipsum2'),
(DEFAULT, 'lorem ipsum3'),
(DEFAULT, 'lorem ipsum4'),
(DEFAULT, 'lorem ipsum5'),
(DEFAULT, 'lorem ipsum6');

insert into idprojekt.genres values
(DEFAULT, 'platform'),
(DEFAULT, 'strategy');

insert into idprojekt.developers values
(DEFAULT, 'pub1'),
(DEFAULT, 'pub2'),
(DEFAULT, 'pub3'),
(DEFAULT, 'dev1'),
(DEFAULT, 'dev2');

insert into idprojekt.products values
(DEFAULT, 'gra1', 256, '2000-04-30', 1, 1),
(DEFAULT, 'gra2', 128, '1999-03-30', 2, 2),
(DEFAULT, 'gra3', 44, '2022-02-22', 3, 3);

insert into idprojekt.games values
(1),
(2),
(3);

insert into idprojekt.products values
(DEFAULT, 'dlc1', 64, '2001-01-01', 1, 4),
(DEFAULT, 'dlc2', 36, '2023-04-30', 2, 5),
(DEFAULT, 'dlc3', 45, '2023-03-30', 2, 6);

insert into idprojekt.dlcs values
(4, 1),
(5, 2),
(6, 2);

insert into idprojekt.game_genre values
(1, 1),
(1, 2),
(2, 3);

insert into idprojekt.products_developers values
(1, 1),
(2, 2),
(3, 3),
(4, 2),
(5, 3);

insert into idprojekt.systems values
(DEFAULT, 'Linux'),
(DEFAULT, 'Windows'),
(DEFAULT, 'MacOS');

insert into idprojekt.product_systems values
(1, 1),
(1, 2),
(2, 1),
(3, 1),
(4, 2),
(4, 3),
(5, 2),
(6, 1);

insert into idprojekt.discounts values
(DEFAULT, 10, '2023-01-10', '2023-03-10'),
(DEFAULT, 10, DEFAULT, '2024-05-01'),
(DEFAULT, 10, '2024-01-10', '2024-03-10');

insert into idprojekt.discounted_products values
(1, 1),
(2, 1),
(3, 5),
(3, 6);

insert into idprojekt.price_history values
(1, 10, '2021-03-10'),
(1, 12, DEFAULT),
(2, 15, '2021-03-10'),
(3, 8, '2021-03-10'),
(4, 33, '2021-03-10'),
(4, 20, '2022-03-10'),
(5, 17, '2022-03-10'),
(6, 15, '2022-03-10');

insert into idprojekt.users values
(DEFAULT, 'user1', 'user1@mail.com', 'haslo123!', 3),
(DEFAULT, 'user2', 'user2@mail.com', 'password', DEFAULT),
(DEFAULT, 'user3', 'user3@mail.com', 'haslo123!', 10),
(DEFAULT, 'admin', 'admin@steam.com', 'admin', 1000);

insert into idprojekt.friends values
(1, 2),
(2, 3),
(1, 3),
(1, 4);

insert into idprojekt.wish_list values
(1, 1),
(1, 2),
(2, 1),
(3, 3);

insert into idprojekt.users_products values
(1, 3, '2022-03-10', 20),
(2, 1, DEFAULT, 0),
(3, 2, '2022-03-11', 25),
(4, 2, '2020-03-10', 1000),
(4, 5, '2020-03-10', 1000),
(4, 6, '2020-03-10', 1000),
(4, 1, '2022-04-10', 20);

insert into idprojekt.reviews values
(1, 3, 6, 'nice'),
(2, 1, 2, 'bad'),
(4, 2, 10, 'best game ever');

insert into idprojekt.achievements values
(DEFAULT, 1, 'ach1', DEFAULT, false),
(DEFAULT, 2, 'ach2', 'desc', false),
(DEFAULT, 2, 'ach3', DEFAULT, false),
(DEFAULT, 2, 'ach4', 'lorem ipsum', true),
(DEFAULT, 3, 'ach5', 'hidden', true),
(DEFAULT, 5, 'ach6', DEFAULT, false);

insert into idprojekt.user_achievements values
(1, 5),
(2, 1),
(4, 2),
(4, 3),
(4, 4),
(4, 6);
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
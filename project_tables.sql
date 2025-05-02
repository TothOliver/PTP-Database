CREATE TABLE player (
player_id INT PRIMARY KEY AUTO_INCREMENT,
player_name VARCHAR(45) NOT NULL,
avg_round DECIMAL (3.1),
play_time TIME,
round_number INT,

FOREIGN KEY (round_number) REFERENCES rounds(round_number)
);

CREATE TABLE rounds (
round_number INT PRIMARY KEY AUTO_INCREMENT,
nr_of_enemies INT NOT NULL
);



CREATE TABLE enemy (
enemy_id INT PRIMARY KEY AUTO_INCREMENT,
enemy_type VARCHAR(45) NOT NULL,
enemy_color VARCHAR(45) NOT NULL,
enemy_difficulty VARCHAR(45) NOT NULL
);

CREATE TABLE spawnrate (
    round_number INT,
    enemy_id VARCHAR(45),
    spawnrate DECIMAL(3,3),  

    PRIMARY KEY (round_number, enemy_id),  -- composite primary key
    FOREIGN KEY (round_number) REFERENCES rounds(round_nunmber),
    FOREIGN KEY (enemy_id) REFERENCES enemy(enemy_id)
);

CREATE TABLE card (
card_id INT PRIMARY KEY AUTO_INCREMENT,
card_name VARCHAR(45),
pick_rate DECIMAL(3,2),
upgrade_rate DECIMAL(3.2),
win_rate DECIMAL(3,2)
);

CREATE TABLE player_card_rate(
card_id INT,
player_id INT,

pick_rate DECIMAL(3,2),
upgrade_rate DECIMAL(3,2),
win_rate DECIMAL (3,2),

PRIMARY KEY (card_id,player_id),
FOREIGN KEY (card_id) REFERENCES card(card_id),
FOREIGN KEY (player_id) REFERENCES player(player_id)
);

INSERT INTO enemy (enemy_type,enemy_color,enemy_difficulty) VALUES
("Pawn","W","easy"),
("Pawn","B","easy"),
("Bishop","W","medium"),
("Bishop","B","medium"),
("Rook","W","hard"),
("Rook","B","hard");

INSERT INTO spawnrate(enemy_id,round_number,spawnrate) VALUES
(1,1,0.5),
(2,1,0.5),
(3,1,0),
(4,1,0),
(5,1,0),
(6,1,0),
(1,2,0.35),
(2,2,0.35),
(3,2,0.15),
(4,2,0.15),
(5,2,0),
(6,2,0),
(1,3,0.35),
(2,3,0.35),
(3,3,0.15),
(4,3,0.15),
(5,3,0),
(6,3,0),
(1,4,0.225),
(2,4,0.225),
(3,4,0.2),
(4,4,0.2),
(5,4,0.075),
(6,4,0.075),
(1,5,0.225),
(2,5,0.225),
(3,5,0.2),
(4,5,0.2),
(5,5,0.075),
(6,5,0.075),
(1,6,0.15),
(2,6,0.15),
(3,6,0.2),
(4,6,0.2),
(5,6,0.15),
(6,6,0.15),
(1,7,0.15),
(2,7,0.15),
(3,7,0.2),
(4,7,0.2),
(5,7,0.15),
(6,7,0.15),
(1,8,0.1),
(2,8,0.1),
(3,8,0.25),
(4,8,0.25),
(5,8,0.15),
(6,8,0.15),
(1,9,0.1),
(2,9,0.1),
(3,9,0.2),
(4,9,0.2),
(5,9,0.2),
(6,9,0.2),
(1,10,0.1),
(2,10,0.1),
(3,10,0.2),
(4,10,0.2),
(5,10,0.2),
(6,10,0.2);

INSERT INTO rounds (nr_of_enemies) VALUES
(6),
(9),
(12),
(14),
(18),
(21),
(23),
(25),
(27),
(30);

INSERT INTO card (card_name,pick_rate, upgrade_rate, win_rate) VALUES 
("Ring of fire",	0.09,	0.11,	0.03),
("Scatter",			0.06,	0.13,	0.03),
("Ice Cubes",		0.14,	0.09,	0.07),
("Magic Missile",	0.04,	0.02,	0.01),
("Rune Shard",		0.16,	0.12,	0.08),
("Disruptor",		0.08,	0.08,	0.04),
("Blade",			0.07,	0.06,	0.04),
("Heal",			0.01,	0.24,	1.00),
("Longshot",		0.25,	0.06,	0.05),
("Haste",			0.1	,	0.09,	0.06);


INSERT INTO player (player_name,avg_round,play_time) VALUES
("Alpacca",		5.1,	"00:10:30",10),
("Björn",		7.2,	"03:20:56",10),
("Chinchilla",	9.0,	"00:40:21",10),
("Drake",		6.7,	"07:02:01",8),
("Ekorre",		4.5,	"10:30:30",7),
("Får",			6.7,	"02:06:06",9),
("Groda",		5.5,	"07:25:30",9),
("Hamster",		4.3,	"00:12:45",6),
("Igelkott",	2.3,	"00:05:02",5),
("Järv",		5.6,	"01:56:36",8),
("Kosa",		7.0,	"03:47:02",9),
("Larv",		4.9,	"10:20:00",7),
("Mus",			6.5,	"07:50:32",8),
("Narval",		5.6,	"11:32:02",8),
("Oxe",			8.1,	"18:14:52",10),
("Papegoja",	6.2,	"04:12:45",7),
("Quokka",		8.8,	"12:57:23",10),
("Räv",			7.6,	"06:19:00",10),
("Snigel",		3.4,	"01:23:45",5),
("Tiger",		4.5,	"05:43:21",9),
("Uggla",		6.5,	"04:12:48",10);


INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (1, 1,	 0.12, 0.02, 0.94);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (2, 1,	 0.13, 0.16, 0.68);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (3, 1,	 0.07, 0.12, 0.27);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (4, 1,	 0.02, 0.08, 0.27);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (5, 1,	 0.11, 0.12, 0.64);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (6, 1,	 0.15, 0.18, 0.96);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (7, 1,	 0.05, 0.11, 0.85);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (8, 1,	 0.16, 0.09, 1.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (9, 1,	 0.11, 0.1, 0.91);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (10, 1,	 0.08, 0.03, 0.79);

INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (1, 2,	 0.17, 0.16, 0.63);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (2, 2,	 0.18, 0.03, 0.46);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (3, 2,	 0.03, 0.09, 0.4);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (4, 2,	 0.16, 0.12, 0.42);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (5, 2,	 0.09, 0.1, 0.18);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (6, 2,	 0.06, 0.1, 0.39);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (7, 2,	 0.03, 0.11, 0.72);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (8, 2,	 0.04, 0.1, 1.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (9, 2,	 0.18, 0.08, 0.88);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (10, 2,	 0.06, 0.11, 0.33);

INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (1, 3, 0.06, 0.13, 0.14);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (2, 3, 0.1, 0.05, 0.91);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (3, 3, 0.07, 0.14, 0.33);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (4, 3, 0.14, 0.09, 0.67);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (5, 3, 0.02, 0.04, 0.93);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (6, 3, 0.14, 0.04, 0.48);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (7, 3, 0.14, 0.17, 0.16);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (8, 3, 0.1, 0.21, 1.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (9, 3, 0.14, 0.12, 0.67);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (10, 3, 0.09, 0.01, 0.41);

INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (1, 4, 0.16, 0.21, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (2, 4, 0.02, 0.1, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (3, 4, 0.12, 0.08, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (4, 4, 0.02, 0.06, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (5, 4, 0.18, 0.05, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (6, 4, 0.06, 0.13, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (7, 4, 0.07, 0.09, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (8, 4, 0.0, 0.1, 0.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (9, 4, 0.27, 0.06, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (10, 4, 0.09, 0.13, 0);

INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (1, 5, 0.13, 0.15, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (2, 5, 0.04, 0.05, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (3, 5, 0.13, 0.07, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (4, 5, 0.11, 0.02, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (5, 5, 0.02, 0.16, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (6, 5, 0.17, 0.11, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (7, 5, 0.09, 0.1, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (8, 5, 0, 0.1, 0.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (9, 5, 0.2, 0.13, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (10, 5, 0.12, 0.11, 0);

INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (1, 6, 0.05, 0.11, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (2, 6, 0.13, 0.07, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (3, 6, 0.04, 0.05, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (4, 6, 0.07, 0.05, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (5, 6, 0.15, 0.07, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (6, 6, 0.17, 0.22, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (7, 6, 0.13, 0.22, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (8, 6, 0.0, 0.05, 0.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (9, 6, 0.14, 0.08, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (10, 6, 0.13, 0.06, 0);

INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (1, 7, 0.14, 0.16, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (2, 7, 0.12, 0.13, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (3, 7, 0.16, 0.09, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (4, 7, 0.08, 0.17, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (5, 7, 0.08, 0.05, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (6, 7, 0.07, 0.14, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (7, 7, 0.03, 0.13, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (8, 7, 0.0, 0.08, 0.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (9, 7, 0.21, 0.02, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (10, 7, 0.11, 0.05, 0);

INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (1, 8, 0.12, 0.16, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (2, 8, 0.14, 0.19, 0.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (3, 8, 0.13, 0.07, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (4, 8, 0.05, 0.15, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (5, 8, 0.08, 0.04, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (6, 8, 0.13, 0.19, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (7, 8, 0.17, 0.08, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (8, 8, 0.0, 0.05, 0.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (9, 8, 0.1, 0.06, 0.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (10, 8, 0.09, 0.02, 0.0);

INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (1, 9, 0.02, 0.17, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (2, 9, 0.06, 0.07, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (3, 9, 0.06, 0.01, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (4, 9, 0.13, 0.08, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (5, 9, 0.17, 0.14, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (6, 9, 0.12, 0.1, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (7, 9, 0.16, 0.07, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (8, 9, 0, 0.07, 0.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (9, 9, 0.2, 0.13, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (10, 9, 0.08, 0.17, 0);

INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (1, 10, 0.09, 0.05, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (2, 10, 0.04, 0.15, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (3, 10, 0.16, 0.15, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (4, 10, 0.17, 0.1, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (5, 10, 0.11, 0.09, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (6, 10, 0.12, 0.13, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (7, 10, 0.12, 0.1, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (8, 10, 0.0, 0.03, 0.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (9, 10, 0.17, 0.03, 0.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (10, 10, 0.02, 0.17, 0.0);

INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (1, 11, 0.12, 0.05, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (2, 11, 0.13, 0.17, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (3, 11, 0.06, 0.15, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (4, 11, 0.03, 0.08, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (5, 11, 0.16, 0.04, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (6, 11, 0.05, 0.07, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (7, 11, 0.17, 0.17, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (8, 11, 0, 0.11, 0.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (9, 11, 0.27, 0.11, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (10, 11, 0.02, 0.05, 0);

INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (1, 12, 0.13, 0.13, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (2, 12, 0.17, 0.07, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (3, 12, 0.06, 0.05, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (4, 12, 0.05, 0.12, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (5, 12, 0.01, 0.15, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (6, 12, 0.03, 0.1, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (7, 12, 0.09, 0.07, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (8, 12, 0, 0.08, 0.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (9, 12, 0.36, 0.14, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (10, 12, 0.09, 0.09, 0);

INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (1, 13, 0.09, 0.14, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (2, 13, 0.11, 0.03, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (3, 13, 0.08, 0.22, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (4, 13, 0.19, 0.18, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (5, 13, 0.13, 0.02, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (6, 13, 0.07, 0.04, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (7, 13, 0.22, 0.17, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (8, 13, 0., 0.08, 0.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (9, 13, 0.04, 0.11, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (10, 13, 0.07, 0.02, 0);

INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (1, 14, 0.04, 0.06, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (2, 14, 0.1, 0.16, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (3, 14, 0.14, 0.1, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (4, 14, 0.11, 0.1, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (5, 14, 0.1, 0.19, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (6, 14, 0.1, 0.12, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (7, 14, 0.1, 0.06, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (8, 14, 0, 0.07, 0.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (9, 14, 0.25, 0.08, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (10, 14, 0.03, 0.06, 0);

INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (1, 15, 0.06, 0.15, 0.44);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (2, 15, 0.2, 0.17, 0.74);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (3, 15, 0.14, 0.12, 0.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (4, 15, 0.01, 0.08, 0.7);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (5, 15, 0.16, 0.14, 0.03);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (6, 15, 0.09, 0.03, 0.31);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (7, 15, 0.07, 0.04, 0.56);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (8, 15, 0.18, 0.03, 1.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (9, 15, 0.04, 0.21, 0.06);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (10, 15, 0.04, 0.04, 0.01);

INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (1, 16, 0.11, 0.03, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (2, 16, 0.17, 0.1, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (3, 16, 0.15, 0.07, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (4, 16, 0.13, 0.08, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (5, 16, 0.16, 0.05, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (6, 16, 0.08, 0.05, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (7, 16, 0.02, 0.22, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (8, 16, 0, 0.14, 0.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (9, 16, 0.05, 0.03, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (10, 16, 0.13, 0.23, 0);

INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (1, 17, 0.04, 0.02, 0.33);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (2, 17, 0.07, 0.02, 0.19);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (3, 17, 0.03, 0.11, 0.79);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (4, 17, 0.13, 0.18, 0.44);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (5, 17, 0.11, 0.17, 0.87);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (6, 17, 0.18, 0.04, 0.98);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (7, 17, 0.14, 0.19, 0.36);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (8, 17, 0.12, 0.02, 1.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (9, 17, 0.16, 0.09, 0.76);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (10, 17, 0.01, 0.16, 0.92);

INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (1, 18, 0.09, 0.07, 0.94);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (2, 18, 0.12, 0.11, 0.51);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (3, 18, 0.02, 0.09, 0.22);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (4, 18, 0.07, 0.07, 0.52);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (5, 18, 0.15, 0.13, 0.62);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (6, 18, 0.02, 0.12, 0.25);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (7, 18, 0.14, 0.11, 0.26);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (8, 18, 0.11, 0.12, 1.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (9, 18, 0.08, 0.07, 0.31);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (10, 18, 0.21, 0.09, 0.03);

INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (1, 19, 0.06, 0.17, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (2, 19, 0.05, 0.14, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (3, 19, 0.18, 0.06, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (4, 19, 0.02, 0.05, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (5, 19, 0.17, 0.16, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (6, 19, 0.02, 0.11, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (7, 19, 0.06, 0.05, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (8, 19, 0, 0.13, 0.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (9, 19, 0.28, 0.04, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (10, 19, 0.16, 0.1, 0);

INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (1, 20, 0.05, 0.08, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (2, 20, 0.11, 0.1, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (3, 20, 0.11, 0.1, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (4, 20, 0.02, 0.11, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (5, 20, 0.19, 0.1, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (6, 20, 0.04, 0.14, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (7, 20, 0.14, 0.07, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (8, 20, 0, 0.17, 0.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (9, 20, 0.3, 0.1, 0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (10, 20, 0.04, 0.04, 0);

INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (1, 21, 0.09, 0.11, 0.64);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (2, 21, 0.05, 0.17, 0.02);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (3, 21, 0.07, 0.03, 0.65);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (4, 21, 0.16, 0.11, 0.9);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (5, 21, 0.05, 0.03, 0.83);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (6, 21, 0.1, 0.06, 0.6);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (7, 21, 0.09, 0.05, 0.05);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (8, 21, 0.15, 0.27, 1.0);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (9, 21, 0.08, 0.08, 0.58);
INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate) VALUES (10, 21, 0.17, 0.1, 0.98);




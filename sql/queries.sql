SELECT pick_rate, win_rate FROM card WHERE card_name = "Ring of fire";

CREATE OR REPLACE VIEW player_card_above_average AS
SELECT p.player_id, p.player_name, c.card_name, u.pick_rate, u.win_rate
FROM player p
JOIN player_card_rate u ON p.player_id = u.player_id
JOIN card c ON u.card_id = c.card_id;

CREATE OR REPLACE VIEW total_number_of_winners AS
SELECT COUNT(DISTINCT p.player_id) AS total_nr_of_players, 
COUNT(DISTINCT CASE WHEN p.round_number >= 10 THEN p.player_id END) AS nr_of_player_won
FROM player p;

CREATE OR REPLACE VIEW average_difficulty_per_round AS
SELECT r.round_number,
	ROUND(SUM(s.spawnrate * 
        CASE e.enemy_difficulty
            WHEN 'easy' THEN 1
            WHEN 'medium' THEN 3
            WHEN 'hard' THEN 5
        END
    ) / SUM(s.spawnrate), 2) AS average_difficulty_numeric,
    CASE 
        WHEN ROUND(SUM(s.spawnrate * 
            CASE e.enemy_difficulty
                WHEN 'easy' THEN 1
                WHEN 'medium' THEN 3
                WHEN 'hard' THEN 5
            END
        ) / SUM(s.spawnrate)) = 1 THEN 'easy'
        WHEN ROUND(SUM(s.spawnrate * 
            CASE e.enemy_difficulty
                WHEN 'easy' THEN 1
                WHEN 'medium' THEN 3
                WHEN 'hard' THEN 5
            END
        ) / SUM(s.spawnrate)) = 2 THEN 'medium'
        ELSE 'hard'
    END AS average_difficulty_label
FROM spawnrate s
JOIN enemy e ON s.enemy_id = e.enemy_id
JOIN rounds r ON s.round_number = r.round_number
GROUP BY r.round_number
ORDER BY r.round_number;


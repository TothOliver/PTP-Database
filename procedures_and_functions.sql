
DELIMITER //
CREATE PROCEDURE add_new_player (
	IN p_name VARCHAR(45),
    IN p_avg_round INT,
    IN p_highscore INT,
    IN p_playtime TIME
)
BEGIN 
    INSERT INTO player(player_name,avg_round,play_time,round_number)
    VALUES (p_name,p_avg_round,p_playtime,p_highscore);
END;
//

CREATE PROCEDURE add_card_rates (
		IN p_player_id INT,
        IN p_card_id INT,
        IN p_pick_rate DECIMAL(3,2),
        IN p_upgrade_rate DECIMAL (3,2),
        IN p_win_rate DECIMAL (3,2)
)
BEGIN
	INSERT INTO player_card_rate (card_id, player_id, pick_rate, upgrade_rate, win_rate)
    VALUES (p_card_id, p_player_id, p_pick_rate, p_upgrade_rate, p_win_rate)
    ON DUPLICATE KEY UPDATE
		pick_rate = VALUES(pick_rate),
        upgrade_rate = VALUES(upgrade_rate),
        win_rate = VALUES(win_rate);
END;
//

DROP FUNCTION IF EXISTS get_global_pick_rate;
CREATE FUNCTION get_global_pick_rate(p_card_id INT)
RETURNS DECIMAL(5,4)
DETERMINISTIC
BEGIN
	DECLARE total_picks DECIMAL (10,2) DEFAULT 0;
    DECLARE total_rounds DECIMAL (10,2) DEFAULT 0;
    
    
	SELECT
        SUM((TIME_TO_SEC(p.play_time) / 120) * r.pick_rate),
        SUM(TIME_TO_SEC(p.play_time) / 120)
    INTO total_picks, total_rounds
    FROM player_card_rate r
    JOIN player p ON p.player_id = r.player_id
    WHERE r.card_id = p_card_id;
    
    IF total_rounds = 0 THEN 
		RETURN 0;
	ELSE 
		RETURN ROUND(total_picks / total_rounds, 2);
	END IF;
END;
//
DROP FUNCTION IF EXISTS get_global_upgrade_rate;
CREATE FUNCTION get_global_upgrade_rate (p_card_id INT)
RETURNS DECIMAL(5,4)
DETERMINISTIC
BEGIN
	DECLARE total_picks DECIMAL (10,2) DEFAULT 0;
    DECLARE total_rounds DECIMAL (10,2) DEFAULT 0;
    
    
	SELECT
        SUM((TIME_TO_SEC(p.play_time) / 240) * r.upgrade_rate),
        SUM(TIME_TO_SEC(p.play_time) / 240)
    INTO total_picks, total_rounds
    FROM player_card_rate r
    JOIN player p ON p.player_id = r.player_id
    WHERE r.card_id = p_card_id;
    
    IF total_rounds = 0 THEN 
		RETURN 0;
	ELSE 
		RETURN ROUND(total_picks / total_rounds, 4);
	END IF;
END;
//
DELIMITER ;


DROP FUNCTION IF EXISTS get_global_win_rate;
DELIMITER //

CREATE FUNCTION get_global_win_rate(p_card_id INT)
RETURNS DECIMAL(5,4)
DETERMINISTIC
BEGIN
    DECLARE total_estimated_wins DECIMAL(10,4) DEFAULT 0;
    DECLARE total_picks DECIMAL(10,4) DEFAULT 0;

    SELECT
        SUM((TIME_TO_SEC(p.play_time) / 120.0) * r.pick_rate * r.win_rate),
        SUM((TIME_TO_SEC(p.play_time) / 120.0) * r.pick_rate)
    INTO total_estimated_wins, total_picks
    FROM player_card_rate r
    JOIN player p ON p.player_id = r.player_id
    WHERE r.card_id = p_card_id;

    IF total_picks = 0 THEN
        RETURN 0;
    ELSE
        RETURN ROUND(total_estimated_wins / total_picks, 4);
    END IF;
END;
//
DELIMITER ;

-- set all player - card winrates to zero if the player has never won
UPDATE player_card_rate r
JOIN player p ON p.player_id = r.player_id
SET r.win_rate = 0
WHERE p.round_number < 10;

-- Updates the global card upgrade rate
SET SQL_SAFE_UPDATES = 0;
UPDATE card
SET upgrade_rate = get_global_upgrade_rate(card_id),
	pick_rate = get_global_pick_rate(card_id),
	win_rate = get_global_win_rate(card_id);

SET SQL_SAFE_UPDATES = 1;
SELECT card_name,pick_rate, upgrade_rate,win_rate FROM card;

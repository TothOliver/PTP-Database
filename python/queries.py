# db_queries.py
import mysql.connector

def run_query(query_num, inputs):
    """
    inputs: dictionary with needed values, e.g., {'player_id': 1, 'card_name': 'Fireball'}
    """
    try:
        conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="[password]",
            database="dv1663"
        )
        cursor = conn.cursor()
        result_text = ""

        if query_num == 1:
            cursor.execute("SELECT * FROM player;")
        elif query_num == 2:
            cursor.execute("SELECT * FROM card;")
        elif query_num == 3:
            cursor.execute("SELECT * FROM enemy;")
        elif query_num == 4:
            card_name = inputs['card_name']
            cursor.execute("""
                SELECT p.player_id, p.player_name, c.card_name, u.pick_rate, u.win_rate
                FROM player_card_above_average u
                JOIN card c ON u.card_name = c.card_name
                JOIN player p ON u.player_id = p.player_id
                WHERE u.card_name = %s
                AND u.pick_rate >= (SELECT pick_rate FROM card WHERE card_name = %s)
                AND u.win_rate >= (SELECT win_rate FROM card WHERE card_name = %s);
            """, (card_name, card_name, card_name))
        elif query_num == 5:
            cursor.execute("SELECT * FROM total_number_of_winners;")
        elif query_num == 6:
            cursor.execute("SELECT * FROM average_difficulty_per_round;")
        elif query_num == 7:
            cursor.callproc('add_new_player', (
                inputs['player_name'],
                int(inputs['avg_round']),
                int(inputs['highscore']),
                inputs['playtime']
            ))
            conn.commit()
            result_text = f"Added player {inputs['player_name']} successfully.\n"
            return result_text
        elif query_num == 8:
            cursor.callproc('add_card_rates', (
                int(inputs['player_id']),
                int(inputs['card_id']),
                float(inputs['pick_rate']),
                float(inputs['upgrade_rate']),
                float(inputs['win_rate'])
            ))
            cursor.callproc('update_card')
            conn.commit()
            result_text = "Card rates added and card updated successfully.\n"
            return result_text
        elif query_num == 9:
            cursor.execute("SELECT * FROM player_card_rate WHERE player_id = %s;", (inputs['player_id'],))

        # Process and format results
        results = cursor.fetchall()
        columns = [desc[0] for desc in cursor.description]

        result_text += " | ".join(columns) + "\n"
        result_text += "-" * 40 + "\n"
        for row in results:
            result_text += " | ".join(str(item) for item in row) + "\n"

        return result_text

    except mysql.connector.Error as err:
        return f"Database error: {err}"

    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()

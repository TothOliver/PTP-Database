import tkinter as tk
from tkinter import scrolledtext
import mysql.connector

def run_query(query_num):
    try:
        conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="[password]",
            database="dv1663"
        )
        cursor = conn.cursor()
        if query_num == 1:
            cursor.execute("""
                SELECT p.player_id, p.player_name
                FROM player p
                JOIN player_card_rate u ON p.player_id = u.player_id
                JOIN card c ON u.card_id = c.card_id
                WHERE c.card_name = 'Ring of fire'
                AND u.pick_rate > c.pick_rate
                AND u.win_rate > c.win_rate;""")
        elif query_num == 2:
             cursor.execute("""
                SELECT r.round_number,
                ROUND(SUM(s.spawnrate * 
                    CASE e.enemy_difficulty
                        WHEN 'easy' THEN 1
                        WHEN 'medium' THEN 2
                        WHEN 'hard' THEN 3
                    END
                ) / SUM(s.spawnrate), 2) AS average_difficulty_numeric,
                CASE 
                    WHEN ROUND(SUM(s.spawnrate * 
                        CASE e.enemy_difficulty
                            WHEN 'easy' THEN 1
                            WHEN 'medium' THEN 2
                            WHEN 'hard' THEN 3
                        END
                    ) / SUM(s.spawnrate)) = 1 THEN 'easy'
                    WHEN ROUND(SUM(s.spawnrate * 
                        CASE e.enemy_difficulty
                            WHEN 'easy' THEN 1
                            WHEN 'medium' THEN 2
                            WHEN 'hard' THEN 3
                        END
                    ) / SUM(s.spawnrate)) = 2 THEN 'medium'
                    ELSE 'hard'
                END AS average_difficulty_label
            FROM spawnrate s
            JOIN enemy e ON s.enemy_id = e.enemy_id
            JOIN rounds r ON s.round_number = r.round_number
            GROUP BY r.round_number
            ORDER BY r.round_number;""")

        results = cursor.fetchall()
        columns = [desc[0] for desc in cursor.description]

        output.delete(1.0, tk.END)
        output.insert(tk.END, " | ".join(columns) + "\n")
        output.insert(tk.END, "-" * 40 + "\n")
        for row in results:
            output.insert(tk.END, " | ".join(str(item) for item in row) + "\n")

    except mysql.connector.Error as err:
        output.delete(1.0, tk.END)
        output.insert(tk.END, f"Database error: {err}")

    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()

window = tk.Tk()
window.title("Window")

query_button = tk.Button(window, text="Show Ring of Fire players", command=lambda: run_query(1))
query_button.pack(pady=10)

query_button2 = tk.Button(window, text="Get average difficutly per Round", command=lambda: run_query(2))
query_button2.pack(pady=10)

output = scrolledtext.ScrolledText(window, width=80, height=20)
output.pack()

window.mainloop()
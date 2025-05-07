import tkinter as tk
from tkinter import scrolledtext
import mysql.connector

def run_query(query_num, card_name=None):
    try:
        conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="[password]",
            database="dv1663"
        )
        cursor = conn.cursor()
        if query_num == 1:
            cursor.execute("SELECT * FROM player;")
        elif query_num == 2:
            cursor.execute("SELECT * FROM card")
        elif query_num == 3:
            cursor.execute("SELECT * FROM enemy;")
        elif query_num == 4:
           cursor.execute("""
                SELECT p.player_id, p.player_name, c.card_name, u.pick_rate, u.win_rate
                FROM player_card_above_average u
                JOIN card c ON u.card_name = c.card_name
                JOIN player p ON u.player_id = p.player_id
                WHERE u.card_name = %s
                AND u.pick_rate >= (SELECT pick_rate FROM card WHERE card_name = %s)
                AND u.win_rate >= (SELECT win_rate FROM card WHERE card_name = %s);""", 
                (card_name, card_name, card_name))
        elif query_num == 5:
            cursor.execute("SELECT * FROM total_number_of_winners;")
        elif query_num == 6:
            cursor.execute("SELECT * FROM average_difficulty_per_round;")
        elif query_num == 7:
            cursor.callproc('add_new_player', ('Whale', 5, 10, '08:30:00'))

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

query_button = tk.Button(window, text="Show all players", command=lambda: run_query(1))
query_button.pack(pady=10)

query_button = tk.Button(window, text="Show all cards", command=lambda: run_query(2))
query_button.pack(pady=10)

query_button = tk.Button(window, text="Show enemy types", command=lambda: run_query(3))
query_button.pack(pady=10)

card_entry = tk.Entry(window)
card_entry.pack(pady=5)

query_button = tk.Button(window, text="Show Players that are good with a card", command=lambda: run_query(4, card_entry.get()))
query_button.pack(pady=10)

query_button2 = tk.Button(window, text="Total Number of Winners", command=lambda: run_query(5))
query_button2.pack(pady=10)

query_button2 = tk.Button(window, text="Get average difficutly per Round", command=lambda: run_query(6))
query_button2.pack(pady=10)

query_button2 = tk.Button(window, text="Add player", command=lambda: run_query(7))
query_button2.pack(pady=10)

output = scrolledtext.ScrolledText(window, width=80, height=20)
output.pack()

window.mainloop()
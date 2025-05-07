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
            card_name = card_name_entry.get()
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
            player_name = name_entry.get()
            avg_round = int(avg_round_entry.get())
            highscore = int(highscore_entry.get())
            playtime = playtime_entry.get()

            cursor.callproc('add_new_player', (player_name, avg_round, highscore, playtime))
            conn.commit()

            output.delete(1.0, tk.END)
            output.insert(tk.END, f"Added player {player_name} successfully.\n")

        elif query_num == 8:
            player_id = int(player_id_entry.get())
            card_id = int(card_id_entry.get())
            pick_rate = float(pick_rate_entry.get())
            upgrade_rate = float(upgrade_rate_entry.get())
            win_rate = float(win_rate_entry.get())

            cursor.callproc('add_card_rates', (player_id, card_id, pick_rate, upgrade_rate, win_rate))
            conn.commit()
            cursor.execute('SELECT update_card();')

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

# Button Section (left column)
query_button1 = tk.Button(window, text="Show all players", command=lambda: run_query(1), borderwidth=1)
query_button1.grid(row=0, column=0, padx=10, pady=5, ipadx=0, ipady=0, sticky='w')

query_button2 = tk.Button(window, text="Show all cards", command=lambda: run_query(2))
query_button2.grid(row=0, column=1, padx=10, pady=5, ipadx=0, ipady=0, sticky='w')

query_button3 = tk.Button(window, text="Show enemy types", command=lambda: run_query(3))
query_button3.grid(row=0, column=2, padx=10, pady=5, ipadx=0, ipady=0, sticky='w')


query_button4 = tk.Button(window, text="Show Players good with a card", command=lambda: run_query(4))
query_button4.grid(row=3, column=0, padx=10, pady=5, sticky='w')

card_name_label = tk.Label(window, text="Player Name:")
card_name_label.grid(row=4, column=0, sticky='w', padx=10)
card_name_entry = tk.Entry(window)
card_name_entry.grid(row=4, column=1, padx=10)

# More Query Buttons
query_button5 = tk.Button(window, text="Total Number of Winners", command=lambda: run_query(5))
query_button5.grid(row=5, column=0, padx=10, pady=5, sticky='w')

query_button6 = tk.Button(window, text="Get average difficulty per Round", command=lambda: run_query(6))
query_button6.grid(row=6, column=0, padx=10, pady=5, sticky='w')

query_button7 = tk.Button(window, text="Add player", command=lambda: run_query(7))
query_button7.grid(row=7, column=0, padx=10, pady=5, sticky='w')

# Player Details Entries
name_label = tk.Label(window, text="Player Name:")
name_label.grid(row=8, column=0, sticky='w', padx=10)
name_entry = tk.Entry(window)
name_entry.grid(row=8, column=1, padx=10)

avg_round_label = tk.Label(window, text="Average Round:")
avg_round_label.grid(row=9, column=0, sticky='w', padx=10)
avg_round_entry = tk.Entry(window)
avg_round_entry.grid(row=9, column=1, padx=10)

highscore_label = tk.Label(window, text="Highscore:")
highscore_label.grid(row=10, column=0, sticky='w', padx=10)
highscore_entry = tk.Entry(window)
highscore_entry.grid(row=10, column=1, padx=10)

playtime_label = tk.Label(window, text="Playtime (HH:MM:SS):")
playtime_label.grid(row=11, column=0, sticky='w', padx=10)
playtime_entry = tk.Entry(window)
playtime_entry.grid(row=11, column=1, padx=10)

# Add card rates button
query_button8 = tk.Button(window, text="Add card rates to player", command=lambda: run_query(8))
query_button8.grid(row=12, column=0, padx=10, pady=5, sticky='w')

# Card rate entries
player_id_label = tk.Label(window, text="Player ID:")
player_id_label.grid(row=13, column=0, sticky='w', padx=10)
player_id_entry = tk.Entry(window)
player_id_entry.grid(row=13, column=1, padx=10)

card_id_label = tk.Label(window, text="Card ID:")
card_id_label.grid(row=14, column=0, sticky='w', padx=10)
card_id_entry = tk.Entry(window)
card_id_entry.grid(row=14, column=1, padx=10)

pick_rate_label = tk.Label(window, text="Pick Rate (0–1):")
pick_rate_label.grid(row=15, column=0, sticky='w', padx=10)
pick_rate_entry = tk.Entry(window)
pick_rate_entry.grid(row=15, column=1, padx=10)

upgrade_rate_label = tk.Label(window, text="Upgrade Rate (0–1):")
upgrade_rate_label.grid(row=16, column=0, sticky='w', padx=10)
upgrade_rate_entry = tk.Entry(window)
upgrade_rate_entry.grid(row=16, column=1, padx=10)

win_rate_label = tk.Label(window, text="Win Rate (0–1):")
win_rate_label.grid(row=17, column=0, sticky='w', padx=10)
win_rate_entry = tk.Entry(window)
win_rate_entry.grid(row=17, column=1, padx=10)

# ScrolledText Output (span two columns)
output = scrolledtext.ScrolledText(window, width=80, height=20)
output.grid(row=18, column=0, columnspan=2, padx=10, pady=10)

window.mainloop()

import tkinter as tk
from tkinter import scrolledtext
import queries

def run_query_wrapper(query_num):
    inputs = {}
    if query_num == 4:
        inputs['card_name'] = card_name_entry.get()
    elif query_num == 7:
        inputs['player_name'] = name_entry.get()
        inputs['avg_round'] = avg_round_entry.get()
        inputs['highscore'] = highscore_entry.get()
        inputs['playtime'] = playtime_entry.get()
    elif query_num == 8:
        inputs['player_id'] = player_id_entry.get()
        inputs['card_id'] = card_id_entry.get()
        inputs['pick_rate'] = pick_rate_entry.get()
        inputs['upgrade_rate'] = upgrade_rate_entry.get()
        inputs['win_rate'] = win_rate_entry.get()
    elif query_num == 9:
        inputs['player_id'] = player1_id_entry.get()

    result = queries.run_query(query_num, inputs)
    output.delete(1.0, tk.END)
    output.insert(tk.END, result)

window = tk.Tk()
window.title("Window")

# Button Section (left column)
query_button1 = tk.Button(window, text="Show all players", command=lambda: run_query_wrapper(1), borderwidth=1)
query_button1.grid(row=0, column=0, padx=10, pady=5, ipadx=0, ipady=0, sticky='w')

query_button2 = tk.Button(window, text="Show all cards", command=lambda: run_query_wrapper(2))
query_button2.grid(row=0, column=1, padx=10, pady=5, ipadx=0, ipady=0, sticky='w')

query_button3 = tk.Button(window, text="Show enemy types", command=lambda: run_query_wrapper(3))
query_button3.grid(row=0, column=2, padx=10, pady=5, ipadx=0, ipady=0, sticky='w')

query_button3 = tk.Button(window, text="Show player card rates", command=lambda: run_query_wrapper(9))
query_button3.grid(row=1, column=0, padx=10, pady=5, ipadx=0, ipady=0, sticky='w')

player1_id_label = tk.Label(window, text="Player ID:")
player1_id_label.grid(row=2, column=0, sticky='w', padx=10)
player1_id_entry = tk.Entry(window)
player1_id_entry.grid(row=2, column=1, padx=10)

query_button4 = tk.Button(window, text="Show Players good with a card", command=lambda: run_query_wrapper(4))
query_button4.grid(row=3, column=0, padx=10, pady=5, sticky='w')

card_name_label = tk.Label(window, text="Card Name:")
card_name_label.grid(row=4, column=0, sticky='w', padx=10)
card_name_entry = tk.Entry(window)
card_name_entry.grid(row=4, column=1, padx=10)

# More Query Buttons
query_button5 = tk.Button(window, text="Total Number of Winners", command=lambda: run_query_wrapper(5))
query_button5.grid(row=5, column=0, padx=10, pady=5, sticky='w')

query_button6 = tk.Button(window, text="Get average difficulty per Round", command=lambda: run_query_wrapper(6))
query_button6.grid(row=6, column=0, padx=10, pady=5, sticky='w')

query_button7 = tk.Button(window, text="Add player", command=lambda: run_query_wrapper(7))
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
query_button8 = tk.Button(window, text="Add card rates to player", command=lambda: run_query_wrapper(8))
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

if __name__ == "__main__":
    window.mainloop()
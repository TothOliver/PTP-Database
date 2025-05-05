import tkinter as tk
from tkinter import scrolledtext
import mysql.connector

def run_query():
    try:
        conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="[password]",
            database="dv1663"
        )
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM card")
        results = cursor.fetchall()
        columns = [desc[0] for desc in cursor.description]

        output.delete(1.0, tk.END)  # Clear previous text
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

query_button = tk.Button(window, text="Show Expensive Black Cars", command=run_query)
query_button.pack(pady=10)

output = scrolledtext.ScrolledText(window, width=80, height=20)
output.pack()

window.mainloop()

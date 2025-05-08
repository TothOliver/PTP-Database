# PTP-Database

This project is a local MySQL database paired with a Python script ('app_gui.py') that provides a graphical interface (using Tkinter) to interact with the database.

The system uses the 'mysql-connector-python' library to handle database connections between the Python program and the MySQL server.

---

## Requirements

- Python 3.x
- 'mysql-connector-python' package (install via 'pip install mysql-connector-python')
- A running **local MySQL server** with:
  - Host: "localhost"
  - Username: "root" (or your configured MySQL user)
  - Password: your local MySQL password
  - Database: a database named "dv1663" (you can change this in the script if using another name)

---

## Setup

In the Python script, the connection to the database is configured like this:

```python
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="[your-password-here]",
    database="dv1663"
)

## Database Setup

To make sure the program works, you **must** prepare the MySQL database by running the provided '.sql' files in the correct order.

### 📦 SQL Files

| File              		| Purpose
| 'project_tables.sql' 		| Defines the database schema: tables, columns, types, primary/foreign keys
| 'queries.sql'   		| Inserts queries
| 'procedures_and_functions.sql' | Inserts procedures and functions



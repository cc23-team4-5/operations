import pandas as pd
import pymssql
import os

CC23_DB_PASSWORD = os.getenv('CC23_DB_PASSWORD')

# Connect to SQL Server
conn = pymssql.connect(server='cc23-team4-5-mssql-server.database.windows.net', user='dbAdmin@cc23-team4-5-mssql-server', password=CC23_DB_PASSWORD, database='cc23-team4-5-mssql-database')
cursor = conn.cursor()

# Create Users Table
cursor.execute('''
		CREATE TABLE users (
			user_id int,
			task_ids VARCHAR(100),
			info_ids VARCHAR(100),
            PRIMARY KEY(user_id)
			)
               ''')
conn.commit()

# Create Task Desriptions Table
cursor.execute('''
		CREATE TABLE task_descriptions (
            task_id int,
            user_id int,
			task_description VARCHAR(800),
            PRIMARY KEY(task_id)
			)
               ''')
conn.commit()

# Create Additional Info Table
cursor.execute('''
		CREATE TABLE additional_info (
			info_id int,
            user_id int,
			additional_info VARCHAR(800),
            PRIMARY KEY(info_id)
			)
               ''')
conn.commit()

# Create User Answer Table
cursor.execute('''
		CREATE TABLE user_answers (
			answer_id int IDENTITY(1,1),
            user_id int,
            task_id int,
			user_answer VARCHAR(800),
            PRIMARY KEY(answer_id)
			)
               ''')
conn.commit()
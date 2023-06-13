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
            task_id VARCHAR(20),
            text_id int,
			questionare_url VARCHAR(100),
            revoke_consent_code VARCHAR(30),
            consent_given int,
            PRIMARY KEY(user_id)
			)
               ''')
conn.commit()

# # Create Texts table
# cursor.execute('''
# 		CREATE TABLE texts (
#             text_id int,
# 			original_text textlarge,
#             PRIMARY KEY(text_id)
# 			)
#                ''')
# conn.commit()

# Create Key-Features Table
cursor.execute('''
		CREATE TABLE key_features (
			kf_id int NOT NULL IDENTITY,
            text_id int,
            user_id int,
			key_features VARCHAR(MAX),
            PRIMARY KEY(kf_id)
			)
               ''')
conn.commit()

# Create Summary Table
cursor.execute('''
		CREATE TABLE summaries (
			summary_id int IDENTITY(1,1),
            text_id int,
            user_id int,
            kf_id int,
            summary VARCHAR(MAX),
            PRIMARY KEY(summary_id)
			)
               ''')
conn.commit()

# Create Validation Table
cursor.execute('''
		CREATE TABLE validations (
			validation_id int IDENTITY(1,1),
            text_id int,
            kf_id int,
            summary_id int,
            user_id int,
            validation VARCHAR(MAX),
            PRIMARY KEY(summary_id)
			)
               ''')
conn.commit()
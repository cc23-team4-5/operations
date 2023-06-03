import pandas as pd
import pymssql
import os

CC23_DB_PASSWORD = os.getenv('CC23_DB_PASSWORD')

# Connect to SQL Server
conn = pymssql.connect(server='cc23-team4-5-mssql-server.database.windows.net', user='dbAdmin@cc23-team4-5-mssql-server', password=CC23_DB_PASSWORD, database='cc23-team4-5-mssql-database')
cursor = conn.cursor()

# Insert Users to Table
user_data = pd.read_csv ('<FILEPATH>', delimiter=';')   
user_df = pd.DataFrame(user_data)
for row in user_df.itertuples():
    print(row)
    print('-' * 50)
    cursor.execute("INSERT INTO users (user_id, questionare_url) VALUES (%s, %s)",
                    (row.user_id, row.questionare_url)
            )

conn.commit()

# Insert Task Descriptions to Table
path = "<FILEPATH>"
task_df = pd.DataFrame(pd.read_csv(path, delimiter=';'))
user_counter = 1
while user_counter < 20:
    for row in task_df.itertuples():
        print(row)
        print('-' * 100)
        
        cursor.execute("INSERT INTO task_descriptions (task_id, user_id, task_description) VALUES (%s, %s, %s)",
                        (row.task_id, user_counter, row.task_description)
                    )
        if row.task_id % 3 == 0:
            user_counter += 1

    conn.commit()


# Insert Additional Info to Table
path = "<FILEPATH>"
info_df = pd.DataFrame(pd.read_csv(path, delimiter=';'))
user_counter = 1
while user_counter < 20:
    for row in info_df.itertuples():
        print(row)
        print('-' * 100)
        
        cursor.execute("INSERT INTO additional_info (info_id, user_id, additional_info) VALUES (%s, %s, %s)",
                        (row.info_id, user_counter, row.info_description)
                    )
        if row.info_id % 3 == 0:
            user_counter += 1
            
    conn.commit()
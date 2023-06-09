import pandas as pd
import pymssql
import os


CC23_DB_PASSWORD = os.getenv('CC23_DB_PASSWORD')


# Connect to SQL Server
conn = pymssql.connect(server='cc23-team4-5-mssql-server.database.windows.net', user='dbAdmin@cc23-team4-5-mssql-server', password=CC23_DB_PASSWORD, database='cc23-team4-5-mssql-database')
cursor = conn.cursor()


# Insert Users into Table
user_data = pd.read_csv ('C:/dev/CC23/operations/scripts/database/users.csv', delimiter=';')   
user_df = pd.DataFrame(user_data)
for row in user_df.itertuples():
    print('User: ', row.user_id)
    cursor.execute("INSERT INTO users (user_id, task_id, text_id, questionare_url, revoke_consent_code) VALUES (%s, %s, %s, %s, %s)",
                    (row.user_id, row.task_id, row.text_id, row.questionare_url, row.revoke_consent_code)
            )

conn.commit()

# Insert Key Features into Table
path = "C:/dev/CC23/operations/scripts/database/data/key_features.csv"
task_df = pd.DataFrame(pd.read_csv(path, delimiter=';'))
for row in task_df.itertuples():
    print('Features: ', row.kf_id)
    
    cursor.execute("INSERT INTO key_features (text_id, user_id, key_features) VALUES (%s, %s, %s)",
                    (row.text_id, row.user_id, row.key_features)
                )

conn.commit()


# Insert Summaries into Table
path = "C:/dev/CC23/operations/scripts/database/data/summaries.csv"
info_df = pd.DataFrame(pd.read_csv(path, delimiter=';'))
for row in info_df.itertuples():
    print('Summary: ', row.summary_id)
    
    cursor.execute("INSERT INTO summaries (text_id, user_id, kf_id, summary) VALUES (%s, %s, %s, %s)",
                    (row.text_id, row.user_id, row.kf_id, row.summary)
                )
        
conn.commit()
import pandas as pd
import pymssql
import os 

CC23_DB_PASSWORD = os.getenv('CC23_DB_PASSWORD')

# Connect to SQL Server
conn = pymssql.connect(server='cc23-team4-5-mssql-server.database.windows.net', user='dbAdmin@cc23-team4-5-mssql-server', password=CC23_DB_PASSWORD, database='cc23-team4-5-mssql-database')
cursor = conn.cursor()

# Delete Users Table
cursor.execute('DROP TABLE [dbo].[users]')
conn.commit()

# Delete Task Desriptions Table
cursor.execute('DROP TABLE [dbo].[task_descriptions]')
conn.commit()

# Delete Additional Info Table
cursor.execute('DROP TABLE [dbo].[additional_info]')
conn.commit()

# Delete User Answers Table
cursor.execute('DROP TABLE [dbo].[user_answers]')
conn.commit()
import pandas as pd
import pymssql
import os 

CC23_DB_PASSWORD = os.getenv('CC23_DB_PASSWORD')

# Connect to SQL Server
conn = pymssql.connect(server='cc23-team4-5-mssql-server.database.windows.net', user='dbAdmin@cc23-team4-5-mssql-server', password=CC23_DB_PASSWORD, database='cc23-team4-5-mssql-database')
cursor = conn.cursor()

# # Delete Users Table
cursor.execute('DROP TABLE [dbo].[users]')
conn.commit()

# # Delete Task Desriptions Table
# cursor.execute('DROP TABLE [dbo].[texts]')
# conn.commit()

# # Delete Additional Info Table
cursor.execute('DROP TABLE [dbo].[key_features]')
conn.commit()

# Delete User Answers Table
cursor.execute('DROP TABLE [dbo].[summaries]')
conn.commit()

# Delete Validations Table
cursor.execute('DROP TABLE [dbo].[validations]')
conn.commit()
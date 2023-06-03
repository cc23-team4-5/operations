# Database Operations
## Setup
**Windows**: 

``` pip install -r .\scripts\requirements.txt ```

Set env variables with database credentials: 
- ``` $env:CC23_DB_USERNAME='<username>' ```
- ``` $env:CC23_DB_PASSWORD='<password>' ```
## Database Commands
### Delete Tables
- ``` python .\scripts\database\delete_tables.py ```
### Create Tables
- ``` python .\scripts\database\create_tables.py ```
### Delete Tables
- ``` python .\scripts\database\import_data.py ```

# Terraform
The ./terraform directory contains IaC for Azure resources on which the project is deployed. 
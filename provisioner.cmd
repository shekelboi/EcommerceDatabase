psql -U postgres -f "sql_scripts/User and DB Creation.sql"
psql -U shopadmin -d ecommerce -f "sql_scripts/Table Creation.sql" -f "sql_scripts/Functions.sql" -f "sql_scripts/Generated.sql"
python "provisioner.py"
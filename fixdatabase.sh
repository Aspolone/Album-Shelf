echo elimina database esistente per riscrivere quello dentro il file schema

sudo mariadb -u root -p -e "DROP DATABASE IF EXISTS albumshelf_db;"

sudo mariadb -u root -p < db/schema.sql

echo caricamento popolamento

sudo mariadb -u root -p < db/popolamento_schema.sql

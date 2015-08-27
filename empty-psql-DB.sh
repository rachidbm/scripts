
[ "$1" == "" ] && echo -e "Provide the Database name and optional username" &&  exit;
uname=$1

if [ "$2" != "" ]; then
 uname=$2
fi

echo user/password/database : $uname;
sudo -u postgres psql $1 -c "DROP SCHEMA IF EXISTS public CASCADE;";
sudo -u postgres psql $1 -c "CREATE SCHEMA IF NOT EXISTS public AUTHORIZATION \"$1\";";
#sudo -u postgres psql $1 -c "ALTER SCHEMA public OWNER TO \"$1\";";

sudo -u postgres psql -c "DROP DATABASE \"$1\""
sudo -u postgres psql -c "CREATE DATABASE \"$1\" OWNER \"$uname\";"

echo user: $uname;
#psql -U$uname -t -d $1 -hlocalhost -c "SELECT 'DROP TABLE ' || n.nspname || '.' || c.relname || ' CASCADE;' FROM pg_catalog.pg_class AS c LEFT JOIN pg_catalog.pg_namespace AS n ON n.oid = c.relnamespace WHERE relkind = 'r' AND n.nspname NOT IN ('pg_catalog', 'pg_toast') AND pg_catalog.pg_table_is_visible(c.oid)" > droptables.sql
#
#echo " To drop all tables execute:"
#echo "psql -q -U$uname -d $1 -hlocalhost -f droptables.sql";


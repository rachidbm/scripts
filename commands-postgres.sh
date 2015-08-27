--SHOW DATABASES
SELECT * FROM pg_database;

CREATE USER dotcms WITH PASSWORD 'dotcms8';
CREATE DATABASE dotcms OWNER dotcms;

# Change password
sudo -u postgres psql postgres
\password postgres
(here you set up your password and exit)

# Create DB
sudo -u postgres createdb ul10nstats


## DB export
pg_dump -U USERNAME > dump.sql

## DB import
psql -q -U USERNAME -hlocalhost DBNAME < dump.sql


# function to drop all sequences

create or replace function drop_all_sequences() returns integer as '
declare
 rec record;
begin
 for rec in select relname as seqname
   from pg_class where relkind=''S''
 loop
   execute ''drop sequence '' || rec.seqname;
 end loop;
 return 1;
end;
' language 'plpgsql';

To activate language: createlang -p5433 -Usiab -d siab-indigo plpgsql
EXECUTE PROCEDURE drop_all_sequences() 
SELECT drop_all_sequences() 



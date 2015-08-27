-- sets permission for all blob to OWNER
do $$
declare r record;
begin
for r in select loid from pg_catalog.pg_largeobject loop
execute 'ALTER LARGE OBJECT ' || r.loid || ' OWNER TO wbcbackendservice';
end loop;
end$$;
CLOSE ALL;

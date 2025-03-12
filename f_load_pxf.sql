CREATE OR REPLACE FUNCTION std9_21_project.f_load_pxf(p_table text, p_source text)
	RETURNS void
	LANGUAGE plpgsql
	VOLATILE
AS $$

DECLARE
	ext_table_name text;
	sql_script text;
	pxf text;

BEGIN
	ext_table_name = p_table||'_ext';
	EXECUTE 'TRUNCATE TABLE '||p_table;
	EXECUTE 'DROP EXTERNAL TABLE IF EXISTS '||ext_table_name;
	pxf = 'pxf://'||p_source||'?PROFILE=Jdbc&JDBC_DRIVER=org.postgresql.Driver&DB_URL=jdbc:postgresql://192.168.214.212:5432/postgres&USER=intern&PASS=intern';
	sql_script = 'CREATE EXTERNAL TABLE '||ext_table_name||' (LIKE '||p_table||')
				LOCATION ('''||pxf||''')
				FORMAT ''CUSTOM'' (FORMATTER=''pxfwritable_import'');';

	EXECUTE sql_script;
	EXECUTE 'INSERT INTO '||p_table||' SELECT * FROM '||ext_table_name;

END;

$$
EXECUTE ON ANY;
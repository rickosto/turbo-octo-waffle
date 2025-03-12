CREATE OR REPLACE FUNCTION std9_21_project.f_report_total_with_dates_day(p_day varchar)
	RETURNS void
	LANGUAGE plpgsql
	VOLATILE
AS $$

DECLARE
	table_name text;
	sql_script text;

BEGIN
	table_name = 'std9_21_project.report_total_with_dates_' ||p_day;
	sql_script = 'DROP TABLE IF EXISTS '||table_name||' CASCADE;
	CREATE TABLE '||table_name||'
	WITH (appendoptimized = true, orientation = row, compresstype = zstd, compresslevel = 1) AS
	SELECT plant "Магазин", SUM(oborot) "Оборот", SUM(product_cnt) "Кол-во проданных товаров", SUM(check_cnt) "Количество чеков",
SUM(traffic_sum) "Трафик", SUM(prod_disc_cnt) "Кол-во товаров по акции",
ROUND((SUM(prod_disc_cnt::numeric) / SUM(product_cnt::numeric))*100, 1) "Доля товаров со скидкой",
ROUND((SUM(product_cnt::numeric) / SUM(check_cnt::numeric)), 2)"Среднее количество товаров в чеке",
ROUND((SUM(check_cnt::numeric) / SUM(traffic_sum::numeric))*100, 2) "Коэффициент конверсии магазина, %",
ROUND((SUM(oborot::numeric) / SUM(check_cnt::numeric)), 1) "Средний чек, руб",
ROUND((SUM(oborot::numeric) / SUM(traffic_sum::numeric)), 1) "Ср. выручка на 1 посетителя, руб"
FROM std9_21_project.bills_with_dates
LEFT JOIN std9_21_project.bills_with_dates_cnt_check USING (plant, day)
RIGHT JOIN std9_21_project.traffic_with_dates USING (plant, day)
LEFT JOIN std9_21_project.coupons_with_dates_cnt_prod_disc USING (plant, day)
WHERE DATE_TRUNC(''day'', std9_21_project.bills_with_dates.day) = DATE_TRUNC(''day'', to_date('''||p_day||''',''YYYYMMDD''))
GROUP BY 1
DISTRIBUTED BY ("Магазин");';

EXECUTE sql_script;
	
END;

$$
EXECUTE ON ANY;
CREATE OR REPLACE FUNCTION std9_21_project.f_report_total()
	RETURNS void
	LANGUAGE plpgsql
	VOLATILE
AS $$

DECLARE
	table_name text;
	sql_script text;
BEGIN
	table_name = 'std9_21_project.report_total';
	EXECUTE 'TRUNCATE TABLE '||table_name;
	sql_script =  'INSERT INTO std9_21_project.report_total
SELECT plant, txt, obr, coupons_dcnt, obr - coupons_dcnt as obr_with_disc, product_cnt, check_cnt,
traffic_sum, prod_promo_cnt, prod_promo_per,
round(product_cnt / check_cnt::numeric(5,2), 2) AS product_cnt_avg,
round(check_cnt::numeric(5,2) / traffic_sum * 100, 2) AS coef_conv,
round(obr / check_cnt::numeric(5,2), 1) AS check_avg, person_avr
FROM std9_21_project.stores
JOIN std9_21_project.zok USING (plant)
JOIN std9_21_project.cnt_check USING (plant)
JOIN std9_21_project.sum_traffic USING (plant)
JOIN std9_21_project.cnt_prod_promo USING (plant)
JOIN std9_21_project.per_prod_promo USING (plant)
JOIN std9_21_project.avr_person USING (plant)
JOIN std9_21_project.dcnt_coupons USING (plant)
ORDER BY 1';
	EXECUTE sql_script;
END;

$$
EXECUTE ON ANY;

CREATE OR REPLACE VIEW std9_21_project.v_mart AS

SELECT plant, SUM(obr), SUM(coupons_dcnt)
--obr - coupons_dcnt as obr_with_disc, product_cnt, check_cnt, traffic_sum, prod_promo_cnt,
--prod_promo_per,
--round(SUM(product_cnt) / SUM(check_cnt)::numeric(5,2),2) AS product_cnt_avg,
--round((SUM(check_cnt)::numeric(5,2) / SUM(traffic_sum)) * 100,2) AS coef_conv,
--round(SUM(obr) / SUM(check_cnt)::numeric(5,2),1) AS check_avg,
--person_avr
FROM std9_21_project.zok
JOIN std9_21_project.cnt_check USING (plant, calday)
JOIN std9_21_project.sum_traffic USING (plant, calday)
JOIN std9_21_project.cnt_prod_promo USING (plant, calday)
JOIN std9_21_project.per_prod_promo USING (plant)
JOIN std9_21_project.avr_person USING (plant)
JOIN std9_21_project.dcnt_coupons USING (plant)
GROUP BY 1
ORDER BY 1
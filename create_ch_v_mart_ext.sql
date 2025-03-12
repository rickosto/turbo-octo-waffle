CREATE TABLE std9_21_project.ch_v_mart_ext
(

    `plant` String,
    `txt` String,
    `obr` Int32,
    `coupons_dcnt` Float32,
    `obr_with_disc` Float32,
    `product_cnt` Int32,
    `check_cnt` Int32,
    `traffic_sum` Int32,
    `prod_promo_cnt` Int32,
    `prod_promo_per` Float32,
    `product_cnt_avg` Float32,
    `coef_conv` Float32,
    `check_avg` Float32,
    `person_avr` Float32
)
ENGINE = PostgreSQL('192.168.214.203:5432', 'adb', 'v_mart', 'std9_21', '27Z3NZcA6qtfqq', 'std9_21_project')
COMMENT 'From GP to CH';
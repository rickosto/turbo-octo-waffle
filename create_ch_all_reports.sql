CREATE TABLE std9_21_project.ch_v_report_total
(
    `Магазин` String,
    `Текст` String,
    `Оборот` Int32,
    `Скидки по купонам` Float32,
    `Оборот с учетом скидки` Float32,
    `Кол-во проданных товаров` Int32,
    `Количество чеков` Int32,
    `Трафик` Int32,
    `Кол-во товаров по акции` Int32,
    `Доля товаров со скидкой` Float32,
    `Среднее количество товаров в чеке` Float32,
    `Коэффициент конверсии магазина, %` Float32,
    `Средний чек, руб` Float32,
    `Ср. выручка на 1 посетителя, руб` Float32
)
ENGINE = PostgreSQL('192.168.214.203:5432', 'adb', 'v_report_total', 'std9_21', '27Z3NZcA6qtfqq', 'std9_21_project')
COMMENT 'From GP to CH - ch_v_report_total';

CREATE TABLE std9_21_project.ch_v_report_total_with_dates_202101
(
    `Магазин` String,
    `Оборот` Int32,
    `Кол-во проданных товаров` Int32,
    `Количество чеков` Int32,
    `Трафик` Int32,
    `Кол-во товаров по акции` Int32,
    `Доля товаров со скидкой` Float32,
    `Среднее количество товаров в чеке` Float32,
    `Коэффициент конверсии магазина, %` Float32,
    `Средний чек, руб` Float32,
    `Ср. выручка на 1 посетителя, руб` Float32
)
ENGINE = PostgreSQL('192.168.214.203:5432', 'adb', 'v_report_total_with_dates_202101', 'std9_21', '27Z3NZcA6qtfqq', 'std9_21_project')
COMMENT 'From GP to CH - ch_v_report_total_with_dates_202101';

CREATE TABLE std9_21_project.ch_v_report_total_with_dates_20210103
(
    `Магазин` String,
    `Оборот` Int32,
    `Кол-во проданных товаров` Int32,
    `Количество чеков` Int32,
    `Трафик` Int32,
    `Кол-во товаров по акции` Int32,
    `Доля товаров со скидкой` Float32,
    `Среднее количество товаров в чеке` Float32,
    `Коэффициент конверсии магазина, %` Float32,
    `Средний чек, руб` Float32,
    `Ср. выручка на 1 посетителя, руб` Float32
)
ENGINE = PostgreSQL('192.168.214.203:5432', 'adb', 'v_report_total_with_dates_20210103', 'std9_21', '27Z3NZcA6qtfqq', 'std9_21_project')
COMMENT 'From GP to CH - ch_v_report_total_with_dates_20210103';
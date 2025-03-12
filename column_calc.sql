--WHERE calday < '2021-02-01'
--Расчет каждого столбца
--Оборот
SELECT plant, SUM(rpa_sat)
FROM std9_21_project.bills
GROUP BY 1
ORDER BY 1

--Скидки по купонам

--Оборот с учетом скидки
-- Оборот - Скидки по купонам
SELECT plant, SUM(rpa_sat)
FROM std9_21_project.bills
GROUP BY 1
ORDER BY 1

--Кол-во проданных товаров
SELECT plant, SUM(qty)
FROM std9_21_project.bills
GROUP BY 1
ORDER BY 1

--Кол-во чеков
WITH t1 AS (SELECT DISTINCT plant, billnum, COUNT(billnum) OVER(PARTITION BY billnum) AS count_check
FROM std9_21_project.bills
ORDER BY plant)

SELECT plant, COUNT(count_check)
FROM t1
GROUP BY 1

--Трафик
SELECT plant, SUM(quantity)
FROM std9_21_project.traffic
GROUP BY 1
ORDER BY 1


--Кол-во товаров по акции
SELECT plant, COUNT(plant)
FROM std9_21_project.coupons
GROUP BY 1
ORDER BY 1

--Доля товаров со скидкой
-- Кол-во товаров по акции / Кол-во проданных товаров
WITH t1 AS (SELECT plant, COUNT(plant) AS count_p
FROM std9_21_project.coupons
GROUP BY 1),

t2 AS (SELECT plant, SUM(qty) AS sum_q
FROM std9_21_project.bills
GROUP BY 1)

SELECT t1.plant, ROUND((count_p / sum_q * 100), 1)
FROM t1
JOIN t2 ON t1.plant = t2. plant
ORDER BY t1.plant;

--Среднее количество товаров в чеке
-- Кол-во проданных товаров /  Кол-во чеков
SELECT plant, SUM(qty)
FROM std9_21_project.bills
GROUP BY 1
ORDER BY 1
-- /
WITH t1 AS (SELECT DISTINCT plant, billnum, COUNT(billnum) OVER(PARTITION BY billnum) AS count_check
FROM std9_21_project.bills
ORDER BY plant)

SELECT plant, COUNT(count_check)
FROM t1
GROUP BY 1
ORDER BY 1

--Коэффициент конверсии магазина, %
-- Кол-во чеков / Трафик
WITH t1 AS (SELECT DISTINCT plant, billnum, COUNT(billnum) OVER(PARTITION BY billnum) AS count_check
FROM std9_21_project.bills
ORDER BY plant)

SELECT plant, COUNT(count_check)
FROM t1
GROUP BY 1
ORDER BY 1
-- /
SELECT plant, SUM(quantity)
FROM std9_21_project.traffic
GROUP BY 1
ORDER BY 1

--Средний чек, руб
-- Оборот / Кол-во чеков
SELECT plant, SUM(rpa_sat)
FROM std9_21_project.bills
GROUP BY 1
ORDER BY 1
-- /
WITH t1 AS (SELECT DISTINCT plant, billnum, COUNT(billnum) OVER(PARTITION BY billnum) AS count_check
FROM std9_21_project.bills
ORDER BY plant)

SELECT plant, COUNT(count_check)
FROM t1
GROUP BY 1
ORDER BY 1

--Средняя выручка на одного посетителя, руб
-- Если Трафик > 0, то Оборот / Трафик
WITH t1 AS (SELECT plant, SUM(rpa_sat) AS sum_rpa
FROM std9_21_project.bills
GROUP BY 1),

t2 AS (SELECT plant, SUM(quantity) AS sum_quant
FROM std9_21_project.traffic
GROUP BY 1)

SELECT t1.plant, ROUND((sum_rpa / sum_quant), 1)
FROM t1
JOIN t2 ON t1.plant = t2. plant
ORDER BY t1.plant;

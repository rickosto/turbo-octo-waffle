--Справочники
CREATE TABLE std9_21_project.stores
(
	shop varchar(5),
	txt varchar(100)
)
DISTRIBUTED REPLICATED;

CREATE TABLE std9_21_project.promos
(
	promo varchar(50),
	name varchar(50),
	type smallint,
	product bigint,
	discount integer
)
DISTRIBUTED REPLICATED;

CREATE TABLE std9_21_project.promo_types
(
	type  smallint,
	txt  varchar(100)
)
DISTRIBUTED REPLICATED;

--Факты
CREATE TABLE std9_21_project.coupons
(
	shop varchar(5),
	"date" date,
	coupon varchar(7),
	promo varchar(50),
	product bigint,
	"check" integer
)
DISTRIBUTED BY (coupon)
PARTITION BY RANGE (date)
(START(date '2021-01-01') INCLUSIVE
END(date '2022-01-01') EXCLUSIVE
EVERY(INTERVAL '1 month'),
DEFAULT PARTITION other);

CREATE TABLE std9_21_project.traffic
(
	shop varchar(5),
	date date,
	time time without time zone,
	frame_id integer,
	quantity smallint
)
WITH (appendoptimized=true, orientation=column, compresstype=zstd, compresslevel=1)
DISTRIBUTED BY (frame_id)
PARTITION BY RANGE (date)
(START(date '2021-01-01') INCLUSIVE
END(date '2022-01-01') EXCLUSIVE
EVERY(INTERVAL '1 month'),
DEFAULT PARTITION other);

CREATE TABLE std9_21_project.bills_head
(
	bill_num integer,
	shop varchar(5),
	date date
)
WITH (appendoptimized=true, orientation=row, compresstype=zstd, compresslevel=1)
DISTRIBUTED BY (bill_num);

CREATE TABLE std9_21_project.bills_item
(
	bill_num integer,
	bill_item smallint,
	material bigint,
	qty smallint,
	netval numeric(17, 2),
	tax numeric(17, 2),
	rpa_sat numeric(17, 2),
	date date
)
WITH (appendoptimized=true, orientation=column, compresstype=zstd, compresslevel=1)
DISTRIBUTED BY (bill_num);


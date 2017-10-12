Use Vidsi;

CREATE TABLE VS_SUBSCRIBER(
	id  int NOT NULL PRIMARY KEY,
	firstname VARCHAR(100),
	middlename VARCHAR(100),
	lastname VARCHAR(100),
	country VARCHAR(100),
	address VARCHAR(255),
	city   VARCHAR(50),
	state   VARCHAR(50),
	subscription_status VARCHAR(1),
	initial_date date ,
	free_streaming_end date,
);

go;

CREATE TABLE VS_SUBSCRIBER_PHONE (
	id int NOT NULL PRIMARY KEY,
	subscriber_id int,
	country_code varchar(2),
	phone_type varchar(100),
	phone_number varchar(20),
	phone_extention varchar(5),
	FOREIGN KEY(subscriber_id) REFERENCES VS_SUBSCRIBER(id)
);

go;

CREATE TABLE VS_SUBSCRIBER_EMAILS (
	id int NOT NULL PRIMARY KEY,
	subscriber_id int,
	email varchar(100),
	FOREIGN KEY(subscriber_id) REFERENCES VS_SUBSCRIBER(id)
);

CREATE TABLE VS_SUBSCRIBER_PAY_CARDS (
	id int NOT NULL PRIMARY KEY,
	subscriber_id int,
	type varchar(100),
	number varchar (20),
	expiration_date date,
	sec_number int, 
	FOREIGN KEY(subscriber_id) REFERENCES VS_SUBSCRIBER(id)
);

go;

CREATE TABLE VS_PLAN_TIER (
	id int NOT NULL PRIMARY KEY,
	description varchar(100),
	cost decimal(10,2),
	streaming_limit decimal(10,2),
);

CREATE TABLE VS_PLAN_DETAIL (
	id int NOT NULL PRIMARY KEY,
	plan_tier_id int,
	detail varchar(100),
	FOREIGN KEY(plan_tier_id) REFERENCES VS_PLAN_TIER(id)
);

go;








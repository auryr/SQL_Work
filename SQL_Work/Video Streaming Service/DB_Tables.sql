Use Vidsi;

CREATE TABLE VS_SUBSCRIBERS(
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

CREATE TABLE VS_SUBSCRIBERS_PHONE (
	id int NOT NULL PRIMARY KEY,
	subscriber_id int,
	country_code varchar(2),
	phone_type varchar(100),
	phone_number varchar(20),
	phone_extention varchar(5),
	FOREIGN KEY(subscriber_id) REFERENCES VS_SUBSCRIBERS(id)
);

go;

CREATE TABLE VS_SUBSCRIBERS_EMAILS (
	id int NOT NULL PRIMARY KEY,
	subscriber_id int,
	email varchar(100),
	FOREIGN KEY(subscriber_id) REFERENCES VS_SUBSCRIBERS(id)
);

CREATE TABLE VS_SUBSCRIBERS_PAY_CARDS (
	id int NOT NULL PRIMARY KEY,
	subscriber_id int,
	type varchar(100),
	number varchar (20),
	expiration_date date,
	sec_number int, 
	FOREIGN KEY(subscriber_id) REFERENCES VS_SUBSCRIBERS(id)
);

go;

CREATE TABLE VS_PLAN_TIERS (
	id int NOT NULL PRIMARY KEY,
	description varchar(100),
	cost decimal(10,2),
	streaming_limit decimal(10,2),
);

CREATE TABLE VS_PLAN_DETAILS (
	id int NOT NULL PRIMARY KEY,
	plan_tier_id int,
	detail varchar(100),
	FOREIGN KEY(plan_tier_id) REFERENCES VS_PLAN_TIERS(id)
);

go;

CREATE TABLE VS_SUBSRIBER_PLANS (
	id int NOT NULL PRIMARY KEY,
	subscriber_id int,
	plan_tier_id int,
	contract_no varchar(100),
	initial_date date,
	expiration_date date,
	status varchar(1),
	payment_method varchar(10),
	auto_pay bit ,
	subscriber_pay_card_id int,
	FOREIGN KEY(subscriber_id) REFERENCES VS_SUBSCRIBERS(id),
	FOREIGN KEY(plan_tier_id)  REFERENCES VS_PLAN_TIERS(id),
	FOREIGN KEY(subscriber_pay_card_id)   REFERENCES VS_SUBSCRIBERS_PAY_CARDS(id)
);

go;


CREATE TABLE VS_CONTENT_PROVIDERS(
	id int NOT NULL PRIMARY KEY,
	name varchar(100),
	registration_brand varchar(100),
	registration_number varchar(120),
	copyright_details text
);

go;

CREATE TABLE VS_GENRES(
	id int NOT NULL PRIMARY KEY,
	description varchar(100),
);

CREATE TABLE VS_CATEGORIES(
	id int NOT NULL PRIMARY KEY,
	description varchar(100),
);

CREATE TABLE VS_AUTHORS(
	id int NOT NULL PRIMARY KEY,
	name varchar(100)
);


go;

CREATE TABLE VS_VIDEOS(
	id int NOT NULL PRIMARY KEY,
	title varchar(100),
	description text,
	license_number varchar(100),
	duration decimal(5,2),
	stream_limit int,
	category_id int,
	content_provider_id int,
	author_id int,
	FOREIGN KEY(category_id)			REFERENCES VS_GENRES(id),
	FOREIGN KEY(content_provider_id)	REFERENCES VS_CONTENT_PROVIDERS(id),
	FOREIGN KEY(author_id)				REFERENCES VS_AUTHORS(id),
);


go;


CREATE TABLE SUBSCRIBERS_VIDEOS(
	id int NOT NULL PRIMARY KEY,
	subscriber_id int,
	video_id int,
	viewed_date date,
	FOREIGN KEY(subscriber_id)	REFERENCES VS_SUBSCRIBERS(id),
	FOREIGN KEY(video_id)		REFERENCES VS_VIDEOS(id),
);

go;












Use Vidsi;

CREATE TABLE VS_CATEGORIES(
	id int NOT NULL PRIMARY KEY,
	description varchar(100),
);

CREATE TABLE VS_SUBSCRIBERS(
	id  int NOT NULL PRIMARY KEY,
	firstname VARCHAR(100),
	middlename VARCHAR(100),
	lastname VARCHAR(100),
	country VARCHAR(100),
	address VARCHAR(255),
	city   VARCHAR(50),
	state   VARCHAR(50),
	initial_date date ,
	free_plan_end date,
	status VARCHAR(1),
	category_id int,
	FOREIGN KEY(category_id) REFERENCES VS_CATEGORIES(id)
);

go

CREATE TABLE VS_SUBSCRIBERS_PHONE (
	id int NOT NULL PRIMARY KEY,
	subscriber_id int,
	country_code varchar(2),
	phone_type varchar(100),
	phone_number varchar(20),
	phone_extention varchar(5),
	note text,
	status VARCHAR(1),
	FOREIGN KEY(subscriber_id) REFERENCES VS_SUBSCRIBERS(id)
);

go

CREATE TABLE VS_SUBSCRIBERS_EMAILS (
	id int NOT NULL PRIMARY KEY,
	subscriber_id int,
	email varchar(100),
	status VARCHAR(1),
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

go

CREATE TABLE VS_PLAN_TIERS (
	id int NOT NULL PRIMARY KEY,
	description varchar(100),
	cost decimal(10,2),
	streaming_limit decimal(10,2),
	extra_streaming_charge decimal(10,2),
	status varchar(1),
);

CREATE TABLE VS_PLAN_DETAILS (
	id int NOT NULL PRIMARY KEY,
	plan_tier_id int,
	detail varchar(100),
	FOREIGN KEY(plan_tier_id) REFERENCES VS_PLAN_TIERS(id)
);

go

CREATE TABLE VS_SUBSCRIBER_PLANS (
	id int NOT NULL PRIMARY KEY,
	subscriber_id int,
	plan_tier_id int,
	subscription_no varchar(100),
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

go


CREATE TABLE VS_CONTENT_PROVIDERS(
	id int NOT NULL PRIMARY KEY,
	name varchar(100),
	registration_brand varchar(100),
	provider_number varchar(120),
	copyright_details text
);

go

CREATE TABLE VS_GENRES(
	id int NOT NULL PRIMARY KEY,
	description varchar(100),
);

CREATE TABLE VS_AUTHORS(
	id int NOT NULL PRIMARY KEY,
	name varchar(100)
);

go

CREATE TABLE VS_VIDEOS(
	id int NOT NULL PRIMARY KEY,
	title varchar(100),
	description text,
	license_number varchar(100),
	duration decimal(5,2),
	view_limit int,
	genre_id int,
	content_provider_id int,
	author_id int,
	release_date date,
	FOREIGN KEY(genre_id)				REFERENCES VS_GENRES(id),
	FOREIGN KEY(content_provider_id)	REFERENCES VS_CONTENT_PROVIDERS(id),
	FOREIGN KEY(author_id)				REFERENCES VS_AUTHORS(id),
);

go

CREATE TABLE SUBSCRIBERS_VIDEOS(
	id int NOT NULL PRIMARY KEY,
	subscriber_id int,
	video_id int,
	viewed_date date,
	FOREIGN KEY(subscriber_id)	REFERENCES VS_SUBSCRIBERS(id),
	FOREIGN KEY(video_id)		REFERENCES VS_VIDEOS(id),
);

go
 
CREATE TABLE INVOICES(
	id int NOT NULL PRIMARY KEY,
	ref_number varchar(12),
	date_issued date,
	description varchar(100),
	amount decimal (10,2),
	expiration_date date,
	status varchar(1),
	subscriber_plan_id int,
	FOREIGN KEY(subscriber_plan_id) REFERENCES VS_SUBSCRIBER_PLANS(id) 
);

go

CREATE TABLE PAYMENTS(
	id int NOT NULL PRIMARY KEY,
	ref_number varchar(12),
	date_issued date,
	description varchar(100),
	amount decimal (10,2),
	status varchar(1),
	subscriber_id int,
	FOREIGN KEY(subscriber_id) REFERENCES VS_SUBSCRIBERS(id),
);

go

CREATE TABLE PAYMENT_INVOICE(
	id int NOT NULL PRIMARY KEY,
	payment_id int,
	invoice_id int,
	amount decimal(10,2),
	FOREIGN KEY(payment_id) REFERENCES PAYMENTS(id) ,
	FOREIGN KEY(invoice_id) REFERENCES INVOICES(id) ,
);

CREATE TABLE PAYMENT_DETAILS(
	id int NOT NULL PRIMARY KEY,
	amount decimal(10,2),
	document_no varchar(15) null,
	payment_id int null,
	subscriber_pay_card_id int null ,
	FOREIGN KEY(payment_id) REFERENCES PAYMENTS(id) ,
	FOREIGN KEY(subscriber_pay_card_id) REFERENCES VS_SUBSCRIBERS_PAY_CARDS(id)
);










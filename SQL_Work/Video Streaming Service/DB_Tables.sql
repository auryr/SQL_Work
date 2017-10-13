USE MASTER;
GO

if  ( SELECT count(name) FROM sys.databases WHERE name='Vidsi_c')>0 DROP DATABASE Vidsi_c;

CREATE DATABASE Vidsi_c;
GO
Use Vidsi_c;



IF OBJECT_ID('dbo.tvsCategories', 'U') IS NOT NULL 
	DROP TABLE tvsCategories
IF OBJECT_ID('dbo.tvsSubscribers', 'U') IS NOT NULL 
	DROP TABLE tvsSubscribers;

IF OBJECT_ID('dbo.tvsSubscribers_phone', 'U') IS NOT NULL 
	DROP TABLE tvsSubscribers_phone;

IF OBJECT_ID('dbo.tvsSubscribers_emails', 'U') IS NOT NULL 
	DROP TABLE tvsSubscribers_emails;

IF OBJECT_ID('dbo.tvsSubscribers_payCards', 'U') IS NOT NULL
	DROP TABLE tvsSubscribers_payCards;

IF OBJECT_ID('dbo.tvsPlanTiers', 'U') IS NOT NULL 
	DROP TABLE tvsPlanTiers;

IF OBJECT_ID('dbo.tvsPlanDetails', 'U') IS NOT NULL 
	DROP TABLE tvsPlanDetails;

IF OBJECT_ID('dbo.tvsSubscribersPlans', 'U') IS NOT NULL 
	DROP TABLE tvsSubscribersPlans;

IF OBJECT_ID('dbo.tvsProviders', 'U') IS NOT NULL 
	DROP TABLE tvsProviders;

IF OBJECT_ID('dbo.tvsGenre', 'U') IS NOT NULL 
	DROP TABLE tvsGenre;

IF OBJECT_ID('dbo.tvsAuthors', 'U') IS NOT NULL 
	DROP TABLE tvsAuthors;

IF OBJECT_ID('dbo.tvsVideos', 'U') IS NOT NULL 
	DROP TABLE tvsVideos;

IF OBJECT_ID('dbo.tvsSubscribersStreaming', 'U') IS NOT NULL 
	DROP TABLE tvsSubscribersStreaming;

IF OBJECT_ID('dbo.tvsInvoices', 'U') IS NOT NULL 
	DROP TABLE tvsInvoices;

IF OBJECT_ID('dbo.tvsPayments', 'U') IS NOT NULL 
	DROP TABLE tvsPayments;

IF OBJECT_ID('dbo.tvsPaymentsInvoices', 'U') IS NOT NULL 
	DROP TABLE tvsPaymentsInvoices;

IF OBJECT_ID('dbo.tvsPaymentsDetails', 'U') IS NOT NULL 
DROP TABLE tvsPaymentsDetails;

GO


CREATE TABLE tvsCategories(
	id int NOT NULL IDENTITY (1,1) PRIMARY KEY,
	description varchar(100),
	expiration_days int,
);
go
CREATE TABLE tvsSubscribers(
	id  int NOT NULL IDENTITY (1,1) PRIMARY KEY,
	firstname VARCHAR(100) NOT NULL,
	middlename VARCHAR(100) NULL,
	lastname VARCHAR(100) NOT NULL,
	country VARCHAR(100)  NOT NULL,
	address VARCHAR(255)  ,
	city   VARCHAR(50),
	state   VARCHAR(50),
	zipcode int,
	initial_date datetime  NOT NULL,
	free_plan_end datetime ,
	status VARCHAR(1)  NOT NULL,
	category_id int  NOT NULL,
	FOREIGN KEY(category_id) REFERENCES tvsCategories(id)
);

go

CREATE TABLE tvsSubscribers_phone (
	id int NOT NULL IDENTITY (1,1) PRIMARY KEY,
	subscriber_id int  NOT NULL,
	country_code varchar(2) ,
	phone_type varchar(100)  NOT NULL,
	phone_number varchar(20)  NOT NULL,
	phone_extention varchar(5),
	note text,
	status VARCHAR(1)  NOT NULL,
	FOREIGN KEY(subscriber_id) REFERENCES tvsSubscribers(id)
);

go

CREATE TABLE tvsSubscribers_emails (
	id int NOT NULL IDENTITY (1,1) PRIMARY KEY,
	subscriber_id int,
	email varchar(100),
	status VARCHAR(1),
	FOREIGN KEY(subscriber_id) REFERENCES tvsSubscribers(id)
);

CREATE TABLE tvsSubscribers_payCards (
	id int NOT NULL IDENTITY (1,1) PRIMARY KEY,
	subscriber_id int,
	type varchar(100),
	number varchar (20),
	expiration_date date,
	operator varchar(20),
	sec_number int, 
	FOREIGN KEY(subscriber_id) REFERENCES tvsSubscribers(id)
);

go

CREATE TABLE tvsPlanTiers (
	id int NOT NULL IDENTITY (1,1) PRIMARY KEY,
	description varchar(100),
	cost decimal(10,2),
	streaming_limit decimal(10,2),
	extra_streaming_charge decimal(10,2),
	status varchar(1),
);

CREATE TABLE tvsPlanDetails (
	id int NOT NULL IDENTITY (1,1) PRIMARY KEY,
	plan_tier_id int,
	detail varchar(100),
	FOREIGN KEY(plan_tier_id) REFERENCES tvsPlanTiers(id)
);

go

CREATE TABLE tvsSubscribersPlans (
	id int NOT NULL IDENTITY (1,1) PRIMARY KEY,
	subscriber_id int,
	plan_tier_id int,
	subscription_no varchar(100),
	initial_date date,
	expiration_date date,
	status varchar(1),
	payment_method varchar(10),
	country VARCHAR(100)  NOT NULL,
	address VARCHAR(255)  ,
	city   VARCHAR(50),
	state   VARCHAR(50),
	zipcode int,
	auto_pay bit ,
	subscriber_pay_card_id int,
	FOREIGN KEY(subscriber_id) REFERENCES tvsSubscribers(id),
	FOREIGN KEY(plan_tier_id)  REFERENCES tvsPlanTiers(id),
	FOREIGN KEY(subscriber_pay_card_id)   REFERENCES tvsSubscribers_payCards(id)
);

go

CREATE TABLE tvsProviders(
	id int NOT NULL IDENTITY (1,1) PRIMARY KEY,
	name varchar(100),
	registration_brand varchar(100),
	provider_number varchar(120),
	copyright_details text
);

go

CREATE TABLE tvsGenre(
	id int NOT NULL IDENTITY (1,1) PRIMARY KEY,
	description varchar(100),
);

CREATE TABLE tvsAuthors(
	id int NOT NULL IDENTITY (1,1) PRIMARY KEY,
	name varchar(100)
);

go

CREATE TABLE tvsVideos(
	id int NOT NULL IDENTITY (1,1) PRIMARY KEY,
	title varchar(100),
	description text,
	license_number varchar(100),
	duration decimal(5,2),
	view_limit int,
	genre_id int,
	provider_id int,
	author_id int,
	release_date date,
	FOREIGN KEY(genre_id)				REFERENCES tvsGenre(id),
	FOREIGN KEY(provider_id)	REFERENCES tvsProviders(id),
	FOREIGN KEY(author_id)				REFERENCES tvsAuthors(id),
);

go

CREATE TABLE tvsSubscribersStreaming(
	id int NOT NULL IDENTITY (1,1) PRIMARY KEY,
	subscriber_id int,
	video_id int,
	streaming_date date,
	FOREIGN KEY(subscriber_id)	REFERENCES tvsSubscribers(id),
	FOREIGN KEY(video_id)		REFERENCES tvsVideos(id),
);

go
 
CREATE TABLE tvsInvoices(
	id int NOT NULL IDENTITY (1,1) PRIMARY KEY,
	ref_number varchar(12),
	date_issued date,
	description varchar(100),
	amount decimal (10,2),
	expiration_date date,
	status varchar(1),
	subscriber_plan_id int,
	FOREIGN KEY(subscriber_plan_id) REFERENCES tvsSubscribersPlans(id) 
);

go

CREATE TABLE tvsPayments(
	id int NOT NULL IDENTITY (1,1) PRIMARY KEY,
	ref_number varchar(12),
	date_issued date,
	description varchar(100),
	amount decimal (10,2),
	status varchar(1),
	subscriber_id int,
	FOREIGN KEY(subscriber_id) REFERENCES tvsSubscribers(id),
);


go

CREATE TABLE tvsPaymentsInvoices(
	id int NOT NULL IDENTITY (1,1) PRIMARY KEY,
	payment_id int,
	invoice_id int,
	amount decimal(10,2),
	FOREIGN KEY(payment_id) REFERENCES tvsPayments(id) ,
	FOREIGN KEY(invoice_id) REFERENCES tvsInvoices(id) ,
);

CREATE TABLE tvsPaymentsDetails(
	id int NOT NULL IDENTITY (1,1) PRIMARY KEY,
	amount decimal(10,2),
	document_no varchar(15) null,
	payment_id int null,
	subscriber_pay_card_id int null ,
	FOREIGN KEY(payment_id) REFERENCES tvsPayments(id) ,
	FOREIGN KEY(subscriber_pay_card_id) REFERENCES tvsSubscribers_payCards(id)
);

CREATE TABLE tvsSubsribersCancellations(
	id int NOT NULL IDENTITY (1,1) PRIMARY KEY,
	subscriber_plan_id int NOT NULL,
	sent_date date ,
	release_date date, 
	FOREIGN KEY(subscriber_plan_id) REFERENCES tvsSubscribersPlans(id),
)








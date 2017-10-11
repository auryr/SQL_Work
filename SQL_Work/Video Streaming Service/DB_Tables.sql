Use Vidsi;

CREATE TABLE VS_SUSCRIBER(
	id  int NOT NULL PRIMARY KEY,
	firstname VARCHAR(100),
	lastname VARCHAR(100),
	status VARCHAR(1),
	country VARCHAR(100),
	address VARCHAR(255),
	city   VARCHAR(50),
	state   VARCHAR(50),

)


CREATE TABLE VS_SUSCRIBER_PHONE (
	id int NOT NULL PRIMARY KEY,
	suscriber_id int,
	country_code varchar(2),
	phone_type varchar(100),
	phone_number varchar(20),
	phone_extention varchar(5),
	FOREIGN KEY(suscriber_id) REFERENCES VS_SUSCRIBER(id)
)
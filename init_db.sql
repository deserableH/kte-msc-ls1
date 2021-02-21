CREATE TABLE Profile (
	login 		varchar(30) PRIMARY KEY NOT NULL,
	mdp		varchar(30),
	name		varchar(50),
       	company		varchar(50),
	email		varchar(50),
	telephone	varchar(20)
);
CREATE TABLE card (
	id		integer PRIMARY KEY NOT NULL,
	name		varchar(50),
	company		varchar(50),
	email		varchar(50),
	telephone	varchar(20),
	login		varchar(30),
	CONSTRAINT fk_login FOREIGN KEY (login) REFERENCES Profile(login)
);


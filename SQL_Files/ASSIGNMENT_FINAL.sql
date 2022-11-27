CREATE TABLE service_route_details
	( route_id		VARCHAR2(5) PRIMARY KEY CHECK(route_id like 'R%'),
	  source_town	VARCHAR2(20) NOT NULL,
	  route_town1	VARCHAR2(30),
	  route_town2	VARCHAR2(30),
	  route_town3	VARCHAR2(30),
	  destination	VARCHAR2(30),
	  operator	VARCHAR2(30) NOT NULL
	);

CREATE TABLE manager_details
	( manager_id	VARCHAR2(5) PRIMARY KEY CHECK(manager_id like 'M%') NOT NULL,
	  name			VARCHAR2(20) NOT NULL,
	  phone_number	NUMBER(10),
	  DOB			DATE NOT NULL,
	  hire_date		DATE NOT NULL,
	  sub_workers	NUMBER(2)
	);

CREATE TABLE bus_details
	( bus_id		VARCHAR2(5) PRIMARY KEY CHECK(bus_id like 'B%') NOT NULL,
	  bus_type 		VARCHAR2(9) CHECK(bus_type in ('seater','sleeper')) NOT NULL,
	  ac_nonac		VARCHAR2(6) CHECK(ac_nonac in ('ac','non-ac')) NOT NULL,
	  seat_strength	NUMBER(2) NOT NULL,
	  owner_reg		VARCHAR2(6) NOT NULL,
	  lease_status	VARCHAR2(10)
	);

CREATE TABLE passenger_details
	( name			VARCHAR2(40) NOT NULL,
	  age			VARCHAR2(3) NOT NULL,
	  phone_number	NUMBER(10) NOT NULL,
	  email_id		VARCHAR2(20),
	  customer_id	VARCHAR2(5) PRIMARY KEY CHECK(customer_id like 'C%')
	);

CREATE TABLE driver_details
	( driver_id		VARCHAR2(5) PRIMARY KEY CHECK(driver_id like 'D%') NOT NULL,
	  name			VARCHAR2(20) NOT NULL,
	  phone_number	NUMBER(10),
	  DOB			DATE NOT NULL,
	  salary		NUMBER(5),
	  hire_date		DATE NOT NULL,
	  manager_id	VARCHAR2(5) CHECK(manager_id like'M%'),
	  rating		NUMBER(1) CHECK(rating<=5),
	  assigned_bus_id	VARCHAR2(5) CHECK(assigned_bus_id like 'B%'), 
	  CONSTRAINT dd_fk
	  FOREIGN KEY(manager_id) REFERENCES manager_details(manager_id),
	  FOREIGN KEY(assigned_bus_id) REFERENCES bus_details(bus_id) ON DELETE SET NULL
	);

CREATE TABLE journey_details
	( 
	  journey_id		VARCHAR2(5) PRIMARY KEY CHECK(journey_id like 'J%'),
	  source		VARCHAR2(20) NOT NULL,
	  destination		VARCHAR2(20) NOT NULL,
	  jddate                DATE NOT NULL,
	  ttime			TIMESTAMP NOT NULL,
	  on_bus_service	VARCHAR2(10) CHECK(on_bus_service IN (NULL,'yes','no')),
	  bus_id		VARCHAR2(5)  CHECK(bus_id like 'B%') NOT NULL,
	  route_id		VARCHAR2(5) CHECK(route_id like 'R%'),
	  CONSTRAINT jd_fk
	  FOREIGN KEY(route_id) REFERENCES service_route_details(route_id),
	  FOREIGN KEY(bus_id) REFERENCES bus_details(bus_id) ON DELETE SET NULL
	);

CREATE TABLE garage_details
	( garage_id		VARCHAR2(5) PRIMARY KEY CHECK(garage_id like 'G%'),
	  bus_id		VARCHAR2(5) CHECK(bus_id like 'B%'),
	  name 			VARCHAR2(40) NOT NULL,
	  address		VARCHAR2(120),
	  CONSTRAINT gd_fk
	  FOREIGN KEY(bus_id) REFERENCES bus_details(bus_id) ON DELETE SET NULL
	);

CREATE TABLE customer_booking_details
	( booking_id	VARCHAR2(6) PRIMARY KEY CHECK(booking_id like 'BO%'),
	  seat_status	VARCHAR2(9) CHECK(seat_status in('confirmed','cancelled')) NOT NULL,
	  booking_date	DATE NOT NULL,
	  travel_date	DATE NOT NULL,
	  journey_id	VARCHAR2(5) CHECK(journey_id like 'J%'),
	  seat_num	NUMBER(2) NOT NULL,
	  customer_id	VARCHAR2(5) CHECK(customer_id like 'C%'),
	  CONSTRAINT cbd_fk
	  FOREIGN KEY(journey_id) REFERENCES journey_details(journey_id),
	  FOREIGN KEY(customer_id) REFERENCES passenger_details(customer_id) ON DELETE SET NULL
	);
@d:/ServiceRouteDets.sql;
@d:/ManagerDets.sql;
@d:/BusDets.sql;
@d:/PassengerDets.sql;
@d:/DriverDets.sql;
@d:/JourneyDets.sql;
@d:/GarageDets.sql;
@d:/CustomerBookingDets.sql;
DROP SCHEMA IF EXISTS luxuryrentals cascade;
CREATE SCHEMA luxuryrentals;
SET search_path TO luxuryrentals, public;
/*
  - We do not enforce every property to have one or more luxuries because it requires assertion.
  - We do not enforce number of guests to be equal or small than property capacity because of the same reason. 
  - We assume rental always starts on Saturday.

*/

-- The possible values of a water type.
CREATE DOMAIN water AS varchar(5) 
   DEFAULT NULL
   CHECK (VALUE = 'beach' OR VALUE = 'lake' OR VALUE = 'pool');

-- The possible values of a water type.
CREATE DOMAIN transit AS varchar(6) 
   DEFAULT NULL
   CHECK (VALUE = 'bus' OR VALUE = 'LRT' OR VALUE = 'subway' OR VALUE = 'none');
   
-- The possible values of a luxury type.
CREATE DOMAIN luxury AS varchar(24) 
   DEFAULT NULL
   CHECK (VALUE = 'hot tub' OR VALUE = 'sauna' OR 
          VALUE = 'laundry service' OR 
          VALUE = 'daily cleaning' OR 
          VALUE = 'daily breakfast delivery' OR 
          VALUE = 'concierge service');

-- The possible values of a rating.
CREATE DOMAIN star AS smallint 
   DEFAULT NULL
   CHECK (VALUE >= 0 AND VALUE <= 5);

-- The possible values of a walkability score.
CREATE DOMAIN score AS smallint 
   DEFAULT NULL
   CHECK (VALUE >= 0 AND VALUE <= 100);

-- A guest registered as a client of the company's luxury rental services.
-- dob is their date of birth.
CREATE TABLE Guest (
  guest_id integer PRIMARY KEY,
  name varchar(40) NOT NULL,
  address varchar NOT NULL,
  dob date NOT NULL
) ;


-- two different hosts can have the same mail
CREATE TABLE Host (
  host_id integer PRIMARY KEY,
  email varchar(80) NOT NULL
) ;


-- The name, such as 'Pearson Airport', associated with a location.
-- num_br is the number of bedrooms.
-- num_ba is the number of bathrooms.
-- Capacity has to be at least the number of bedrooms.
CREATE TABLE Property (
  property_id integer PRIMARY KEY,
  host_id integer NOT NULL REFERENCES Host(host_id),
  num_br integer NOT NULL,
  num_ba integer NOT NULL,
  capacity integer NOT NULL CHECK (capacity>=num_br),
  address varchar NOT NULL
) ;


-- A rental of a property.
-- renter is the guest who is held responsibly legally.
-- num_week is the total number of week of this rental.
-- credit_card is the renter's payment information for this rental. 
CREATE TABLE Rental (
  rental_id integer PRIMARY KEY,
  property_id integer NOT NULL REFERENCES Property(property_id),
  renter integer NOT NULL REFERENCES Guest(guest_id),
  start_date date NOT NULL CHECK (extract(dow from start_date) = 6),
  num_week smallint NOT NULL CHECK (num_week>=1),
  credit_card bigint NOT NULL
) ;


-- A rental can be registered by other guests apart from renter.
-- Renter has to be a registered guest.  
CREATE TABLE RegisteredGuest (
  rental_id integer REFERENCES Rental(rental_id),
  guest_id integer REFERENCES Guest(guest_id),
  PRIMARY KEY (rental_id, guest_id)
) ;


-- A property can have different price at different week.
-- a week is defined to start on a Saturday.s
CREATE TABLE PropertyPrice (
  property_id integer REFERENCES Property(property_id),
  week date CHECK (extract(dow from week) = 6),
  price integer NOT NULL,
  PRIMARY KEY (property_id, week)
) ;

-- A water property can have multiple water types.
-- Each has its own lifeguarding.
-- lifeguarding boolean indicates whether lifeguarding is available.
CREATE TABLE WaterProperty (
  property_id integer REFERENCES Property(property_id),
  water_type water,
  lifeguarding boolean NOT NULL,
  PRIMARY KEY (property_id, water_type)
) ;

-- City properties have a walkability score (0 to 100)
-- and the type of transit that is closest (either bus, LRT, subway, or none).
CREATE TABLE CityProperty (
  property_id integer REFERENCES Property(property_id) PRIMARY KEY,
  walkability score NOT NULL,
  closest_transit transit NOT NULL
) ;

-- Because these are luxury rentals, every property includes one or more luxuries
CREATE TABLE Luxuries (
  property_id integer REFERENCES Property(property_id),
  service luxury,
  PRIMARY KEY (property_id, service)
) ;


-- The property associated with this rental
-- was given this rating by the guest who is registered in this rental.
CREATE TABLE PropertyRating (
  rental_id integer,
  guest_id integer,
  rating star NOT NULL,
  FOREIGN KEY (rental_id, guest_id) REFERENCES RegisteredGuest (rental_id, guest_id),
  PRIMARY KEY (rental_id, guest_id)
) ;


-- The host of the property associated with this rental
-- was given this rating by the renter.
-- Only renter can rate the host, not the other guests.
CREATE TABLE HostRating (
  rental_id integer REFERENCES Rental(rental_id) PRIMARY KEY,
  rating star NOT NULL
) ;


-- The property associated with this rental
-- was given this comment by the guest who is
-- registered in this rental and have rated the property.
CREATE TABLE PropertyComment (
  rental_id integer,
  guest_id integer,
  comment varchar NOT NULL,
  FOREIGN KEY (rental_id, guest_id) REFERENCES PropertyRating (rental_id, guest_id),
  PRIMARY KEY (rental_id, guest_id)
) ;

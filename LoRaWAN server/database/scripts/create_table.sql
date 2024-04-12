CREATE TABLE parking_lot (
building_number varchar(4) not null,
parking_lot_number varchar(4) not null,
occupied boolean not null,
PRIMARY KEY (`building_number`, `parking_lot_number`)
);
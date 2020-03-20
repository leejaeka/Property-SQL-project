insert into guest values
(1, 'Darth Vader', 'Death Star', 1985-12-06),
(2, 'Leia, Princess', 'Alderaan', 2001-10-05),
(3, 'Romeo Montague', 'Verona', 1988-05-11),
(4, 'Mercutio', 'Verona', 1988-03-03),
(5, 'Juliet Capulet', 'Verona', 1991-07-24),
(6, 'Chewbacca', 'Kashyyyk', 1998-09-15);


insert into host values
(1, 'luke@gmail.com'),
(2, 'leia@gmail.com'),
(3, 'han@gmail.com');


insert into property values
(1, 1, 3, 1, 6, 'Tatooine'),
(2, 2, 1, 1, 2, 'Alderaan'),
(3, 3, 2, 1, 3, 'Corellia'),
(4, 2, 2, 1, 2, 'Verona'),
(5, 3, 2, 2, 4, 'Florence'),
(6, 1, 1, 1, 2, 'Toronto');


-- Locations are specified as longitude and latitude (in that order), in degrees.
insert into rental values
(1, 2, 1, '2019-01-05', 1, 3466704824219330),
(2, 3, 2, '2019-01-12', 2, 6011253896008199),
(3, 2, 3, '2019-01-12', 1, 5446447451075463),
(4, 5, 4, '2019-01-05', 1, 4666153163329984),
(5, 5, 6, '2019-01-12', 1, 6011624297465933);


insert into registeredguest values
(1, 1),
(1, 2),
(2, 2),
(2, 3),
(2, 5),
(3, 3),
(3, 5),
(4, 4),
(4, 3),
(4, 1),
(5, 6),
(5, 2);

insert into propertyprice values
(2, '2019-01-05', 580),
(3, '2019-01-12', 750),
(3, '2019-01-19', 750),
(2, '2019-01-12', 600),
(5, '2019-01-05', 1000),
(5, '2019-01-12', 1220);


insert into waterproperty values
(2, 'lake', false);


insert into cityproperty values
(3, 20, 'bus');


insert into luxuries values
(1, 'hot tub'),
(1, 'daily cleaning'),
(2, 'hot tub'),
(2, 'sauna'),
(2, 'daily cleaning'),
(3, 'daily breakfast delivery'),
(3, 'concierge service'),
(4, 'laundry service'),
(5, 'hot tub'),
(6, 'hot tub'),
(6, 'sauna'),
(6, 'laundry service'),
(6, 'daily cleaning'),
(6, 'concierge service');



insert into PropertyRating values
(1, 2, 5),
(1, 1, 2),
(2, 3, 5),
(2, 5, 5),
(2, 2, 1),
(3, 5, 5),
(4, 4, 1),
(4, 3, 1),
(5, 6, 3);

insert into HostRating values
(1, 2),
(2, 5),
(3, 3),
(4, 4),
(5, 4);


insert into PropertyComment values
(1, 1, 'Looks like she hides rebel scum here.'),
(2, 2, 'A bit scruffy, could do with more regular housekeeping'),
(5, 6, 'Fantastic, arggg');

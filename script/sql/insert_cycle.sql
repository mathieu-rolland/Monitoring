/*
	Script used to create new cycle in table monitoring.cycle
*/

insert into CYCLE (timestamp, timeend) values ( STR_TO_DATE('@start_date', '%Y/%M/%d %H:%i%s'), STR_TO_DATE('@end_date', '%Y/%M/%d %H:%i%s') );
commit;

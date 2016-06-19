/*
	Script used to create new cycle in table monitoring.cycle
*/

insert into CYCLE (timestamp, timeend) values ( @start_date, @end_date );
commit;

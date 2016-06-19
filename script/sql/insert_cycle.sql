/*
	Script used to create new cycle in table monitoring.cycle
*/

insert into monitoring.CYCLE (timestamp, timeend) values ( @start_date, @end_date );
select * from monitoring.CYCLE;

commit;

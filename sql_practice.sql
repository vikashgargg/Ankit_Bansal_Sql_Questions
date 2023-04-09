-- Ready script:
create table hall_events
(
hall_id integer,
start_date date,
end_date date
);
delete from hall_events
insert into hall_events values 
(1,'2023-01-13','2023-01-14')
,(1,'2023-01-14','2023-01-17')
,(1,'2023-01-15','2023-01-17')
,(1,'2023-01-18','2023-01-25')
,(2,'2022-12-09','2022-12-23')
,(2,'2022-12-13','2022-12-17')
,(3,'2022-12-01','2023-01-30');


-- Solution:
with cte as ( select *,row_number() over(order by hall_id,start_date) as event_id from hall_events), r_cte as select hall_id,start_date,end_date,event_id, 1 as flag from cte where event_id=1 union all select cte.hall_id,cte.start_date,cte.end_date,cte.event_id ,case when cte.hall_id=r_cte.hall_id and (cte.start_date between r_cte.start_date and r_cte.end_date or r_cte.start_date between cte.start_date and cte.end_date) then 0 else 1 end + flag as flag from r_cte inner join cte on r_cte.event_id+1 = cte.event_id 
select hall_id, flag,min (start_date) as start_date, max(end_date) as end_date from r_cte group by hall_id, flag


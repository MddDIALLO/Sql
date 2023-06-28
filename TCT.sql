---Summary----------


select SERVED_MSISDN ,sum(DURATION) DURATION  from (
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190401_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190402_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190403_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190404_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190405_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190406_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190407_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190408_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190409_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190410_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190411_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190412_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190413_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190414_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190415_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190416_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190417_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190418_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190419_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190420_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190421_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190422_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190423_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190424_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190425_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190426_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190427_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190428_USAGE_EVENTS)
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190429_USAGE_EVENTS)
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190430_USAGE_EVENTS)
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190431_USAGE_EVENTS)
)
where  SERVED_MSISDN in('224123456789',
'224123456789',
'224123456789') and replace(TOTAL_COST,',','.')=0 and DURATION <>0
group by SERVED_MSISDN


---------DETAILS--------------

select * from (
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190401_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190402_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190403_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190404_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190405_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190406_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190407_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190408_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190409_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190410_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190411_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190412_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190413_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190414_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190415_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190416_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190417_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190418_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190419_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190420_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190421_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190422_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190423_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190424_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190425_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190426_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190427_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190428_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190429_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190430_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20190431_USAGE_EVENTS)
)
where   SERVED_MSISDN in('224123456789',
'224123456789',
'224123456789') and replace(TOTAL_COST,',','.')=0 and DURATION <>0


set echo off
set feedback off
set linesize 10000
set pagesize 0
set sqlprompt ''
set trimspool on
set space 0
set truncate on
set termout off
set verify off
set sqlblanklines on
column dt new_value new_dt 
column ext new_value new_ext 
column tble new_value new_tble
column tble1 new_value new_tble1
column tble2 new_value new_tble2
column tble3 new_value new_tble3
column trt new_value new_trt



select to_char(sysdate-1,'YYYYMMDD') dt,'_' trt,'.csv' ext, 'msc_events' tble, 'MSC_EVENTS' tble1 , 'US_JOU_ENT' tble2, 'US_JOU_ENT' tble3 from dual; 

SPOOL F:\CRS\MSC\TCT_VOICE&new_ext
ALTER session SET NLS_DATE_FORMAT='DD/MM/YYYY HH24:MI:SS';


select to_date(to_char(UTC_ANSWER_TIME, 'dd/mm/yyyy'), 'dd/mm/yyyy') ||';'||
sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ||';'||
sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) ||';'||
sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) ||';'||
sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) ||';'||
sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) ||';'||
sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ||';'||
sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) ||';'||
sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) ||';'||
sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) ||';'||
sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end)
from msc_events partition(D&new_dt&new_trt&new_tble1) where traffic_type_id=0 group by to_date(to_char(UTC_ANSWER_TIME, 'dd/mm/yyyy'), 'dd/mm/yyyy');




SPOOL off;
exit  

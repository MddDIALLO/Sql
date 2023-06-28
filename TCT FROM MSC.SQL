-----------------TCT FROM MSC
-------------VOICE
select 'D20190401' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190401_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190402' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
      sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190402_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190403' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190403_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190404' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190404_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190405' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190405_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190406' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
      sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190406_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190407' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190407_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190408' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190408_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190409' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190409_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190410' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
      sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190410_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190411' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190411_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190412' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190412_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190413' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190413_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190414' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190414_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190415' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190415_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190416' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190416_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190417' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190417_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190418' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190418_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190419' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190419_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190420' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190420_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190421' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190421_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190422' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190422_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190423' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190423_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190424' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190424_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190425' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190425_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190426' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190426_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190427' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190427_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190428' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190428_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190429' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190429_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190430' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190430_msc_EVENTS) where traffic_type_id=0 
union all
select 'D20190431' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN CALL_duration  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN CALL_duration  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN CALL_duration  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN CALL_duration  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then CALL_duration  end) INTERNATONAL,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE_COUNT,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL_COUNT,
       sum(case when traffic_type_id = 0 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL_COUNT
from msc_events partition(D20190431_msc_EVENTS) where traffic_type_id=0 



-------------------SMS
select 'D20190401' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190401_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190402' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
      sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190402_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190403' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190403_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190404' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190404_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190405' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190405_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190406' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
      sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190406_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190407' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190407_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190408' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190408_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190409' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190409_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190410' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
      sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190410_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190411' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190411_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190412' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190412_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190413' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190413_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190414' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190414_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190415' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190415_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190416' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190416_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190417' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190417_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190418' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190418_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190419' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190419_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190420' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190420_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190421' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190421_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190422' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190422_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190423' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190423_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190424' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190424_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190425' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190425_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190426' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190426_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190427' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190427_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190428' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190428_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190429' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190429_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190430' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190430_msc_EVENTS) where traffic_type_id = 4 
union all
select 'D20190431' report_date,sum(CASE WHEN ( CALLED_NUMBER like  '0022466%' OR CALLED_NUMBER like  '66%' OR CALLED_NUMBER like  '066%' OR (CALLED_NUMBER like  '0066%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22466%' ) THEN 1  END) ONNET,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022465%' OR CALLED_NUMBER like  '65%' OR CALLED_NUMBER like  '065%' OR (CALLED_NUMBER like  '0065%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22465%' ) THEN 1  END) OFFNET_CELLCOM,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022462%' OR CALLED_NUMBER like  '62%' OR CALLED_NUMBER like  '062%' OR (CALLED_NUMBER like  '0062%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22462%' ) THEN 1  END) OFFNET_ORANGE,
       sum(CASE WHEN ( CALLED_NUMBER like  '0022463%' OR CALLED_NUMBER like  '63%' OR CALLED_NUMBER like  '063%' OR (CALLED_NUMBER like  '0063%'  and length(CALLED_NUMBER)<12 ) OR CALLED_NUMBER like  '22463%' ) THEN 1  END) OFFNET_INTERCELL,
       sum(case when traffic_type_id = 4 and  substr(case when length(called_number) = 9 then '224'||called_number else called_number end,1,3) not like '224%' and length(called_number) >=10 then 1  end) INTERNATONAL
from msc_events partition(D20190431_msc_EVENTS) where traffic_type_id = 4 


-----------------------------DATA
select SERVICE_IDENTIFIER_ID,RATING_GROUP ,sum(TOTAL_COST) TOTAL_COST, sum(TOTAL) TOTAL
from IT_MIS_BUNDLE_MBBt 
where REPORT_DATE between to_date('01/03/2019', 'dd/mm/yyyy') and to_date('19/03/2019', 'dd/mm/yyyy')
group by SERVICE_IDENTIFIER_ID,RATING_GROUP
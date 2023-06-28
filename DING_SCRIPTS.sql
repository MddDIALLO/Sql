truncate table IT_MIS_EZETOP_REFILL_DING_RPT;

alter table report_user.IT_MIS_DR_EZETOP_REFILL1 LOCATION (DR_DIR_INPUT_FILES:'DR_EZETOP_REFILL20190131.csv');

commit;

insert into report_user.IT_MIS_EZETOP_REFILL_DING_RPT 
select ACCOUNT_EVENT_ID,SERVED_MSISDN,UTC_TIMESTAMP,AMOUNT 
FROM report_user.IT_MIS_DR_EZETOP_REFILL1;

commit;

select distinct *
from report_user.IT_MIS_EZETOP_REFILL_DING_RPT
where AMOUNT>0

--DING BALANCE------------------------------
select *
FROM report_user.IT_MIS_DR_SDP_TOT_MAIN_SUBS
where ACCOUNT_MSISDN = '666362728'
and STAT_DATE like '%022019'
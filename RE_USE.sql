---liste des dormands
truncate table IT_MIS_MSISDN;
commit;

insert into IT_MIS_MSISDN
select distinct called_number
from ( select called_number,min(min_transaction) min_transaction,max(max_transaction) max_transaction
from 
( 

select * from REPORT_USER.IT_MIS_RGS90_MOC_MTC_TEMP

)
where  ( (substr(called_number,1,2) like '66%' and length(called_number) =9 )
--                            or (  substr(called_number,1,3) like '662%' and length(called_number) =9 )
--                            or (  substr(called_number,1,3) like '666%' and length(called_number) =9 )
--                            or (  substr(called_number,1,3) like '669%' and length(called_number) =9 )
or (called_number like '22466%' and length(called_number) =12 )
--                            or (called_number like '224666%'  and length(called_number) =12 )
--                            or (called_number like '224669%'  and length(called_number) =12 )   
--                            or (called_number like '224662%'  and length(called_number) =12 )   
)
and called_number in ( select '224'|| account_msisdn from REPORT_USER.IT_DR_IN_STATUS_SUBSCRIBERS where status_msisdn <> 'Installed')
group by called_number
)
where max_transaction between to_date(to_char(sysdate-2000,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-180,'dd/mm/yyyy'),'dd/mm/yyyy');
commit;

drop table IT_MIS_MSISDN3;

create table IT_MIS_MSISDN3 as
select distinct a.MSISDN,b.ACCOUNT_CLASS
from IT_MIS_MSISDN a , REPORT_USER.IT_DR_IN_STATUS_SUBSCRIBERS b
where substr(a.MSISDN,4,11)=b.account_msisdn
group by  a.MSISDN,b.ACCOUNT_CLASS;
commit;


select SERVICE_CLASS_NAME,ACCOUNT_CLASS,TOTAL
from (
select distinct ACCOUNT_CLASS,count(*) TOTAL
from IT_MIS_MSISDN3
where ACCOUNT_CLASS not in ('6','15','23','30','31','80','101')
and msisdn not in ( select TERMINAL_NO from REPORT_USER.IT_MIS_DEATIL_DEALER )
and msisdn not in (SELECT MSISDN FROM REPORT_USER.IT_EOD_USER_BALANCE where MSISDN is not null and length(MSISDN)=12)
group by ACCOUNT_CLASS ) a, REPORT_USER.IT_MIS_DR_SPD_INITIAL_BALANCE2 b
where ACCOUNT_CLASS=SERVICE_CLASS_ID(+);

select *
from IT_MIS_MSISDN3
where ACCOUNT_CLASS not in ('6','15','23','30','31','80','101')
and msisdn not in ( select TERMINAL_NO from REPORT_USER.IT_MIS_DEATIL_DEALER  )
and msisdn not in (SELECT MSISDN FROM REPORT_USER.IT_EOD_USER_BALANCE where MSISDN is not null and length(MSISDN)=12)

----------30000 IN SERVICE_CLASS 20 and 29 TO SEND TO ABDOURAHMANE----------------------------------------
select SERVICE_CLASS_NAME,ACCOUNT_CLASS,TOTAL
from (
select distinct ACCOUNT_CLASS,count(*) TOTAL
from IT_MIS_MSISDN3
where ACCOUNT_CLASS in ('20','29')
and msisdn not in ( select TERMINAL_NO from REPORT_USER.IT_MIS_DEATIL_DEALER )
and msisdn not in (SELECT MSISDN FROM REPORT_USER.IT_EOD_USER_BALANCE where MSISDN is not null and length(MSISDN)=12)
and '224'||msisdn not in (select MSISDN from TEMPORAIRE)
group by ACCOUNT_CLASS ) a, REPORT_USER.IT_MIS_DR_SPD_INITIAL_BALANCE2 b
where ACCOUNT_CLASS=SERVICE_CLASS_ID(+)

select *
from IT_MIS_MSISDN3
where ACCOUNT_CLASS in  ('20','29')
and msisdn not in ( select TERMINAL_NO from REPORT_USER.IT_MIS_DEATIL_DEALER  )
and msisdn not in (SELECT MSISDN FROM REPORT_USER.IT_EOD_USER_BALANCE where MSISDN is not null and length(MSISDN)=12)
and msisdn not in (select MSISDN from TEMPORAIRE)
and rownum<=30000

select *
from IT_MIS_MSISDN3
where ACCOUNT_CLASS in  ('20','29')
and msisdn not in ( select TERMINAL_NO from REPORT_USER.IT_MIS_DEATIL_DEALER  )
and msisdn not in (SELECT MSISDN FROM REPORT_USER.IT_EOD_USER_BALANCE where MSISDN is not null and ACCOUNTTYPE='Mobile Money')
and msisdn not IN(select '224'||ACCOUNT_MSISDN from REPORT_USER.IT_DR_IN_STATUS_SUBSCRIBER_SDP group by ACCOUNT_MSISDN having count(ACCOUNT_MSISDN)>1)
and msisdn not in (select MSISDN from TEMPORAIRE)
and rownum<=30000





--------BACKUP TO MAKE SPACE IN IT_MK_TAF_TAF_DEALER_AREA_MJR-------
truncate table IT_MK_TAF_TAF_DEALER_AREA_1904;

insert into IT_MK_TAF_TAF_DEALER_AREA_1904
select * from IT_MK_TAF_TAF_DEALER_AREA_MJR
where UTC_TIMESTAMP<=to_date('28/02/2019','dd/mm/yyyy');

commit;

create table IT_MK_TAF_TAF_DEALER_AREA_1905 as
select * from IT_MK_TAF_TAF_DEALER_AREA_MJR
where UTC_TIMESTAMP>to_date('28/02/2019','dd/mm/yyyy');

commit;


truncate table IT_MK_TAF_TAF_DEALER_AREA_MJR;

 DROP INDEX "REPORT_USER"."DEALER_MSISDN_DAILY_MJR"; commit;
 DROP INDEX "REPORT_USER"."TOTAL_SMS_MJR_DAILY"; commit;
 
insert into IT_MK_TAF_TAF_DEALER_AREA_MJR
select distinct * from IT_MK_TAF_TAF_DEALER_AREA_1905;

commit;

CREATE INDEX REPORT_USER.DEALER_MSISDN_DAILY_MJR ON REPORT_USER.IT_MK_TAF_TAF_DEALER_AREA_MJR
(DEALER_MSISDN)
LOGGING
TABLESPACE DATA
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


CREATE INDEX REPORT_USER.TOTAL_SMS_MJR_DAILY ON REPORT_USER.IT_MK_TAF_TAF_DEALER_AREA_MJR
(TOTAL_SMS)
LOGGING
TABLESPACE DATA
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;

commit;
insert into IT_MK_TAF_TAF_DEALER_AREA_MJRH
SELECT DISTINCT * FROM IT_MK_TAF_TAF_DEALER_AREA_MJRM;

commit; 
 
truncate table IT_MK_TAF_TAF_DEALER_AREA_MJRM;
------------------------------------------------------------

exec dbms_stats.gather_table_stats('report_user','IT_MK_TAF_TAF_DEALER_AREA_MJR') ;

-- DROP INDEX "REPORT_USER"."DEALER_MSISDN_AREA_MONTHLY"; commit;

insert into REPORT_USER.IT_MK_TAF_TAF_DEALER_AREA_MJRM
             select dealer_msisdn,max(cell_id) cell_id ,max(total_sms) total_sms,report_date 
             from 
                          (select dealer_msisdn,cell_id,total_sms, report_date
                            from 
                            (select dealer_msisdn,cell_id,sum(total_sms) total_sms,to_char(utc_timestamp,'yyyymm') report_date
                            from REPORT_USER.IT_MK_TAF_TAF_DEALER_AREA_MJR 
                            where to_char(utc_timestamp,'yyyymm') = to_char(trunc(sysdate-1,'MONTH'),'yyyymm')
                            --and DEALER_MSISDN = '224664413825'
                            group by dealer_msisdn,to_char(utc_timestamp,'yyyymm'),cell_id ) t1
                            where  total_sms = ( select max(total_sms) total_sms 
                                           from 
                                           (select dealer_msisdn, sum(total_sms) total_sms ,cell_id, to_char(utc_timestamp,'yyyymm') report_date
                                            from REPORT_USER.IT_MK_TAF_TAF_DEALER_AREA_MJR 
                                            where to_char(utc_timestamp,'yyyymm') = to_char(trunc(sysdate-1,'MONTH'),'yyyymm')
                                           -- and DEALER_MSISDN = '224664413825'
                                            group by dealer_msisdn,cell_id,to_char(utc_timestamp,'yyyymm')
                                           ) t2 
                                            where t2.dealer_msisdn=t1.dealer_msisdn
                                            and report_date = to_char(trunc(sysdate-1,'MONTH'),'yyyymm')
                                            group by dealer_msisdn
                                          )
                                   ) a  
            group by dealer_msisdn,report_date;
            
            commit;                       


CREATE INDEX REPORT_USER.DEALER_MSISDN_AREA_MONTHLY ON REPORT_USER.IT_MK_TAF_TAF_DEALER_AREA_MJRM
                    (DEALER_MSISDN)
                    LOGGING
                    TABLESPACE DATA
                    PCTFREE    10
                    INITRANS   2
                    MAXTRANS   255
                    STORAGE    (
                                INITIAL          64K
                                NEXT             1M
                                MINEXTENTS       1
                               MAXEXTENTS       UNLIMITED
                                PCTINCREASE      0
                                BUFFER_POOL      DEFAULT
                                FLASH_CACHE      DEFAULT
                                CELL_FLASH_CACHE DEFAULT
                               )
                   NOPARALLEL;

commit;

-------------------------------------------------------------------------------------------------------------------------------------------


--- script pour des données anterieur à  J-1
update REPORT_USER.IT_MK_ERS_SD_POS_TRACK_DTL2
set SENDER=substr(SENDER,1,3)||substr(SENDER_ACCOUNT_ID,-9,9)
where TRANSACTION_TYPE='POS_REFILL_TO_SUBSCRIBER'
and to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy')=to_date('13/11/2018','dd/mm/yyyy')
and substr(SENDER_ACCOUNT_ID,-9,9)<>substr(SENDER,-9,9)
and length(SENDER_ACCOUNT_ID)=13;

COMMIT;

---------  POS AMOUNT SENT  AND BALANCE PER AREA  

insert into  REPORT_USER.IT_MK_ERS_SD_POS_TRACK_AREA 
select   'POS_AREA' DEALER_LOCATION, 
         VILLE,
         COMMUNES,
         GOUVERNORATS,
         REGION_NATURELLE,
         SENDER,
         SENDER_ACCOUNT_ID,
         AMOUNT_SENT,
         BALANCE,
         TRANSACTION_DATE ,
         CELL_ID       
from 
( select   
         TRANSACTION_TYPE,
         SENDER,
         SENDER_ACCOUNT_ID,
         AMOUNT_SENT,
         BALANCE,
         TRANSACTION_DATE
from 
(select  TRANSACTION_TYPE,
        SENDER,
        SENDER_ACCOUNT_ID,
        SUM(ABS(AMOUNT_SENT)) AMOUNT_SENT,
        TRANSACTION_DATE         
from REPORT_USER.IT_MK_ERS_SD_POS_TRACK_DTL2   
where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date('13/11/2018','dd/mm/yyyy') and to_date('13/11/2018','dd/mm/yyyy')
-- where TRANSACTION_DATE between to_date('13/11/2018','dd/mm/yyyy') and to_date('13/11/2018','dd/mm/yyyy')
group by TRANSACTION_TYPE,
        SENDER,
        SENDER_ACCOUNT_ID,
        TRANSACTION_DATE ) t1, 

( select distinct * from REPORT_USER.IT_MIS_DEALER_BALANCE_HIST_B 
   where report_date between to_date('13/11/2018','dd/mm/yyyy') and to_date('13/11/2018','dd/mm/yyyy')
   and RESELLER_TYPE ='PointOfSales' ) t2 
where SENDER_ACCOUNT_ID=RESELLER_ID ) t4, 

(select   DEALER_MSISDN,
         VILLE,
         COMMUNES,
         GOUVERNORATS,
         REGION_NATURELLE ,
         CELL_ID               
from REPORT_USER.IT_MK_TAF_TAF_DEALER_AREA_MJRM ,REPORT_USER.IT_MIS_CELLID_FINAL_2013
where   CELL_ID= CELLID
and UTC_TIMESTAMP =to_char(trunc(sysdate-2,'MONTH'),'yyyymm') ) t3
where  SENDER=DEALER_MSISDN(+);

COMMIT;

------------- EVD TABLE POPULATED
delete from REPORT_USER.IT_MIS_EVD_MODULE  
where TRANSACTION_DATE = to_date('13/11/2018','dd/mm/yyyy');

commit;

insert into REPORT_USER.IT_MIS_EVD_MODULE  
select CELLID,DEALER_LOCATION ROLE,SENDER_ACCOUNT_ID AGENT_ID,SENDER MSISDN,TRANSACTION_DATE 
from REPORT_USER.IT_MK_ERS_SD_POS_TRACK_AREA
where TRANSACTION_DATE = to_date('13/11/2018','dd/mm/yyyy');

commit;

-- Execute immediate ' truncate table IT_MK_DEALER_BALANCE' ; 
 
---- MTNATL DAILY REFILL TRANSACTIONS 
delete from mckinsey_user.IT_MK_ERS_TDR_DETAIL_MTNATL@MKDBLINK
where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date('13/11/2018','dd/mm/yyyy') and to_date('13/11/2018','dd/mm/yyyy');
             
     commit;  

insert into mckinsey_user.IT_MK_ERS_TDR_DETAIL_MTNATL@MKDBLINK  
select * from report_user.IT_MK_ERS_TDR_DETAIL_MTNATL
where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date('13/11/2018','dd/mm/yyyy') and to_date('13/11/2018','dd/mm/yyyy');
             
     commit;

     
------ DIOSTRIBUTOR TRANSACTION TRACK ---
delete from mckinsey_user.IT_MK_ERS_DISTRIBUTOR_TRACK@MKDBLINK
where REPORT_DATE  between to_date('13/11/2018','dd/mm/yyyy') and to_date('13/11/2018','dd/mm/yyyy');
             
     commit;
     
insert into mckinsey_user.IT_MK_ERS_DISTRIBUTOR_TRACK@MKDBLINK  
SELECT * from report_user.IT_MK_ERS_DISTRIBUTOR_TRACK
where REPORT_DATE  between to_date('13/11/2018','dd/mm/yyyy') and to_date('13/11/2018','dd/mm/yyyy');
             
     commit;
    

----SD and POS REFILL AND BALANCE PER AREA  
delete from mckinsey_user.IT_MK_ERS_SD_POS_TRACK_AREA@MKDBLINK
where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy')  between to_date('13/11/2018','dd/mm/yyyy') and to_date('13/11/2018','dd/mm/yyyy');
             
     commit;
     
insert into  mckinsey_user.IT_MK_ERS_SD_POS_TRACK_AREA@MKDBLINK 
select * from report_user.IT_MK_ERS_SD_POS_TRACK_AREA
where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy')  between to_date('13/11/2018','dd/mm/yyyy') and to_date('13/11/2018','dd/mm/yyyy');
             
     commit;
     

------------- EVD TABLE POPULATED

delete from mckinsey_user.IT_MIS_EVD_MODULE@MKDBLINK  
where TRANSACTION_DATE = to_date('13/11/2018','dd/mm/yyyy');

commit;


insert into mckinsey_user.IT_MIS_EVD_MODULE@MKDBLINK  
select CELLID,DEALER_LOCATION ROLE,SENDER_ACCOUNT_ID AGENT_ID,SENDER MSISDN,TRANSACTION_DATE 
from report_user.IT_MK_ERS_SD_POS_TRACK_AREA
where TRANSACTION_DATE = to_date('13/11/2018','dd/mm/yyyy');

commit;


delete from mckinsey_user.IT_MK_ERS_SD_POS_TRACK_DTL@MKDBLINK
where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy')  between to_date('13/11/2018','dd/mm/yyyy') and to_date('13/11/2018','dd/mm/yyyy');
             
     commit;      


     
delete from REPORT_USER.IT_MK_ERS_SD_POS_TRACK_DTL
where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy')  between to_date('13/11/2018','dd/mm/yyyy') and to_date('13/11/2018','dd/mm/yyyy');
             
     commit;  

insert into REPORT_USER.IT_MK_ERS_SD_POS_TRACK_DTL 
select 'POS_REFILL_TO_SUBSCRIBER' TRANSACTION_TYPE,to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') TRANSACTION_DATE,INITIATOR_MSISDN SENDER,INITIATOR_RESELLER_ID SENDER_ACCOUNT_ID,
RECEIVER_RESELLER_ID RECEIVER_ACCOUNT_ID,RECEIVER_MSISDN RECEIVER,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181113_TDR_DETAIL_CELLID_NW)
WHERE --to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
--and 
UPPER(TRANSACTION_TYPE)='TOPUP' 
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
group by to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy'),INITIATOR_MSISDN,INITIATOR_RESELLER_ID,RECEIVER_RESELLER_ID,RECEIVER_MSISDN;

commit; 
  
---------  SD TRACKING TRANSACTION 

insert into mckinsey_user.IT_MK_ERS_SD_POS_TRACK_DTL@MKDBLINK  
select *  from report_user.IT_MK_ERS_SD_POS_TRACK_DTL
where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy')  between to_date('13/11/2018','dd/mm/yyyy') and to_date('13/11/2018','dd/mm/yyyy');
             
commit; 


-----------------REGULARISATION TAF TAF DEALER-------------------------------

------  -- 1) spooltaftafdealersarea -> 6h
------2) IT_MIS_TAFTAF_DEALER_AREA_PROC -> 7h
------3) IT_ERS_TAF_TAF_DEALER_BALANCE -> 8h
------4 ) Aliou to create 
---- MTNATL DAILY REFILL TRANSACTIONS

----------------MACKINZEY DB---------------------------------- 
delete from mckinsey_user.IT_MK_ERS_TDR_DETAIL_MTNATL
where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy');
             
commit; 

------ DIOSTRIBUTOR TRANSACTION TRACK ---
delete from mckinsey_user.IT_MK_ERS_DISTRIBUTOR_TRACK
where REPORT_DATE  between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy');
             
commit;

delete from mckinsey_user.IT_MK_ERS_SD_POS_TRACK_AREA
where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy')  between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy');
             
commit;


delete from mckinsey_user.IT_MIS_EVD_MODULE  
where TRANSACTION_DATE = to_date('01/04/2019','dd/mm/yyyy');

commit;

delete from mckinsey_user.IT_MK_ERS_SD_POS_TRACK_DTL
where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy')  between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy');
             
     commit; 
     
--------------------REPORT USER----------------


delete from REPORT_USER.IT_MK_ERS_TDR_DETAIL_MTNATL
where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy');
             
     commit;
     
delete from REPORT_USER.IT_MK_ERS_DISTRIBUTOR_TRACK
where REPORT_DATE  between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy');
             
     commit;
     
delete from REPORT_USER.IT_MK_ERS_SD_POS_TRACK_AREA
where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy')  between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy');
             
     commit;


   
---- MTNATL DAILY REFILL TRANSACTIONS 

insert into REPORT_USER.IT_MK_ERS_TDR_DETAIL_MTNATL  
select END_TIME TRANSACTION_DATE,ERSREFERENCE,SENDER_RESELLER_ID SENDERRESELLERID,RECEIVER_MSISDN,RECEIVER_RESELLER_ID RECEIVER_ID,REQUEST_AMOUNT_VALUE/100 SENDERAMOUNT,
RECEIVER_AMOUNT_VALUE/100 RECEIVER_AMOUNT,TRANSACTION_PROFILE TRANSACTION_TYPE_DESC,RECEIVER_BALANCE_VALUE_BEFORE RECEIVERBALANCEVALUEBEFORE,RECEIVER_BALANCE_VALUE_AFTER SENDERBALANCEVALUEAFTER,INITIATOR_USER_ID REMOTEADDRESS
from report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190401_TDR_DETAIL_CELLID_NW)
WHERE --to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
--and 
TRANSACTION_PROFILE='CREDIT_TRANSFER'
and UPPER(CLIENT_TYPE) like'WEB%'
and (upper(RECEIVER_ACCOUNT_ID) like'D%' OR upper(RECEIVER_ACCOUNT_ID) like'SD_S%')
and upper(RESULT_STATUS)='SUCCESS'
AND UPPER(TRANSACTION_TYPE)='TRANSFER' 
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N';

commit;


------ DIOSTRIBUTOR TRANSACTION TRACK ---

insert into REPORT_USER.IT_MK_ERS_DISTRIBUTOR_TRACK  
select   
         REFILL_TYPE, 
         t2.RESELLER_ID,
         case when length(RESELLER_ID)=10 then '2246'||substr(RESELLER_ID,3,8) else '224'||substr(RESELLER_ID,3,9) end RESELLER_MSISDN,
         decode(RESELLER_ID,'D_660105068','AROBASE_INLAND1','D_661220909','CPS','D_69635323','GUESSECOM','d_64722500','AROBASE','D_64639533','OKB','D_664229580','ETS_ADF','NEW_DISTRI')  DISTRIBUTOR,
         nvl(RECEIVER_AMOUNT,0) AMOUNT_RECEIVED,
         BALANCE,
         t2.REPORT_DATE
         
from 
( select   'MTN_REFILL_TO_DISTRIBUTOR' REFILL_TYPE, 
         RECEIVER_ID,
         RECEIVER_MSISDN,
        decode(RECEIVER_ID,'D_660105068','AROBASE_INLAND1','D_661220909','CPS','D_69635323','GUESSECOM','d_64722500','AROBASE','D_64639533','OKB','D_664229580','ETS_ADF','NEW_DISTRI')  DISTRIBUTOR,
        sum(RECEIVER_AMOUNT) RECEIVER_AMOUNT, 
        to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy') report_date
from REPORT_USER.IT_MK_ERS_TDR_DETAIL_MTNATL
--where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date('09/11/2015','dd/mm/yyyy') and to_date('09/11/2015','dd/mm/yyyy')
where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy')
group by RECEIVER_ID,
         RECEIVER_MSISDN,
         decode(RECEIVER_MSISDN,'D_660105068','AROBASE_INLAND1','D_661220909','CPS','D_69635323','GUESSECOM','d_64722500','AROBASE','D_64639533','OKB','D_664229580','ETS_ADF','NEW_DISTRI'),
         to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy')
 )  t1,
 
 ( select * from REPORT_USER.IT_MIS_DEALER_BALANCE_HIST_B 
   where report_date between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy')
   and RESELLER_TYPE ='Distributor' ) t2 
 
 where t1.RECEIVER_ID(+)=t2.RESELLER_ID
 and   t1.REPORT_DATE(+)=t2.REPORT_DATE
 and BALANCE > 1000000
 order by BALANCE desc; 

COMMIT;


---- DISTRIBUTOR REFILL AND BALANCE PER AREA  

insert into  REPORT_USER.IT_MK_ERS_SD_POS_TRACK_AREA 
select  'DISTRIBUTOR_AREA' DEALER_LOCATION, 
                  VILLE,
                 COMMUNES,
                 GOUVERNORATS,
                 REGION_NATURELLE,
                 RESELLER_ID,
                 DISTRIBUTOR,
                 AMOUNT_RECEIVED,
                 BALANCE,
                 REPORT_DATE ,
                 CELL_ID
from REPORT_USER.IT_MK_ERS_DISTRIBUTOR_TRACK , REPORT_USER.IT_MK_TAF_TAF_DEALER_AREA_MJRM ,REPORT_USER.IT_MIS_CELLID_FINAL_2013
where RECEIVER_MSISDN(+)=DEALER_MSISDN
and to_char(REPORT_DATE,'yyyymm')=UTC_TIMESTAMP 
and report_date = to_date('01/04/2019','dd/mm/yyyy')
and CELL_ID= CELLID(+);

COMMIT;

truncate table IT_MK_ERS_SD_POS_TRACK_DTL2;

---------  SD TRACKING TRANSACTION 
insert into REPORT_USER.IT_MK_ERS_SD_POS_TRACK_DTL2  
select 'SD_REFILL_TO_SD_AND_POS' TRANSACTION_TYPE,to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') TRANSACTION_DATE,INITIATOR_MSISDN SENDER,
INITIATOR_RESELLER_ID SENDER_ACCOUNT_ID,RECEIVER_RESELLER_ID RECEIVER_ACCOUNT_ID,RECEIVER_MSISDN RECEIVER,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190401_TDR_DETAIL_CELLID_NW)
WHERE --to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') 
--and 
upper(RESULT_STATUS)='SUCCESS' 
and UPPER(TRANSACTION_TYPE)='TRANSFER'  
and upper(SENDER_RESELLER_TYPE) LIKE'SD%'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N' 
group by to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy'),INITIATOR_MSISDN,INITIATOR_RESELLER_ID,RECEIVER_RESELLER_ID,RECEIVER_MSISDN;

commit;


--select * from  REPORT_USER.IT_MK_ERS_SD_POS_TRACK_DTL2



---------  SD  AMOUNT SENT  AND BALANCE PER AREA  
insert into  REPORT_USER.IT_MK_ERS_SD_POS_TRACK_AREA  
select   'SD_AREA' DEALER_LOCATION, 
         VILLE,
         COMMUNES,
         GOUVERNORATS,
         REGION_NATURELLE,
         SENDER,
         SENDER_ACCOUNT_ID,
         AMOUNT_SENT,
         BALANCE,
         TRANSACTION_DATE ,
         CELL_ID       
from 
( select   
         TRANSACTION_TYPE,
         SENDER,
         SENDER_ACCOUNT_ID,
         AMOUNT_SENT,
         BALANCE,
         TRANSACTION_DATE
from 
(select  TRANSACTION_TYPE,
        SENDER,
        SENDER_ACCOUNT_ID,
        SUM(ABS(AMOUNT_SENT)) AMOUNT_SENT,
        TRANSACTION_DATE         
from REPORT_USER.IT_MK_ERS_SD_POS_TRACK_DTL2   
-- where TRANSACTION_DATE between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy')
where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy')
and TRANSACTION_TYPE='SD_REFILL_TO_SD_AND_POS' 
group by TRANSACTION_TYPE,
        SENDER,
        SENDER_ACCOUNT_ID,
        TRANSACTION_DATE ) t1, 

( select distinct * from REPORT_USER.IT_MIS_DEALER_BALANCE_HIST_B 
   where report_date between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy')
   and RESELLER_TYPE ='SubDistributor' ) t2 
where SENDER_ACCOUNT_ID=RESELLER_ID ) t4, 

(select   DEALER_MSISDN,
         VILLE,
         COMMUNES,
         GOUVERNORATS,
         REGION_NATURELLE  ,
         CELL_ID       
from REPORT_USER.IT_MK_TAF_TAF_DEALER_AREA_MJRM ,REPORT_USER.IT_MIS_CELLID_FINAL_2013
where   CELL_ID= CELLID
and UTC_TIMESTAMP =to_char(trunc(SYSDATE-1,'MONTH'),'yyyymm') ) t3
where  SENDER=DEALER_MSISDN(+);

COMMIT;

--select TRANSACTION_DATE from  REPORT_USER.IT_MK_ERS_SD_POS_TRACK_DTL2
-- group by TRANSACTION_DATE 

---------  POS TRACKING TRANSACTION 

insert into REPORT_USER.IT_MK_ERS_SD_POS_TRACK_DTL2 
select 'POS_REFILL_TO_SUBSCRIBER' TRANSACTION_TYPE,to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') TRANSACTION_DATE,INITIATOR_MSISDN SENDER,INITIATOR_RESELLER_ID SENDER_ACCOUNT_ID,
RECEIVER_RESELLER_ID RECEIVER_ACCOUNT_ID,RECEIVER_MSISDN RECEIVER,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190401_TDR_DETAIL_CELLID_NW)
WHERE --to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
--and 
UPPER(TRANSACTION_TYPE)='TOPUP' 
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
group by to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy'),INITIATOR_MSISDN,INITIATOR_RESELLER_ID,RECEIVER_RESELLER_ID,RECEIVER_MSISDN;

commit;   


--- script pour des données anterieur à  J-1
update IT_MK_ERS_SD_POS_TRACK_DTL2
set SENDER=substr(SENDER,1,3)||substr(SENDER_ACCOUNT_ID,-9,9)
where TRANSACTION_TYPE='POS_REFILL_TO_SUBSCRIBER'
and to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy')=to_date('01/04/2019','dd/mm/yyyy')
and substr(SENDER_ACCOUNT_ID,-9,9)<>substr(SENDER,-9,9)
and length(SENDER_ACCOUNT_ID)=13;

COMMIT;

---------  POS AMOUNT SENT  AND BALANCE PER AREA  

insert into  REPORT_USER.IT_MK_ERS_SD_POS_TRACK_AREA 
select   'POS_AREA' DEALER_LOCATION, 
         VILLE,
         COMMUNES,
         GOUVERNORATS,
         REGION_NATURELLE,
         SENDER,
         SENDER_ACCOUNT_ID,
         AMOUNT_SENT,
         BALANCE,
         TRANSACTION_DATE ,
         CELL_ID       
from 
( select   
         TRANSACTION_TYPE,
         SENDER,
         SENDER_ACCOUNT_ID,
         AMOUNT_SENT,
         BALANCE,
         TRANSACTION_DATE
from 
(select  TRANSACTION_TYPE,
        SENDER,
        SENDER_ACCOUNT_ID,
        SUM(ABS(AMOUNT_SENT)) AMOUNT_SENT,
        TRANSACTION_DATE         
from REPORT_USER.IT_MK_ERS_SD_POS_TRACK_DTL2   
where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy')
-- where TRANSACTION_DATE between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy')
group by TRANSACTION_TYPE,
        SENDER,
        SENDER_ACCOUNT_ID,
        TRANSACTION_DATE ) t1, 

( select distinct * from REPORT_USER.IT_MIS_DEALER_BALANCE_HIST_B 
   where report_date between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy')
   and RESELLER_TYPE ='PointOfSales' ) t2 
where SENDER_ACCOUNT_ID=RESELLER_ID ) t4, 

(select   DEALER_MSISDN,
         VILLE,
         COMMUNES,
         GOUVERNORATS,
         REGION_NATURELLE ,
         CELL_ID               
from REPORT_USER.IT_MK_TAF_TAF_DEALER_AREA_MJRM ,REPORT_USER.IT_MIS_CELLID_FINAL_2013
where   CELL_ID= CELLID
and UTC_TIMESTAMP =to_char(trunc(SYSDATE-1,'MONTH'),'yyyymm') ) t3
where  SENDER=DEALER_MSISDN(+);

COMMIT;

------------- EVD TABLE POPULATED
delete from REPORT_USER.IT_MIS_EVD_MODULE  
where TRANSACTION_DATE = to_date('01/04/2019','dd/mm/yyyy');

commit;

insert into REPORT_USER.IT_MIS_EVD_MODULE  
select CELLID,DEALER_LOCATION ROLE,SENDER_ACCOUNT_ID AGENT_ID,SENDER MSISDN,TRANSACTION_DATE 
from REPORT_USER.IT_MK_ERS_SD_POS_TRACK_AREA
where TRANSACTION_DATE = to_date('01/04/2019','dd/mm/yyyy');

commit;

-- Execute immediate ' truncate table IT_MK_DEALER_BALANCE' ; 
 
---- MTNATL DAILY REFILL TRANSACTIONS 
delete from mckinsey_user.IT_MK_ERS_TDR_DETAIL_MTNATL@MKDBLINK
where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy');
             
     commit;  

insert into mckinsey_user.IT_MK_ERS_TDR_DETAIL_MTNATL@MKDBLINK  
select * from report_user.IT_MK_ERS_TDR_DETAIL_MTNATL
where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy');
             
     commit;

     
------ DIOSTRIBUTOR TRANSACTION TRACK ---
delete from mckinsey_user.IT_MK_ERS_DISTRIBUTOR_TRACK@MKDBLINK
where REPORT_DATE  between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy');
             
     commit;
     
insert into mckinsey_user.IT_MK_ERS_DISTRIBUTOR_TRACK@MKDBLINK  
SELECT * from report_user.IT_MK_ERS_DISTRIBUTOR_TRACK
where REPORT_DATE  between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy');
             
     commit;
    

----SD and POS REFILL AND BALANCE PER AREA  
delete from mckinsey_user.IT_MK_ERS_SD_POS_TRACK_AREA@MKDBLINK
where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy')  between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy');
             
     commit;
     
insert into  mckinsey_user.IT_MK_ERS_SD_POS_TRACK_AREA@MKDBLINK 
select * from report_user.IT_MK_ERS_SD_POS_TRACK_AREA
where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy')  between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy');
             
     commit;
     

------------- EVD TABLE POPULATED

delete from mckinsey_user.IT_MIS_EVD_MODULE@MKDBLINK  
where TRANSACTION_DATE = to_date('01/04/2019','dd/mm/yyyy');

commit;


insert into mckinsey_user.IT_MIS_EVD_MODULE@MKDBLINK  
select CELLID,DEALER_LOCATION ROLE,SENDER_ACCOUNT_ID AGENT_ID,SENDER MSISDN,TRANSACTION_DATE 
from report_user.IT_MK_ERS_SD_POS_TRACK_AREA
where TRANSACTION_DATE = to_date('01/04/2019','dd/mm/yyyy');

commit;


delete from mckinsey_user.IT_MK_ERS_SD_POS_TRACK_DTL@MKDBLINK
where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy')  between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy');
             
     commit;      


     
delete from REPORT_USER.IT_MK_ERS_SD_POS_TRACK_DTL
where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy')  between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy');
             
     commit;  

insert into REPORT_USER.IT_MK_ERS_SD_POS_TRACK_DTL 
select 'POS_REFILL_TO_SUBSCRIBER' TRANSACTION_TYPE,to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') TRANSACTION_DATE,INITIATOR_MSISDN SENDER,INITIATOR_RESELLER_ID SENDER_ACCOUNT_ID,
RECEIVER_RESELLER_ID RECEIVER_ACCOUNT_ID,RECEIVER_MSISDN RECEIVER,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190401_TDR_DETAIL_CELLID_NW)
WHERE --to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
--and 
UPPER(TRANSACTION_TYPE)='TOPUP' 
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
group by to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy'),INITIATOR_MSISDN,INITIATOR_RESELLER_ID,RECEIVER_RESELLER_ID,RECEIVER_MSISDN;

commit; 
  
---------  SD TRACKING TRANSACTION 

insert into mckinsey_user.IT_MK_ERS_SD_POS_TRACK_DTL@MKDBLINK  
select *  from report_user.IT_MK_ERS_SD_POS_TRACK_DTL
where to_date(to_char(TRANSACTION_DATE,'dd/mm/yyyy'),'dd/mm/yyyy')  between to_date('01/04/2019','dd/mm/yyyy') and to_date('01/04/2019','dd/mm/yyyy');
             
commit; 
     
     /* 
delete from report_user.IT_MIS_ERS_TDR_ADJUST_DETAIL@MKDBLINK
WHERE to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy')=to_date('01/04/2019','dd/mm/yyyy');

commit;

INSERT INTO IT_MIS_ERS_TDR_ADJUST_DETAIL@MKDBLINK
select * 
from report_user.IT_MIS_ERS_TDR_ADJUST_DETAIL
WHERE to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy')=to_date('01/04/2019','dd/mm/yyyy');

commit; */   
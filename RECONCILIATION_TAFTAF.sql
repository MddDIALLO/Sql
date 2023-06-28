--------------- FROM CRS (topup)
select substr(TRANSACTION_DATE,1,8) TRANSACTION_DATE,sum(ERS_TOTAL_AMOUNT) ERS_TOTAL_AMOUNT 
from REPORT_USER.IT_MK_ERS_REFILL_AMOUNT
where TRANSACTION_DATE like'201811%'
group by substr(TRANSACTION_DATE,1,8)
order by TRANSACTION_DATE

--------------- TAFTAF TRANSACTION POS FROM ERS (TDR FILE)

-------- TAFTAF TRANSACTION AREA
select DEALER_LOCATION,TRANSACTION_DATE,sum(AMOUNT_SENT) AMOUNT_SENT
from REPORT_USER.IT_MK_ERS_SD_POS_TRACK_AREA 
where DEALER_LOCATION='POS_AREA' 
and 
TRANSACTION_DATE between to_date('01/11/2018','dd/mm/yyyy') and to_date('07/11/2018','dd/mm/yyyy')
group by DEALER_LOCATION,TRANSACTION_DATE
order by TRANSACTION_DATE


--------------- TAFTAF TRANSACTION POS (GLOBAL REPORT) --------------- TAFTAF TRANSACTION POS FROM ERS-----------------
select 'D20181101' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181101_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181102' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181102_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181103' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181103_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181104' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181104_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181105' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181105_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION ALL
select 'D20181106' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181106_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181107' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181107_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181108' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181108_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181109' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181109_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181110' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181110_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181111' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181111_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181112' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181112_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181113' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181113_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181114' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181114_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181115' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181115_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION ALL
select 'D20181116' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181116_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181117' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181117_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181118' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181118_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181119' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181119_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181120' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181120_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181121' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181121_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181122' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181122_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181123' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181123_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181124' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181124_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181125' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181125_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION ALL
select 'D20181126' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181126_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181127' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181127_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181128' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181128_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181129' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181129_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181130' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181130_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
UNION All
select 'D20181131' TRANSACTION_DATE,
sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
from REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20181131_TDR_DETAIL_CELLID_NW)
WHERE UPPER(TRANSACTION_TYPE)='TOPUP' 
--and to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1 ,'dd/mm/yyyy'),'dd/mm/yyyy')
and upper(RESULT_STATUS)='SUCCESS'
and upper(SENDER_RESELLER_TYPE)='POS'
and upper(RECEIVER_AMOUNT_VALUE)<>'\N'
and upper(REQUEST_AMOUNT_VALUE)<>'\N'
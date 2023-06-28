---------------------------------------prepaid roaming report -------------------------------------------------------
----- VOICE
select report_date,transaction_type,trunc(sum(OPACCUMSEC)+sum(PACCUMSEC)) DURATION,
       trunc(sum(opunits)+sum(punits)) REVENUE  
from IT_MIS_CRS_REV_MONTHLY_FINAL3
where report_date LIKE'201811%' -- TO_CHAR(SYSDATE-1,'YYYYMMDD')
and transaction_type like '%CAPV2%'
--and transaction_type  in ('Voice Int  NONE WECA')
group by report_date,transaction_type 


------SMS
select report_date,transaction_type,trunc(sum(OPCALLS)+sum(PCALLS)) TOTAL,
       trunc(sum(opunits)+sum(punits)) REVENUE  
from IT_MIS_CRS_REV_MONTHLY_FINAL3
where report_date LIKE'201811%' -- TO_CHAR(SYSDATE-1,'YYYYMMDD')
and transaction_type like 'S%ROAM%'
--and transaction_type  in ('Voice Int  NONE WECA')
group by report_date,transaction_type
----------------------------------------------------------------------------------------------------------------------

-----------------------------SCRIPTS USEDVOUCHERS load regularisation-------------------------------------------------

delete from IT_MK_VOUCHER_REFILL_AMOUNT where substr(STAT_DATE,1,8) between '20181030' and '20181030';

commit;

alter table IT_MK_VOUCHER_REFILL1 LOCATION(DR_DIR_USEDVOUC_FILES:'USDV_20181030.txt');

commit;

insert into IT_MK_VOUCHER_REFILL_AMOUNT(VOUCHER_TYPE,TOTAL_REFILL,TOTAL_AMOUNT,STAT_DATE) 
select decode(b.AMOUNT,2000,'2K',5000,'5K',10000,'10K',20000,'20K',50000,'50K',100000,'100K') VOUCHER_TYPE,count(1) TOTAL_REFILL,b.AMOUNT*count(1)TOTAL_AMOUNT,substr(activation_date,7,4)||substr(activation_date,4,2)||substr(activation_date,1,2)||'12' 
from IT_MK_VOUCHER_REFILL1 b
WHERE substr(b.ACTIVATION_DATE,12,2) between '00' and '11'
group by b.AMOUNT,substr(activation_date,7,4)||substr(activation_date,4,2)||substr(activation_date,1,2)||'12' order by TOTAL_REFILL desc;
COMMIT;

insert into IT_MK_VOUCHER_REFILL_AMOUNT(VOUCHER_TYPE,TOTAL_REFILL,TOTAL_AMOUNT,STAT_DATE) 
select decode(b.AMOUNT,2000,'2K',5000,'5K',10000,'10K',20000,'20K',50000,'50K',100000,'100K') VOUCHER_TYPE,count(1) TOTAL_REFILL,b.AMOUNT*count(1)TOTAL_AMOUNT,substr(activation_date,7,4)||substr(activation_date,4,2)||substr(activation_date,1,2)||'20' 
from IT_MK_VOUCHER_REFILL1 b
WHERE substr(b.ACTIVATION_DATE,12,2) between '12' and '19'
group by b.AMOUNT,substr(activation_date,7,4)||substr(activation_date,4,2)||substr(activation_date,1,2)||'20' order by TOTAL_REFILL desc;
COMMIT;

insert into IT_MK_VOUCHER_REFILL_AMOUNT(VOUCHER_TYPE,TOTAL_REFILL,TOTAL_AMOUNT,STAT_DATE) 
select decode(b.AMOUNT,2000,'2K',5000,'5K',10000,'10K',20000,'20K',50000,'50K',100000,'100K') VOUCHER_TYPE,count(1) TOTAL_REFILL,b.AMOUNT*count(1)TOTAL_AMOUNT,substr(activation_date,7,4)||substr(activation_date,4,2)||substr(activation_date,1,2)||'24' 
from IT_MK_VOUCHER_REFILL1 b
WHERE substr(b.ACTIVATION_DATE,12,2) between '20' and '23'
group by b.AMOUNT,substr(activation_date,7,4)||substr(activation_date,4,2)||substr(activation_date,1,2)||'24' order by TOTAL_REFILL desc;

COMMIT;

delete from IT_MK_VOUCHER_REFILL_DAILY d
where SUBSTR(d.ACTIVATION_DATE,7,4)='2018'
and SUBSTR(d.ACTIVATION_DATE,4,2)='06'
AND SUBSTR(d.ACTIVATION_DATE,1,2)='10'
AND SUBSTR(d.ACTIVATION_DATE,1,2)='30';

commit;


insert into IT_MK_VOUCHER_REFILL_DAILY
select *
from IT_MK_VOUCHER_REFILL1 b;

commit;

delete FROM report_user.IT_MK_VOUCHER_REFILL_AMOUNT where length(STAT_DATE)<6;

            commit;

delete from IT_MK_VOUCHER_GLOBAL_REPORT  
            where to_date(STAT_DATE,'yyyymmdd') between TRUNC(SYSDATE-1,'MONTH') AND TO_DATE (TO_CHAR(SYSDATE-1,'dd/mm/yyyy'),'dd/mm/yyyy');

            commit;

            -- VOUCHERS SCRIPT 
            insert into IT_MK_VOUCHER_GLOBAL_REPORT  
            select a.VOUCHER_TYPE,sum(a.TOTAL_REFILL) TOTAL_VOUCHERS_REFILL,sum(a.TOTAL_AMOUNT) TOTAL_AMOUNT_VOUCHERS_REFILL,substr(a.STAT_DATE,1,8) STAT_DATE
            from IT_MK_VOUCHER_REFILL_AMOUNT a 
            where to_date(substr(a.STAT_DATE,1,8),'yyyymmdd') between TRUNC(SYSDATE-1,'MONTH') AND TO_DATE (TO_CHAR(SYSDATE-1,'dd/mm/yyyy'),'dd/mm/yyyy') 
            group by a.VOUCHER_TYPE,substr(a.STAT_DATE,1,8)
            order by substr(a.STAT_DATE,1,8);
            
            delete from IT_MK_ERS_GLOBAL_REPORT
            where to_date(TRANSACTION_DATE,'yyyymmdd') between TRUNC(SYSDATE-1,'MONTH') AND TO_DATE (TO_CHAR(SYSDATE-1,'dd/mm/yyyy'),'dd/mm/yyyy');
            
            commit;
            
            -- ERS  SCRIPT 
            insert into IT_MK_ERS_GLOBAL_REPORT  
            select b.ERS_TYPE_REFILL,sum(b.ERS_TOTAL_TRANSACTION)ERS_TOTAL_TRANSACTION ,sum(b.ERS_TOTAL_AMOUNT)ERS_TOTAL_AMOUNT,substr(b.TRANSACTION_DATE,1,8)TRANSACTION_DATE
            from IT_MK_ERS_REFILL_AMOUNT b
            where to_date(substr(b.TRANSACTION_DATE,1,8),'yyyymmdd') between TRUNC(SYSDATE-1,'MONTH') AND TO_DATE (TO_CHAR(SYSDATE-1,'dd/mm/yyyy'),'dd/mm/yyyy') -- = to_date(record_current_date.name,'yyyymmdd') 
            group by b.ERS_TYPE_REFILL,substr(b.TRANSACTION_DATE,1,8)
            order by substr(b.TRANSACTION_DATE,1,8); 
            
            commit;
            
            --- FAF SCRIPT 
             delete from IT_MK_FAF_GLOBAL_REPORT
            where DATE_TRANSACTION between TRUNC(SYSDATE-1,'MONTH') AND TO_DATE (TO_CHAR(SYSDATE-1,'dd/mm/yyyy'),'dd/mm/yyyy');
            
            commit;
            
            insert into IT_MK_FAF_GLOBAL_REPORT 
            select  to_date(SUBSTR(DATE_TRANSACTION,1,10),'yyyy-mm-dd') DATE_TRANSACTION,
            sum(case when  TRANSACTION_TYPE in ( 'VAS_MANAGER_FAF_ADD','FAF_ADD') then 1 end ) FAF_TOTAL_ACTIVATION,
            sum(case when  TRANSACTION_TYPE in ( 'VAS_MANAGER_FAF_REMOVE','FAF_REMOVE') then nvl(1,0) end ) FAF_TOTAL_DESACTIVATION,
            count(1) TOTAL_TRANSACTION,
            sum( case when TRANSACTION_TYPE in ( 'VAS_MANAGER_FAF_ADD','FAF_ADD') then 500 end) TOTAL_FAF_ADD_AMOUNT
            from IT_MK_ERS_FAF_DETAIL
            where STATUS like '0'
            and to_date(SUBSTR(DATE_TRANSACTION,1,10),'yyyy-mm-dd') between TRUNC(SYSDATE-1,'MONTH') AND TO_DATE (TO_CHAR(SYSDATE-1,'dd/mm/yyyy'),'dd/mm/yyyy')--= to_date(record_current_date.name,'yyyy/mm/dd')  --to_date(SUBSTR(DATE_TRANSACTION,1,10),'yyyy-mm-dd')
            group by to_date(SUBSTR(DATE_TRANSACTION,1,10),'yyyy-mm-dd')
            order by to_date(SUBSTR(DATE_TRANSACTION,1,10),'yyyy-mm-dd') ;
--             
            commit;
            
          ---- FAF DASHBOARD STAT     
           delete from IT_MK_DASHBOARD_REPORT_FAF
            where DATE_TRANSACTION between TRUNC(SYSDATE-1,'MONTH') AND TO_DATE (TO_CHAR(SYSDATE-1,'dd/mm/yyyy'),'dd/mm/yyyy');
            
            commit;
            
            insert into IT_MK_DASHBOARD_REPORT_FAF  
            select FAF_SUBSCRIBERS,FAF_LIST_SUBSCRIBERS,FAF_TOTAL_ACTIVATION,FAF_TOTAL_DESACTIVATION,TOTAL_FAF_ADD_AMOUNT,DATE_TRANSACTION
            from 
            ( ---- SCRIPT FAF SCRIBERS 
            select sum((b.FAF_1_MSISDN+b.FAF_2_MSISDN+b.FAF_3_MSISDN+b.FAF_4_MSISDN+b.FAF_5_MSISDN)) FAF_SUBSCRIBERS,sum(b.FAF_3_SUBS_TOTAL) FAF_LIST_SUBSCRIBERS ,to_date(b.STAT_DATE,'dd/mm/yyyy')STAT_DATE
            from IT_MIS_FAF_SUBSCRIBER_REPORT b
            where to_date(b.STAT_DATE,'dd/mm/yyyy') between TRUNC(SYSDATE-1,'MONTH') AND TO_DATE (TO_CHAR(SYSDATE-1,'dd/mm/yyyy'),'dd/mm/yyyy')--= to_date(record_current_date.name,'yyyy/mm/dd') 
            group by to_date(b.STAT_DATE,'dd/mm/yyyy')) t6,
            (---- SCRIPT FAF ACTIVATION  
            select b.FAF_TOTAL_ACTIVATION,b.FAF_TOTAL_DESACTIVATION,b.TOTAL_FAF_ADD_AMOUNT,DATE_TRANSACTION
            from IT_MK_FAF_GLOBAL_REPORT b
            where b.DATE_TRANSACTION between TRUNC(SYSDATE-1,'MONTH') AND TO_DATE (TO_CHAR(SYSDATE-1,'dd/mm/yyyy'),'dd/mm/yyyy')--=to_date(record_current_date.name,'yyyy/mm/dd') 
            )t7
            where t7.DATE_TRANSACTION=t6.STAT_DATE;
            
            commit;
            
            
--             ---- AIRTIME  DASHBOARD STAT   

---- FAF DASHBOARD STAT     
            delete from IT_MK_DASHBOARD_REPORT_AIRTIME  
            where STAT_DATE between TRUNC(SYSDATE-1,'MONTH') AND TO_DATE (TO_CHAR(SYSDATE-1,'dd/mm/yyyy'),'dd/mm/yyyy');

            commit;
                          
            insert into IT_MK_DASHBOARD_REPORT_AIRTIME  
            select TOTAL_VOUCHERS_REFILL,TOTAL_AMOUNT_VOUCHERS_REFILL,ERS_TOTAL_TRANSACTION,ERS_TOTAL_AMOUNT,TRANSACTION_DATE STAT_DATE
            from 
            (--- VOUCHERS STATS 
            select sum(a.TOTAL_VOUCHERS_REFILL) TOTAL_VOUCHERS_REFILL,sum(a.TOTAL_AMOUNT_VOUCHERS_REFILL)TOTAL_AMOUNT_VOUCHERS_REFILL,to_date(a.STAT_DATE,'yyyy/mm/dd') STAT_DATE
            from IT_MK_VOUCHER_GLOBAL_REPORT a 
            where to_date(a.STAT_DATE,'yyyy/mm/dd') between TRUNC(SYSDATE-1,'MONTH') AND TO_DATE (TO_CHAR(SYSDATE-1,'dd/mm/yyyy'),'dd/mm/yyyy')--=to_date(record_current_date.name,'yyyy/mm/dd') 
            group by to_date(a.STAT_DATE,'yyyy/mm/dd'))t4,
            ( ---- ERS SCRIPT 
            select sum(a.ERS_TOTAL_TRANSACTION) ERS_TOTAL_TRANSACTION,sum(a.ERS_TOTAL_AMOUNT) ERS_TOTAL_AMOUNT,to_date(a.TRANSACTION_DATE,'yyyy/mm/dd') TRANSACTION_DATE
            from IT_MK_ERS_GLOBAL_REPORT a
            where to_date(a.TRANSACTION_DATE,'yyyy/mm/dd') between TRUNC(SYSDATE-1,'MONTH') AND TO_DATE (TO_CHAR(SYSDATE-1,'dd/mm/yyyy'),'dd/mm/yyyy')--=to_date(record_current_date.name,'yyyy/mm/dd')  
            group by to_date(a.TRANSACTION_DATE,'yyyy/mm/dd'))t3
            where t3.TRANSACTION_DATE=t4.STAT_DATE;
                        
           commit;

DELETE FROM IT_MIS_DR_INPUT_OUTPUT_TBL WHERE TRANSACTION_DESCRIPTION='USED VOUCHERS LOADED' 
AND REPORT_DATE BETWEEN TRUNC(sysdate-1,'month') AND TO_DATE(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');

COMMIT;

INSERT INTO report_user.IT_MIS_DR_INPUT_OUTPUT_TBL
SELECT 'INPUT' TRANSACTION_TYPE,
        'USED VOUCHERS LOADED',
        SUM(TOTAL_AMOUNT),
        TO_DATE(SUBSTR(STAT_DATE,1,8),'YYYY/MM/DD') REPORT_DATE
FROM report_user.IT_MK_VOUCHER_REFILL_AMOUNT
WHERE TO_DATE(SUBSTR(STAT_DATE,1,8),'YYYY/MM/DD') BETWEEN TRUNC(sysdate-1,'month') AND TO_DATE(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
GROUP BY TO_DATE(SUBSTR(STAT_DATE,1,8),'YYYY/MM/DD')
ORDER BY TO_DATE(SUBSTR(STAT_DATE,1,8),'YYYY/MM/DD')DESC;
COMMIT;

DELETE FROM USED_VOUCHERS_MONTHLY_TEMP_2@STOCKDBLINK WHERE USEDDATE=TO_DATE('30/10/2018','DD/MM/YYYY'); COMMIT;

INSERT INTO USED_VOUCHERS_MONTHLY_TEMP_2@STOCKDBLINK d
SELECT distinct d.SERIAL,d.MSISDN,TO_DATE(SUBSTR(d.activation_date,1,2)||'/'||SUBSTR(d.activation_date,4,2)||'/'||SUBSTR(d.activation_date,7,4),'dd/mm/yyyy')  
FROM IT_MK_VOUCHER_REFILL_DAILY d
where SUBSTR(d.ACTIVATION_DATE,7,4)='2018' 
AND SUBSTR(d.ACTIVATION_DATE,4,2)='10'
AND SUBSTR(d.ACTIVATION_DATE,1,2)='30';

COMMIT; 

DELETE FROM USED_VOUCHERS_MONTHLY_OCT18@STOCKDBLINK WHERE USEDDATE=TO_DATE('30/10/2018','DD/MM/YYYY'); COMMIT;

INSERT INTO USED_VOUCHERS_MONTHLY_OCT18@STOCKDBLINK d
SELECT distinct d.SERIAL,d.MSISDN,TO_DATE(SUBSTR(d.activation_date,1,2)||'/'||SUBSTR(d.activation_date,4,2)||'/'||SUBSTR(d.activation_date,7,4),'dd/mm/yyyy')  
FROM IT_MK_VOUCHER_REFILL_DAILY d
where SUBSTR(d.ACTIVATION_DATE,7,4)='2018' 
AND SUBSTR(d.ACTIVATION_DATE,4,2)='10'
AND SUBSTR(d.ACTIVATION_DATE,1,2)='30';

COMMIT;

DELETE FROM it_used_v_global WHERE ACTIVATION_DATE=TO_DATE('30/10/2018','DD/MM/YYYY'); COMMIT;

insert into it_used_v_global 
SELECT COUNT( DISTINCT d.SERIAL) TOTAL,TO_DATE(SUBSTR(d.activation_date,1,2)||'/'||SUBSTR(d.activation_date,4,2)||'/'||SUBSTR(d.activation_date,7,4),'dd/mm/yyyy') activation_date 
FROM IT_MK_VOUCHER_REFILL_DAILY d
where SUBSTR(d.ACTIVATION_DATE,7,4)='2018' 
AND SUBSTR(d.ACTIVATION_DATE,4,2)='10'
AND SUBSTR(d.ACTIVATION_DATE,1,2)='30'
GROUP BY TO_DATE(SUBSTR(d.activation_date,1,2)||'/'||SUBSTR(d.activation_date,4,2)||'/'||SUBSTR(d.activation_date,7,4),'dd/mm/yyyy');

COMMIT;
---------------------------------------------------------------------------------------------------------------------------

-----------------------------------------Scripts Wimax subscribers RGS90--------------------------------------------------- 

create table it_msisdn_wimax_rgs90_sep25 as
select MSISDN,'23' SERVICE_CLASS
from report_user.IT_MIS_RGS90_MOC_MTC_DETAIL
where RGS_TYPE='RGS90_MOC_MTC'
and REPORT_DATE=to_date('25/09/2018','dd/mm/yyyy')
AND MSISDN IN(SELECT '224'||account_msisdn from report_user.it_dr_in_status_subscribers where ACCOUNT_CLASS='23');

commit;

select b.MSISDN,NAME,ID_TYPE,ID_NUMBER 
from report_user.IT_MIS_DR_TT_SUBSCRIBERS_DUMP a,it_msisdn_wimax_rgs90_sep25 b
where '224'||a.MSISDN(+)=b.MSISDN
---------------------------------------------------------------------------------------------------------------------------



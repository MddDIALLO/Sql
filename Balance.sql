---------------------------REGULATION BALANCE--------------------------------------
truncate table REPORT_USER.IT_MOMO_ACCOUNT_PROFILE_STATUS;

insert into REPORT_USER.IT_MOMO_ACCOUNT_PROFILE_STATUS 
SELECT distinct c.REGISTRATION_DATE,b.ACTIVATION_DATE,c.MSISDN,d.BALANCE,b.ACCOUNTHOLDER_ID,b.PROFILENAME,c.OTHERID,c.OTHERID_TYPE,d.ACCOUNTSTATUS,c.AH_GIVENNAME,c.AH_SURNAME,c.AH_GENDER,d.LASTACTIVITYTIME,to_date(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy') REPORT_DATE
from 
(SELECT to_date(to_char(LOGGINGTIME,'dd/mm/yyyy hh24:mi:ss'),'dd/mm/yyyy hh24:mi:ss') ACTIVATION_DATE,MSISDN,IDENTITY,ACCOUNTHOLDER_ID,PROFILENAME,OTHERID
from TBL_AUDITLOG@MIS2MOMOREPORT
WHERE transactiontype = 'ActivateUser' 
and status='SUCCESS') b,
(
SELECT to_date(to_char(LOGGINGTIME,'dd/mm/yyyy hh24:mi:ss'),'dd/mm/yyyy hh24:mi:ss') REGISTRATION_DATE,MSISDN,IDENTITY,PROFILENAME,OTHERID,AH_GIVENNAME,AH_SURNAME,AH_GENDER,OTHERID_TYPE
from TBL_AUDITLOG@MIS2MOMOREPORT
WHERE transactiontype = 'RegisterAccountHolder' 
and status='SUCCESS'
) c,EOD_USER_BALANCE@MIS2MOMOREPORT d
where substr(b.ACCOUNTHOLDER_ID,4,12)=c.MSISDN --b.PROFILENAME=c.PROFILENAME
and c.IDENTITY=d.ACCOUNTHOLDERID
and c.MSISDN=d.MSISDN
and b.IDENTITY=d.ACCOUNTHOLDERID
--and d.CURRENCY='GNF'
--AND UPPER(d.PROFILE) LIKE'ACCOUNT%HOLDER%'
and trim(ACCOUNTTYPE)='Mobile Money';

commit;

truncate table REPORT_USER.IT_MOMO_ACCOUNT_PROFILE_STAT_H;

insert into REPORT_USER.IT_MOMO_ACCOUNT_PROFILE_STAT_H 
SELECT distinct c.REGISTRATION_DATE,c.ACTIVATION_DATE,d.MSISDN,d.BALANCE,'Not Available' ACCOUNTHOLDER_ID,c.PROFILENAME,c.IDNUMBER OTHERID,c.IDTYPE OTHERID_TYPE,d.ACCOUNTSTATUS,c.NAME AH_GIVENNAME,c.NAME AH_SURNAME,c.GENDER AH_GENDER,d.LASTACTIVITYTIME,to_date(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy') REPORT_DATE
from EOD_USER_BALANCE@MIS2MOMOREPORT d,REPORT_USER.IT_MIS_MOMO_SUBSCRIBERS c
where d.MSISDN=c.MSISDN --b.PROFILENAME=c.PROFILENAME
--and b.IDENTITY=c.IDENTITY
--AND UPPER(d.PROFILE) LIKE'ACCOUNT%HOLDER%'
and trim(ACCOUNTTYPE)='Mobile Money'
and d.MSISDN not in(select MSISDN from REPORT_USER.IT_MOMO_ACCOUNT_PROFILE_STATUS);

commit;

delete from REPORT_USER.IT_MOMO_SUBSCRIBER_PER_SITE
where to_date(DATETIME,'dd/mm/yyyy')=to_date(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

INSERT INTO REPORT_USER.IT_MOMO_SUBSCRIBER_PER_SITE 
select a.REPORT_DATE,a.MSISDN MSISDN_RGS90,a.MAJOR_CELLID,a.SITE_CODE SITE_CODE,
       TO_CHAR(sysdate-1,'dd/mm/yyyy') DATETIME,b.MSISDN MSISDN,b.PROFILENAME PROFILENAME,b.BALANCE BALANCE
from REPORT_USER.IT_MIS_GLOBAL_SITE_CODE_RGS90 a,REPORT_USER.IT_MOMO_ACCOUNT_PROFILE_STATUS b
where a.MSISDN(+)='00'||b.MSISDN;

COMMIT;

INSERT INTO REPORT_USER.IT_MOMO_SUBSCRIBER_PER_SITE 
select a.REPORT_DATE,a.MSISDN MSISDN_RGS90,a.MAJOR_CELLID,a.SITE_CODE SITE_CODE,
       TO_CHAR(sysdate-1,'dd/mm/yyyy') DATETIME,b.MSISDN MSISDN,b.PROFILENAME PROFILENAME,b.BALANCE BALANCE
from REPORT_USER.IT_MIS_GLOBAL_SITE_CODE_RGS90 a,REPORT_USER.IT_MOMO_ACCOUNT_PROFILE_STAT_H b
where a.MSISDN(+)='00'||b.MSISDN;

COMMIT;  

delete from IT_MOMO_SUBSCRIBER_PER_SITE@MKDBLINK
where to_date(DATETIME,'dd/mm/yyyy')=to_date(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

INSERT INTO IT_MOMO_SUBSCRIBER_PER_SITE@MKDBLINK
SELECT *
from REPORT_USER.IT_MOMO_SUBSCRIBER_PER_SITE
where to_date(DATETIME,'dd/mm/yyyy')=to_date(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;


---------------------------REGULATION Activations--------------------------------------
---------------------------REGULATION Activations--------------------------------------
delete from IT_MIS_MOMO_NEW_ACTIV_VIA_BULK
where to_date(to_char(LOGGINGTIME,'dd/mm/yyyy'),'dd/mm/yyyy')=to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

insert into IT_MIS_MOMO_NEW_ACTIV_VIA_BULK -- IT_MIS_MOMO_NEW_ACTIV@MIS2MOMOREPORT
select to_date(substr(a.DATETIME,9,2)||substr(a.DATETIME,6,2)||substr(a.DATETIME,1,4)||substr(a.DATETIME,11,9),'dd/mm/yyyy hh24:mi:ss') LOGGINGTIME,a.TOMSISDN MSISDN,
       'BULK_REG_MOMO' RECRUITER,
c.CUSTOMER_FIRSTNAME AH_GIVENNAME,c.CUSTOMER_SURNAME AH_SURNAME,to_char(c.CUSTOMER_BIRTHDATE,'yyyy-mm-dd') AH_BIRTHDATE,
'NOT AVAILABLE' AH_GENDER,
a.TRANSACTIONID TRANSACTIONID,'BULKREGISTRATION' TRANSACTIONTYPE,a.TOPROFILE PROFILENAME,
b.IDENTITY 
from EWP_FINANCIAL_CSV@MIS2MOMOREPORT a,(select ACCOUNTHOLDERID IDENTITY,MSISDN 
                                        from FDIAWARA.EOD_USER_BALANCE@MIS2MOMOREPORT 
                                        where msisdn is not null and ACCOUNTTYPE='Mobile Money') b,report_user.IT_MIS_AXON_REG_DTL c
where a.TOMSISDN=b.MSISDN
and '224'||c.CUSTOMER_MSISDN(+)=b.MSISDN
and a.FROMUSERNAME='mtnbonus.mtn'
and a.TRANSACTIONTYPE='TRANSFER'
and a.INITIATINGUSER='ID:am/ADMIN'
and substr(a.DATETIME,1,10)=to_char(sysdate-1,'yyyy-mm-dd') -- '2018-12-03'
and a.FROMMSISDN='224661320469';

commit;

------------------the name of this report on FACTS is ACTIVATION_MOMO
DELETE FROM IT_MOMO_ACTIVATION_AREA_DAILY
WHERE REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd');

commit;

INSERT INTO IT_MOMO_ACTIVATION_AREA_DAILY  
select t.*,STATUT,VILLE,COMMUNES,GOUVERNORATS,REGION_NATURELLE,SITE_TYPE,to_char(sysdate-1,'yyyy-mm-dd') REPORT_DATE
    from IT_MIS_MOMO_NEW_ACTIVATION@MIS2MOMOREPORT t,IT_MIS_GLOBAL_SITE_CODE_RGS90 a,IT_MIS_CELLID_FINAL_2013 b,
    (select SUBNO,'TRANSACTED' STATUT from(
                    select frommsisdn SUBNO
                    from EWP_FINANCIAL_CSV@MIS2MOMOREPORT
                    where TRANSACTIONTYPE in ('CASH_OUT','DEBIT','EXTERNAL_PAYMENT','PAYMENT')
                    and upper(trim(TRANSACTIONSTATUS))='COMMITTED'
                    and substr(DATETIME,1,10) between to_char(sysdate-1,'yyyy-mm-dd') and to_char(sysdate-1,'yyyy-mm-dd')
                    union all
                    select TOMSISDN
                    from EWP_FINANCIAL_CSV@MIS2MOMOREPORT 
                    where TRANSACTIONTYPE in ('BATCH_TRANSFER','CASH_IN','DEPOSIT','TRANSFER_TO_INVITATION','TRANSFER_TO_VOUCHER')
                    and upper(trim(TRANSACTIONSTATUS))='COMMITTED'
                    and substr(DATETIME,1,10) between to_char(sysdate-1,'yyyy-mm-dd') and to_char(sysdate-1,'yyyy-mm-dd') /*
                    union all
                    select a.TOMSISDN
                    from EWP_FINANCIAL_CSV@MIS2MOMOREPORT a
                    where a.FROMUSERNAME='mtnbonus.mtn'
                    and a.TRANSACTIONTYPE='TRANSFER'
                    and a.INITIATINGUSER='ID:am/ADMIN'
                    and a.FROMMSISDN='224661320469'
                    and substr(DATETIME,1,10) between to_char(sysdate-1,'yyyy-mm-dd') and to_char(sysdate-1,'yyyy-mm-dd') */
                                            )
    group by SUBNO
    ) x
    where '00'||t.msisdn = a.MSISDN(+)
    and a.MAJOR_CELLID=b.cellid(+)
    and t.msisdn=x.SUBNO(+)
    and to_date(to_char(t.LOGGINGTIME,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy'); 
    
commit;

INSERT INTO IT_MOMO_ACTIVATION_AREA_DAILY  
select distinct t.*,STATUT,VILLE,COMMUNES,GOUVERNORATS,REGION_NATURELLE,SITE_TYPE,to_char(sysdate-1,'yyyy-mm-dd') REPORT_DATE
    from IT_MIS_MOMO_NEW_ACTIV_VIA_BULK t,IT_MIS_GLOBAL_SITE_CODE_RGS90 a,IT_MIS_CELLID_FINAL_2013 b,
    (select SUBNO,'TRANSACTED' STATUT from(
                    select frommsisdn SUBNO
                    from EWP_FINANCIAL_CSV@MIS2MOMOREPORT
                    where TRANSACTIONTYPE in ('CASH_OUT','DEBIT','EXTERNAL_PAYMENT','PAYMENT')
                    and upper(trim(TRANSACTIONSTATUS))='COMMITTED'
                    and substr(DATETIME,1,10) between to_char(sysdate-1,'yyyy-mm-dd') and to_char(sysdate-1,'yyyy-mm-dd')
                    union all
                    select TOMSISDN
                    from EWP_FINANCIAL_CSV@MIS2MOMOREPORT 
                    where TRANSACTIONTYPE in ('BATCH_TRANSFER','CASH_IN','DEPOSIT','TRANSFER_TO_INVITATION','TRANSFER_TO_VOUCHER')
                    and upper(trim(TRANSACTIONSTATUS))='COMMITTED'
                    and substr(DATETIME,1,10) between to_char(sysdate-1,'yyyy-mm-dd') and to_char(sysdate-1,'yyyy-mm-dd') /*
                    union all
                    select a.TOMSISDN
                    from EWP_FINANCIAL_CSV@MIS2MOMOREPORT a
                    where a.FROMUSERNAME='mtnbonus.mtn'
                    and a.TRANSACTIONTYPE='TRANSFER'
                    and a.INITIATINGUSER='ID:am/ADMIN'
                    and a.FROMMSISDN='224661320469'
                    and substr(DATETIME,1,10) between to_char(sysdate-1,'yyyy-mm-dd') and to_char(sysdate-1,'yyyy-mm-dd') */
                                            )
    group by SUBNO
    ) x
    where '00'||t.msisdn = a.MSISDN(+)
    and a.MAJOR_CELLID=b.cellid(+)
    and t.msisdn=x.SUBNO(+)
    and t.MSISDN not in(select MSISDN FROM IT_MOMO_ACTIVATION_AREA_DAILY where REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd'))
    and to_date(to_char(t.LOGGINGTIME,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy'); 
    
commit;

delete FROM IT_MOMO_ACTV_EXCEPT_WITH_BULK
WHERE REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd');

commit;

INSERT INTO IT_MOMO_ACTV_EXCEPT_WITH_BULK 
select *
FROM IT_MOMO_ACTIVATION_AREA_DAILY
WHERE RECRUITER='BULK_REG_MOMO'
and MSISDN in(select MSISDN FROM IT_MOMO_ACTIVATION_AREA_DAILY where RECRUITER!='BULK_REG_MOMO')
AND REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd');

commit;

--delete FROM IT_MOMO_ACTIVATION_AREA_DAILY
--WHERE RECRUITER='BULK_REG_MOMO'
--and MSISDN in(select MSISDN FROM IT_MOMO_ACTIVATION_AREA_DAILY where RECRUITER!='BULK_REG_MOMO')
--AND REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd');
--
--commit;

INSERT INTO IT_MOMO_ACTIVATION_AREA_DAILY
SELECT distinct TO_TIMESTAMP (ACTIVATION_DATE, 'DD/MM/YYYY HH24:MI:SS') LOGGINGTIME,
a.MSISDN,
a.RECRUITER_MSISDN RECRUITER,
a.SURNAME AH_GIVENNAME,
a.FIRSTNAME AH_SURNAME,
to_char(to_date(a.DATEOFBIRTH,'dd/mm/yyyy'),'yyyy-mm-dd') AH_BIRTHDATE,
a.GENDER AH_GENDER,
' ' TRANSACTIONID,
' 'TRANSACTIONTYPE,
a.PROFILE PROFILENAME,
' ' IDENTITY,
' ' STATUT,
b.VILLE,
b.COMMUNES,
b.GOUVERNORATS,
b.REGION_NATURELLE,
b.SITE_TYPE,
to_char(sysdate-1,'yyyy-mm-dd') REPORT_DATE
from IT_MIS_ACCOUNTHOLDER_MOMO a,
(select c.MSISDN,d.VILLE,d.COMMUNES,d.GOUVERNORATS,d.REGION_NATURELLE,d.SITE_TYPE
from IT_MIS_GLOBAL_SITE_CODE_RGS90 c,IT_MIS_CELLID_FINAL_2013 d
where  c.MAJOR_CELLID=d.cellid(+)) b
WHERE '00'||a.MSISDN = b.MSISDN
AND to_date(a.ACTIVATION_DATE,'dd/mm/yyyy') = to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
AND a.MSISDN NOT IN (SELECT MSISDN FROM IT_MOMO_ACTIVATION_AREA_DAILY);

COMMIT;

DELETE FROM IT_MOMO_ACTIVATION_AREA_DAILY@MKDBLINK
WHERE REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd');

commit;   

INSERT INTO IT_MOMO_ACTIVATION_AREA_DAILY@MKDBLINK
SELECT *
FROM IT_MOMO_ACTIVATION_AREA_DAILY
WHERE REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd');

commit; 


------------------the name of this report on FACTS is MOMO_FIRST_CASHIN_BULK_REG
----- MOMO_FIRST_CASHIN_BULK_REG >=2000 REPORT (activation_date=cashin_date)
delete from it_mis_momo_actv_receivekdo_3k a
where to_date(to_char(a.LOGGINGTIME,'dd/mm/yyyy'),'dd/mm/yyyy')=to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

insert into it_mis_momo_actv_receivekdo_3k   
select to_date(to_char(LOGGINGTIME,'dd/mm/yyyy hh24:mi:ss'),'dd/mm/yyyy hh24:mi:ss') LOGGINGTIME,
       MSISDN,RECRUITER,AH_GIVENNAME,AH_SURNAME,AH_BIRTHDATE,AH_GENDER,TRANSACTIONID
       TRANSACTIONTYPE,PROFILENAME,IDENTITY,'3000' AMOUNT
from IT_MOMO_ACTIVATION_AREA_DAILY 
where RECRUITER='BULK_REG_MOMO'
and REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd');

commit;

delete from it_mis_CASHIN_aft_3k_kdo a
where to_date(to_char(a.DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy')=to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

insert into it_mis_CASHIN_aft_3k_kdo 
select DISTINCT a.FROMMSISDN AGENT_OR_MERCHANT_MSISDN,a.TOMSISDN MSISDN,a.AMOUNT CASH_IN_AMOUNT,
to_date(substr(a.DATETIME,9,2)||substr(a.DATETIME,6,2)||substr(a.DATETIME,1,4)||substr(a.DATETIME,11,9),'dd/mm/yyyy hh24:mi:ss') DATETIME
from EWP_FINANCIAL_CSV@MIS2MOMOREPORT a
where TRANSACTIONTYPE='CASH_IN'
and upper(trim(a.TRANSACTIONSTATUS))='COMMITTED'
and a.FROMMSISDN!='224661320469'
and a.TOMSISDN in(SELECT MSISDN FROM it_mis_momo_actv_receivekdo_3k)
and substr(a.DATETIME,1,10)=to_char(sysdate-1,'yyyy-mm-dd');

commit;

truncate table it_mis_first_CASHIN_aft_3k_kdo;

insert into it_mis_first_CASHIN_aft_3k_kdo 
SELECT distinct a.AGENT_OR_MERCHANT_MSISDN,a.MSISDN,a.CASH_IN_AMOUNT,a.DATETIME
FROM report_user.it_mis_CASHIN_aft_3k_kdo a
where a.DATETIME=(select min(b.DATETIME) 
                  from it_mis_CASHIN_aft_3k_kdo b
                  where a.MSISDN=b.MSISDN
                  group by b.MSISDN);

commit;

truncate table IT_MIS_FIRST_CASHIN_BULK_REG;

insert into IT_MIS_FIRST_CASHIN_BULK_REG
select distinct a.LOGGINGTIME ACTIVATION_DATE,a.MSISDN,/*a.AH_GIVENNAME,a.AH_SURNAME,a.AH_BIRTHDATE,a.IDENTITY,*/a.PROFILENAME,
       b.CASH_IN_AMOUNT,b.AGENT_OR_MERCHANT_MSISDN,b.CASH_IN_DATE
from it_mis_momo_actv_receivekdo_3k a,(select AGENT_OR_MERCHANT_MSISDN,MSISDN,CASH_IN_AMOUNT,DATETIME CASH_IN_DATE
                                        from it_mis_first_CASHIN_aft_3k_kdo
                                        WHERE TO_NUMBER(CASH_IN_AMOUNT)>=2000) b
where a.MSISDN=b.MSISDN
and to_date(to_char(a.LOGGINGTIME,'dd/mm/yyyy'),'dd/mm/yyyy')=to_date(to_char(b.CASH_IN_DATE,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

delete FROM IT_MIS_FIRST_CASHIN_BULK_REG@MKDBLINK; commit;
  
insert into IT_MIS_FIRST_CASHIN_BULK_REG@MKDBLINK 
SELECT *
FROM IT_MIS_FIRST_CASHIN_BULK_REG;

commit;


---------REGULATION OF ALL -----------------------------
------------------the name of this report on FACTS is MOMOSP_TRANSACTION_DETAIL_REPORT
----- MOMO SP TRANSACTION DETAIL REPORT 
delete from REPORT_USER.IT_MIS_SP_TRANSACTION_DETAIL
where substr(DATETIME,1,10)=to_char(sysdate-1,'yyyy-mm-dd');

commit;

insert into REPORT_USER.IT_MIS_SP_TRANSACTION_DETAIL 
select DATETIME,TRANSACTIONID,TRANSACTIONTYPE,FROMMSISDN,FROMUSERNAME,FROMPROFILE,
              TOMSISDN,TOUSERNAME,TOPROFILE,AMOUNT,FROMFEE,TOFEE,TRANSACTIONSTATUS
from EWP_FINANCIAL_CSV@MIS2MOMOREPORT
where TRANSACTIONTYPE in ('DEBIT','TRANSFER')
and substr(DATETIME,1,10)=to_char(sysdate-1,'yyyy-mm-dd');

commit;

delete from IT_MIS_SP_TRANSACTION_DETAIL@MKDBLINK
where substr(DATETIME,1,10)=to_char(sysdate-1,'yyyy-mm-dd');

commit;

INSERT INTO IT_MIS_SP_TRANSACTION_DETAIL@MKDBLINK
SELECT * from REPORT_USER.IT_MIS_SP_TRANSACTION_DETAIL
where substr(DATETIME,1,10)=to_char(sysdate-1,'yyyy-mm-dd');

commit;

delete from REPORT_USER.IT_MIS_MFS_SP_TRANSACTION_RPT
where DATETIME=to_char(sysdate-1,'yyyy-mm-dd');

commit;

insert into REPORT_USER.IT_MIS_MFS_SP_TRANSACTION_RPT 
select substr(DATETIME,1,10) DATETIME,'TOUSERNAME' SP_TRANS,TOUSERNAME USERNAME,TRANSACTIONTYPE,FROMPROFILE,TOPROFILE, count(*) NB_TRANSACTIONS, sum(FROMFEE) FROMFEE_AMOUNT, sum(TOFEE) TOFEE_AMOUNT, sum(AMOUNT) AMOUNT
from EWP_FINANCIAL_CSV@MIS2MOMOREPORT
where TOUSERNAME in('intouch.sp','nsia.sp','sunu.sp','lanala.sp','ggmoney2.sp','ggmoney1.sp','mtn.sp','guinea.games','moobifun.sp','GUPOL.SP','canalplus.sp','GGame.web','GGame.ussd','sayele.sp','AROBASE.sp','LynxLance.sp','baysim.sp','maersk.sp','momogw1.sp','momogw2.sp','momogw3.sp','momogw4.sp','momogw5.sp','mfsremit.sp','startime.sp','taxgn.sp')    
and substr(DATETIME,1,10)=to_char(sysdate-1,'yyyy-mm-dd')
group by substr(DATETIME,1,10),TRANSACTIONTYPE,TOUSERNAME,FROMPROFILE,TOPROFILE

union all

select substr(DATETIME,1,10) DATETIME,'FROMUSERNAME' SP_TRANS,FROMUSERNAME USERNAME,TRANSACTIONTYPE,FROMPROFILE,TOPROFILE, count(*) NB_TRANSACTIONS, sum(FROMFEE) FROMFEE_AMOUNT, sum(TOFEE) TOFEE_AMOUNT, sum(AMOUNT) AMOUNT
from EWP_FINANCIAL_CSV@MIS2MOMOREPORT
where FROMUSERNAME in('intouch.sp','nsia.sp','sunu.sp','lanala.sp','ggmoney2.sp','ggmoney1.sp','mtn.sp','guinea.games','moobifun.sp','GUPOL.SP','canalplus.sp','GGame.web','GGame.ussd','sayele.sp','AROBASE.sp','LynxLance.sp','baysim.sp','maersk.sp','momogw1.sp','momogw2.sp','momogw3.sp','momogw4.sp','momogw5.sp','mfsremit.sp','startime.sp','taxgn.sp')    
and substr(DATETIME,1,10)=to_char(sysdate-1,'yyyy-mm-dd')
group by substr(DATETIME,1,10),TRANSACTIONTYPE,FROMUSERNAME,FROMPROFILE,TOPROFILE;

commit;

delete from IT_MIS_MFS_SP_TRANSACTION_RPT@mkdblink
where DATETIME=to_char(sysdate-1,'yyyy-mm-dd');

commit;

insert into IT_MIS_MFS_SP_TRANSACTION_RPT@mkdblink
select * from REPORT_USER.IT_MIS_MFS_SP_TRANSACTION_RPT
where DATETIME=to_char(sysdate-1,'yyyy-mm-dd');

commit;

------------------the name of this report on FACTS is ACTIVATION_MOMO
DELETE FROM REPORT_USER.IT_MIS_MOMO_NEW_ACTIV_VIA_BULK
WHERE to_date(to_char(LOGGINGTIME,'dd/mm/yyyy'),'dd/mm/yyyy')=to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

insert into REPORT_USER.IT_MIS_MOMO_NEW_ACTIV_VIA_BULK -- IT_MIS_MOMO_NEW_ACTIV@MIS2MOMOREPORT
select to_date(substr(a.DATETIME,9,2)||substr(a.DATETIME,6,2)||substr(a.DATETIME,1,4)||substr(a.DATETIME,11,9),'dd/mm/yyyy hh24:mi:ss') LOGGINGTIME,a.TOMSISDN MSISDN,
       'BULK_REG_MOMO' RECRUITER,
c.CUSTOMER_FIRSTNAME AH_GIVENNAME,c.CUSTOMER_SURNAME AH_SURNAME,to_char(c.CUSTOMER_BIRTHDATE,'yyyy-mm-dd') AH_BIRTHDATE,
'NOT AVAILABLE' AH_GENDER,
a.TRANSACTIONID TRANSACTIONID,'BULKREGISTRATION' TRANSACTIONTYPE,a.TOPROFILE PROFILENAME,
b.IDENTITY 
from EWP_FINANCIAL_CSV@MIS2MOMOREPORT a,(select ACCOUNTHOLDERID IDENTITY,MSISDN 
                                        from FDIAWARA.EOD_USER_BALANCE@MIS2MOMOREPORT 
                                        where msisdn is not null and ACCOUNTTYPE='Mobile Money') b,report_user.IT_MIS_AXON_REG_DTL c
where a.TOMSISDN=b.MSISDN
and '224'||c.CUSTOMER_MSISDN(+)=b.MSISDN
and a.FROMUSERNAME='mtnbonus.mtn'
and a.TRANSACTIONTYPE='TRANSFER'
and a.INITIATINGUSER='ID:am/ADMIN'
and substr(a.DATETIME,1,10)=to_char(sysdate-1,'yyyy-mm-dd') -- '2018-12-03'
and a.FROMMSISDN='224661320469';

commit;

DELETE FROM REPORT_USER.IT_MOMO_ACTIVATION_AREA_DAILY
WHERE REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd');

commit;

INSERT INTO REPORT_USER.IT_MOMO_ACTIVATION_AREA_DAILY  
select t.*,STATUT,VILLE,COMMUNES,GOUVERNORATS,REGION_NATURELLE,SITE_TYPE,to_char(sysdate-1,'yyyy-mm-dd') REPORT_DATE
    from IT_MIS_MOMO_NEW_ACTIVATION@MIS2MOMOREPORT t,REPORT_USER.IT_MIS_GLOBAL_SITE_CODE_RGS90 a,REPORT_USER.IT_MIS_CELLID_FINAL_2013 b,
    (select SUBNO,'TRANSACTED' STATUT from(
                    select frommsisdn SUBNO
                    from EWP_FINANCIAL_CSV@MIS2MOMOREPORT
                    where TRANSACTIONTYPE in ('CASH_OUT','DEBIT','EXTERNAL_PAYMENT','PAYMENT')
                    and upper(trim(TRANSACTIONSTATUS))='COMMITTED'
                    and substr(DATETIME,1,10) between to_char(sysdate-1,'yyyy-mm-dd') and to_char(sysdate-1,'yyyy-mm-dd')
                    union all
                    select TOMSISDN
                    from EWP_FINANCIAL_CSV@MIS2MOMOREPORT 
                    where TRANSACTIONTYPE in ('BATCH_TRANSFER','CASH_IN','DEPOSIT','TRANSFER_TO_INVITATION','TRANSFER_TO_VOUCHER')
                    and upper(trim(TRANSACTIONSTATUS))='COMMITTED'
                    and substr(DATETIME,1,10) between to_char(sysdate-1,'yyyy-mm-dd') and to_char(sysdate-1,'yyyy-mm-dd') /*
                    union all
                    select a.TOMSISDN
                    from EWP_FINANCIAL_CSV@MIS2MOMOREPORT a
                    where a.FROMUSERNAME='mtnbonus.mtn'
                    and a.TRANSACTIONTYPE='TRANSFER'
                    and a.INITIATINGUSER='ID:am/ADMIN'
                    and a.FROMMSISDN='224661320469'
                    and substr(DATETIME,1,10) between to_char(sysdate-3,'yyyy-mm-dd') and to_char(sysdate-3,'yyyy-mm-dd') */
                                            )
    group by SUBNO
    ) x
    where '00'||t.msisdn = a.MSISDN(+)
    and a.MAJOR_CELLID=b.cellid(+)
    and t.msisdn=x.SUBNO(+)
    and to_date(to_char(t.LOGGINGTIME,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy'); 
    
commit;

INSERT INTO REPORT_USER.IT_MOMO_ACTIVATION_AREA_DAILY  
select distinct t.*,STATUT,VILLE,COMMUNES,GOUVERNORATS,REGION_NATURELLE,SITE_TYPE,to_char(sysdate-1,'yyyy-mm-dd') REPORT_DATE
    from REPORT_USER.IT_MIS_MOMO_NEW_ACTIV_VIA_BULK t,REPORT_USER.IT_MIS_GLOBAL_SITE_CODE_RGS90 a,REPORT_USER.IT_MIS_CELLID_FINAL_2013 b,
    (select SUBNO,'TRANSACTED' STATUT from(
                    select frommsisdn SUBNO
                    from EWP_FINANCIAL_CSV@MIS2MOMOREPORT
                    where TRANSACTIONTYPE in ('CASH_OUT','DEBIT','EXTERNAL_PAYMENT','PAYMENT')
                    and upper(trim(TRANSACTIONSTATUS))='COMMITTED'
                    and substr(DATETIME,1,10) between to_char(sysdate-1,'yyyy-mm-dd') and to_char(sysdate-1,'yyyy-mm-dd')
                    union all
                    select TOMSISDN
                    from EWP_FINANCIAL_CSV@MIS2MOMOREPORT 
                    where TRANSACTIONTYPE in ('BATCH_TRANSFER','CASH_IN','DEPOSIT','TRANSFER_TO_INVITATION','TRANSFER_TO_VOUCHER')
                    and upper(trim(TRANSACTIONSTATUS))='COMMITTED'
                    and substr(DATETIME,1,10) between to_char(sysdate-1,'yyyy-mm-dd') and to_char(sysdate-1,'yyyy-mm-dd') /*
                    union all
                    select a.TOMSISDN
                    from EWP_FINANCIAL_CSV@MIS2MOMOREPORT a
                    where a.FROMUSERNAME='mtnbonus.mtn'
                    and a.TRANSACTIONTYPE='TRANSFER'
                    and a.INITIATINGUSER='ID:am/ADMIN'
                    and a.FROMMSISDN='224661320469'
                    and substr(DATETIME,1,10) between to_char(sysdate-3,'yyyy-mm-dd') and to_char(sysdate-3,'yyyy-mm-dd') */
                                            )
    group by SUBNO
    ) x
    where '00'||t.msisdn = a.MSISDN(+)
    and a.MAJOR_CELLID=b.cellid(+)
    and t.msisdn=x.SUBNO(+)
    and t.MSISDN not in(select MSISDN FROM REPORT_USER.IT_MOMO_ACTIVATION_AREA_DAILY where REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd'))
    and to_date(to_char(t.LOGGINGTIME,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy'); 
    
commit;

delete FROM REPORT_USER.IT_MOMO_ACTV_EXCEPT_WITH_BULK
WHERE REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd');

commit;

INSERT INTO REPORT_USER.IT_MOMO_ACTV_EXCEPT_WITH_BULK 
select *
FROM REPORT_USER.IT_MOMO_ACTIVATION_AREA_DAILY
WHERE RECRUITER='BULK_REG_MOMO'
and MSISDN in(select MSISDN FROM REPORT_USER.IT_MOMO_ACTIVATION_AREA_DAILY where RECRUITER!='BULK_REG_MOMO')
AND REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd');

commit;

--delete FROM REPORT_USER.IT_MOMO_ACTIVATION_AREA_DAILY
--WHERE RECRUITER='BULK_REG_MOMO'
--and MSISDN in(select MSISDN FROM IT_MOMO_ACTIVATION_AREA_DAILY where RECRUITER!='BULK_REG_MOMO')
--AND REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd');
--
--commit;

INSERT INTO REPORT_USER.IT_MOMO_ACTIVATION_AREA_DAILY
SELECT distinct TO_TIMESTAMP (ACTIVATION_DATE, 'DD/MM/YYYY HH24:MI:SS') LOGGINGTIME,
a.MSISDN,
a.RECRUITER_MSISDN RECRUITER,
a.SURNAME AH_GIVENNAME,
a.FIRSTNAME AH_SURNAME,
to_char(to_date(a.DATEOFBIRTH,'dd/mm/yyyy'),'yyyy-mm-dd') AH_BIRTHDATE,
a.GENDER AH_GENDER,
' ' TRANSACTIONID,
' 'TRANSACTIONTYPE,
a.PROFILE PROFILENAME,
' ' IDENTITY,
' ' STATUT,
b.VILLE,
b.COMMUNES,
b.GOUVERNORATS,
b.REGION_NATURELLE,
b.SITE_TYPE,
to_char(sysdate-1,'yyyy-mm-dd') REPORT_DATE
from REPORT_USER.IT_MIS_ACCOUNTHOLDER_MOMO a,
(select c.MSISDN,d.VILLE,d.COMMUNES,d.GOUVERNORATS,d.REGION_NATURELLE,d.SITE_TYPE
from REPORT_USER.IT_MIS_GLOBAL_SITE_CODE_RGS90 c,REPORT_USER.IT_MIS_CELLID_FINAL_2013 d
where  c.MAJOR_CELLID=d.cellid(+)) b
WHERE '00'||a.MSISDN = b.MSISDN
AND to_date(a.ACTIVATION_DATE,'dd/mm/yyyy') = to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
AND a.MSISDN NOT IN (SELECT MSISDN FROM REPORT_USER.IT_MOMO_ACTIVATION_AREA_DAILY);

COMMIT;

DELETE FROM IT_MOMO_ACTIVATION_AREA_DAILY@MKDBLINK
WHERE REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd');

commit;   

INSERT INTO IT_MOMO_ACTIVATION_AREA_DAILY@MKDBLINK
SELECT *
FROM REPORT_USER.IT_MOMO_ACTIVATION_AREA_DAILY
WHERE REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd');

commit;

 

--exec REPORT_USER.IT_MIS_MFS_DAILY_REPORT_PROC1;

------------------the name of this report on FACTS is MOMO AGENT TRANSACTIONS
                     ----------------- Agent with number of transaction an total amount with region
DELETE FROM REPORT_USER.IT_MOMO_AGENT_ACTIVATION_AREA
WHERE REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd');

commit;


INSERT INTO REPORT_USER.IT_MOMO_AGENT_ACTIVATION_AREA 
select t.MSISDN,t.PROFIL,
       sum(case when t.TRANSACTIONTYPE='CASH_IN' then 1 end) TOTAL_CASH_IN,
       sum(case when t.TRANSACTIONTYPE='CASH_IN' then AMOUNT end) CASH_IN_AMOUNT,
       sum(case when t.TRANSACTIONTYPE='CASH_IN' then FROMFEE end) CASH_IN_FEE,
       sum(case when t.TRANSACTIONTYPE='CASH_OUT' then 1 end) TOTAL_CASH_OUT,
       sum(case when t.TRANSACTIONTYPE='CASH_OUT' then AMOUNT end) CASH_OUT_AMOUNT,
       sum(case when t.TRANSACTIONTYPE='CASH_OUT' then FROMFEE end) CASH_OUT_FEE,
       sum(case when t.TRANSACTIONTYPE='TRANSFER_FROM_VOUCHER' then 1 end) TOTAL_TRANSFER,
       sum(case when t.TRANSACTIONTYPE='TRANSFER_FROM_VOUCHER' then AMOUNT end) TRANSFER_AMOUNT,
       sum(case when t.TRANSACTIONTYPE='TRANSFER_FROM_VOUCHER' then FROMFEE end) TRANSFER_FEE,
       b.VILLE,b.COMMUNES,b.GOUVERNORATS,b.REGION_NATURELLE,b.SITE_TYPE,to_char(sysdate-1,'yyyy-mm-dd') REPORT_DATE 
from (
        select TOMSISDN MSISDN,TOPROFILE PROFIL,AMOUNT,FROMFEE,TRANSACTIONTYPE
        from EWP_FINANCIAL_CSV@MIS2MOMOREPORT 
        where TRANSACTIONTYPE in ('CASH_OUT')
        and upper(trim(TRANSACTIONSTATUS))='COMMITTED'
        and substr(DATETIME,1,10) between to_char(sysdate-1,'yyyy-mm-dd') and to_char(sysdate-1,'yyyy-mm-dd')
        and TOPROFILE in ('MTNGC Agent Profile','MTNGC Super Agent Profile')
        union all
        select TOMSISDN MSISDN,TOPROFILE PROFIL,AMOUNT,FROMFEE,TRANSACTIONTYPE
        from EWP_FINANCIAL_CSV@MIS2MOMOREPORT 
        where TRANSACTIONTYPE in ('TRANSFER_FROM_VOUCHER')
        and upper(trim(TRANSACTIONSTATUS))='COMMITTED'
        and substr(DATETIME,1,10) between to_char(sysdate-1,'yyyy-mm-dd') and to_char(sysdate-1,'yyyy-mm-dd')
        and TOPROFILE in ('MTNGC Agent Profile','MTNGC Super Agent Profile')
        union all
        select FROMMSISDN MSISDN,FROMPROFILE PROFIL,AMOUNT,FROMFEE,TRANSACTIONTYPE
        from EWP_FINANCIAL_CSV@MIS2MOMOREPORT 
        where TRANSACTIONTYPE in ('CASH_IN')
        and upper(trim(TRANSACTIONSTATUS))='COMMITTED'
        and substr(DATETIME,1,10) between to_char(sysdate-1,'yyyy-mm-dd') and to_char(sysdate-1,'yyyy-mm-dd')
        and FROMPROFILE in ('MTNGC Agent Profile','MTNGC Super Agent Profile')
     ) t,REPORT_USER.IT_MIS_GLOBAL_SITE_CODE_RGS90 a,REPORT_USER.IT_MIS_CELLID_FINAL_2013 b
where '00'||t.msisdn = a.MSISDN(+)
and a.MAJOR_CELLID=b.cellid(+) 
and t.TRANSACTIONTYPE in ('CASH_IN','CASH_OUT')
and t.PROFIL in ('MTNGC Agent Profile','MTNGC Super Agent Profile')
group by t.MSISDN,t.PROFIL,b.VILLE,b.COMMUNES,b.GOUVERNORATS,b.REGION_NATURELLE,b.SITE_TYPE;

commit;


DELETE FROM IT_MOMO_AGENT_ACTIVATION_AREA@MKDBLINK
WHERE REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd');

commit;   

INSERT INTO IT_MOMO_AGENT_ACTIVATION_AREA@MKDBLINK
SELECT *
FROM REPORT_USER.IT_MOMO_AGENT_ACTIVATION_AREA
WHERE REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd');

commit;

------------------the name of this report on FACTS is MOMO NEW AGENT and MERCHANT ACTIVATED

DELETE FROM REPORT_USER.IT_MOMO_ACTIVATION_AREA_DAILYP
WHERE REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd');

commit;

insert into REPORT_USER.IT_MOMO_ACTIVATION_AREA_DAILYP   
select t.*,STATUT,VILLE,COMMUNES,GOUVERNORATS,REGION_NATURELLE,SITE_TYPE,to_char(sysdate-1,'yyyy-mm-dd') REPORT_DATE
    from IT_MIS_MOMO_NEW_ACTIVATIONP@MIS2MOMOREPORT t,REPORT_USER.IT_MIS_GLOBAL_SITE_CODE_RGS90 a,REPORT_USER.IT_MIS_CELLID_FINAL_2013 b,
    (select SUBNO,'TRANSACTED' STATUT from(
                    select frommsisdn SUBNO
                    from EWP_FINANCIAL_CSV@MIS2MOMOREPORT
                    where TRANSACTIONTYPE in ('CASH_OUT','DEBIT','EXTERNAL_PAYMENT','PAYMENT')
                    and upper(trim(TRANSACTIONSTATUS))='COMMITTED'
                    and substr(DATETIME,1,10) between to_char(sysdate-1,'yyyy-mm-dd') and to_char(sysdate-1,'yyyy-mm-dd')
                    union all
                    select TOMSISDN
                    from EWP_FINANCIAL_CSV@MIS2MOMOREPORT 
                    where TRANSACTIONTYPE in ('BATCH_TRANSFER','CASH_IN','DEPOSIT','TRANSFER_TO_INVITATION','TRANSFER_TO_VOUCHER')
                    and upper(trim(TRANSACTIONSTATUS))='COMMITTED'
                    and substr(DATETIME,1,10) between to_char(sysdate-1,'yyyy-mm-dd') and to_char(sysdate-1,'yyyy-mm-dd')
                                            )
    group by SUBNO
    ) x
    where '00'||t.msisdn = a.MSISDN(+)
    and a.MAJOR_CELLID=b.cellid(+)
    and t.msisdn=x.SUBNO(+)
    and t.PROFILENAME in('MTNGC Agent Profile','MTNGC Super Agent Profile','MTNGC Merchant Profile')
    and t.IDENTITY is not null
    and to_date(to_char(t.LOGGINGTIME,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');
    
    commit; 
    
   DELETE FROM IT_MOMO_ACTIVATION_AREA_DAILYP@MKDBLINK
   WHERE REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd');

    commit;
    
    INSERT INTO IT_MOMO_ACTIVATION_AREA_DAILYP@MKDBLINK
SELECT *
FROM REPORT_USER.IT_MOMO_ACTIVATION_AREA_DAILYP
WHERE REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd')
and IDENTITY is not null;

commit; 

------------------the name of this report on FACTS is MOMO MERCHANT TRANSACTIONS
            ----------------- Agent with number of transaction an total amount with region
DELETE FROM REPORT_USER.IT_MOMO_MERCHANT_TRANSACT_AREA
WHERE REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd');

commit;

INSERT INTO REPORT_USER.IT_MOMO_MERCHANT_TRANSACT_AREA 
select t.MSISDN,t.PROFIL,
       sum(case when t.TRANSACTIONTYPE='CASH_IN' then 1 end) TOTAL_CASH_IN,
       sum(case when t.TRANSACTIONTYPE='CASH_IN' then AMOUNT end) CASH_IN_AMOUNT,
       sum(case when t.TRANSACTIONTYPE='CASH_IN' then FROMFEE end) CASH_IN_FEE,
       sum(case when t.TRANSACTIONTYPE='DEBIT' then 1 end) TOTAL_DEBIT,
       sum(case when t.TRANSACTIONTYPE='DEBIT' then AMOUNT end) DEBIT_AMOUNT,
       sum(case when t.TRANSACTIONTYPE='DEBIT' then FROMFEE end) DEBIT_FEE,
       sum(case when t.TRANSACTIONTYPE='PAYMENT' then 1 end) TOTAL_PAYMENT, 
       sum(case when t.TRANSACTIONTYPE='PAYMENT' then AMOUNT end) PAYMENT_AMOUNT,
       sum(case when t.TRANSACTIONTYPE='PAYMENT' then FROMFEE end) PAYMENT_FEE,
       sum(case when t.TRANSACTIONTYPE='TRANSFER_FROM_VOUCHER' then 1 end) TOTAL_TRANSFER,
       sum(case when t.TRANSACTIONTYPE='TRANSFER_FROM_VOUCHER' then AMOUNT end) TRANSFER_AMOUNT,
       sum(case when t.TRANSACTIONTYPE='TRANSFER_FROM_VOUCHER' then FROMFEE end) TRANSFER_FEE,
       b.VILLE,b.COMMUNES,b.GOUVERNORATS,b.REGION_NATURELLE,b.SITE_TYPE,to_char(sysdate-1,'yyyy-mm-dd') REPORT_DATE 
from (
        select TOMSISDN MSISDN,TOPROFILE PROFIL,AMOUNT,FROMFEE,TRANSACTIONTYPE
        from EWP_FINANCIAL_CSV@MIS2MOMOREPORT 
        where TRANSACTIONTYPE in('DEBIT','PAYMENT')
        and upper(trim(TRANSACTIONSTATUS))='COMMITTED'
        and substr(DATETIME,1,10) between to_char(sysdate-1,'yyyy-mm-dd') and to_char(sysdate-1,'yyyy-mm-dd')
        and TOPROFILE in ('MTNGC Merchant Promo Profile','MTNGC Merchant Profile')
        union all
        select FROMMSISDN MSISDN,FROMPROFILE PROFIL,AMOUNT,FROMFEE,TRANSACTIONTYPE
        from EWP_FINANCIAL_CSV@MIS2MOMOREPORT 
        where TRANSACTIONTYPE in ('CASH_IN')
        and upper(trim(TRANSACTIONSTATUS))='COMMITTED'
        and substr(DATETIME,1,10) between to_char(sysdate-1,'yyyy-mm-dd') and to_char(sysdate-1,'yyyy-mm-dd')
        and FROMPROFILE in ('MTNGC Merchant Promo Profile','MTNGC Merchant Profile')
     ) t,REPORT_USER.IT_MIS_GLOBAL_SITE_CODE_RGS90 a,REPORT_USER.IT_MIS_CELLID_FINAL_2013 b
where '00'||t.msisdn = a.MSISDN(+)
and a.MAJOR_CELLID=b.cellid(+) 
and t.TRANSACTIONTYPE in ('CASH_IN','DEBIT','PAYMENT')
and t.PROFIL in ('MTNGC Merchant Promo Profile','MTNGC Merchant Profile')
group by t.MSISDN,t.PROFIL,b.VILLE,b.COMMUNES,b.GOUVERNORATS,b.REGION_NATURELLE,b.SITE_TYPE;

commit;


DELETE FROM IT_MOMO_MERCHANT_TRANSACT_AREA@MKDBLINK
WHERE REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd');

commit;   

INSERT INTO IT_MOMO_MERCHANT_TRANSACT_AREA@MKDBLINK
SELECT *
FROM REPORT_USER.IT_MOMO_MERCHANT_TRANSACT_AREA
WHERE REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd');

commit;

------------------the name of this report on FACTS is RGS30_MOMO_per_TRANSACTION_TYPE
----- MOMO RGS30 PER TRANSACTION TYPE

DELETE FROM REPORT_USER.IT_MIS_RGS_MOMO_TRASTYPE_STAT
WHERE REPORT_DATE=to_date(to_char(sysdate-1,'yyyy-mm-dd'),'yyyy-mm-dd');

commit;

INSERT INTO REPORT_USER.IT_MIS_RGS_MOMO_TRASTYPE_STAT 
select TRANSACTIONTYPE,'RGS30_MOC_MTC' as RGS_TYPE,  to_date(to_char(sysdate-31,'yyyy-mm-dd'),'yyyy-mm-dd') || ' ---> '||to_date(to_char(sysdate-1,'yyyy-mm-dd'),'yyyy-mm-dd') Period, count(distinct msisdn) total_msisdn, to_date(to_char(sysdate-1,'yyyy-mm-dd'),'yyyy-mm-dd') report_date
from( 
select DATETIME,TRANSACTIONTYPE,FROMMSISDN MSISDN
from EWP_FINANCIAL_CSV@MIS2MOMOREPORT
where TRANSACTIONTYPE in ('BATCH_TRANSFER','CASH_IN','CASH_OUT','DEBIT','DEPOSIT','EXTERNAL_PAYMENT','EXTERNAL_TRANSFER','FLOAT_TRANSFER','PAYMENT','RESOURCE_INFORMATION_ENQUIRY','TRANSFER','TRANSFER_TO_INVITATION','TRANSFER_TO_VOUCHER','WITHDRAWAL')
and FROMMSISDN is not null
and upper(trim(TRANSACTIONSTATUS))='COMMITTED'

union all

select DATETIME,TRANSACTIONTYPE,TOMSISDN MSISDN
from EWP_FINANCIAL_CSV@MIS2MOMOREPORT
where TRANSACTIONTYPE in ('BATCH_TRANSFER','CASH_IN','CASH_OUT','DEBIT','DEPOSIT',/*'EXTERNAL_PAYMENT',*/'EXTERNAL_TRANSFER','FLOAT_TRANSFER','PAYMENT','RESOURCE_INFORMATION_ENQUIRY','TRANSFER','TRANSFER_TO_INVITATION','TRANSFER_TO_VOUCHER','WITHDRAWAL')
and TOMSISDN is not null
and upper(trim(TRANSACTIONSTATUS))='COMMITTED'
)
where substr(DATETIME,1,10) between to_char(sysdate-31,'yyyy-mm-dd') and to_char(sysdate-1,'yyyy-mm-dd')
group by TRANSACTIONTYPE;

commit;

delete FROM IT_MIS_RGS_MOMO_TRASTYPE_STAT@MKDBLINK
WHERE REPORT_DATE=to_date(to_char(sysdate-1,'yyyy-mm-dd'),'yyyy-mm-dd');

commit;

insert into IT_MIS_RGS_MOMO_TRASTYPE_STAT@MKDBLINK
select * 
FROM REPORT_USER.IT_MIS_RGS_MOMO_TRASTYPE_STAT
WHERE REPORT_DATE=to_date(to_char(sysdate-1,'yyyy-mm-dd'),'yyyy-mm-dd');

commit;

------------------the name of this report on FACTS is AIRTIME_REFILL_PER_SITE_CODE
----- MOMO AIRTIME LOAD PER SITE
delete from REPORT_USER.IT_MOMO_AIRTIME_TRANS_DAILY 
where DATETIME=to_char(sysdate-1,'yyyy-mm-dd');

commit;

INSERT INTO REPORT_USER.IT_MOMO_AIRTIME_TRANS_DAILY 
select substr(DATETIME,1,10) DATETIME,FROMMSISDN,sum(to_number(AMOUNT)) AMOUNT
from EWP_FINANCIAL_CSV@MIS2MOMOREPORT
where TRANSACTIONTYPE ='EXTERNAL_PAYMENT'
and lower(TOUSERNAME) like'%airtime%'
and upper(trim(TRANSACTIONSTATUS))='COMMITTED'
and substr(DATETIME,1,10) between to_char(sysdate-1,'yyyy-mm-dd') and to_char(sysdate-1,'yyyy-mm-dd')
group by substr(DATETIME,1,10),FROMMSISDN;

commit;

delete FROM REPORT_USER.IT_MOMO_AIRTIME_PER_SITE_CODE
WHERE SUBSTR(DATETIME,1,7)=TO_CHAR(sysdate-1,'yyyy-mm');

commit;

INSERT INTO REPORT_USER.IT_MOMO_AIRTIME_PER_SITE_CODE 
SELECT DATETIME,nvl(SITE_CODE,'UNKNOWN') SITE_CODE,sum(AMOUNT) AMOUNT
from (
select a.REPORT_DATE,a.MSISDN,a.MAJOR_CELLID,a.SITE_CODE,b.DATETIME,b.FROMMSISDN,b.AMOUNT
from REPORT_USER.IT_MIS_GLOBAL_SITE_CODE_RGS90 a,REPORT_USER.IT_MOMO_AIRTIME_TRANS_DAILY b
where MSISDN(+)='00'||b.FROMMSISDN 
and SUBSTR(DATETIME,1,7)=TO_CHAR(sysdate-1,'yyyy-mm')
)
group by DATETIME,nvl(SITE_CODE,'UNKNOWN');

commit;

delete FROM IT_MOMO_AIRTIME_PER_SITE_CODE@MKDBLINK
WHERE SUBSTR(DATETIME,1,7)=TO_CHAR(sysdate-1,'yyyy-mm');

commit;    

insert into IT_MOMO_AIRTIME_PER_SITE_CODE@MKDBLINK
select *
FROM REPORT_USER.IT_MOMO_AIRTIME_PER_SITE_CODE
WHERE SUBSTR(DATETIME,1,7)=TO_CHAR(sysdate-1,'yyyy-mm');

commit;  


------------------the name of this report on FACTS is MOMO_TRANSACTION_PER_SITE_CODE
----- MOMO TOTAL TRANSACTION PER SITE

delete from REPORT_USER.IT_MOMO_TRANS_PER_SITE_CODE 
where SUBSTR(DATETIME,4,7)=TO_CHAR(sysdate-1,'mm/yyyy');

commit;

INSERT INTO REPORT_USER.IT_MOMO_TRANS_PER_SITE_CODE 
SELECT DATETIME,nvl(SITE_CODE,'UNKNOWN') SITE_CODE,count(TRANSACTIONTYPE) TRANSACTIONTYPE
from (
select a.REPORT_DATE,a.MSISDN,a.MAJOR_CELLID,a.SITE_CODE SITE_CODE,b.DATETIME DATETIME,b.MSISDN,b.TRANSACTIONTYPE TRANSACTIONTYPE
from REPORT_USER.IT_MIS_GLOBAL_SITE_CODE_RGS90 a,REPORT_USER.IT_EWP_DAILY_TRANSACTION b
where a.MSISDN(+)='00'||b.MSISDN 
and SUBSTR(b.DATETIME,4,7)=TO_CHAR(sysdate-1,'mm/yyyy')
)
group by DATETIME,nvl(SITE_CODE,'UNKNOWN');

commit;

delete from IT_MOMO_TRANS_PER_SITE_CODE@MKDBLINK 
where SUBSTR(DATETIME,4,7)=TO_CHAR(sysdate-1,'mm/yyyy');

commit;  

insert into IT_MOMO_TRANS_PER_SITE_CODE@MKDBLINK
select * from REPORT_USER.IT_MOMO_TRANS_PER_SITE_CODE 
where SUBSTR(DATETIME,4,7)=TO_CHAR(sysdate-1,'mm/yyyy');

commit;

------------------the name of this report on FACTS is MOMO_DEPOSIT_TRANSACTION_PER_SITE_CODE
----- MOMO DEPOSIT TOTAL AMOUNT TRANSACTION PER SITE
delete from REPORT_USER.IT_MOMO_DEPOSIT_TRANS_DAILY c
where SUBSTR(c.DATETIME,1,7)=TO_CHAR(sysdate-1,'yyyy-mm');

commit;

insert into REPORT_USER.IT_MOMO_DEPOSIT_TRANS_DAILY
select DATETIME,TOMSISDN,FROMACCOUNT,TOUSERNAME, AMOUNT
from EWP_FINANCIAL_CSV@MIS2MOMOREPORT
where UPPER (TRANSACTIONTYPE) LIKE '%DEPOSIT%'
and TOMSISDN is not null
and upper(trim(TRANSACTIONSTATUS))='COMMITTED'
and SUBSTR(DATETIME,1,7)=TO_CHAR(sysdate-1,'yyyy-mm');

commit;

delete from REPORT_USER.IT_MOMO_DEPOSIT_PER_SITE_CODE  c
where SUBSTR(c.DATETIME,1,7)=TO_CHAR(sysdate-1,'yyyy-mm');

commit;

INSERT INTO REPORT_USER.IT_MOMO_DEPOSIT_PER_SITE_CODE 
SELECT SUBSTR(DATETIME,1,10) DATETIME,nvl(SITE_CODE,'UNKNOWN') SITE_CODE,TOMSISDN,TOUSERNAME,sum(to_number(AMOUNT)) AMOUNT
from (
select a.REPORT_DATE,a.MSISDN,a.MAJOR_CELLID,a.SITE_CODE SITE_CODE,b.DATETIME DATETIME,b.TOMSISDN TOMSISDN,TOUSERNAME TOUSERNAME,b.AMOUNT AMOUNT
from REPORT_USER.IT_MIS_GLOBAL_SITE_CODE_RGS90 a,REPORT_USER.IT_MOMO_DEPOSIT_TRANS_DAILY b
where a.MSISDN(+)='00'||b.TOMSISDN 
and SUBSTR(b.DATETIME,1,7)=TO_CHAR(sysdate-1,'yyyy-mm')
)
group by SUBSTR(DATETIME,1,10),nvl(SITE_CODE,'UNKNOWN'),TOMSISDN,TOUSERNAME;

commit;

delete from IT_MOMO_DEPOSIT_PER_SITE_CODE@MKDBLINK  c
where SUBSTR(c.DATETIME,1,7)=TO_CHAR(sysdate-1,'yyyy-mm');

commit;

INSERT INTO IT_MOMO_DEPOSIT_PER_SITE_CODE@MKDBLINK
SELECT *
from REPORT_USER.IT_MOMO_DEPOSIT_PER_SITE_CODE  c
where SUBSTR(c.DATETIME,1,7)=TO_CHAR(sysdate-1,'yyyy-mm');

commit;

------------------the name of this report on FACTS is MOMO_CASHIN_CASHOUT_AMOUNT_PER_SITE_CODE
----- MOMO CASH_IN CASH_OUT AMOUNT PER SITE
delete from REPORT_USER.IT_MOMO_CASH_IN_OUT_SITE_CODE b
where SUBSTR(b.DATETIME,4,7)=TO_CHAR(sysdate-1,'mm/yyyy');

commit;

insert into REPORT_USER.IT_MOMO_CASH_IN_OUT_SITE_CODE  
SELECT DATETIME,nvl(SITE_CODE,'UNKNOWN') SITE_CODE,TRANSACTIONTYPE,sum(to_number(TRANSACTION_AMOUNT)) TRANSACTION_AMOUNT,sum(to_number(FROMFEE)) FROMFEE,sum(to_number(TOFEE)) TOFEE
from (
select a.REPORT_DATE,a.MSISDN,a.MAJOR_CELLID,a.SITE_CODE SITE_CODE,b.TRANSACTIONTYPE TRANSACTIONTYPE,b.MSISDN MSISDN,b.TRANSACTION_AMOUNT TRANSACTION_AMOUNT,b.FROMFEE FROMFEE,b.TOFEE TOFEE,b.DATETIME DATETIME
from REPORT_USER.IT_MIS_GLOBAL_SITE_CODE_RGS90 a,REPORT_USER.IT_EWP_CASHIN_CASHOUT_AMOUNT b
where a.MSISDN(+)='00'||b.MSISDN 
and SUBSTR(b.DATETIME,4,7)=TO_CHAR(sysdate-1,'mm/yyyy')
)
group by DATETIME,nvl(SITE_CODE,'UNKNOWN'),TRANSACTIONTYPE;

commit;

delete from IT_MOMO_CASH_IN_OUT_SITE_CODE@MKDBLINK b
where SUBSTR(b.DATETIME,4,7)=TO_CHAR(sysdate-1,'mm/yyyy');

commit;

INSERT INTO IT_MOMO_CASH_IN_OUT_SITE_CODE@MKDBLINK
select * from REPORT_USER.IT_MOMO_CASH_IN_OUT_SITE_CODE b
where SUBSTR(b.DATETIME,4,7)=TO_CHAR(sysdate-1,'mm/yyyy');

commit;

------------------the name of this report on FACTS is MOMO_PENETRATION_PER_SITE_CODE
----- MOMO PENETRATION AMOUNT PER SITE

DELETE from REPORT_USER.IT_MOMO_PENETRATION_PER_SITE
where SUBSTR(DATETIME,4,7)=TO_CHAR(sysdate-1,'mm/yyyy');

commit;

INSERT INTO REPORT_USER.IT_MOMO_PENETRATION_PER_SITE 
SELECT SUBSTR(DATETIME,1,10) DATETIME,nvl(SITE_CODE,'UNKNOWN') SITE_CODE,TRANSACTIONTYPE,sum(to_number(AMOUNT)) AMOUNT,sum(to_number(FROMFEE)) FROMFEE,sum(to_number(TOFEE)) TOFEE
from (
select a.REPORT_DATE,a.MSISDN MSISDN_RGS90,a.MAJOR_CELLID,a.SITE_CODE SITE_CODE,b.DATETIME DATETIME,b.MSISDN MSISDN,TRANSACTIONTYPE TRANSACTIONTYPE,b.TRANSACTION_AMOUNT AMOUNT,b.FROMFEE FROMFEE,b.TOFEE TOFEE
from REPORT_USER.IT_MIS_GLOBAL_SITE_CODE_RGS90 a,REPORT_USER.IT_EWP_DAILY_PENETRATION b
where a.MSISDN(+)='00'||b.MSISDN 
and SUBSTR(b.DATETIME,4,7)=TO_CHAR(sysdate-1,'mm/yyyy')
)
group by SUBSTR(DATETIME,1,10),nvl(SITE_CODE,'UNKNOWN'),TRANSACTIONTYPE;

commit;

DELETE from IT_MOMO_PENETRATION_PER_SITE@MKDBLINK
where SUBSTR(DATETIME,4,7)=TO_CHAR(sysdate-1,'mm/yyyy');

commit;

insert into IT_MOMO_PENETRATION_PER_SITE@MKDBLINK
select *
from REPORT_USER.IT_MOMO_PENETRATION_PER_SITE
where SUBSTR(DATETIME,4,7)=TO_CHAR(sysdate-1,'mm/yyyy');

commit;

------------------the name of this report on FACTS is RGS30_MOMO_per_SITE_CODE
----- MOMO SUBSCRIBER RGS30 PER SITE
delete from REPORT_USER.IT_MIS_RGS_MOMO_DTL_PER_SITE
WHERE REPORT_DATE=to_date(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

INSERT INTO REPORT_USER.IT_MIS_RGS_MOMO_DTL_PER_SITE 
SELECT REPORT_DATE,RGS_TYPE,PERIOD,nvl(SITE_CODE,'UNKNOWN') SITE_CODE,PROFILE_NAME,count(MSISDN) TOTAL_MSISDN
from (
      select a.REPORT_DATE REPORT_DATE_MJR_CELLID,a.MSISDN MSISDN_RGS90,a.MAJOR_CELLID,a.SITE_CODE SITE_CODE,
             b.REPORT_DATE REPORT_DATE,b.MSISDN MSISDN,b.RGS_TYPE RGS_TYPE,b.PERIOD PERIOD,b.PROFILE PROFILE_NAME
      from REPORT_USER.IT_MIS_GLOBAL_SITE_CODE_RGS90 a,REPORT_USER.IT_MIS_RGS_MOMO_DETAILS b
      where a.MSISDN(+)='00'||b.MSISDN 
      and b.REPORT_DATE=to_date(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
     )
group by REPORT_DATE,RGS_TYPE,PERIOD,nvl(SITE_CODE,'UNKNOWN'),PROFILE_NAME;

commit;

delete from IT_MIS_RGS_MOMO_DTL_PER_SITE@MKDBLINK
WHERE REPORT_DATE=to_date(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

insert into IT_MIS_RGS_MOMO_DTL_PER_SITE@MKDBLINK
select * from REPORT_USER.IT_MIS_RGS_MOMO_DTL_PER_SITE
WHERE REPORT_DATE=to_date(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;




------------------the name of this report on FACTS is MOMO_BUNDLE_PURCHASSED_REPORT
----- MOMO BUNDLE PURCHASSED DAIL REPORT

delete from REPORT_USER.IT_MIS_DAILY_MOMO_BUNDLE_BUYED
where to_date(DATETIME,'dd/mm/yyyy')=to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

insert into REPORT_USER.IT_MIS_DAILY_MOMO_BUNDLE_BUYED
select * 
from REPORT_USER.IT_EWP_DAILY_MOMO_BUNDLE_BUY
where to_date(DATETIME,'dd/mm/yyyy')=to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

delete from IT_MIS_DAILY_MOMO_BUNDLE_BUYED@MKDBLINK
where to_date(DATETIME,'dd/mm/yyyy')=to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

INSERT INTO IT_MIS_DAILY_MOMO_BUNDLE_BUYED@MKDBLINK
select * 
from REPORT_USER.IT_EWP_DAILY_MOMO_BUNDLE_BUY
where to_date(DATETIME,'dd/mm/yyyy')=to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

------------------the name of this report on FACTS is MOMO_FIRST_CASHIN_BULK_REG
----- MOMO_FIRST_CASHIN_BULK_REG >=2000 REPORT (activation_date=cashin_date)
delete from REPORT_USER.it_mis_momo_actv_receivekdo_3k a
where to_date(to_char(a.LOGGINGTIME,'dd/mm/yyyy'),'dd/mm/yyyy')=to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

insert into REPORT_USER.it_mis_momo_actv_receivekdo_3k   
select to_date(to_char(LOGGINGTIME,'dd/mm/yyyy hh24:mi:ss'),'dd/mm/yyyy hh24:mi:ss') LOGGINGTIME,
       MSISDN,RECRUITER,AH_GIVENNAME,AH_SURNAME,AH_BIRTHDATE,AH_GENDER,TRANSACTIONID
       TRANSACTIONTYPE,PROFILENAME,IDENTITY,'3000' AMOUNT
from REPORT_USER.IT_MOMO_ACTIVATION_AREA_DAILY 
where RECRUITER='BULK_REG_MOMO'
and REPORT_DATE=to_char(sysdate-1,'yyyy-mm-dd');

commit;

delete from REPORT_USER.it_mis_CASHIN_aft_3k_kdo a
where to_date(to_char(a.DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy')=to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

insert into REPORT_USER.it_mis_CASHIN_aft_3k_kdo 
select DISTINCT a.FROMMSISDN AGENT_OR_MERCHANT_MSISDN,a.TOMSISDN MSISDN,a.AMOUNT CASH_IN_AMOUNT,
to_date(substr(a.DATETIME,9,2)||substr(a.DATETIME,6,2)||substr(a.DATETIME,1,4)||substr(a.DATETIME,11,9),'dd/mm/yyyy hh24:mi:ss') DATETIME
from EWP_FINANCIAL_CSV@MIS2MOMOREPORT a
where TRANSACTIONTYPE='CASH_IN'
and upper(trim(a.TRANSACTIONSTATUS))='COMMITTED'
and a.FROMMSISDN!='224661320469'
and a.TOMSISDN in(SELECT MSISDN FROM REPORT_USER.it_mis_momo_actv_receivekdo_3k)
and substr(a.DATETIME,1,10)=to_char(sysdate-1,'yyyy-mm-dd');

commit;

truncate table REPORT_USER.it_mis_first_CASHIN_aft_3k_kdo;

insert into REPORT_USER.it_mis_first_CASHIN_aft_3k_kdo 
SELECT distinct a.AGENT_OR_MERCHANT_MSISDN,a.MSISDN,a.CASH_IN_AMOUNT,a.DATETIME
FROM report_user.it_mis_CASHIN_aft_3k_kdo a
where a.DATETIME=(select min(b.DATETIME) 
                  from REPORT_USER.it_mis_CASHIN_aft_3k_kdo b
                  where a.MSISDN=b.MSISDN
                  group by b.MSISDN);

commit;

truncate table REPORT_USER.IT_MIS_FIRST_CASHIN_BULK_REG;

insert into REPORT_USER.IT_MIS_FIRST_CASHIN_BULK_REG
select distinct a.LOGGINGTIME ACTIVATION_DATE,a.MSISDN,/*a.AH_GIVENNAME,a.AH_SURNAME,a.AH_BIRTHDATE,a.IDENTITY,*/a.PROFILENAME,
       b.CASH_IN_AMOUNT,b.AGENT_OR_MERCHANT_MSISDN,b.CASH_IN_DATE
from REPORT_USER.it_mis_momo_actv_receivekdo_3k a,(select AGENT_OR_MERCHANT_MSISDN,MSISDN,CASH_IN_AMOUNT,DATETIME CASH_IN_DATE
                                        from REPORT_USER.it_mis_first_CASHIN_aft_3k_kdo
                                        WHERE TO_NUMBER(CASH_IN_AMOUNT)>=2000) b
where a.MSISDN=b.MSISDN
and to_date(to_char(a.LOGGINGTIME,'dd/mm/yyyy'),'dd/mm/yyyy')=to_date(to_char(b.CASH_IN_DATE,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

delete FROM IT_MIS_FIRST_CASHIN_BULK_REG@MKDBLINK; commit;
  
insert into IT_MIS_FIRST_CASHIN_BULK_REG@MKDBLINK 
SELECT *
FROM REPORT_USER.IT_MIS_FIRST_CASHIN_BULK_REG;

commit;

------------------the name of this report on FACTS is MOMOSP_TRANSACTION_DETAIL_REPORT
----- MOMO SP TRANSACTION DETAIL REPORT 
delete from REPORT_USER.IT_MIS_SP_TRANSACTION_DETAIL
where substr(DATETIME,1,10)=to_char(sysdate-1,'yyyy-mm-dd');

commit;

insert into REPORT_USER.IT_MIS_SP_TRANSACTION_DETAIL 
select DATETIME,TRANSACTIONID,TRANSACTIONTYPE,FROMMSISDN,FROMUSERNAME,FROMPROFILE,
              TOMSISDN,TOUSERNAME,TOPROFILE,AMOUNT,FROMFEE,TOFEE,TRANSACTIONSTATUS
from EWP_FINANCIAL_CSV@MIS2MOMOREPORT
where TRANSACTIONTYPE in ('DEBIT','TRANSFER')
and substr(DATETIME,1,10)=to_char(sysdate-1,'yyyy-mm-dd');

commit;

delete from IT_MIS_SP_TRANSACTION_DETAIL@MKDBLINK
where substr(DATETIME,1,10)=to_char(sysdate-1,'yyyy-mm-dd');

commit;

INSERT INTO IT_MIS_SP_TRANSACTION_DETAIL@MKDBLINK
SELECT * from REPORT_USER.IT_MIS_SP_TRANSACTION_DETAIL
where substr(DATETIME,1,10)=to_char(sysdate-1,'yyyy-mm-dd');

commit;

---------------------------REGULATION BALANCE--------------------------------------
truncate table REPORT_USER.IT_MOMO_ACCOUNT_PROFILE_STATUS;

insert into REPORT_USER.IT_MOMO_ACCOUNT_PROFILE_STATUS 
SELECT distinct c.REGISTRATION_DATE,b.ACTIVATION_DATE,c.MSISDN,d.BALANCE,b.ACCOUNTHOLDER_ID,b.PROFILENAME,c.OTHERID,c.OTHERID_TYPE,d.ACCOUNTSTATUS,c.AH_GIVENNAME,c.AH_SURNAME,c.AH_GENDER,d.LASTACTIVITYTIME,to_date(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy') REPORT_DATE
from 
(SELECT to_date(to_char(LOGGINGTIME,'dd/mm/yyyy hh24:mi:ss'),'dd/mm/yyyy hh24:mi:ss') ACTIVATION_DATE,MSISDN,IDENTITY,ACCOUNTHOLDER_ID,PROFILENAME,OTHERID
from TBL_AUDITLOG@MIS2MOMOREPORT
WHERE transactiontype = 'ActivateUser' 
and status='SUCCESS') b,
(
SELECT to_date(to_char(LOGGINGTIME,'dd/mm/yyyy hh24:mi:ss'),'dd/mm/yyyy hh24:mi:ss') REGISTRATION_DATE,MSISDN,IDENTITY,PROFILENAME,OTHERID,AH_GIVENNAME,AH_SURNAME,AH_GENDER,OTHERID_TYPE
from TBL_AUDITLOG@MIS2MOMOREPORT
WHERE transactiontype = 'RegisterAccountHolder' 
and status='SUCCESS'
) c,EOD_USER_BALANCE@MIS2MOMOREPORT d
where substr(b.ACCOUNTHOLDER_ID,4,12)=c.MSISDN --b.PROFILENAME=c.PROFILENAME
and c.IDENTITY=d.ACCOUNTHOLDERID
and c.MSISDN=d.MSISDN
and b.IDENTITY=d.ACCOUNTHOLDERID
--and d.CURRENCY='GNF'
--AND UPPER(d.PROFILE) LIKE'ACCOUNT%HOLDER%'
and trim(ACCOUNTTYPE)='Mobile Money';

commit;

truncate table REPORT_USER.IT_MOMO_ACCOUNT_PROFILE_STAT_H;

insert into REPORT_USER.IT_MOMO_ACCOUNT_PROFILE_STAT_H 
SELECT distinct c.REGISTRATION_DATE,c.ACTIVATION_DATE,d.MSISDN,d.BALANCE,'Not Available' ACCOUNTHOLDER_ID,c.PROFILENAME,c.IDNUMBER OTHERID,c.IDTYPE OTHERID_TYPE,d.ACCOUNTSTATUS,c.NAME AH_GIVENNAME,c.NAME AH_SURNAME,c.GENDER AH_GENDER,d.LASTACTIVITYTIME,to_date(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy') REPORT_DATE
from EOD_USER_BALANCE@MIS2MOMOREPORT d,REPORT_USER.IT_MIS_MOMO_SUBSCRIBERS c
where d.MSISDN=c.MSISDN --b.PROFILENAME=c.PROFILENAME
--and b.IDENTITY=c.IDENTITY
--AND UPPER(d.PROFILE) LIKE'ACCOUNT%HOLDER%'
and trim(ACCOUNTTYPE)='Mobile Money'
and d.MSISDN not in(select MSISDN from REPORT_USER.IT_MOMO_ACCOUNT_PROFILE_STATUS);

commit;

delete from REPORT_USER.IT_MOMO_SUBSCRIBER_PER_SITE
where to_date(DATETIME,'dd/mm/yyyy')=to_date(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

INSERT INTO REPORT_USER.IT_MOMO_SUBSCRIBER_PER_SITE 
select a.REPORT_DATE,a.MSISDN MSISDN_RGS90,a.MAJOR_CELLID,a.SITE_CODE SITE_CODE,
       TO_CHAR(sysdate-1,'dd/mm/yyyy') DATETIME,b.MSISDN MSISDN,b.PROFILENAME PROFILENAME,b.BALANCE BALANCE
from REPORT_USER.IT_MIS_GLOBAL_SITE_CODE_RGS90 a,REPORT_USER.IT_MOMO_ACCOUNT_PROFILE_STATUS b
where a.MSISDN(+)='00'||b.MSISDN;

COMMIT;

INSERT INTO REPORT_USER.IT_MOMO_SUBSCRIBER_PER_SITE 
select a.REPORT_DATE,a.MSISDN MSISDN_RGS90,a.MAJOR_CELLID,a.SITE_CODE SITE_CODE,
       TO_CHAR(sysdate-1,'dd/mm/yyyy') DATETIME,b.MSISDN MSISDN,b.PROFILENAME PROFILENAME,b.BALANCE BALANCE
from REPORT_USER.IT_MIS_GLOBAL_SITE_CODE_RGS90 a,REPORT_USER.IT_MOMO_ACCOUNT_PROFILE_STAT_H b
where a.MSISDN(+)='00'||b.MSISDN;

COMMIT;  

delete from IT_MOMO_SUBSCRIBER_PER_SITE@MKDBLINK
where to_date(DATETIME,'dd/mm/yyyy')=to_date(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

INSERT INTO IT_MOMO_SUBSCRIBER_PER_SITE@MKDBLINK
SELECT *
from REPORT_USER.IT_MOMO_SUBSCRIBER_PER_SITE
where to_date(DATETIME,'dd/mm/yyyy')=to_date(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

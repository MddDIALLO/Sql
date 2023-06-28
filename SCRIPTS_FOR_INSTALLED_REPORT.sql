------ INVENTORY DATABASE
TRUNCATE TABLE IT_IN_INSTALLED;
------ INVENTORY DATABASE
TRUNCATE TABLE IT_INST_SAGE_MSISDN2;
COMMIT;

------ REPORTDB DATABASE
----- EXECUTE THE BELOW SCRIPT 
insert into INUSER.IT_IN_INSTALLED@STOCKDBLINK
select '224'||a.ACCOUNT_MSISDN,a.ACCOUNT_CLASS
from REPORT_USER.IT_DR_IN_STATUS_SUBSCRIBERS a
where a.STATUS_MSISDN='Installed';

COMMIT;

------ REPORTDB DATABASE
----- EXECUTE THE BELOW SCRIPT 
insert into INUSER.IT_INST_SAGE_MSISDN2@STOCKDBLINK
select '224'||a.ACCOUNT_MSISDN,a.ACCOUNT_CLASS--,a.FIRST_CALL_DATE
from REPORT_USER.IT_DR_IN_STATUS_SUBSCRIBERS a,INUSER.IT_INST_SAGE_MSISDN@STOCKDBLINK b
where '224'||a.ACCOUNT_MSISDN=b.SSF_GSM_NUMBER
and a.STATUS_MSISDN='Installed';

COMMIT;

------ INVENTORY DATABASE
----- EXECUTE THE BELOW SCRIPT 
delete FROM IT_IN_INSTALLED
WHERE GSM_NUMBER in(
                    SELECT SSF_GSM_NUMBER
                    FROM IT_INST_SAGE_MSISDN2);

COMMIT;

------ INVENTORY DATABASE
----- EXECUTE THE BELOW SCRIPT 
INSERT INTO IT_INST_PROFILE_MONTHLY
  ---- GLOBAL REPORT INSTALLED MSISDN PER INVENTORY PROFILE new script
SELECT  'INVENTORY PROFILE' PROFILE_TYPE,c.INV_ITEM_NAME ITEM_NAME, COUNT(1) TOTAL,TO_CHAR(SYSDATE-2,'YYYYMM') 
FROM IT_IN_INSTALLED a, SIM_SUP_FILE b , INV_ITEM c 
WHERE trim(a.GSM_NUMBER)=b.SSF_GSM_NUMBER
AND c.INV_ITEM_ID=b.SSF_INV_ITEM
AND b.SSF_ACT_DATE IS  NULL -- (b.SSF_ACT_DATE is  null or b.SSF_ACT_DATE=to_date('01/01/2015','dd/mm/yyyy') ) -- 
AND b.SSF_RP_ID IS NOT  NULL
AND b.SSF_CREATION_DATE= (SELECT MAX(d.ssf_creation_date)
                              FROM SIM_SUP_FILE d
                              WHERE d.ssf_gsm_number = b.ssf_gsm_number
                             -- and b.ssf_act_date =to_date(record_in_fc.fc,'dd/mm/yyyy')        
                              GROUP BY d.ssf_gsm_number
                              ) 
GROUP BY c.INV_ITEM_NAME;
                              
commit; 

------ INVENTORY DATABASE 
----- EXECUTE THE BELOW SCRIPT 
INSERT INTO IT_INST_PROFILE_MONTHLY
--- GLOBAL REPORT INSTALLED MSISDN PER SERVICE CLASS new script 
SELECT 'SERVICE_CLASS PROFILE' PROFILE_TYPE,a.SERVICE_CLASS , COUNT(1) TOTAL,TO_CHAR(SYSDATE-2,'YYYYMM') 
FROM IT_IN_INSTALLED a, SIM_SUP_FILE b , INV_ITEM c 
WHERE trim(a.GSM_NUMBER)=b.SSF_GSM_NUMBER
AND c.INV_ITEM_ID=b.SSF_INV_ITEM
AND b.SSF_ACT_DATE IS  NULL --  (b.SSF_ACT_DATE is  null or b.SSF_ACT_DATE=to_date('01/01/2015','dd/mm/yyyy') ) --  
AND b.SSF_RP_ID IS NOT  NULL
AND b.SSF_CREATION_DATE= (SELECT MAX(d.ssf_creation_date)
                              FROM SIM_SUP_FILE d
                              WHERE d.ssf_gsm_number = b.ssf_gsm_number
                             -- and b.ssf_act_date =to_date(record_in_fc.fc,'dd/mm/yyyy')        
                              GROUP BY d.ssf_gsm_number
                              ) 

GROUP BY a.SERVICE_CLASS;

COMMIT;


---- installed of sold from Sage
------ INVENTORY DATABASE
----- EXECUTE THE BELOW SCRIPT 
INSERT INTO IT_INST_PROFILE_MONTHLY
  ---- GLOBAL REPORT INSTALLED MSISDN PER INVENTORY PROFILE new script
SELECT  'SAGE INVENTORY PROFILE' PROFILE_TYPE,c.INV_ITEM_NAME ITEM_NAME, COUNT(1) TOTAL,TO_CHAR(SYSDATE-2,'YYYYMM') 
FROM IT_INST_SAGE_MSISDN2 a, SIM_SUP_FILE b , INV_ITEM c 
WHERE trim(a.SSF_GSM_NUMBER)=b.SSF_GSM_NUMBER
AND c.INV_ITEM_ID=b.SSF_INV_ITEM
AND b.SSF_ACT_DATE IS  NULL --  (b.SSF_ACT_DATE is  null or b.SSF_ACT_DATE=to_date('01/01/2015','dd/mm/yyyy') ) -- 
AND b.SSF_RP_ID IS NULL
AND b.SSF_CREATION_DATE= (SELECT MAX(d.ssf_creation_date)
                              FROM SIM_SUP_FILE d
                              WHERE d.ssf_gsm_number = b.ssf_gsm_number
                             -- and b.ssf_act_date =to_date(record_in_fc.fc,'dd/mm/yyyy')        
                              GROUP BY d.ssf_gsm_number
                              ) 
GROUP BY c.INV_ITEM_NAME;
                              
commit; 


------ INVENTORY DATABASE
----- EXECUTE THE BELOW SCRIPT 
INSERT INTO IT_INST_PROFILE_MONTHLY
--- GLOBAL REPORT INSTALLED MSISDN PER SERVICE CLASS new script 
SELECT 'SAGE SERVICE_CLASS PROFILE' PROFILE_TYPE,a.ACCOUNT_CLASS , COUNT(1) TOTAL,TO_CHAR(SYSDATE-2,'YYYYMM') 
FROM IT_INST_SAGE_MSISDN2 a, SIM_SUP_FILE b , INV_ITEM c 
WHERE trim(a.SSF_GSM_NUMBER)=b.SSF_GSM_NUMBER
AND c.INV_ITEM_ID=b.SSF_INV_ITEM
AND b.SSF_ACT_DATE IS  NULL -- (b.SSF_ACT_DATE is  null or b.SSF_ACT_DATE=to_date('01/01/2015','dd/mm/yyyy') ) --  
AND b.SSF_RP_ID IS NULL
AND b.SSF_CREATION_DATE= (SELECT MAX(d.ssf_creation_date)
                              FROM SIM_SUP_FILE d
                              WHERE d.ssf_gsm_number = b.ssf_gsm_number
                             -- and b.ssf_act_date =to_date(record_in_fc.fc,'dd/mm/yyyy')        
                              GROUP BY d.ssf_gsm_number
                              ) 

GROUP BY a.ACCOUNT_CLASS;

COMMIT;


---- installed detail of sold from Inventory
----- EXECUTE THE BELOW SCRIPT 
TRUNCATE TABLE IT_DTL_INSTALLED_SOLD;

COMMIT;

------ INVENTORY DATABASE
----- EXECUTE THE BELOW SCRIPT 
INSERT INTO IT_DTL_INSTALLED_SOLD 
  ---DETAIL INSTALLED MSISDN new script
SELECT b.SSF_GSM_NUMBER
FROM IT_IN_INSTALLED a, SIM_SUP_FILE b , INV_ITEM c 
WHERE trim(a.GSM_NUMBER)=b.SSF_GSM_NUMBER
AND c.INV_ITEM_ID=b.SSF_INV_ITEM
AND b.SSF_ACT_DATE IS  NULL  -- (b.SSF_ACT_DATE IS  NULL or b.SSF_ACT_DATE = to_date('01/01/2015','dd/mm/yyyy'))
AND b.SSF_RP_ID IS NOT  NULL
AND b.SSF_CREATION_DATE= (SELECT MAX(d.ssf_creation_date)
                              FROM SIM_SUP_FILE d
                              WHERE d.ssf_gsm_number = b.ssf_gsm_number
                             -- and b.ssf_act_date =to_date(record_in_fc.fc,'dd/mm/yyyy')        
                              GROUP BY d.ssf_gsm_number
                              ) ;
                              
commit; 


------ INVENTORY DATABASE
----- EXECUTE THE BELOW SCRIPT 
INSERT INTO IT_DTL_INSTALLED_SOLD
  ---DETAIL INSTALLED MSISDN new script
SELECT b.SSF_GSM_NUMBER
FROM IT_INST_SAGE_MSISDN2 a, SIM_SUP_FILE b , INV_ITEM c 
WHERE trim(a.SSF_GSM_NUMBER)=b.SSF_GSM_NUMBER
AND c.INV_ITEM_ID=b.SSF_INV_ITEM
AND b.SSF_ACT_DATE IS  NULL -- (b.SSF_ACT_DATE IS  NULL or b.SSF_ACT_DATE = to_date('01/01/2015','dd/mm/yyyy'))
AND b.SSF_RP_ID IS NULL
AND b.SSF_CREATION_DATE= (SELECT MAX(d.ssf_creation_date)
                              FROM SIM_SUP_FILE d
                              WHERE d.ssf_gsm_number = b.ssf_gsm_number
                             -- and b.ssf_act_date =to_date(record_in_fc.fc,'dd/mm/yyyy')        
                              GROUP BY d.ssf_gsm_number
                              ) ;
                              
commit; 



--------Après avoir lancer toutes les procedures et scripts, on recupère les données comme suit---------

---Pour la partie SIM Cards Initial Balance du Rapport Unearned Revenue on utilise les scripts suivants:
--Pour le nombre de Sim vendues par SC
select *
from IT_INST_PROFILE_MONTHLY
where MONTH_YEAR=TO_CHAR(SYSDATE-3,'YYYYMM') 
and PROFILE_TYPE like'%SERVICE%';

--Pour determiner les doublons par SC
select ACCOUNT_CLASS, COUNT(distinct ACCOUNT_MSISDN)  
from IT_DR_IN_STATUS_SUBSCRIBERS 
where '224'||ACCOUNT_MSISDN in(SELECT SSF_GSM_NUMBER 
                                FROM IT_DTL_INSTALLED_SOLD@STOCKDBLINK
                                group by SSF_GSM_NUMBER
                                having count(SSF_GSM_NUMBER)>1
                                )
GROUP BY ACCOUNT_CLASS
  


--Pour verifier la quantité par SC avant mise à jour
select *
from IT_INST_PROFILE_MONTHLY
where MONTH_YEAR=TO_CHAR(SYSDATE-3,'YYYYMM') 
and PROFILE_TYPE like'SAGE%'
and ITEM_NAME ='SC'

--Pour la suppression des doublons par SC nombre de 
update IT_INST_PROFILE_MONTHLY
set QUANTITY=QUANTITY-n
where MONTH_YEAR=TO_CHAR(SYSDATE-1,'YYYYMM') 
and PROFILE_TYPE like'SAGE%'
and ITEM_NAME ='SC'

  

---Pour le rapport SAGE1000 on utilise les scripts suivants------------------------
--FIRST CALLS REPORT
SELECT ACTV_STATUS,RP_NAME,ITEM_NAME,QUANTITY
FROM IT_SIM_ACTV_REPORT;

--SALES FROM INVENTORY (DATE_DISTRIBUTOR_ITEM_QUANTITY)
select *
from IT_VOUCHERS_DIST_ITEM_QTY;

--SALES FROM INVENTORY (DATE_ITEM)
select USEDDATE,VOUCHER_NAME,sum(QUANTITY_ACTIVATED) QUANTITY_ACTIVATED
from IT_VOUCHERS_DIST_ITEM_QTY
group by USEDDATE,VOUCHER_NAME;

--SALES FROM SAGE (DATE_DISTRIBUTOR_ITEM_QUANTITY AND DATE_ITEM)
select USEDDATE,ITEM_NAME,count(distinct SERIAL) TOTAL
from IT_VOUCHERS_USED_SAGE_DTL1
group by USEDDATE,ITEM_NAME;

--USED VOUCHERS REPORT--
select DISTRIBUTOR,VOUCHER_NAME,sum(QUANTITY_ACTIVATED) QUANTITY_ACTIVATED
from IT_VOUCHERS_DIST_ITEM_QTY
group by DISTRIBUTOR,VOUCHER_NAME
UNION ALL
SELECT STORE_SELLING,ITEM_NAME,QUANTITY_ACTIVATED 
FROM IT_VOUCHERS_POS_MAG_REPORT
UNION ALL
select 'SALES FROM SAGE',ITEM_NAME,count(distinct SERIAL) TOTAL
from IT_VOUCHERS_USED_SAGE_DTL1
group by ITEM_NAME
UNION ALL
select 'HORS_SYSTEM',ITEM_NAME,count(distinct SERIAL) TOTAL
from IT_VOUCHERS_DTL_MTH1
group by ITEM_NAME
union all
select * from IT_DAMMAGE_REPORT_MTH;


SELECT *
FROM IT_CREDIT_SALES_DTL


SELECT *
FROM IT_CREDIT_SALES_GBL


select * from IT_DAMMAGE_REPORT_MTH


--LES TABLES DU RGS A CREER CHAQUE MOIS------------
select * from IT_MIS_RGS_MTC_LOAD_DEC18

select * from IT_MIS_RGS_MTC2_LOAD_DEC18

select * from IT_MIS_RGS_MOC_LOAD_DEC18

select * from IT_MIS_RGS_MTC2_LOAD_DEC18


select * from IT_MIS_MOC_REV_GLOBAL_DEC18


CREATE OR REPLACE PROCEDURE REPORT_USER.IT_MIS_TRACKING_FC_NEW_TMP IS
 
BEGIN 

DECLARE
daily_date VARCHAR2(30);
gadgbl number;
gadloc number;
fcrgbl number;
fcrloc number;

CURSOR CURRENT_DATE IS 
   
    SELECT  TO_DATE(a.NAME,'dd/mm/yyyy') NAME2,SUBSTR(a.NAME,1,2) day_name, to_char(to_date(a.name,'dd/mm/yyyy'),'yyyymmdd') NAME,substr(b.FULL_NAMES_ENGLISH,1,3)||substr(b.YEARS,-2,2) MONTHS
    FROM REPORT_USER.IT_DAY_TO_DAY a,REPORT_USER.IT_MONTH_TO_YEAR b
    where substr(a.name,-4,4)=b.YEARS
    AND trim(to_char(to_date(a.name,'dd/mm/yyyy'),'MONTH'))=trim(b.FULL_NAMES_ENGLISH)
   -- and to_date(a.name,'dd/mm/yyyy')  between to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy') 
    and to_date(name,'dd/mm/yyyy')  between  to_date('17/07/2018','dd/mm/yyyy') and to_date('17/07/2018','dd/mm/yyyy') 
    order by substr(a.name,1,2);
    
   
record_current_date    CURRENT_DATE%ROWTYPE;

BEGIN 
  
  
  OPEN CURRENT_DATE;
       
     LOOP
         FETCH CURRENT_DATE INTO record_current_date;
            EXIT WHEN CURRENT_DATE%NOTFOUND;   
                                        
  /* SCRIPT FOR LOADING RECONNECTION MSISDN  YESTERDAY    */        

--DELETE FROM  IT_MIS_RGS90_CHURN_GROSSADD
--WHERE  RGS_TYPE = 'RECO'
--AND report_date =TO_DATE(record_current_date.NAME,'dd/mm/yyyy');
--            
--COMMIT;
 
/*INSERT INTO  IT_MIS_RGS90_CHURN_GROSSADD  
SELECT 'RECO' RGS_TYPE ,msisdn,record_current_date.NAME2 report_date  --TO_DATE(record_current_date.NAME,'dd/mm/yyyy') report_date  
FROM ( 

           
(SELECT msisdn
FROM IT_MIS_RGS90_MOC_MTC_DETAIL
WHERE report_date = record_current_date.NAME2 -- TO_DATE(record_current_date.NAME,'dd/mm/yyyy') 
AND operator_name='Areeba'

MINUS

SELECT msisdn
FROM IT_MIS_RGS90_MOC_MTC_DETAIL
WHERE report_date= record_current_date.NAME2-1 -- TO_DATE(record_current_date.NAME,'dd/mm/yyyy')-1
AND operator_name='Areeba'
 
 )
 
 MINUS
 
 ( SELECT DISTINCT '224'|| account_msisdn msisdn FROM IT_DR_IN_STATUS_SUBSCRIBERS
                       WHERE status_msisdn <> 'Installed'
                       AND first_call_date <> TO_DATE('01/01/1970','dd/mm/yyyy')
                        AND first_call_date = record_current_date.NAME2 -- TO_DATE(record_current_date.NAME,'dd/mm/yyyy')
)                     
 

          
) ;

COMMIT; */ 

/* END SCRIPT FOR LOADING RECONNECTION MSISDN  YESTERDAY    */

                  EXECUTE IMMEDIATE 'TRUNCATE TABLE report_user.IT_MIS_DAILY_FIRST_CALL_TEMP';
                  COMMIT;
                   
                  INSERT INTO  report_user.IT_MIS_DAILY_FIRST_CALL_TEMP 
                  SELECT DISTINCT '224'|| account_msisdn msisdn,first_call_date FROM REPORT_USER.IT_DR_IN_STATUS_SUBSCRIBERS
                  WHERE status_msisdn <> 'Installed'
                  AND first_call_date <> TO_DATE('01/01/1970','dd/mm/yyyy')
                  AND TO_CHAR(first_call_date,'yyyymmdd') = record_current_date.NAME;            
                 
                  COMMIT;      
               
                    
  SELECT record_current_date.NAME INTO daily_date
  FROM dual ;
  
  -- substr(daily_date,1,2)
  
--   IF SUBSTR(daily_date,1,2)<=9 THEN  
  
  --- FC SCRIPT INSERTION  
    
    EXECUTE IMMEDIATE 'INSERT INTO report_user.IT_MIS_DAILY_FIRST_CALL_REPORT ' ||

    ' SELECT  GSM_NUMBER,MAJOR_CELLID,TRANSACTION_DATE ' ||
    ' FROM '|| 

    ' (  SELECT b.GSM_NUMBER FROM report_user.IT_MIS_DAILY_FIRST_CALL_TEMP b ' ||
    ' )t3, ' ||
  
    ' (  SELECT MSISDN GSM, MAX(MAJOR_CELLID) MAJOR_CELLID ,TRANSACTION_DATE ' ||  
    '  FROM  report_user.IT_MIS_MJR_CELLID_DAILY_'||record_current_date.MONTHS||' partition(MK'||daily_date||')' ||
    '  WHERE MAJOR_CELLID is not null' || 
    '  GROUP BY MSISDN ,TRANSACTION_DATE  ' ||  
    ' )t4 WHERE t4.GSM=t3.GSM_NUMBER ' ;  -- SUBSTR(t4.GSM,3,12)=t3.GSM_NUMBER
    
   -- EXECUTE IMMEDIATE 'TRUNCATE TABLE IT_MIS_DAILY_FIRST_CALL_TEMP';
    COMMIT;
    

    
--     ---- WINBACK SCRIPT INSERTION 
--     
       EXECUTE IMMEDIATE ' INSERT INTO  report_user.IT_MIS_DAILY_FC_WINBACK ' ||                  
                        ' select msisdn,major_cellid,report_date ' ||
                        ' from ' ||
                        ' (SELECT MSISDN GSM, MAX(MAJOR_CELLID) MAJOR_CELLID ,TRANSACTION_DATE ' ||
                        ' FROM  report_user.IT_MIS_MJR_CELLID_DAILY_'||record_current_date.MONTHS||' partition(MK'||daily_date||')' ||
                        ' WHERE MAJOR_CELLID is not null'  ||
                        ' GROUP BY MSISDN ,TRANSACTION_DATE ) t1, ' ||

                        ' (select msisdn,report_date ' ||
                        ' from  report_user.IT_MIS_RGS90_CHURN_GROSSADD ' ||
                        ' where to_char(report_date,''yyyymmdd'') = ' ||record_current_date.NAME||
                        ' and rgs_type=''RECO'' ' ||
                        ' ) t2 ' ||
                        ' where t1.GSM=t2.msisdn ' || --  SUBSTR(t1.GSM,3,12)=t2.msisdn
                        ' and t1.transaction_date=t2.report_date ' ;
                    
       COMMIT;
         
         INSERT INTO report_user.IT_MIS_DAILY_FIRST_CALL_REPORT 
         SELECT  * 
         FROM report_user.IT_MIS_DAILY_FC_WINBACK 
         WHERE TO_CHAR(FC_DATE_RECO,'yyyymmdd') =  record_current_date.NAME;


COMMIT;

execute immediate 'truncate table REPORT_USER.IT_MIS_UNLOCALIZED_GADD';


insert into REPORT_USER.IT_MIS_UNLOCALIZED_GADD
select *
from REPORT_USER.IT_MIS_DAILY_FIRST_CALL_REPORT
where to_char(DAILY_CONSO,'yyyymmdd')=record_current_date.NAME
and MAJOR_CELL_ID not like'%-%'
and MAJOR_CELL_ID not in(select cellid from REPORT_USER.it_mis_cellid_final_2013);

commit;

DELETE from REPORT_USER.IT_MIS_DAILY_FIRST_CALL_REPORT
where to_char(DAILY_CONSO,'yyyymmdd')=record_current_date.NAME
and MAJOR_CELL_ID not in(select cellid from REPORT_USER.it_mis_cellid_final_2013);

commit;

delete from REPORT_USER.IT_MIS_GADD_CELLID_AXON_REGIST
where to_char(REPORT_DATE,'yyyymmdd')=record_current_date.NAME; -- =to_date('17/07/2018','dd/mm/yyyy');

commit;

INSERT INTO REPORT_USER.IT_MIS_GADD_CELLID_AXON_REGIST 
select distinct '224'||a.AGENT_MSISDN AGENT_MSISDN,c.SUBSCRIBER SUBSCRIBER,a.SUBMISSION_CELLID CUSTOMER_SUBMISSION_CELLID,b.SUBMISSION_CELLID AGENT_SUBMISSION_CELLID, to_date(to_char(a.DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy') REPORT_DATE
from REPORT_USER.IT_MIS_AXON_REG_DTL a,REPORT_USER.IT_MIS_AXON_REG_AGT_CELLID b,REPORT_USER.IT_MIS_UNLOCALIZED_GADD c
where a.AGENT_MSISDN=b.AGENT_MSISDN
and '224'||a.CUSTOMER_MSISDN=c.SUBSCRIBER
and to_char(a.DATETIME,'yyyymmdd')=record_current_date.NAME;

commit;

INSERT INTO report_user.IT_MIS_DAILY_FIRST_CALL_REPORT   
    SELECT DISTINCT SUBSCRIBER,AGENT_SUBMISSION_CELLID,REPORT_DATE
    FROM report_user.IT_MIS_GADD_CELLID_AXON_REGIST 
    where to_char(REPORT_DATE,'yyyymmdd')=record_current_date.NAME;

commit;
    ----- FC REPARTITION
 ----- FC REPARTITION
    INSERT INTO report_user.IT_MIS_DAILY_FISRT_CALL_GLOBAL  
     SELECT TOWN,REGION,GOUVERNORATS,DEPARTMENT,COUNT(1) TOTAL_ACTIVATED,DAILY_CONSO ACTIVATION_DATE
     FROM 
   ( SELECT  CELLID,VILLE TOWN,COMMUNES REGION,GOUVERNORATS,REGION_NATURELLE DEPARTMENT
           FROM  report_user.IT_MIS_CELLID_FINAL_2013 
     )t1,( SELECT * FROM report_user.IT_MIS_DAILY_FIRST_CALL_REPORT WHERE MAJOR_CELL_ID NOT LIKE'%-%') t2
     WHERE t2.MAJOR_CELL_ID=t1.CELLID
     AND TO_CHAR(DAILY_CONSO,'yyyymmdd') = record_current_date.NAME
     GROUP BY TOWN,DAILY_CONSO,REGION,GOUVERNORATS,DEPARTMENT
    ORDER BY TOWN;
    
    COMMIT;
 
    INSERT INTO report_user.IT_MIS_DAILY_FISRT_CALL_GLOBAL  
     SELECT TOWN,REGION,GOUVERNORATS,DEPARTMENT,COUNT(1) TOTAL_ACTIVATED,DAILY_CONSO ACTIVATION_DATE
     FROM 
   ( SELECT CODE_COUNTRY_OPERATOR CELLID,ROAMING_PARTNER_NAME||'/'||VPMN_COUNTRY_NAME TOWN,ROAMING_PARTNER_NAME||'/'||VPMN_COUNTRY_NAME REGION,ROAMING_PARTNER_NAME||'/'||VPMN_COUNTRY_NAME GOUVERNORATS,ROAMING_PARTNER_NAME||'/'||VPMN_COUNTRY_NAME DEPARTMENT
           FROM  report_user.IT_ROAMING_PARTNER_IMSI 
     )t1,( SELECT SUBSCRIBER,REGEXP_SUBSTR (MAJOR_CELL_ID, '[^-]+')||SUBSTR((MAJOR_CELL_ID),-(length(MAJOR_CELL_ID)-(length(REGEXP_SUBSTR (MAJOR_CELL_ID, '[^-]+'))+1)),(length(MAJOR_CELL_ID)-(length(REGEXP_SUBSTR (MAJOR_CELL_ID, '[^-]+'))+1))) MAJOR_CELL_ID,DAILY_CONSO 
           FROM report_user.IT_MIS_DAILY_FIRST_CALL_REPORT  WHERE MAJOR_CELL_ID LIKE'%-%') t2
     WHERE  t2.MAJOR_CELL_ID=t1.CELLID
     AND TO_CHAR(DAILY_CONSO,'yyyymmdd') = record_current_date.NAME
     GROUP BY TOWN,DAILY_CONSO,REGION,GOUVERNORATS,DEPARTMENT
    ORDER BY TOWN;
    
    COMMIT;
    
    --- TOTAL WINBACK SCRIPT
        INSERT INTO report_user.IT_MIS_DAILY_WINBACK_GLOBAL  
        SELECT report_date  FC_DATE_RECO,COUNT(1) TOTAL_FC_RECO  
        FROM  report_user.IT_MIS_RGS90_CHURN_GROSSADD 
        WHERE TO_CHAR(report_date,'yyyymmdd') = record_current_date.NAME
        AND RGS_TYPE='RECO'  
        GROUP BY report_date;
           
        --- TOTAL FC SCRIPT
        INSERT INTO report_user.IT_MIS_DAILY_FC_GLOBAL  
        SELECT fc, COUNT(1) total_FC  FROM report_user.IT_MIS_DAILY_FIRST_CALL_TEMP
        WHERE TO_CHAR(fc,'yyyymmdd')  =  record_current_date.NAME
        GROUP BY fc;
        
        --- TOTAL DAILY GROSS ADD
        INSERT INTO report_user.IT_MIS_DAILY_GROSS_ADD  
        SELECT daily_conso, total_fc+total_fc_reco total_gross_add 
        FROM report_user.IT_MIS_DAILY_FC_GLOBAL,report_user.IT_MIS_DAILY_WINBACK_GLOBAL
        WHERE daily_conso=fc_date_reco
        AND TO_CHAR(daily_conso,'yyyymmdd') = record_current_date.NAME;
--     

    ---- FIRST CALL VS FISRT CALL LOCATED            
      INSERT INTO report_user.IT_MIS_DAILY_FC_REPARTITION 
      SELECT FC_DATE,total_gross_add-total_located fc_repartition
      FROM 
      ( SELECT a.DAILY_CONSO FC_DATE,COUNT(1) total_located
        FROM report_user.IT_MIS_DAILY_FIRST_CALL_REPORT a
        WHERE TO_CHAR(DAILY_CONSO,'yyyymmdd')  = record_current_date.NAME
        GROUP BY a.DAILY_CONSO )t1, 
        ( SELECT daily_conso,total_gross_add
        FROM report_user.IT_MIS_DAILY_GROSS_ADD 
         WHERE TO_CHAR(daily_conso,'yyyymmdd') = record_current_date.NAME )t2
        WHERE t2.DAILY_CONSO=t1.FC_DATE
        AND TO_CHAR(FC_DATE,'yyyymmdd')  = record_current_date.NAME
        ORDER BY FC_DATE ;
        
        COMMIT;


         --- REPARTITION CURSOR 
         INSERT INTO report_user.IT_MIS_DAILY_GROSS_ADD_ADJUST  
             SELECT activation_date,total_town,fc_repartition, ROUND(fc_repartition/total_town,0) repartition_number
             FROM 
             (SELECT activation_date, COUNT(1) total_town  FROM  report_user.IT_MIS_DAILY_FISRT_CALL_GLOBAL
              WHERE TO_CHAR(activation_date,'yyyymmdd') = record_current_date.NAME
              GROUP BY activation_date
              ORDER BY activation_date) t1,
              ( SELECT  * 
                FROM report_user.IT_MIS_DAILY_FC_REPARTITION
                WHERE TO_CHAR(fc_date,'yyyymmdd') = record_current_date.NAME
              ) t2
              WHERE t1.activation_date=t2.fc_date;
            COMMIT;
    
              -- HISTORY DATA SCRIPT 
             INSERT INTO report_user.IT_MIS_DAILY_FC_GLOBALH  
             SELECT * FROM  report_user.IT_MIS_DAILY_FISRT_CALL_GLOBAL
             WHERE TO_CHAR(activation_date,'yyyymmdd') = record_current_date.NAME;
             COMMIT;
                                   
    /*
        DIFFERENCE ENTRE GROSSADD GLOBALE ET GROSSADD LOCALISEE
        
        */
           select RGS90_GROSSADD  INTO gadgbl
           from REPORT_USER.IT_MK_RGS_TRACKING_REPORT
            where OPERATORS='Areeba'
             and TO_CHAR(periods ,'yyyymmdd')  = record_current_date.NAME;
              
            SELECT SUM(TOTAL_ACTIVATED) INTO gadloc
            FROM report_user.IT_MIS_DAILY_FISRT_CALL_GLOBAL a
            WHERE TO_CHAR(ACTIVATION_DATE,'yyyymmdd')  = record_current_date.NAME;
 
               insert into report_user.IT_MIS_DAILY_FISRT_CALL_GLOBAL      
        select 'UNKNOWN' ,'UNKNOWN' ,'UNKNOWN' ,'UNKNOWN' ,gadgbl-gadloc,record_current_date.NAME2 -- TO_DATE(record_current_date.NAME,'dd/mm/yyyy')  
        from dual;
        
        commit;
        

            /* SCRIPT FOR FIRST CALL REPARTITION */                

    INSERT INTO report_user.IT_MIS_DAILY_FC_REPART_REPT   
    SELECT DISTINCT *
    FROM report_user.IT_MIS_DAILY_FIRST_CALL_REPORT a
    WHERE to_char(a.DAILY_CONSO,'yyyymmdd')=record_current_date.NAME
    AND a.SUBSCRIBER IN(SELECT b.SUBSCRIBER
                        FROM report_user.IT_MIS_DAILY_FIRST_CALL_REPORT b 
                        WHERE to_char(b.DAILY_CONSO,'yyyymmdd')=record_current_date.NAME
                        
                        MINUS
                        
                        SELECT c.SUBSCRIBER 
                        FROM report_user.IT_MIS_DAILY_FC_WINBACK c
                        WHERE to_char(c.FC_DATE_RECO,'yyyymmdd')=record_current_date.NAME);
                        
   commit;

delete from REPORT_USER.IT_MIS_DAILY_FC_REPART_REPT 
where to_char(DAILY_CONSO,'yyyymmdd')=record_current_date.NAME
and MAJOR_CELL_ID not like'%-%'
and MAJOR_CELL_ID not in(select cellid from REPORT_USER.it_mis_cellid_final_2013);

 commit;
                              
execute immediate 'truncate table REPORT_USER.IT_MIS_UNLOCALIZED_FC';

insert into REPORT_USER.IT_MIS_UNLOCALIZED_FC
select STATUS_MSISDN,'224'||ACCOUNT_MSISDN,ACCOUNT_CLASS,FIRST_CALL_DATE,SERVICE_FEE_PERIOD,SERVICE_EXPIRY_DATE 
from REPORT_USER.IT_DR_IN_STATUS_SUBSCRIBERS
where to_char(FIRST_CALL_DATE,'yyyymmdd')=record_current_date.NAME
and '224'||ACCOUNT_MSISDN not in(select SUBSCRIBER from REPORT_USER.IT_MIS_DAILY_FC_REPART_REPT where to_char(DAILY_CONSO,'yyyymmdd')=record_current_date.NAME);

commit;
 
delete from REPORT_USER.IT_MIS_FC_CELLID_AXON_REGIST
where to_char(REPORT_DATE,'yyyymmdd')=record_current_date.NAME; -- =to_date('17/07/2018','dd/mm/yyyy');

commit;

INSERT INTO REPORT_USER.IT_MIS_FC_CELLID_AXON_REGIST 
select distinct '224'||a.AGENT_MSISDN AGENT_MSISDN,c.ACCOUNT_MSISDN ACCOUNT_MSISDN,a.SUBMISSION_CELLID CUSTOMER_SUBMISSION_CELLID,b.SUBMISSION_CELLID AGENT_SUBMISSION_CELLID, to_date(to_char(a.DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy') REPORT_DATE
from REPORT_USER.IT_MIS_AXON_REG_DTL a,REPORT_USER.IT_MIS_AXON_REG_AGT_CELLID b,REPORT_USER.IT_MIS_UNLOCALIZED_FC c
where a.AGENT_MSISDN=b.AGENT_MSISDN
and '224'||a.CUSTOMER_MSISDN=c.ACCOUNT_MSISDN
-- and to_char(a.DATETIME,'yyyymmdd')=record_current_date.NAME
and to_char(c.FIRST_CALL_DATE,'yyyymmdd')=record_current_date.NAME;

commit;
 

INSERT INTO report_user.IT_MIS_DAILY_FC_REPART_REPT   
    SELECT DISTINCT ACCOUNT_MSISDN,AGENT_SUBMISSION_CELLID,REPORT_DATE
    FROM report_user.IT_MIS_FC_CELLID_AXON_REGIST 
    where to_char(REPORT_DATE,'yyyymmdd')=record_current_date.NAME;
--    and length(CUSTOMER_SUBMISSION_CELLID)<4
--    and length(AGENT_SUBMISSION_CELLID)>=4;

commit;

 ----- FC REPARTITION
    -- INSERT INTO IT_MIS_DAILY_FISRT_CALL_GLOBAL  
 INSERT INTO report_user.IT_MIS_DAILY_FC_REPART_GLOBAL 
     SELECT TOWN,REGION,GOUVERNORATS,DEPARTMENT,COUNT(1) TOTAL_ACTIVATED,DAILY_CONSO ACTIVATION_DATE
     FROM 
   ( SELECT  CELLID,VILLE TOWN,COMMUNES REGION,GOUVERNORATS,REGION_NATURELLE DEPARTMENT
           FROM report_user.IT_MIS_CELLID_FINAL_2013 
     )t1,( SELECT * FROM report_user.IT_MIS_DAILY_FC_REPART_REPT WHERE MAJOR_CELL_ID NOT LIKE'%-%') t2
     WHERE t2.MAJOR_CELL_ID=t1.CELLID
     AND TO_CHAR(DAILY_CONSO,'yyyymmdd') =record_current_date.NAME 
     GROUP BY TOWN,DAILY_CONSO,REGION,GOUVERNORATS,DEPARTMENT
    ORDER BY TOWN;
    
    COMMIT;
    
 
    INSERT INTO report_user.IT_MIS_DAILY_FISRT_CALL_GLOBAL  
     SELECT TOWN,REGION,GOUVERNORATS,DEPARTMENT,COUNT(1) TOTAL_ACTIVATED,DAILY_CONSO ACTIVATION_DATE
     FROM 
   ( SELECT CODE_COUNTRY_OPERATOR CELLID,ROAMING_PARTNER_NAME||'/'||VPMN_COUNTRY_NAME TOWN,ROAMING_PARTNER_NAME||'/'||VPMN_COUNTRY_NAME REGION,ROAMING_PARTNER_NAME||'/'||VPMN_COUNTRY_NAME GOUVERNORATS,ROAMING_PARTNER_NAME||'/'||VPMN_COUNTRY_NAME DEPARTMENT
           FROM  report_user.IT_ROAMING_PARTNER_IMSI 
     )t1,( SELECT SUBSCRIBER,REGEXP_SUBSTR (MAJOR_CELL_ID, '[^-]+')||SUBSTR((MAJOR_CELL_ID),-(length(MAJOR_CELL_ID)-(length(REGEXP_SUBSTR (MAJOR_CELL_ID, '[^-]+'))+1)),(length(MAJOR_CELL_ID)-(length(REGEXP_SUBSTR (MAJOR_CELL_ID, '[^-]+'))+1))) MAJOR_CELL_ID,DAILY_CONSO 
           FROM report_user.IT_MIS_DAILY_FC_REPART_REPT WHERE MAJOR_CELL_ID LIKE'%-%') t2
     WHERE  t2.MAJOR_CELL_ID=t1.CELLID
     AND TO_CHAR(DAILY_CONSO,'yyyymmdd') = record_current_date.NAME
     GROUP BY TOWN,DAILY_CONSO,REGION,GOUVERNORATS,DEPARTMENT
    ORDER BY TOWN;
    
    COMMIT;
    
     execute immediate 'TRUNCATE TABLE REPORT_USER.IT_MIS_UNLOCALIZED_FC2';

            INSERT INTO REPORT_USER.IT_MIS_UNLOCALIZED_FC2 
            select STATUS_MSISDN,'224'||ACCOUNT_MSISDN ACCOUNT_MSISDN,ACCOUNT_CLASS,FIRST_CALL_DATE,SERVICE_FEE_PERIOD,SERVICE_EXPIRY_DATE 
            from REPORT_USER.IT_DR_IN_STATUS_SUBSCRIBERS
            where to_char(FIRST_CALL_DATE,'yyyymmdd')= record_current_date.NAME
            and '224'||ACCOUNT_MSISDN not in(select SUBSCRIBER 
                                             from REPORT_USER.IT_MIS_DAILY_FC_REPART_REPT 
                                             where to_char(DAILY_CONSO,'yyyymmdd')= record_current_date.NAME);

            commit;

            INSERT INTO report_user.IT_MIS_DAILY_FC_REPART_GLOBAL 
            select 'Customer Relation' TOWN,'Customer Relation' REGION,'Customer Relation' GOUVERNORATS,'Customer Relation' DEPARTMENT,count(distinct MSISDN) TOTAL_ACTIVATED,record_current_date.NAME2 ACTIVATION_DATE
            from REPORT_USER.IT_MIS_DR_TT_SUBSCRIBERS_DUMP 
            where '224'||MSISDN in(select ACCOUNT_MSISDN from REPORT_USER.IT_MIS_UNLOCALIZED_FC2)
            and ACTIVATED_USER_NAME<>'axontt';
                
                COMMIT;
                
          --- TOTAL DAILY FIRST CALLS  
        
          INSERT INTO report_user.IT_MIS_DAILY_FC_REPARTITION2 
         SELECT FC_DATE,total_fc-total_located fc_repartition
              FROM 
              ( SELECT a.DAILY_CONSO FC_DATE,COUNT(1) total_located
                FROM report_user.IT_MIS_DAILY_FC_REPART_REPT a
                WHERE TO_CHAR(DAILY_CONSO,'yyyymmdd')  = record_current_date.NAME
                GROUP BY a.DAILY_CONSO )t1, 
                ( SELECT daily_conso,total_fc
                FROM report_user.IT_MIS_DAILY_FC_GLOBAL 
                 WHERE TO_CHAR(daily_conso,'yyyymmdd') = record_current_date.NAME )t2
                WHERE t2.DAILY_CONSO=t1.FC_DATE
                AND TO_CHAR(FC_DATE,'yyyymmdd')= record_current_date.NAME 
                ORDER BY FC_DATE ;
                
                COMMIT;
                
                
        --- REPARTITION CURSOR 
         INSERT INTO report_user.IT_MIS_DAILY_FIRST_CALL_ADJUST 
             SELECT activation_date,total_town,fc_repartition, ROUND(fc_repartition/total_town,0) repartition_number
             FROM 
             (SELECT activation_date, COUNT(1) total_town  FROM report_user.IT_MIS_DAILY_FC_REPART_GLOBAL 
              WHERE TO_CHAR(activation_date,'yyyymmdd') = record_current_date.NAME
              GROUP BY activation_date
              ORDER BY activation_date) t1,
              ( SELECT  * 
                FROM report_user.IT_MIS_DAILY_FC_REPARTITION2
                WHERE TO_CHAR(fc_date,'yyyymmdd') = record_current_date.NAME
              ) t2
              WHERE t1.activation_date=t2.fc_date;
            COMMIT;
            
                         -- HISTORY DATA SCRIPT 
             INSERT INTO report_user.IT_MIS_DAILY_FC_REPART_GLOBALH 
             SELECT * FROM report_user.IT_MIS_DAILY_FC_REPART_GLOBAL   
             WHERE TO_CHAR(activation_date,'yyyymmdd') = record_current_date.NAME;
             COMMIT;
              
    /*
        DIFFERENCE ENTRE FC_REPARTITION GLOBAL ET FC_REPARTITION LOCALISE
        
        */
              select TOTAL_FIRST_CALL into fcrgbl
            from REPORT_USER.IT_MK_DASHBOARD_REPORT_IN
            where to_char(REPORT_DATE,'yyyymmdd')=record_current_date.NAME;        

            
            select sum(TOTAL_ACTIVATED) into fcrloc
            from report_user.IT_MIS_DAILY_FC_REPART_GLOBAL 
            where to_char(ACTIVATION_DATE,'yyyymmdd')= record_current_date.NAME;
               

            insert into report_user.IT_MIS_DAILY_FC_REPART_GLOBAL      
            select 'UNKNOWN' ,'UNKNOWN' ,'UNKNOWN' ,'UNKNOWN' ,fcrgbl-fcrloc,record_current_date.NAME2 -- TO_DATE(record_current_date.NAME,'dd/mm/yyyy')  
            from dual;
        
            commit;

  /*          ----Load data into old MCKINSEY DB FOR FACTS 
            INSERT INTO IT_MK_DAILY_FC_REPART_GLOBAL@MKDBLINK
            SELECT * FROM report_user.IT_MIS_DAILY_FC_REPART_GLOBAL
            WHERE  to_char(activation_date,'yyyymmdd')= record_current_date.NAME;
            
            COMMIT;  
 */
 /* END SCRIPT FOR FIRST CALL REPARTITION */
 
 /*  SCRIP INITIAL BALANCE REPORT */
 --- load fc initial balance 
INSERT INTO REPORT_USER.IT_MIS_DAILY_FC_INITIALBALANCE
SELECT subscriber,service_class, initial_balance,major_cell_id,daily_conso
FROM ( SELECT * FROM REPORT_USER.IT_MIS_DAILY_FIRST_CALL_REPORT
WHERE TO_CHAR(daily_conso,'yyyymmdd') = record_current_date.NAME  )t1,
( SELECT * FROM REPORT_USER.IT_MIS_FC_INITIAL_BALANCE 
WHERE TO_CHAR(activation_date,'yyyymmdd')=record_current_date.NAME )t2
WHERE trim(t2.msisdn)=t1.subscriber;

COMMIT;

-- ---- Load into OLD MCKINSEY
-- 
-- INSERT INTO IT_MK_DAILY_FIRST_CALL_BALANC2@MKDBLINK
-- SELECT a.subscriber,a.service_class,DECODE(a.initial_balance,'','0',a.initial_balance) initial_balance,a.major_cell_id,a.DAILY_CONSO 
-- FROM IT_MIS_DAILY_FC_INITIALBALANCE a
-- WHERE  TO_CHAR(daily_conso,'yyyymmdd') = record_current_date.NAME;
--  
--  COMMIT;
INSERT INTO REPORT_USER.IT_MK_DAILY_FIRST_CALL_BALANC2
SELECT subscriber,service_class,DECODE(initial_balance,'','0',initial_balance) initial_balance,major_cell_id,DAILY_CONSO 
FROM REPORT_USER.IT_MIS_DAILY_FC_INITIALBALANCE
WHERE  TO_CHAR(daily_conso,'yyyymmdd') = record_current_date.NAME
AND initial_balance IS NOT NULL ;
COMMIT;

/*  END SCRIP INITIAL BALANCE REPORT */

END LOOP;  
   CLOSE CURRENT_DATE;
   END;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN NULL;
END;
/
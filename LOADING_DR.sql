--CREATE OR REPLACE procedure REPORT_USER.IT_MIS_DR_LOADING_PROC is
begin 

declare

TABLE_NAME varchar2(50);
filename varchar2(50);
filename2 varchar2(50);
adjustment number;

cursor cursor_table is 

SELECT   name,substr(name,1,2) day_name,to_char(to_date(name,'dd/mm/yyyy'),'yyyymmdd') day_name2
FROM REPORT_USER.IT_DAY_TO_DAY
where to_date(name,'dd/mm/yyyy') between to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy') and  to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
order by substr(name,1,2) ;
   


record_cursor_table    cursor_table%rowtype;

begin 
  
  open cursor_table;
       
     loop
         fetch cursor_table into record_cursor_table;
            exit when cursor_table%notfound; 
   
              
              REPORT_USER.IT_MIS_DR_CLEARENCE_PROC;      
 
             -- READ MC KINSEY DR FILES
              SELECT 'DR_CORPORATE_REFILL'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_CORPORATE_REFILL '||' location('''||filename2||''')'; 
              
              SELECT 'DR_CUG_REFILL'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_CUG_REFILL'||' location('''||filename2||''')'; 
              
              SELECT 'DR_DAILY_PACK_REFILL'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_DAILY_REFILL_REFILL '||' location('''||filename2||''')'; 
              
              SELECT 'DR_EZETOP_ACCOUNT_REFILL'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_EZETOPACCOUNT_REFILL'||' location('''||filename2||''')'; 
              
              SELECT 'DR_EZETOP_REFILL'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_EZETOP_REFILL '||' location('''||filename2||''')'; 
              
              SELECT 'DR_R2S_REFILL_NEW'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_ERS_REFILL'||' location('''||filename2||''')'; 
              
              SELECT 'DR_SDP_BONUS'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_SDP_BONUS '||' location('''||filename2||''')'; 
      
              SELECT 'DR_SOCHITEL_ACCOUNT_REFILL'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_SOCHITELACC_REFILL '||' location('''||filename2||''')'; 
              
              SELECT 'DR_SOCHITEL_REFILL'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_SOCHITEL_REFILL '||' location('''||filename2||''')'; 
              
              SELECT 'DR_P2P_REFILL_NEW'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_P2P_REFILL '||' location('''||filename2||''')'; 
              
              SELECT 'DR_BizFlex'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_BizFlex_REFILL '||' location('''||filename2||''')'; 
            
              SELECT 'DR_HVC_BUNDLE_REFILL'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_HVC_BUNDLE_REFILL '||' location('''||filename2||''')'; 
              
                            
              SELECT 'DR_VOICE_BUNDLE_REFILL'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_VOICE_BUNDLE_REFILL '||' location('''||filename2||''')'; 
              
                                         
                            
              SELECT 'DR_NEON_REFILL'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_NEON_REFILL '||' location('''||filename2||''')'; 
              
                            
              SELECT 'DR_LCMS_REFILL'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_LCMS_REFILL '||' location('''||filename2||''')'; 
              
                     
              SELECT 'DR_EASTERREFILL'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_EASTERREFILL '||' location('''||filename2||''')'; 
        
              SELECT 'DR_WINBACKFEFILL'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_WINBACK_REFILL '||' location('''||filename2||''')'; 
              
              SELECT 'DR_THREEINONE'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_THREEINONE_REFILL '||' location('''||filename2||''')'; 
              
              SELECT 'DR_COMBOWEEKLY'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_COMBOWEEK_REFILL '||' location('''||filename2||''')';               
              
              SELECT 'DR_COMBODAILY'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_COMBODAILY_REFILL '||' location('''||filename2||''')'; 
              
              SELECT 'DR_MICROBUNDLINGREFILL'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_DR_INPUT_GTM_MICROBUNDLING '||' location('''||filename2||''')'; 
              
              SELECT 'DR_DATA_NVP'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_DATA_NVP_REFILL '||' location('''||filename2||''')'; 
              
              SELECT 'DR_BONJOUR_GUINEE'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_BJR_GN_REFILL '||' location('''||filename2||''')'; 
              
              
              --- DEDUCTION TABLES 
              
              SELECT 'DR_DAILY_PACK_DEDUCTION'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_DAILY_PACK_DEDUCTION'||' location('''||filename2||''')'; 
              
              SELECT 'DR_EZETOP_DEDUCTION'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_EZETOP_DEDUCTION '||' location('''||filename2||''')'; 
              
              SELECT 'DR_FAF_DEDUCTION'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_FAF_DEDUCTION '||' location('''||filename2||''')'; 

              SELECT 'DR_MODE_DEDUCTION'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_MODE_DEDUCTION '||' location('''||filename2||''')'; 
              
              SELECT 'DR_SIM_CHANGE_DEDUCTION'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_SIM_CHANGE_DEDUCTION '||' location('''||filename2||''')'; 
         
              SELECT 'DR_SOCHITEL_DEDUCTION'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_SOCHITEL_DEDUCTION '||' location('''||filename2||''')'; 
              
              SELECT 'DR_TMP_AREEBA_PRO_ADJUST'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_TPM_AREEBA_PRO '||' location('''||filename2||''')';   
            
              SELECT 'DR_MOBILEMONEY_REFILL'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_MOBILEMONEY_REFILL '||' location('''||filename2||''')'; 
      
              SELECT 'DR_TPM_DEDUCTION'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_TPM_DEDUCTION '||' location('''||filename2||''')'; 
        
              SELECT 'DR_P2P_DEDUCTION'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_P2P_DEDUCTION '||' location('''||filename2||''')';
                    
              SELECT 'DR_HVC_BUNDLE_DEDUCTION'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_HVC_BUNDLE_DEDUCTION'||' location('''||filename2||''')';               
                                        
              SELECT 'DR_VOICE_OFF_PEAK_DEDUCTION'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_VOICE_OFFPEAK_DEDUCT '||' location('''||filename2||''')'; 
                       
              SELECT 'DR_EASTERDEDUCTION'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_EASTERDEDUCTION '||' location('''||filename2||''')'; 
                       
              SELECT 'DR_WINBACKDEDUCTION'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_WINBACK_DEDUCTION '||' location('''||filename2||''')'; 
                       
              SELECT 'DR_THREEINONEDEDUCTION'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_THREEINONE_DEDUCTION '||' location('''||filename2||''')';  
                       
              SELECT 'DR_BEPC'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_BEPC_DEDUCTION '||' location('''||filename2||''')'; 
               
              SELECT 'DR_COMBOWEEKLY'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_COMBOWEEK_DEDUCTION '||' location('''||filename2||''')'; 
               
              SELECT 'DR_COMBODAILY'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_COMBODAILY_DEDUCTION '||' location('''||filename2||''')'; 
              
                             
              SELECT 'DR_CONCERT_DEDUCTION'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_CONCERTMHD_DEDUCTION '||' location('''||filename2||''')';
              
              SELECT 'DR_MICROBUNDLINGDEDUCTION'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_DR_OUTPUT_GTM_MICROBUNDLING '||' location('''||filename2||''')'; 
              
              SELECT 'DR_DATA_NVP_DEDUCTION'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_DATA_NVP_DEDUCTION '||' location('''||filename2||''')'; 
              
              SELECT 'DR_DAILY_BUNDLE_DEDUCTION'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_DAILY_BUNDLE_DEDUC '||' location('''||filename2||''')'; 
               
              SELECT 'DR_INTER_BUNDLE_DEDUCTION'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_INTER_BUNDLE_DEDUC '||' location('''||filename2||''')'; 
                       
              SELECT 'DR_KINGDEDUCTION'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_KING_DEDUCTION '||' location('''||filename2||''')'; 
               
             
            ---- DELETE  CURRENT MONTH DATA
          DELETE FROM REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL
          WHERE REPORT_DATE BETWEEN TRUNC(sysdate-1,'month') AND TO_DATE(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');
          --and TRANSACTION_DESCRIPTION not in ('SMS_BUNDLE__DEDUCTION','SMS_BUNDLE_REFILL');
          COMMIT;
           
           
            ---CORPORATE REFILL 
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL  
            SELECT  TRANSACTION_TYPE,
                    'CORPORATE_REFILL' TRANSACTION_DESCRIPTION,
                    SUM(AMOUNT) TOTAL_AMOUNT,
                    TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_CORPORATE_REFILL 
            --WHERE TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY') BETWEEN TO_DATE('6/1/2013','MM/DD/YYYY')  AND TO_DATE('6/30/2013','MM/DD/YYYY')
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') 
            ORDER BY TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')   DESC ;
            COMMIT;

            --- CUG REFILL 
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            SELECT  TRANSACTION_TYPE,
                    'CUG_REFILL',
                    SUM(replace(AMOUNT,',','.')) TOTAL_AMOUNT,
                    TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_CUG_REFILL 
            where TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') is not null
            --WHERE TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY') BETWEEN TO_DATE('6/1/2013','MM/DD/YYYY')  AND TO_DATE('6/30/2013','MM/DD/YYYY')
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')
            ORDER BY TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  DESC ;
            COMMIT;


            --EZETOP_REFILL
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
          SELECT  TRANSACTION_TYPE,
                    'EZETOP_REFILL',
                    ABS(SUM(replace(AMOUNT,',','.'))) TOTAL_AMOUNT,
                    TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_EZETOP_REFILL 
            WHERE ABS(replace(SUBSTR(AMOUNT,1,LENGTH(AMOUNT)-1),',','.')) IS NOT NULL
            AND LENGTH(SERVED_MSISDN)='12'
            AND replace(SUBSTR(AMOUNT,1,LENGTH(AMOUNT)-1),',','.')> 0 
            AND CASH_ACCOUNT_ID='0'
            --WHERE TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY') BETWEEN TO_DATE('6/1/2013','MM/DD/YYYY')  AND TO_DATE('6/30/2013','MM/DD/YYYY')
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')
            ORDER BY TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  DESC ;
            COMMIT;
            
                
             --- EZETOP ACCOUNT REFILL
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL
            SELECT  TRANSACTION_TYPE,
                    'EZETOP_ACCOUNT_REFILL',
                    SUM(AMOUNT) TOTAL_AMOUNT,
                    TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_EZETOPACCOUNT_REFILL
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  
            ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
            COMMIT;
            
                        
            ---SOCHITEL ACCOUNT REFILL  
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL
            SELECT  TRANSACTION_TYPE,
                    'SOCHITEL_ACCOUNT_REFILL',
                    SUM(AMOUNT) TOTAL_AMOUNT,
                    TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_SOCHITELACC_REFILL 
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  
            ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
            COMMIT;

            --- SOCHITEL_REFILL
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            SELECT  TRANSACTION_TYPE,
                    'SOCHITEL_REFILL',
                    ABS(SUM(AMOUNT)) TOTAL_AMOUNT,
                    TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_SOCHITEL_REFILL 
            WHERE SUBSTR(AMOUNT,1,LENGTH(AMOUNT)-1)>0
          --  WHERE TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY') BETWEEN TO_DATE('6/1/2013','MM/DD/YYYY')  AND TO_DATE('6/30/2013','MM/DD/YYYY')
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')
            ORDER BY TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  DESC ;
            COMMIT;

        --MOBILEMONEY_REFILL
       INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
        SELECT  TRANSACTION_TYPE,
                    'MOBILEMONEY_REFILL',
                    ABS(SUM(replace(AMOUNT,',','.'))) TOTAL_AMOUNT,
                    TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_MOBILEMONEY_REFILL
            WHERE ABS(replace(SUBSTR(AMOUNT,1,LENGTH(AMOUNT)-1),',','.')) IS NOT NULL
            AND LENGTH(SERVED_MSISDN)='12'
            AND CASH_ACCOUNT_ID IN (0)
      --      AND replace(SUBSTR(AMOUNT,1,LENGTH(AMOUNT)-1),',','.')> 0 
            --WHERE TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY') BETWEEN TO_DATE('6/1/2013','MM/DD/YYYY')  AND TO_DATE('6/30/2013','MM/DD/YYYY')
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')
            ORDER BY TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  DESC ;
            COMMIT;
            

            ---SDP BONUS 
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            SELECT  TRANSACTION_TYPE,
                    'SDP_BONUS',
                    SUM(REPLACE(BALANCE_AFTER_EVENT,',','.') - replace(BALANCE_BEFORE_EVENT,',','.')) TOTAL_AMOUNT,
                    TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_SDP_BONUS
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') ;
            COMMIT;

             INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL
            SELECT 'INPUT' TRANSACTION_TYPE,
                    'USED VOUCHERS LOADED',
                    SUM(TOTAL_AMOUNT),
                    TO_DATE(SUBSTR(STAT_DATE,1,8),'YYYY/MM/DD') REPORT_DATE
            FROM REPORT_USER.IT_MK_VOUCHER_REFILL_AMOUNT
            WHERE TO_DATE(SUBSTR(STAT_DATE,1,8),'YYYY/MM/DD') BETWEEN TRUNC(sysdate-1,'month') AND TO_DATE(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
            GROUP BY TO_DATE(SUBSTR(STAT_DATE,1,8),'YYYY/MM/DD')
            ORDER BY TO_DATE(SUBSTR(STAT_DATE,1,8),'YYYY/MM/DD')DESC;
            COMMIT;

            --- TOTAL INITIAL BALANCE 
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL
            SELECT  'INPUT' TRANSACTION_TYPE,
                    'FC AMOUNT', 
                     TOTAL_INITIAL_BALANCE,
                     REPORT_DATE
            FROM REPORT_USER.IT_MK_DASHBOARD_REPORT_IN 
            WHERE REPORT_DATE  BETWEEN trunc(sysdate-1,'month') AND to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
            ORDER BY REPORT_DATE DESC;
            COMMIT;

            ---DAILY PACK REFILL 
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            SELECT  TRANSACTION_TYPE,
                    'DAILY_PACK_REFILL',
                    SUM(AMOUNT) TOTAL_AMOUNT,
                    TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_DAILY_REFILL_REFILL 
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  
            ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
            COMMIT;


             INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL
   
            select 'INPUT' TRANSACTION_TYPE, 'SMS_BUNDLE_REFILL' TRANSACTION_DESCRIPTION, sum (a.IB_GPRS_ACCESS_COST) TOTAL_AMOUNT, TO_DATE(TO_CHAR(a.IB_SMS_DATE, 'yyyy-mm-dd'),'yyyy-mm-dd') REPORT_DATE 
            from ib_smss_all@DBLINKUSSD a
            where TO_DATE(TO_CHAR(a.IB_SMS_DATE, 'yyyy-mm-dd'),'yyyy-mm-dd') BETWEEN  trunc(sysdate-1,'month')  and to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
            and a.IB_FLAG='4'
            and A.IB_REQUEST in (upper('S1'),upper('S2'),upper('S3'),upper('S4'),upper('S5'))
            --and (a.IB_REQUEST like 'A%' or A.IB_REQUEST like 'V%' or A.IB_REQUEST like 'I%' or A.IB_REQUEST like 'K%' or A.IB_REQUEST like 'F%')
            Group by TO_DATE(TO_CHAR(a.IB_SMS_DATE, 'yyyy-mm-dd'),'yyyy-mm-dd')
            
            union all
            
            select 'INPUT' TRANSACTION_TYPE,'SMS_BUNDLE_REFILL' TRANSACTION_DESCRIPTION,sum(SMS_REFILL) TOTAL_AMOUNT,TO_DATE(TO_CHAR(PROVISION_DATE, 'yyyy-mm-dd'),'yyyy-mm-dd')
            from sms_bundles_transaction@mis2app
            where TO_DATE(TO_CHAR(PROVISION_DATE, 'yyyy-mm-dd'),'yyyy-mm-dd') BETWEEN  trunc(sysdate-1,'month')  and to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
            and RESPONSE='SUCCESS'
            group by TO_DATE(TO_CHAR(PROVISION_DATE, 'yyyy-mm-dd'),'yyyy-mm-dd');
            
             commit;

               ---R2S REFILL
               INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
                SELECT  TRANSACTION_TYPE,
                'R2S_REFILL',
                SUM(replace(TRANSACTION_AMOUNT,',','.')) TOTAL_AMOUNT,
                TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
                FROM REPORT_USER.IT_MIS_DR_ERS_REFILL 
                GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  
                ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
                COMMIT; 
                
              ---P2P REFILL
              
               INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL
                SELECT  'INPUT',
                'P2P_REFILL',
                SUM(replace (TRANSACTION_AMOUNT,',','.')) TOTAL_AMOUNT,
                TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
                FROM REPORT_USER.IT_MIS_DR_P2P_REFILL  
                GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  
                ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
                COMMIT; 
                
                
             

        INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL
        SELECT  TRANSACTION_TYPE,'BIZFLEX_REFILL',
                    SUM(AMOUNT) TOTAL_AMOUNT,
                    TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_BizFlex_REFILL
           --where AMOUNT >0
           GROUP BY TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY'), TRANSACTION_TYPE
            ORDER BY TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY')  DESC  ;
              COMMIT;
              

               INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL
               SELECT  'INPUT','HVC_BUNDLE_REFILL',
                    SUM(AMOUNT) TOTAL_AMOUNT,
                    TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_HVC_BUNDLE_REFILL
           where AMOUNT >0
           GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY')
            ORDER BY TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY')  DESC  ;
            COMMIT;              
              
          INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL       
          SELECT  TRANSACTION_TYPE,
         'NEON_REFILL',         
         SUM(replace(amount,',','.')) amount ,
         TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY')
            FROM REPORT_USER.IT_MIS_DR_NEON_REFILL
            where amount is not null
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY')
            ORDER BY TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY')  DESC ;             
            commit;
                           
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            SELECT  TRANSACTION_TYPE,
            'LCMS_REFILL',
            ABS(SUM(replace(TRANSACTION_AMOUNT,',','.'))) TOTAL_AMOUNT,
            TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_LCMS_REFILL
            where replace(TRANSACTION_AMOUNT,',','.')>0
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  
            ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
            COMMIT; 
            
          INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL       
          SELECT  TRANSACTION_TYPE,
         'VOICE_BUNDLE_REFILL',         
         SUM( case when SUBSTR(CASH_ACCOUNT_ID,1,LENGTH(CASH_ACCOUNT_ID)-1) in ('11','12') then amount*600  end )+
         SUM( case  when SUBSTR(CASH_ACCOUNT_ID,1,LENGTH(CASH_ACCOUNT_ID)-1) in ('13','3') then amount end ) amount ,
         TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY')
            FROM REPORT_USER.IT_MIS_DR_VOICE_BUNDLE_REFILL
            where SUBSTR(CASH_ACCOUNT_ID,1,LENGTH(CASH_ACCOUNT_ID)-1)<>0
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY')
            ORDER BY TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY')  DESC ;             
            commit;
            
                           
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            SELECT  TRANSACTION_TYPE,
            'WINBACK_REFILL',
            ABS(SUM(replace(TRANSACTION_AMOUNT,',','.'))) TOTAL_AMOUNT,
            TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_WINBACK_REFILL
            where replace(TRANSACTION_AMOUNT,',','.')>0
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  
            ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
            COMMIT; 
            
            
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL             
            SELECT  TRANSACTION_TYPE,
            'THREEINONE_REFILL',
            ABS(SUM(replace(TRANSACTION_AMOUNT,',','.'))) TOTAL_AMOUNT,
            TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_THREEINONE_REFILL
            where replace(TRANSACTION_AMOUNT,',','.')>0
          --  and DEDICATED_ACCOUNT_ID in ('13','40','39')
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  ;
            --ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
 
            COMMIT; 
            
            
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL             
            SELECT  TRANSACTION_TYPE,
            'COMBOWEEK_REFILL',
            ABS(SUM(replace(TRANSACTION_AMOUNT,',','.'))) TOTAL_AMOUNT,
            TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_COMBOWEEK_REFILL
            where replace(TRANSACTION_AMOUNT,',','.')>0
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  

            union all

            SELECT 'INPUT',
            'COMBOWEEK_REFILL',
            ABS(SUM(replace(TRANSACTION_AMOUNT,',','.'))) TOTAL_AMOUNT,
            TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_COMBOWEEK_DEDUCTION
            where replace(TRANSACTION_AMOUNT,',','.')>0
            and TRANSACTION_AMOUNT is not null
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY');
                        
            COMMIT; 
             
            
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL             
            SELECT  TRANSACTION_TYPE,
            'COMBODAILY_REFILL',
            ABS(SUM(replace(TRANSACTION_AMOUNT,',','.'))) TOTAL_AMOUNT,
            TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_COMBODAILY_REFILL
            where replace(TRANSACTION_AMOUNT,',','.')>0
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  

            union all

            SELECT 'INPUT',
            'COMBODAILY_REFILL',
            ABS(SUM(replace(TRANSACTION_AMOUNT,',','.'))) TOTAL_AMOUNT,
            TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_COMBODAILY_DEDUCTION
            where replace(TRANSACTION_AMOUNT,',','.')>0
            and TRANSACTION_AMOUNT is not null
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY');
                        
            COMMIT; 
             

              INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL             
            SELECT  TRANSACTION_TYPE,
            'GTM_MICROBUNDLING_REFILL',
            ABS(SUM(replace(TRANSACTION_AMOUNT,',','.'))) TOTAL_AMOUNT,
            TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_DR_INPUT_GTM_MICROBUNDLING
            where replace(TRANSACTION_AMOUNT,',','.')>0
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  ;

                        
            COMMIT; 
            
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL             
            SELECT  TRANSACTION_TYPE,
            'DATA_NVP_REFILL',
            ABS(SUM(replace(TRANSACTION_AMOUNT,',','.'))) TOTAL_AMOUNT,
            TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_DATA_NVP_REFILL
            where replace(TRANSACTION_AMOUNT,',','.')>0
          --  and DEDICATED_ACCOUNT_ID in ('13','40','39')
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  ;
            --ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
    
            COMMIT; 

            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            
            SELECT  TRANSACTION_TYPE,
            'BONJOUR_REFILL',
            ABS(SUM(replace(TRANSACTION_AMOUNT,',','.'))) TOTAL_AMOUNT,
            TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_BJR_GN_REFILL
            where replace(TRANSACTION_AMOUNT,',','.')>0
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  
            ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
            
            COMMIT; 
            
            -- OUTPUT ------ 

            /*INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            --- CLEARANCE
            SELECT TRANSACTION_TYPE,
                   'CLEARANCE',
                   SUM(replace(MA_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA1_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA2_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace

            (DA3_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA4_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA5_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA6_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace

            (DA7_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA8_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA9_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA10_CREDREPORT_USER.IT_CLEARED,'.','.'))+
                   SUM(replace(DA11_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA12_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA13_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace

            (DA14_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA15_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA16_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA17_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM

            (replace(DA18_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA19_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA20_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA25_CREDREPORT_USER.IT_CLEARED,'.','.'))+
            SUM(replace(DA26_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA27_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA29_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA30_CREDREPORT_USER.IT_CLEARED,'.','.'))+
            SUM(replace(DA31_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA32_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA33_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA34_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA35_CREDREPORT_USER.IT_CLEARED,'.','.'))+
            SUM(replace(DA36_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA37_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA38_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA39_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA40_CREDREPORT_USER.IT_CLEARED,'.','.'))+
            SUM(replace(DA41_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA42_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA43_CREDREPORT_USER.IT_CLEARED,'.','.'))+
            SUM(replace(DA44_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA45_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA46_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA47_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA48_CREDREPORT_USER.IT_CLEARED,'.','.'))+
            SUM(replace(DA49_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA50_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA51_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA52_CREDREPORT_USER.IT_CLEARED,'.','.'))+
            SUM(replace(DA53_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA54_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA55_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA56_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA57_CREDREPORT_USER.IT_CLEARED,'.','.'))+
            SUM(replace(DA58_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA59_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA60_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA61_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA62_CREDREPORT_USER.IT_CLEARED,'.','.'))
            +SUM(replace(DA63_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA64_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA65_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA66_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA67_CREDREPORT_USER.IT_CLEARED,'.','.'))
            +SUM(replace(DA68_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA69_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA70_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA71_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA72_CREDREPORT_USER.IT_CLEARED,'.','.'))
            +SUM(replace(DA73_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA74_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA75_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA76_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA77_CREDREPORT_USER.IT_CLEARED,'.','.'))
            +SUM(replace(DA78_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA79_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA101_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA102_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA105_CREDREPORT_USER.IT_CLEARED,'.','.'))
            +SUM(replace(DA106_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA151_CREDREPORT_USER.IT_CLEARED,'.','.'))+SUM(replace(DA152_CREDREPORT_USER.IT_CLEARED,'.','.')) TOTAL_CLEARANCE,
                   TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_CLEARANCE
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY')
            ORDER BY TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY')  DESC;*/
            
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL
            --- CLEARANCE
            SELECT  'OUTPUT',
            'CLEARANCE',
                   SUM(replace(TOTAL_AMOUNT,',','.')) Amount,
                   TO_DATE(SUBSTR(REPORT_DATE,1,10),'DD/MM/YY') Report_date
                   from REPORT_USER.IT_MIS_DR_CLEARANCENW1
                   where ACCOUNT_ID not in (81,101,80,82,102)
                   and STAT_REPORT between  trunc(sysdate-1,'month')  and to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
                   GROUP BY TO_DATE(SUBSTR(REPORT_DATE,1,10),'DD/MM/YY')
            ORDER BY TO_DATE(SUBSTR(REPORT_DATE,1,10),'DD/MM/YY')  DESC;
           
            COMMIT;
            
            

                   


            ---- SIM CHANGE DEDUCTION 
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            SELECT  TRANSACTION_TYPE,
                    'SIM_CHANGE_DEDUCTION',
                    ABS(SUM(AMOUNT)) TOTAL_AMOUNT,
                    TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_SIM_CHANGE_DEDUCTION
            --WHERE TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') BETWEEN TO_DATE('6/1/2013','MM/DD/YYYY')  AND TO_DATE('6/30/2013','MM/DD/YYYY')
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')
            ORDER BY TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  DESC;
            COMMIT;
             
            -- EZETOP DEDUCTION 
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            SELECT  TRANSACTION_TYPE,
                    'EZETOP_DEDUCTION',
                    ABS(SUM(replace(AMOUNT,',','.'))) TOTAL_AMOUNT,
                    TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_EZETOP_DEDUCTION
            WHERE   LENGTH(SERVED_MSISDN)='12'
            AND replace(SUBSTR(AMOUNT,1,LENGTH(AMOUNT)-1),',','.')< 0 
            AND CASH_ACCOUNT_ID='0'
            --WHERE TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') BETWEEN TO_DATE('6/1/2013','MM/DD/YYYY')  AND TO_DATE('6/30/2013','MM/DD/YYYY')
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')
            ORDER BY TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  DESC ;
            COMMIT;

            --- SOCHITEL DEDUCTION 
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            SELECT  TRANSACTION_TYPE,
                    'SOCHITEL_DEDUCTION',
                    ABS(SUM(AMOUNT)) TOTAL_AMOUNT,
                    TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_SOCHITEL_DEDUCTION
            --WHERE TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') BETWEEN TO_DATE('6/1/2013','MM/DD/YYYY')  AND TO_DATE('6/30/2013','MM/DD/YYYY')
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')
            ORDER BY TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  DESC ;
            COMMIT;


            --- FAF DEDUCTION
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            SELECT  TRANSACTION_TYPE,
                    'FAF_DEDUCTION',
                    ABS(SUM(AMOUNT)) TOTAL_AMOUNT,
                    TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_FAF_DEDUCTION
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')
            ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
            COMMIT; 
 

             INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
                    
            select 'OUTPUT' TRANSACTION_TYPE, 'SMS_BUNDLE__DEDUCTION' TRANSACTION_DESCRIPTION, sum (a.IB_COST) TOTAL_AMOUNT, TO_DATE(TO_CHAR(a.IB_SMS_DATE, 'yyyy-mm-dd'),'yyyy-mm-dd') REPORT_DATE 
            from ib_smss_all@DBLINKUSSD a
            where TO_DATE(TO_CHAR(a.IB_SMS_DATE, 'yyyy-mm-dd'),'yyyy-mm-dd') BETWEEN  trunc(sysdate-1,'month')  and to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
            and a.IB_FLAG='4'
            and A.IB_REQUEST in (upper('S1'),upper('S2'),upper('S3'),upper('S4'),upper('S5'))
            --and (a.IB_REQUEST like 'A%' or A.IB_REQUEST like 'V%' or A.IB_REQUEST like 'I%' or A.IB_REQUEST like 'K%' or A.IB_REQUEST like 'F%')
            Group by TO_DATE(TO_CHAR(a.IB_SMS_DATE, 'yyyy-mm-dd'),'yyyy-mm-dd')
            
            union all
            
            select 'OUTPUT' TRANSACTION_TYPE, 'SMS_BUNDLE__DEDUCTION' TRANSACTION_DESCRIPTION,sum(PACKAGE_PRICE) TOTAL_AMOUNT,TO_DATE(TO_CHAR(PROVISION_DATE, 'yyyy-mm-dd'),'yyyy-mm-dd')
            from sms_bundles_transaction@mis2app
            where TO_DATE(TO_CHAR(PROVISION_DATE, 'yyyy-mm-dd'),'yyyy-mm-dd') BETWEEN  trunc(sysdate-1,'month')  and to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
            and RESPONSE='SUCCESS'
            group by TO_DATE(TO_CHAR(PROVISION_DATE, 'yyyy-mm-dd'),'yyyy-mm-dd');
            
            commit;
            
--            ---TMP AREEBA PRO 
--            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
--            SELECT  TRANSACTION_TYPE,
--                    'TPM_AREEBA_PRO',
--                    SUM(AMOUNT) TOTAL_AMOUNT,
--                    TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
--            FROM REPORT_USER.IT_MIS_DR_TPM_AREEBA_PRO
--            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')
--            ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC; 
--            COMMIT;
--            
            
            --- MODE DEDUCTION
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            SELECT  TRANSACTION_TYPE,
                    'MODE_DEDUCTION',
                    ABS(SUM(replace(AMOUNT,',','.'))) TOTAL_AMOUNT,
                    TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_MODE_DEDUCTION 
           -- WHERE TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY') BETWEEN TO_DATE('6/1/2013','MM/DD/YYYY')  AND TO_DATE('6/30/2013','MM/DD/YYYY')
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')
            ORDER BY TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  DESC  ;
            COMMIT; 

            --- DAILY PACK DEDUCTION
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            SELECT  TRANSACTION_TYPE,
                    'DAILY_PACK_DEDUCTION',
                    ABS(SUM(AMOUNT)) TOTAL_AMOUNT,
                    TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_DAILY_PACK_DEDUCTION
            WHERE AMOUNT IN ('-300','-1300','-2500')
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')
            ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC ;
            COMMIT;

            --- SALES VIA USSD DEDUCTION 
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            SELECT  TRANSACTION_TYPE,
                    'SALES _VIA_USSD_DEDUCTION',
                    ABS(SUM(AMOUNT)) TOTAL_AMOUNT,
                    TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_DAILY_PACK_DEDUCTION
            WHERE AMOUNT NOT IN ('-300','-1300','-2500')
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')
            ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
            COMMIT;
                        

           --- P2P DEUCTION 

            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL
            SELECT  TRANSACTION_TYPE,
            'P2P_DEDUCTION',
            SUM(ABS(replace (TRANSACTION_AMOUNT,',','.'))) TOTAL_AMOUNT,
            TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_P2P_DEDUCTION  
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  
            ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
            COMMIT; 
              
           --- TMP DEUCTION                 
                            
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            SELECT  TRANSACTION_TYPE,
                    'TPM_DEDUCTION',
                    ABS(SUM(AMOUNT)) TOTAL_AMOUNT,
                    TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_TPM_DEDUCTION
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')
            ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC ;
            COMMIT;            
            
            
          INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL
            SELECT  'OUTPUT','HVC_BUNDLE_DEDUCTION',
                    ABS(SUM(AMOUNT)) TOTAL_AMOUNT,
                    TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_HVC_BUNDLE_DEDUCTION
           where AMOUNT <0
           GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY')
            ORDER BY TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY')  DESC  ;
            COMMIT;
            
               INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL       
          SELECT  'OUTPUT',
         'VOICE_BUNDLE_DEDUCTION',ABS(SUM(amount)),TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY')
            FROM REPORT_USER.IT_MIS_DR_VOICE_BUNDLE_REFILL
            where SUBSTR(CASH_ACCOUNT_ID,1,LENGTH(CASH_ACCOUNT_ID)-1)=0
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY')
            ORDER BY TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY')  DESC ;
            commit;
            

        INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
        SELECT 'OUTPUT',
        'DAILY_BUNDLE_DEDUCTION',
        ABS(SUM(TRANSACTION_AMOUNT)) TOTAL_AMOUNT,
        TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
        FROM REPORT_USER.IT_MIS_DR_DAILY_BUNDLE_DEDUC
        where TRANSACTION_AMOUNT<0
        GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  
        ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
        COMMIT; 
                
        -----------------------------------INTERNATIONAL BUNDLE DEDUCTION---------------------------
        
         INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
        SELECT 'OUTPUT',
        'INTER_BUNDLE_DEDUCTION',
        ABS(SUM(TRANSACTION_AMOUNT)) TOTAL_AMOUNT,
        TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
        FROM REPORT_USER.IT_MIS_DR_INTER_BUNDLE_DEDUC
        where TRANSACTION_AMOUNT<0
        GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  
        ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
        COMMIT;
        
        
 
            --- VOICE OFFPEAK DEDUCTION
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            SELECT  TRANSACTION_TYPE,
                    'VOICE_OFFPEAK_DEDUCTION',
                    abs(SUM(nvl(TRANSACTION_AMOUNT,0))) TOTAL_AMOUNT,
                    TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_VOICE_OFFPEAK_DEDUCT
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY')
            ORDER BY TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY')  DESC  ;
            COMMIT;             
 
                  
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            SELECT  TRANSACTION_TYPE,
            'WINBACK_DEDUCTION',
            ABS(SUM(replace(TRANSACTION_AMOUNT,',','.'))) TOTAL_AMOUNT,
            TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_WINBACK_DEDUCTION
            where replace(TRANSACTION_AMOUNT,',','.')<0
            and TRANSACTION_AMOUNT is not null
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  
            ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
            COMMIT; 
            
            
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            SELECT  TRANSACTION_TYPE,
            'THREEINONE_DEDUCTION',
            ABS(SUM(replace(TRANSACTION_AMOUNT,',','.'))) TOTAL_AMOUNT,
            TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_THREEINONE_DEDUCTION
            where replace(TRANSACTION_AMOUNT,',','.')<0
            and TRANSACTION_AMOUNT is not null
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  
            ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
            COMMIT; 
            
            
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            SELECT  TRANSACTION_TYPE,
            'BEPC_DEDUCTION',
            ABS(SUM(replace(TRANSACTION_AMOUNT,',','.'))) TOTAL_AMOUNT,
            TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_BEPC_DEDUCTION
            where replace(TRANSACTION_AMOUNT,',','.')<0
            and TRANSACTION_AMOUNT is not null
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  
            ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
            COMMIT; 
                        
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            SELECT  TRANSACTION_TYPE,
            'COMBODAILY_DEDUCTION',
            ABS(SUM(replace(TRANSACTION_AMOUNT,',','.'))) TOTAL_AMOUNT,
            TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_COMBODAILY_DEDUCTION
            where replace(TRANSACTION_AMOUNT,',','.')<0
            and TRANSACTION_AMOUNT is not null
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  
            ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
            COMMIT; 
                  
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            SELECT  TRANSACTION_TYPE,
            'COMBOWEEK_DEDUCTION',
            ABS(SUM(replace(TRANSACTION_AMOUNT,',','.'))) TOTAL_AMOUNT,
            TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_COMBOWEEK_DEDUCTION
            where replace(TRANSACTION_AMOUNT,',','.')<0
            and TRANSACTION_AMOUNT is not null
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  
            ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
            COMMIT; 
                
            

            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            SELECT  TRANSACTION_TYPE,
            'CONCERT_DEDUCTION',
            ABS(SUM(replace(TRANSACTION_AMOUNT,',','.'))) TOTAL_AMOUNT,
            TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_CONCERTMHD_DEDUCTION
            where replace(TRANSACTION_AMOUNT,',','.')<0
            and TRANSACTION_AMOUNT is not null
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  
            ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
            COMMIT; 
            
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
             SELECT  TRANSACTION_TYPE,
            'GTM_MICROBUNDLING_DEDUCTION',
            ABS(SUM(replace(TRANSACTION_AMOUNT,',','.'))) TOTAL_AMOUNT,
            TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_DR_OUTPUT_GTM_MICROBUNDLING
            where replace(TRANSACTION_AMOUNT,',','.')<0
            and TRANSACTION_AMOUNT is not null
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  
            ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
            
            COMMIT;
                                   
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
             SELECT  TRANSACTION_TYPE,
            'DATA_NVP_DEDUCTION',
            ABS(SUM(replace(TRANSACTION_AMOUNT,',','.'))) TOTAL_AMOUNT,
            TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_DATA_NVP_DEDUCTION
            where replace(TRANSACTION_AMOUNT,',','.')<0
            and TRANSACTION_AMOUNT is not null
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  
            ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
            
            COMMIT;
                      
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
            SELECT  TRANSACTION_TYPE,
            'KINGDEDUCTION',
            ABS(SUM(replace(TRANSACTION_AMOUNT,',','.'))) TOTAL_AMOUNT,
            TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_KING_DEDUCTION
            where replace(TRANSACTION_AMOUNT,',','.')<0
            and TRANSACTION_AMOUNT is not null
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  
            ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
            COMMIT; 
             
--           ---- DELETE INTO MIS DB 
--          DELETE FROM REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL@REPORTDBDBLINK
--          WHERE REPORT_DATE BETWEEN TRUNC(sysdate-1,'month') AND TO_DATE(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');
--          COMMIT;
--             ---- LOAD INTO MIS DB 
--           INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL@REPORTDBDBLINK
--           SELECT * FROM REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL
--           WHERE REPORT_DATE BETWEEN TRUNC(sysdate-1,'month') AND TO_DATE(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');
--           COMMIT;

-- 
--           
                   
            

   commit;
    

       end loop;  
               close cursor_table;
             
              
              
                   
     end;


--      delete from REPORT_USER.IT_MIS_WIMAX_TRAFFIC_REVENUE12@DBLINKMIS 
--      where  accountreason=5
--      and to_date(to_char(STARTTIME,'yyyy:mm:dd'),'yyyy:mm:dd')  between  trunc(sysdate-1,'month') and to_date(to_char(sysdate-1,'yyyy:mm:dd'),'yyyy:mm:dd');
--      commit; 
--               
--     insert into REPORT_USER.IT_MIS_WIMAX_TRAFFIC_REVENUE12@DBLINKMIS 
--     select * from REPORT_USER.IT_MIS_WIMAX_TRAFFIC_REVENUE12
--     where  accountreason=5
--     and to_date(to_char(STARTTIME,'yyyy:mm:dd'),'yyyy:mm:dd')  between  trunc(sysdate-1,'month') and to_date(to_char(sysdate-1,'yyyy:mm:dd'),'yyyy:mm:dd');
--      
--     commit;
     
    exception
    when no_data_found then null;
end;
/

--CREATE OR REPLACE procedure REPORT_USER.IT_MIS_DR_BONUS_ON_REFILL_PROC is

begin 


          DELETE FROM REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL
          WHERE REPORT_DATE BETWEEN TRUNC(sysdate-1,'month') AND TO_DATE(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
          and TRANSACTION_DESCRIPTION  = 'BONUS_ON_REFILL';
          COMMIT;
          
          
          DELETE FROM REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL
          WHERE REPORT_DATE BETWEEN TRUNC(sysdate-1,'month') AND TO_DATE(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
           and TRANSACTION_DESCRIPTION  = 'MODE_REFILL';
          COMMIT;
          
          
          DELETE FROM REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL
          WHERE REPORT_DATE BETWEEN TRUNC(sysdate-1,'month') AND TO_DATE(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
           and TRANSACTION_DESCRIPTION  = 'TCT_DEDUCTION';
          COMMIT;
          
           DELETE FROM REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL
          WHERE REPORT_DATE BETWEEN TRUNC(sysdate-1,'month') AND TO_DATE(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
           and TRANSACTION_DESCRIPTION  = 'DAILY_BUNDLE_REFILL';
          COMMIT;
          
          DELETE FROM REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL
          WHERE REPORT_DATE BETWEEN TRUNC(sysdate-1,'month') AND TO_DATE(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
           and TRANSACTION_DESCRIPTION  = 'INTER_BUNDLE_REFILL';
          COMMIT;
          
declare

TABLE_NAME varchar2(50);
filename varchar2(50);
filename2 varchar2(50);
adjustment number;

          
cursor cursor_table is 

SELECT   name,substr(name,1,2) day_name,to_char(to_date(name,'dd/mm/yyyy'),'yyyymmdd') day_name2
FROM REPORT_USER.IT_DAY_TO_DAY
where to_date(name,'dd/mm/yyyy') between  trunc(sysdate-1,'month')  and  to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
order by substr(name,1,2) ;
   


record_cursor_table    cursor_table%rowtype;

begin 
  
  open cursor_table;
       
     loop
         fetch cursor_table into record_cursor_table;
            exit when cursor_table%notfound; 


             -- READ MC KINSEY DR FILES
              SELECT 'DR_MODE_REFILL'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_MODE_REFILL '||' location('''||filename2||''')'; 
              
              SELECT 'DR_BONUS_ON_REFILL'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_BONUS_ON_REFILL'||' location('''||filename2||''')'; 
              
                 SELECT 'DR_TCT'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_TCT '||' location('''||filename2||''')';   
              
              SELECT 'DR_DAILY_BUNDLE_REFILL'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_DAILY_BUNDLE_REFILL '||' location('''||filename2||''')'; 
            
              SELECT 'DR_INTER_BUNDLE_REFILL'||record_cursor_table.day_name2||'.csv' INTO filename2
              FROM dual;            
              EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_DR_INTER_BUNDLE_REFILL '||' location('''||filename2||''')';
                             
              INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
                SELECT  TRANSACTION_TYPE,
                'INTER_BUNDLE_REFILL',
                SUM(replace(TRANSACTION_AMOUNT,',','.')) TOTAL_AMOUNT,
                TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
                FROM REPORT_USER.IT_MIS_DR_INTER_BUNDLE_REFILL
                where replace(TRANSACTION_AMOUNT,',','.')>0
                GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  
                ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
                COMMIT;
                
                INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
                        
            SELECT  TRANSACTION_TYPE,
            'TCT_DEDUCTION',
            SUM(ABS(replace(AMOUNT,',','.'))) TOTAL_AMOUNT,
            TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_TCT
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  ;
            COMMIT; 
            
             INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL 
                SELECT  TRANSACTION_TYPE,
                'DAILY_BUNDLE_REFILL',
                SUM(replace(TRANSACTION_AMOUNT,',','.')) TOTAL_AMOUNT,
                TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') REPORT_DATE
                FROM REPORT_USER.IT_MIS_DR_DAILY_BUNDLE_REFILL
                where replace(TRANSACTION_AMOUNT,',','.')>0
                GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY')  
                ORDER BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DESC;
                COMMIT; 
              
              
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL    
            SELECT  TRANSACTION_TYPE,
             'BONUS_ON_REFILL',SUM(replace(BONUS_ON_DA2,',','.'))+SUM(replace(BONUS_ON_DA3,',','.'))+SUM(replace(BONUS_ON_DA9,',','.'))+SUM(replace(BONUS_ON_DA10,',','.'))+SUM(replace(BONUS_ON_DA17,',','.'))+SUM(replace(BONUS_ON_DA18,',','.'))+SUM(replace(BONUS_ON_DA14,',','.'))+SUM(replace(BONUS_ON_DA19,',','.'))+SUM(replace(BONUS_ON_DA25,',','.'))+SUM(replace(BONUS_ON_DA26,',','.'))+SUM(replace(BONUS_ON_DA29,',','.'))+SUM(replace(BONUS_ON_DA30,',','.'))+SUM(replace(BONUS_ON_DA43,',','.'))+SUM(replace(BONUS_ON_DA44,',','.'))+SUM(replace(BONUS_ON_DA79,',','.'))+SUM(replace(BONUS_ON_DA105,',','.'))+SUM(replace(BONUS_ON_DA106,',','.')),TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY')
            FROM REPORT_USER.IT_MIS_DR_BONUS_ON_REFILL
            WHERE DEDICATED_ACCOUNT_ID > 0
            --and SOURCE_DR_NAME='RefillRecord'
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY')
            ORDER BY TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY')  DESC ;
            
            COMMIT; 
            
            --- MODE REFILL
            INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL     
                   
            SELECT  TRANSACTION_TYPE,
                    'MODE_REFILL',
                   SUM(nvl(replace(AMOUNT,',','.'),0)) TOTAL_AMOUNT,
                    TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY') REPORT_DATE
            FROM REPORT_USER.IT_MIS_DR_MODE_REFILL 
            --WHERE TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY') BETWEEN TO_DATE('6/1/2013','MM/DD/YYYY')  AND TO_DATE('6/30/2013','MM/DD/YYYY')
            GROUP BY TRANSACTION_TYPE,TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY')
            ORDER BY TO_DATE(SUBSTR(UTC_TIMESTAMP,1,10),'DD/MM/YY')  DESC  ;
        
            COMMIT; 
            
--           ---- DELETE INTO MIS DB 
--          DELETE FROM REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL@REPORTDBDBLINK
--          WHERE REPORT_DATE BETWEEN TRUNC(sysdate-1,'month') AND TO_DATE(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');
--          COMMIT;
--             ---- LOAD INTO MIS DB 
--           INSERT INTO REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL@REPORTDBDBLINK
--           SELECT * FROM REPORT_USER.IT_MIS_DR_INPUT_OUTPUT_TBL
--           WHERE REPORT_DATE BETWEEN TRUNC(sysdate-1,'month') AND TO_DATE(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');
--           COMMIT;

-- 
--           
                   
            

   commit;
    

       end loop;  
               close cursor_table;
             
              
              
                   
     end;

    exception
    when no_data_found then null;
end;
/



-----ESME----------------
BEGIN

DECLARE

filename VARCHAR2(50);

CURSOR cursor_table IS 

SELECT   NAME,SUBSTR(NAME,1,2) day_name,TO_CHAR(TO_DATE(NAME,'dd/mm/yyyy'),'yyyymmdd') day_name2
FROM REPORT_USER.IT_DAY_TO_DAY
-- WHERE TO_DATE(NAME,'dd/mm/yyyy') BETWEEN TO_DATE('16/10/2015','dd/mm/yyyy') AND TO_DATE('16/10/2015','dd/mm/yyyy') 
--to_date('05/04/2014','dd/mm/yyyy') and  to_date('09/04/2014','dd/mm/yyyy')
WHERE TO_DATE(NAME,'dd/mm/yyyy') BETWEEN to_date(to_char(SYSDATE-89,'dd/mm/yyyy'),'dd/mm/yyyy') and  to_date(to_char(SYSDATE-59,'dd/mm/yyyy'),'dd/mm/yyyy')
ORDER BY SUBSTR(NAME,1,2) ;


record_cursor_table    cursor_table%ROWTYPE;

BEGIN 
  
  OPEN cursor_table;
       
     LOOP
         FETCH cursor_table INTO record_cursor_table;
            EXIT WHEN cursor_table%NOTFOUND; 
            

            SELECT 'ESME_DR_'||record_cursor_table.day_name2||'.txt' INTO filename
            FROM dual;         
                           
            EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_SMSC_PR_TRANS  '||' location('''||filename||''')';   
            

            SELECT 'ESME_PR_'||record_cursor_table.day_name2||'.txt' INTO filename
            FROM dual;         
                           
            EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_SMSC_DR_TRANS  '||' location('''||filename||''')';   
            
-----------  START MOC  --------------- 
        
        commit;

        insert into report_user.IT_MIS_SMSC_TRANSAC_AUG18
        select * from REPORT_USER.IT_MIS_SMSC_PR_TRANS;

        commit;

        insert into report_user.IT_MIS_SMSC_TRANSAC_AUG18
        select * from REPORT_USER.IT_MIS_SMSC_DR_TRANS;

        commit;
        
            END LOOP;  
        
               CLOSE cursor_table;
                   
END;
END;
/

----MTS---------------------
BEGIN

DECLARE

filename VARCHAR2(50);

CURSOR cursor_table IS 

SELECT   NAME,SUBSTR(NAME,1,2) day_name,TO_CHAR(TO_DATE(NAME,'dd/mm/yyyy'),'yyyymmdd') day_name2
FROM REPORT_USER.IT_DAY_TO_DAY
-- WHERE TO_DATE(NAME,'dd/mm/yyyy') BETWEEN TO_DATE('16/10/2015','dd/mm/yyyy') AND TO_DATE('16/10/2015','dd/mm/yyyy') 
--to_date('05/04/2014','dd/mm/yyyy') and  to_date('09/04/2014','dd/mm/yyyy')
WHERE TO_DATE(NAME,'dd/mm/yyyy') BETWEEN to_date(to_char(SYSDATE-4,'dd/mm/yyyy'),'dd/mm/yyyy') and  to_date(to_char(SYSDATE-1,'dd/mm/yyyy'),'dd/mm/yyyy')
ORDER BY SUBSTR(NAME,1,2) ;


record_cursor_table    cursor_table%ROWTYPE;

BEGIN 
  
  OPEN cursor_table;
       
     LOOP
         FETCH cursor_table INTO record_cursor_table;
            EXIT WHEN cursor_table%NOTFOUND; 
            

            SELECT 'MTS_DR_'||record_cursor_table.day_name2||'.txt' INTO filename
            FROM dual;         
                           
            EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_SMSC_PR_TRANS_MTS  '||' location('''||filename||''')';   
            

            SELECT 'MTS_PR_'||record_cursor_table.day_name2||'.txt' INTO filename
            FROM dual;         
                           
            EXECUTE IMMEDIATE ' alter table REPORT_USER.IT_MIS_SMSC_DR_TRANS_MTS  '||' location('''||filename||''')';   
            
-----------  START MOC  --------------- 
        
        commit;

        insert into report_user.IT_MIS_SMSC_TRANSAC_MTS_NOV18
        select * from REPORT_USER.IT_MIS_SMSC_PR_TRANS_MTS;

        commit;

        insert into report_user.IT_MIS_SMSC_TRANSAC_MTS_NOV18
        select * from REPORT_USER.IT_MIS_SMSC_DR_TRANS_MTS;

        commit;


        
            END LOOP;  
        
               CLOSE cursor_table;
                   
END;
END;
/

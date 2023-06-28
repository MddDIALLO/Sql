-------------------AIRTIME-------------------------------------------DANS--REPORTDBDB------------------------

delete from IT_MIS_DR_AIRTIME_LOAD_report2 
where DATE_REFILL between to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy') and  to_date(to_char(sysdate-3,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

delete  from IT_MIS_DR_AIRTIME_LOADED_AREA2
where DATE_REFILL between to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy') and  to_date(to_char(sysdate-3,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

BEGIN 

declare

filename varchar2(50);
revgbl number;
revloc number;

cursor cursor_table is 

SELECT   to_date(name,'dd/mm/yyyy') date_name ,substr(name,1,2) day_name,to_char(to_date(name,'dd/mm/yyyy'),'yyyymmdd') day_name2
FROM IT_DAY_TO_DAY
where to_date(name,'dd/mm/yyyy') between to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy') and  to_date(to_char(sysdate-3,'dd/mm/yyyy'),'dd/mm/yyyy')
order by substr(name,1,2) ;


record_cursor_table    cursor_table%rowtype;

begin 
  
  open cursor_table;
       
     loop
         fetch cursor_table into record_cursor_table;
            exit when cursor_table%notfound; 
            

            SELECT 'Airtime_per_CellID_NEW_'||record_cursor_table.day_name2||'.csv' INTO filename
            FROM dual;         
                           
            EXECUTE IMMEDIATE ' alter table IT_MIS_DR_AIRTIME_CELLID_DTL2  '||' location('''||filename||''')'; 
               
            
            /* SCRIPT FOR LOGICAL USED VOUCHERS OF NATIONAL */  
               ---- LOGICAL VOUCHERS
INSERT INTO  IT_MIS_DR_AIRTIME_LOADED_AREA2   
        select  'LOGICAL' VOUCHER_TYPE,
        t1.CELL_IDENTIFIER CELLID, 
        t2.VILLE,t2.COMMUNES,t2.GOUVERNORATS,t2.REGION_NATURELLE,
        t1.MSISDN,
        t1.SERVICE_CLASS_NAME, 
                
        t1.VOUCHER_SERIAL_NUMBER,
                
        -- decode (t1.NOMINAL_TRANSACTION_AMOUNT,'2000','R2K','5000','R5K','10000','R10K','20000','R20K','50000','R50K','100000','R100K') RECHARGE_TYPE,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='2000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0  then 1 end ),0) R2K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='2000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R2K_LOGICAL_AMOUNT,
                
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='5000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0 then 1 end ),0) R5K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='5000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R5K_LOGICAL_AMOUNT,
                
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='10000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0 then 1 end ),0) R10K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='10000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R10K_LOGICAL_AMOUNT,
                
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='20000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0 then 1 end ),0) R20K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='20000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R20K_LOGICAL_AMOUNT_TOTAL,
                
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='50000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0 then 1 end ),0) R50K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='50000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R50K_LOGICAL_AMOUNT_TOTAL,
                
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='100000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0 then 1 end ),0) R100K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='100000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R100K_LOGICAL_AMOUNT_TOTAL,
        TO_DATE(SUBSTR(t1.UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DATE_REFILL,
        SUBSTR(t1.UTC_TIMESTAMP,12,2) DATE_REFILL_HOUR
        from ( select  * from IT_MIS_DR_AIRTIME_CELLID_DTL2
        where VOUCHER_SERIAL_NUMBER is not null 
        and CELL_IDENTIFIER is not null 
        -- and t1.ACCOUNT_EVENT_ID='451398251'
        and CELL_IDENTIFIER not like'%-%'  
        ) t1,IT_MIS_CELLID_FINAL_2013 t2 --IT_MIS_CELLID_FINAL_2013@REPORTDBDBLINK t2 
        WHERE  t1.CELL_IDENTIFIER=t2.CELLID   
        and t1.VOUCHER_SERIAL_NUMBER  not like '70%'        
        --AND MSISDN='224664735547'
        GROUP BY t1.CELL_IDENTIFIER,t1.SERVICE_CLASS_NAME, TO_DATE(SUBSTR(t1.UTC_TIMESTAMP,1,10),'DD/MM/YYYY') ,SUBSTR(t1.UTC_TIMESTAMP,12,2),t1.MSISDN,t2.VILLE,t2.COMMUNES,t2.GOUVERNORATS,t2.REGION_NATURELLE,t1.VOUCHER_SERIAL_NUMBER;
       
      commit;                        /* END SCRIPT FOR LOGICAL USED VOUCHERS OF NATIONAL */
      
             /*  SCRIPT FOR PHYSICAL USED VOUCHERS OF NATIONAL */
---------- CLASSIC VOUCHERS
 INSERT INTO  IT_MIS_DR_AIRTIME_LOADED_AREA2   
        select  'CLASSIC' VOUCHER_TYPE,
        t1.CELL_IDENTIFIER CELLID, 
        t2.VILLE,t2.COMMUNES,t2.GOUVERNORATS,t2.REGION_NATURELLE,
        t1.MSISDN,
        t1.SERVICE_CLASS_NAME, 
                
        t1.VOUCHER_SERIAL_NUMBER,
                
        -- decode (t1.NOMINAL_TRANSACTION_AMOUNT,'2000','R2K','5000','R5K','10000','R10K','20000','R20K','50000','R50K','100000','R100K') RECHARGE_TYPE,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='2000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0  then 1 end ),0) R2K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='2000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R2K_LOGICAL_AMOUNT,
                
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='5000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0 then 1 end ),0) R5K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='5000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R5K_LOGICAL_AMOUNT,
                
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='10000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0 then 1 end ),0) R10K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='10000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R10K_LOGICAL_AMOUNT,
                
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='20000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0 then 1 end ),0) R20K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='20000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R20K_LOGICAL_AMOUNT_TOTAL,
                
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='50000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0 then 1 end ),0) R50K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='50000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R50K_LOGICAL_AMOUNT_TOTAL,
                
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='100000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0 then 1 end ),0) R100K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='100000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R100K_LOGICAL_AMOUNT_TOTAL,
        TO_DATE(SUBSTR(t1.UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DATE_REFILL,
        SUBSTR(t1.UTC_TIMESTAMP,12,2) DATE_REFILL_HOUR
        from ( select  * from IT_MIS_DR_AIRTIME_CELLID_DTL2
        where VOUCHER_SERIAL_NUMBER is not null 
        and CELL_IDENTIFIER is not null 
        -- and t1.ACCOUNT_EVENT_ID='451398251'
        and CELL_IDENTIFIER not like'%-%'  
        ) t1,IT_MIS_CELLID_FINAL_2013 t2 --IT_MIS_CELLID_FINAL_2013@REPORTDBDBLINK t2 
        WHERE  t1.CELL_IDENTIFIER=t2.CELLID   
        and t1.VOUCHER_SERIAL_NUMBER  like '70%'        
        --AND MSISDN='224664735547'
        GROUP BY t1.CELL_IDENTIFIER,t1.SERVICE_CLASS_NAME, TO_DATE(SUBSTR(t1.UTC_TIMESTAMP,1,10),'DD/MM/YYYY') ,SUBSTR(t1.UTC_TIMESTAMP,12,2),t1.MSISDN,t2.VILLE,t2.COMMUNES,t2.GOUVERNORATS,t2.REGION_NATURELLE,t1.VOUCHER_SERIAL_NUMBER;
       
      commit;          /* END SCRIPT FOR PHYSICAL USED VOUCHERS OF NATIONAL */
      
      
      /* SCRIPT FOR LOGICAL USED VOUCHERS OF ROAMER */
INSERT INTO  IT_MIS_DR_AIRTIME_LOADED_AREA2   
        select  'LOGICAL' VOUCHER_TYPE,
        trim(t2.CODE_COUNTRY_OPERATOR) CELLID, 
        t2.ROAMING_PARTNER_NAME||' / '||t2.VPMN_COUNTRY_NAME VILLE,
        t2.ROAMING_PARTNER_NAME||' / '||t2.VPMN_COUNTRY_NAME COMMUNES,
        t2.ROAMING_PARTNER_NAME||' / '||t2.VPMN_COUNTRY_NAME GOUVERNORATS,
        t2.ROAMING_PARTNER_NAME||' / '||t2.VPMN_COUNTRY_NAME REGION_NATURELLE,
        t1.MSISDN,
        t1.SERVICE_CLASS_NAME, 
                
        t1.VOUCHER_SERIAL_NUMBER,
                
        -- decode (t1.NOMINAL_TRANSACTION_AMOUNT,'2000','R2K','5000','R5K','10000','R10K','20000','R20K','50000','R50K','100000','R100K') RECHARGE_TYPE,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='2000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0  then 1 end ),0) R2K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='2000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R2K_LOGICAL_AMOUNT,
                
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='5000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0 then 1 end ),0) R5K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='5000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R5K_LOGICAL_AMOUNT,
                
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='10000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0 then 1 end ),0) R10K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='10000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R10K_LOGICAL_AMOUNT,
                
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='20000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0 then 1 end ),0) R20K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='20000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R20K_LOGICAL_AMOUNT_TOTAL,
                
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='50000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0 then 1 end ),0) R50K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='50000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R50K_LOGICAL_AMOUNT_TOTAL,
                
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='100000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0 then 1 end ),0) R100K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='100000' and t1.VOUCHER_SERIAL_NUMBER not  like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R100K_LOGICAL_AMOUNT_TOTAL,
        TO_DATE(SUBSTR(t1.UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DATE_REFILL,
        SUBSTR(t1.UTC_TIMESTAMP,12,2) DATE_REFILL_HOUR
        from ( select  * from IT_MIS_DR_AIRTIME_CELLID_DTL2
        where VOUCHER_SERIAL_NUMBER is not null 
        and CELL_IDENTIFIER is not null 
        -- and t1.ACCOUNT_EVENT_ID='451398251'
        and CELL_IDENTIFIER like'%-%'  
        ) t1,IT_ROAMING_PARTNER_IMSI t2 
        WHERE  substr(REGEXP_SUBSTR (t1.CELL_IDENTIFIER, '[^-]+')||SUBSTR((t1.CELL_IDENTIFIER),-(length(t1.CELL_IDENTIFIER)-(length(REGEXP_SUBSTR (t1.CELL_IDENTIFIER, '[^-]+'))+1)),(length(t1.CELL_IDENTIFIER)-(length(REGEXP_SUBSTR (t1.CELL_IDENTIFIER, '[^-]+'))+1))),1,5)=substr(trim(t2.CODE_COUNTRY_OPERATOR(+)),1,5) 
        and t1.VOUCHER_SERIAL_NUMBER  not like '70%'        
        --AND MSISDN='224664735547'
        GROUP BY trim(t2.CODE_COUNTRY_OPERATOR),t1.SERVICE_CLASS_NAME, TO_DATE(SUBSTR(t1.UTC_TIMESTAMP,1,10),'DD/MM/YYYY') ,SUBSTR(t1.UTC_TIMESTAMP,12,2),t1.MSISDN,t2.ROAMING_PARTNER_NAME||' / '||t2.VPMN_COUNTRY_NAME,t1.VOUCHER_SERIAL_NUMBER;
       
      commit;   /* END SCRIPT FOR LOGICAL USED VOUCHERS OF ROAMER */
      
      
      
/* SCRIPT FOR PHYSICAL USED VOUCHERS OF ROAMER */      
 INSERT INTO  IT_MIS_DR_AIRTIME_LOADED_AREA2   
        select  'CLASSIC' VOUCHER_TYPE,
        trim(t2.CODE_COUNTRY_OPERATOR) CELLID, 
        t2.ROAMING_PARTNER_NAME||' / '||t2.VPMN_COUNTRY_NAME VILLE,
        t2.ROAMING_PARTNER_NAME||' / '||t2.VPMN_COUNTRY_NAME COMMUNES,
        t2.ROAMING_PARTNER_NAME||' / '||t2.VPMN_COUNTRY_NAME GOUVERNORATS,
        t2.ROAMING_PARTNER_NAME||' / '||t2.VPMN_COUNTRY_NAME REGION_NATURELLE,
        t1.MSISDN,
        t1.SERVICE_CLASS_NAME, 
                
        t1.VOUCHER_SERIAL_NUMBER,
                
        -- decode (t1.NOMINAL_TRANSACTION_AMOUNT,'2000','R2K','5000','R5K','10000','R10K','20000','R20K','50000','R50K','100000','R100K') RECHARGE_TYPE,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='2000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0  then 1 end ),0) R2K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='2000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R2K_LOGICAL_AMOUNT,
                
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='5000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0 then 1 end ),0) R5K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='5000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R5K_LOGICAL_AMOUNT,
                
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='10000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0 then 1 end ),0) R10K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='10000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R10K_LOGICAL_AMOUNT,
                
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='20000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0 then 1 end ),0) R20K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='20000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R20K_LOGICAL_AMOUNT_TOTAL,
                
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='50000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0 then 1 end ),0) R50K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='50000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R50K_LOGICAL_AMOUNT_TOTAL,
                
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='100000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0 then 1 end ),0) R100K_LOGICAL_TOTAL,
        nvl(sum(case when t1.NOMINAL_TRANSACTION_AMOUNT='100000' and t1.VOUCHER_SERIAL_NUMBER like '70%' and t1.CASH_ACCOUNT_ID=0 then t1.NOMINAL_TRANSACTION_AMOUNT end ),0) R100K_LOGICAL_AMOUNT_TOTAL,
        TO_DATE(SUBSTR(t1.UTC_TIMESTAMP,1,10),'DD/MM/YYYY') DATE_REFILL,
        SUBSTR(t1.UTC_TIMESTAMP,12,2) DATE_REFILL_HOUR
        from ( select  * from IT_MIS_DR_AIRTIME_CELLID_DTL2
        where VOUCHER_SERIAL_NUMBER is not null 
        and CELL_IDENTIFIER is not null 
        -- and t1.ACCOUNT_EVENT_ID='451398251'
        and CELL_IDENTIFIER like'%-%'  
        ) t1,IT_ROAMING_PARTNER_IMSI t2 
        WHERE  substr(REGEXP_SUBSTR (t1.CELL_IDENTIFIER, '[^-]+')||SUBSTR((t1.CELL_IDENTIFIER),-(length(t1.CELL_IDENTIFIER)-(length(REGEXP_SUBSTR (t1.CELL_IDENTIFIER, '[^-]+'))+1)),(length(t1.CELL_IDENTIFIER)-(length(REGEXP_SUBSTR (t1.CELL_IDENTIFIER, '[^-]+'))+1))),1,5)=substr(trim(t2.CODE_COUNTRY_OPERATOR(+)),1,5) 
        and t1.VOUCHER_SERIAL_NUMBER  like '70%'        
        --AND MSISDN='224664735547'
        GROUP BY trim(t2.CODE_COUNTRY_OPERATOR),t1.SERVICE_CLASS_NAME, TO_DATE(SUBSTR(t1.UTC_TIMESTAMP,1,10),'DD/MM/YYYY') ,SUBSTR(t1.UTC_TIMESTAMP,12,2),t1.MSISDN,t2.ROAMING_PARTNER_NAME||' / '||t2.VPMN_COUNTRY_NAME,t1.VOUCHER_SERIAL_NUMBER;
       
      commit;         
      
      /* END SCRIPT FOR PHYSICAL USED VOUCHERS OF ROAMER */      
        
        insert into IT_MIS_DR_AIRTIME_LOAD_report2  
        select VILLE,
        COMMUNES,
        GOUVERNORATS,
        VOUCHER_TYPE,
        REGION_NATURELLE,
        sum(R5K_LOGICAL_TOTAL)+sum(R10K_LOGICAL_TOTAL)+sum(R20K_LOGICAL_TOTAL)+sum(R50K_LOGICAL_TOTAL)+sum(R100K_LOGICAL_TOTAL) TOTAL_LOGICAL_LOADED,
        sum(R5K_LOGICAL_AMOUNT)+sum(R10K_LOGICAL_AMOUNT)+sum(R20K_LOGICAL_AMOUNT_TOTAL)+sum(R50K_LOGICAL_AMOUNT_TOTAL)+sum(R100K_LOGICAL_AMOUNT_TOTAL) TOTAL_LOGICAL_AMOUNT,
        sum(R5K_LOGICAL_TOTAL) R5K_LOGICAL_TOTAL, 
        sum(R5K_LOGICAL_AMOUNT) R5K_LOGICAL_AMOUNT,
        sum(R10K_LOGICAL_TOTAL) R10K_LOGICAL_TOTAL, 
        sum(R10K_LOGICAL_AMOUNT) R10K_LOGICAL_AMOUNT,
        sum(R20K_LOGICAL_TOTAL) R20K_LOGICAL_TOTAL, 
        sum(R20K_LOGICAL_AMOUNT_TOTAL) R20K_LOGICAL_AMOUNT,
        sum(R50K_LOGICAL_TOTAL) R50K_LOGICAL_TOTAL,
        sum(R50K_LOGICAL_AMOUNT_TOTAL) R50K_LOGICAL_AMOUNT,
        sum(R100K_LOGICAL_TOTAL) R100K_LOGICAL_TOTAL,
        sum(R100K_LOGICAL_AMOUNT_TOTAL) R100K_LOGICAL_AMOUNT,  
        DATE_REFILL,
        DATE_REFILL_HOUR
        from IT_MIS_DR_AIRTIME_LOADED_AREA2  
        where DATE_REFILL= record_cursor_table.date_name --to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
        group by VILLE,
        COMMUNES,
        GOUVERNORATS,
        VOUCHER_TYPE,
        REGION_NATURELLE,
        DATE_REFILL,
        DATE_REFILL_HOUR
        order by REGION_NATURELLE,DATE_REFILL_HOUR;
        commit;
        
       
        
--        insert into IT_MIS_DR_AIRTIME_LOAD_report2@DBLINKMCKINSEY
--        select VILLE,COMMUNES,GOUVERNORATS,VOUCHER_TYPE,REGION_NATURELLE,sum(TOTAL_LOGICAL_LOADED) TOTAL_LOGICAL_LOADED ,sum(TOTAL_LOGICAL_AMOUNT) TOTAL_LOGICAL_AMOUNT,sum(R5K_LOGICAL_TOTAL) R5K_LOGICAL_TOTAL,sum(R5K_LOGICAL_AMOUNT) R5K_LOGICAL_AMOUNT,
--        sum(R10K_LOGICAL_TOTAL) R10K_LOGICAL_TOTAL,sum(R10K_LOGICAL_AMOUNT) R10K_LOGICAL_AMOUNT,sum(R20K_LOGICAL_TOTAL) R20K_LOGICAL_TOTAL,sum(R20K_LOGICAL_AMOUNT) R20K_LOGICAL_AMOUNT,sum(R50K_LOGICAL_TOTAL) R50K_LOGICAL_TOTAL,
--        sum(R50K_LOGICAL_AMOUNT) R50K_LOGICAL_AMOUNT,sum(R100K_LOGICAL_TOTAL) R100K_LOGICAL_TOTAL,sum(R100K_LOGICAL_AMOUNT) R100K_LOGICAL_AMOUNT,DATE_REFILL
--        from IT_MIS_DR_AIRTIME_LOAD_report2 
--        where DATE_REFILL= record_cursor_table.date_name --to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
--        group by DATE_REFILL,VILLE,COMMUNES,GOUVERNORATS,VOUCHER_TYPE,REGION_NATURELLE;
--        commit;

 /*
        DIFFERENCE ENTRE REVENU GLOBALE ET REVENUE LOCALISEE
        
        */
    
 
         SELECT sum(TOTAL_AMOUNT) into  revgbl
        FROM  IT_MK_VOUCHER_REFILL_AMOUNT
        WHERE SUBSTR(STAT_DATE,1,8)= record_cursor_table.day_name2; --TO_CHAR(sysdate-4,'yyyymmdd');


        select sum(TOTAL_LOGICAL_AMOUNT) into revloc
        from IT_MIS_DR_AIRTIME_LOAD_report2
        where DATE_REFILL= record_cursor_table.date_name; --to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy');
        
        if revgbl>revloc then
                 
                begin
                
                        insert into IT_MIS_DR_AIRTIME_LOAD_report2      
                        select 'UNKNOWN' ,'UNKNOWN' ,'UNKNOWN' ,'UNKNOWN' ,'UNKNOWN' ,0,revgbl-revloc,0,0,0,0,0,0,0,0,0,0,record_cursor_table.date_name ,'NA'  
                        from dual;
                        
                        commit;
                        
--                        insert into IT_MIS_DR_AIRTIME_LOAD_report2@DBLINKMCKINSEY      
--                        select 'UNKNOWN' ,'UNKNOWN' ,'UNKNOWN' ,'UNKNOWN' ,'UNKNOWN' ,0,revgbl-revloc,0,0,0,0,0,0,0,0,0,0,record_cursor_table.date_name -- ,'NA'  
--                        from dual;
--                        
--                        commit;
        
               end;
               
              end if;        
--select DATE_REFILL,sum(TOTAL_LOGICAL_AMOUNT) from IT_MIS_DR_AIRTIME_LOAD_report 
--where DATE_REFILL>= to_date(to_char(sysdate-31,'dd/mm/yyyy'),'dd/mm/yyyy')
--group by DATE_REFILL 


-----sript for regularisation
--select * from IT_MIS_DR_AIRTIME_LOAD_report2 
--where DATE_REFILL= to_date(to_char(sysdate-5,'dd/mm/yyyy'),'dd/mm/yyyy')

--delete from IT_MIS_DR_AIRTIME_LOAD_report2 
--where DATE_REFILL= to_date(to_char(sysdate-5,'dd/mm/yyyy'),'dd/mm/yyyy')

--select *  from IT_MIS_DR_AIRTIME_LOADED_AREA2
--where DATE_REFILL= to_date(to_char(sysdate-5,'dd/mm/yyyy'),'dd/mm/yyyy')

--delete  from IT_MIS_DR_AIRTIME_LOADED_AREA2
--where DATE_REFILL= to_date(to_char(sysdate-5,'dd/mm/yyyy'),'dd/mm/yyyy')

--select count(*) from air_account_events partition(D20130930_AIR_ACC_EV)
                
        end loop;  
        
               close cursor_table;
                   
     end;


END;
/

delete from IT_MIS_DR_AIRTIME_LOAD_report2@MKDBLINK 
where DATE_REFILL between to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy') and  to_date(to_char(sysdate-3,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

INSERT INTO IT_MIS_DR_AIRTIME_LOAD_report2@MKDBLINK 
SELECT * from IT_MIS_DR_AIRTIME_LOAD_report2 
where DATE_REFILL between to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy') and  to_date(to_char(sysdate-3,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

delete  from IT_MIS_DR_AIRTIME_LOADED_AREA2@MKDBLINK
where DATE_REFILL  between to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy') and  to_date(to_char(sysdate-3,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

INSERT INTO IT_MIS_DR_AIRTIME_LOADED_AREA2@MKDBLINK 
SELECT * from IT_MIS_DR_AIRTIME_LOADED_AREA2 
where DATE_REFILL  between to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy') and  to_date(to_char(sysdate-3,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

-------------------TAFTAF-------------------------------------------DANS--REPORTDBDB------------------------
-----sript for regularisation
delete from IT_MIS_DR_R2S_LOAD_AREA_RPT2
where DATE_REFILL= to_date(to_char(sysdate-19,'dd/mm/yyyy'),'dd/mm/yyyy');
commit;

delete  from IT_MIS_DR_R2S_LOAD_AREA2
where TO_DATE(SUBSTR(DATE_REFILL,1,10),'DD/MM/YYYY')=to_date(to_char(sysdate-19,'dd/mm/yyyy'),'dd/mm/yyyy');
commit;


BEGIN 

declare

filename varchar2(50);
revgbl number;
revloc number;

cursor cursor_table is 

SELECT   to_date(name,'dd/mm/yyyy') date_name ,substr(name,1,2) day_name,to_char(to_date(name,'dd/mm/yyyy'),'yyyymmdd') day_name2
FROM IT_DAY_TO_DAY
where to_date(name,'dd/mm/yyyy') between to_date(to_char(sysdate-19,'dd/mm/yyyy'),'dd/mm/yyyy') and  to_date(to_char(sysdate-19,'dd/mm/yyyy'),'dd/mm/yyyy')
order by substr(name,1,2) ;


record_cursor_table    cursor_table%rowtype;

begin 
  
  open cursor_table;
       
     loop
         fetch cursor_table into record_cursor_table;
            exit when cursor_table%notfound; 
            

            SELECT 'IT_DR_R2S_CELLID_NEW_'||record_cursor_table.day_name2||'.csv' INTO filename
            FROM dual;         
                           
            EXECUTE IMMEDIATE ' alter table IT_MIS_DR_ERS_REFILL_CELLID2  '||' location('''||filename||''')';   
 

        ----------- LOAD R2S PER CELLID DETAIL 
         INSERT INTO IT_MIS_DR_R2S_LOAD_AREA2    
        SELECT a.CELL_IDENTIFIER CELLID,
        b.VILLE,
        b.COMMUNES,
        b.GOUVERNORATS,
        b.REGION_NATURELLE,
        SERVICE_CLASS_NAME,
        SERVED_MSISDN,
        CASH_ACCOUNT_ID,        
        nvl(sum(case when REPLACE(a.AMOUNT,',','.')=500  and a.CASH_ACCOUNT_ID=0  then 1 end ),0) R500_R2S_TOTAL,
        nvl(sum(case when REPLACE(a.AMOUNT,',','.')=500  and a.CASH_ACCOUNT_ID=0 then REPLACE(a.AMOUNT,',','.') end ),0) R500K_R2S_AMOUNT,
                
        nvl(sum(case when REPLACE(a.AMOUNT,',','.') between 501 and 1000  and a.CASH_ACCOUNT_ID=0  then 1 end ),0) R1K_R2S_TOTAL,
        nvl(sum(case when REPLACE(a.AMOUNT,',','.') between 501 and 1000  and a.CASH_ACCOUNT_ID=0 then REPLACE(a.AMOUNT,',','.') end ),0) R1K_R2S_AMOUNT,
                
        nvl(sum(case when REPLACE(a.AMOUNT,',','.') between 1001 and 4999  and a.CASH_ACCOUNT_ID=0 then 1 end ),0) R5K_R2S_TOTAL,
        nvl(sum(case when REPLACE(a.AMOUNT,',','.') between 1001 and 4999  and a.CASH_ACCOUNT_ID=0 then REPLACE(a.AMOUNT,',','.') end ),0) R5K_R2S_AMOUNT,
                
        nvl(sum(case when REPLACE(a.AMOUNT,',','.')  between 5000 and 9999  and a.CASH_ACCOUNT_ID=0 then 1 end ),0) R10K_R2S_TOTAL,
        nvl(sum(case when REPLACE(a.AMOUNT,',','.')  between 5000 and 9999  and a.CASH_ACCOUNT_ID=0 then REPLACE(a.AMOUNT,',','.') end ),0) R10K_R2S_AMOUNT,
                
        nvl(sum(case when REPLACE(a.AMOUNT,',','.') between 10000 and 19999  and a.CASH_ACCOUNT_ID=0 then 1 end ),0) R20K_R2S_TOTAL,
        nvl(sum(case when REPLACE(a.AMOUNT,',','.') between 10000 and 19999  and a.CASH_ACCOUNT_ID=0 then REPLACE(a.AMOUNT,',','.') end ),0) R20K_R2S_AMOUNT,
                
        nvl(sum(case when REPLACE(a.AMOUNT,',','.')  between 20000 and 49999  and a.CASH_ACCOUNT_ID=0 then 1 end ),0) R50K_R2S_TOTAL,
        nvl(sum(case when REPLACE(a.AMOUNT,',','.') between  20000 and 49999  and a.CASH_ACCOUNT_ID=0 then REPLACE(a.AMOUNT,',','.') end ),0) R50K_R2S_AMOUNT,
                
        nvl(sum(case when REPLACE(a.AMOUNT,',','.')  between 50000 and 99999  and a.CASH_ACCOUNT_ID=0 then 1 end ),0) R100K_R2S_TOTAL,
        nvl(sum(case when REPLACE(a.AMOUNT,',','.')  between 50000 and 99999  and a.CASH_ACCOUNT_ID=0 then REPLACE(a.AMOUNT,',','.') end ),0) R100K_R2S_AMOUNT,
                
        nvl(sum(case when REPLACE(a.AMOUNT,',','.')  >= 100000 and a.CASH_ACCOUNT_ID=0 then 1 end ),0) RPLUSDE100K_R2S_TOTAL,
        nvl(sum(case when REPLACE(a.AMOUNT,',','.')  >= 100000   and a.CASH_ACCOUNT_ID=0 then REPLACE(a.AMOUNT,',','.') end ),0) RPLUSDE100K_R2S_AMOUNT,
        a.UTC_TIMESTAMP DATE_REFILL,
        SUBSTR(a.UTC_TIMESTAMP,12,2) DATE_REFILL_HOUR        
        FROM  IT_MIS_DR_ERS_REFILL_CELLID2 a, IT_MIS_CELLID_FINAL_2013 b
        WHERE  a.CELL_IDENTIFIER=b.CELLID
        and a.CELL_IDENTIFIER NOT like'%-%' 
        GROUP BY a.CELL_IDENTIFIER ,
        b.VILLE,
        b.COMMUNES,
        b.GOUVERNORATS,
        b.REGION_NATURELLE,
        a.SERVICE_CLASS_NAME,
        a.SERVED_MSISDN,
        a.CASH_ACCOUNT_ID,
        a.UTC_TIMESTAMP,
        SUBSTR(a.UTC_TIMESTAMP,12,2);
        
        commit;

         /* SCRIPT FOR TOPUP OF ROAMER */
         INSERT INTO IT_MIS_DR_R2S_LOAD_AREA2    
        SELECT trim(b.CODE_COUNTRY_OPERATOR) CELLID,
        b.ROAMING_PARTNER_NAME||' / '||b.VPMN_COUNTRY_NAME VILLE,
        b.ROAMING_PARTNER_NAME||' / '||b.VPMN_COUNTRY_NAME COMMUNES,
        b.ROAMING_PARTNER_NAME||' / '||b.VPMN_COUNTRY_NAME GOUVERNORATS,
        b.ROAMING_PARTNER_NAME||' / '||b.VPMN_COUNTRY_NAME REGION_NATURELLE,
        a.SERVICE_CLASS_NAME,
        a.SERVED_MSISDN,
        a.CASH_ACCOUNT_ID,        
        nvl(sum(case when REPLACE(a.AMOUNT,',','.')=500  and a.CASH_ACCOUNT_ID=0  then 1 end ),0) R500_R2S_TOTAL,
        nvl(sum(case when REPLACE(a.AMOUNT,',','.')=500  and a.CASH_ACCOUNT_ID=0 then REPLACE(a.AMOUNT,',','.') end ),0) R500K_R2S_AMOUNT,
                
        nvl(sum(case when REPLACE(a.AMOUNT,',','.') between 501 and 1000  and a.CASH_ACCOUNT_ID=0  then 1 end ),0) R1K_R2S_TOTAL,
        nvl(sum(case when REPLACE(a.AMOUNT,',','.') between 501 and 1000  and a.CASH_ACCOUNT_ID=0 then REPLACE(a.AMOUNT,',','.') end ),0) R1K_R2S_AMOUNT,
                
        nvl(sum(case when REPLACE(a.AMOUNT,',','.') between 1001 and 4999  and a.CASH_ACCOUNT_ID=0 then 1 end ),0) R5K_R2S_TOTAL,
        nvl(sum(case when REPLACE(a.AMOUNT,',','.') between 1001 and 4999  and a.CASH_ACCOUNT_ID=0 then REPLACE(a.AMOUNT,',','.') end ),0) R5K_R2S_AMOUNT,
                
        nvl(sum(case when REPLACE(a.AMOUNT,',','.')  between 5000 and 9999  and a.CASH_ACCOUNT_ID=0 then 1 end ),0) R10K_R2S_TOTAL,
        nvl(sum(case when REPLACE(a.AMOUNT,',','.')  between 5000 and 9999  and a.CASH_ACCOUNT_ID=0 then REPLACE(a.AMOUNT,',','.') end ),0) R10K_R2S_AMOUNT,
                
        nvl(sum(case when REPLACE(a.AMOUNT,',','.') between 10000 and 19999  and a.CASH_ACCOUNT_ID=0 then 1 end ),0) R20K_R2S_TOTAL,
        nvl(sum(case when REPLACE(a.AMOUNT,',','.') between 10000 and 19999  and a.CASH_ACCOUNT_ID=0 then REPLACE(a.AMOUNT,',','.') end ),0) R20K_R2S_AMOUNT,
                
        nvl(sum(case when REPLACE(a.AMOUNT,',','.')  between 20000 and 49999  and a.CASH_ACCOUNT_ID=0 then 1 end ),0) R50K_R2S_TOTAL,
        nvl(sum(case when REPLACE(a.AMOUNT,',','.') between  20000 and 49999  and a.CASH_ACCOUNT_ID=0 then REPLACE(a.AMOUNT,',','.') end ),0) R50K_R2S_AMOUNT,
                
        nvl(sum(case when REPLACE(a.AMOUNT,',','.')  between 50000 and 99999  and a.CASH_ACCOUNT_ID=0 then 1 end ),0) R100K_R2S_TOTAL,
        nvl(sum(case when REPLACE(a.AMOUNT,',','.')  between 50000 and 99999  and a.CASH_ACCOUNT_ID=0 then REPLACE(a.AMOUNT,',','.') end ),0) R100K_R2S_AMOUNT,
                
        nvl(sum(case when REPLACE(a.AMOUNT,',','.')  >= 100000 and a.CASH_ACCOUNT_ID=0 then 1 end ),0) RPLUSDE100K_R2S_TOTAL,
        nvl(sum(case when REPLACE(a.AMOUNT,',','.')  >= 100000   and a.CASH_ACCOUNT_ID=0 then REPLACE(a.AMOUNT,',','.') end ),0) RPLUSDE100K_R2S_AMOUNT,
        a.UTC_TIMESTAMP DATE_REFILL,
        SUBSTR(UTC_TIMESTAMP,12,2) DATE_REFILL_HOUR        
        FROM  IT_MIS_DR_ERS_REFILL_CELLID2 a, IT_ROAMING_PARTNER_IMSI b   
        WHERE  substr(REGEXP_SUBSTR (a.CELL_IDENTIFIER, '[^-]+')||SUBSTR((a.CELL_IDENTIFIER),-(length(a.CELL_IDENTIFIER)-(length(REGEXP_SUBSTR (a.CELL_IDENTIFIER, '[^-]+'))+1)),(length(a.CELL_IDENTIFIER)-(length(REGEXP_SUBSTR (a.CELL_IDENTIFIER, '[^-]+'))+1))),1,5)=substr(trim(b.CODE_COUNTRY_OPERATOR(+)),1,5)
        and a.CELL_IDENTIFIER like'%-%' 
        GROUP BY trim(b.CODE_COUNTRY_OPERATOR(+)) ,
        b.ROAMING_PARTNER_NAME||' / '||b.VPMN_COUNTRY_NAME,
        a.SERVICE_CLASS_NAME,
        a.SERVED_MSISDN,
        a.CASH_ACCOUNT_ID,
        a.UTC_TIMESTAMP,
        SUBSTR(a.UTC_TIMESTAMP,12,2);
        commit;
          
        insert into  IT_MIS_DR_R2S_LOAD_AREA_RPT2 
        SELECT  VILLE,
        COMMUNES,
        GOUVERNORATS,
        REGION_NATURELLE,
        sum(R500_R2S_TOTAL)+sum(R1K_R2S_TOTAL)+sum(R5K_R2S_TOTAL)+sum(R10K_R2S_TOTAL)+sum(R20K_R2S_TOTAL)+sum(R50K_R2S_TOTAL)+sum(R100K_R2S_TOTAL)+sum(RPLUSDE100K_R2S_TOTAL) R2S_TOTAL,
        sum(R500K_R2S_AMOUNT)+sum(R1K_R2S_AMOUNT)+sum(R5K_R2S_AMOUNT)+ sum(R10K_R2S_AMOUNT)+sum(R20K_R2S_AMOUNT)+sum(R50K_R2S_AMOUNT)+sum(R100K_R2S_AMOUNT)+ sum(RPLUSDE100K_R2S_AMOUNT) R2S_TOTAL_AMOUNT,
        sum(R500_R2S_TOTAL)  R500_R2S_TOTAL,
        sum(R500K_R2S_AMOUNT) R500K_R2S_AMOUNT,
        sum(R1K_R2S_TOTAL) R1K_R2S_TOTAL,
        sum(R1K_R2S_AMOUNT) R1K_R2S_AMOUNT,
        --        sum(R2K_R2S_TOTAL) R2K_R2S_TOTAL,
        --        sum(R2K_R2S_AMOUNT) R2K_R2S_AMOUNT,
        sum(R5K_R2S_TOTAL) R5K_R2S_TOTAL,
        sum(R5K_R2S_AMOUNT) R5K_R2S_AMOUNT,
        sum(R10K_R2S_TOTAL) R10K_R2S_TOTAL,
        sum(R10K_R2S_AMOUNT) R10K_R2S_AMOUNT,
        sum(R20K_R2S_TOTAL) R20K_R2S_TOTAL,
        sum(R20K_R2S_AMOUNT) R20K_R2S_AMOUNT,
        sum(R50K_R2S_TOTAL) R50K_R2S_TOTAL,
        sum(R50K_R2S_AMOUNT) R50K_R2S_AMOUNT,
        sum(R100K_R2S_TOTAL) R100K_R2S_TOTAL,
        sum(R100K_R2S_AMOUNT) R100K_R2S_AMOUNT,
        sum(RPLUSDE100K_R2S_TOTAL) RPLUSDE100K_R2S_TOTAL,
        sum(RPLUSDE100K_R2S_AMOUNT) RPLUSDE100K_R2S_AMOUNT, 
        TO_DATE(SUBSTR(DATE_REFILL,1,10),'DD/MM/YYYY') DATE_REFILL,
        DATE_REFILL_HOUR
        FROM  IT_MIS_DR_R2S_LOAD_AREA2 
        where TO_DATE(SUBSTR(DATE_REFILL,1,10),'DD/MM/YYYY')= record_cursor_table.date_name -- (to_char(sysdate-19,'dd/mm/yyyy'),'dd/mm/yyyy')
        GROUP BY VILLE,
        COMMUNES,
        GOUVERNORATS,
        REGION_NATURELLE,   
        TO_DATE(SUBSTR(DATE_REFILL,1,10),'DD/MM/YYYY'),
        DATE_REFILL_HOUR ;   
        commit;     
        
        
        
--        insert into IT_MIS_DR_R2S_LOAD_AREA_RPT2@MKDBLINK
--        select VILLE,COMMUNES,GOUVERNORATS,REGION_NATURELLE,sum(R2S_TOTAL) R2S_TOTAL,sum(R2S_TOTAL_AMOUNT) R2S_TOTAL_AMOUNT,sum(R500_R2S_TOTAL) R500_R2S_TOTAL,sum(R500K_R2S_AMOUNT) R500K_R2S_AMOUNT,
--        sum(R1K_R2S_TOTAL) R1K_R2S_TOTAL,sum(R1K_R2S_AMOUNT) R1K_R2S_AMOUNT,sum(R5K_R2S_TOTAL) R5K_R2S_TOTAL,sum(R5K_R2S_AMOUNT) R5K_R2S_AMOUNT,sum(R10K_R2S_TOTAL) R10K_R2S_TOTAL,sum(R10K_R2S_AMOUNT) R10K_R2S_AMOUNT,
--        sum(R20K_R2S_TOTAL) R20K_R2S_TOTAL,sum(R20K_R2S_AMOUNT) R20K_R2S_AMOUNT,sum(R50K_R2S_TOTAL) R50K_R2S_TOTAL,sum(R50K_R2S_AMOUNT) R50K_R2S_AMOUNT,sum(R100K_R2S_TOTAL) R100K_R2S_TOTAL,
--        sum(R100K_R2S_AMOUNT) R100K_R2S_AMOUNT,sum(RPLUSDE100K_R2S_TOTAL) RPLUSDE100K_R2S_TOTAL,sum(RPLUSDE100K_R2S_AMOUNT) RPLUSDE100K_R2S_AMOUNT,DATE_REFILL 
--        from IT_MIS_DR_R2S_LOAD_AREA_RPT2
--        where DATE_REFILL= record_cursor_table.date_name --to_date(to_char(sysdate-19,'dd/mm/yyyy'),'dd/mm/yyyy')
--        group by DATE_REFILL,VILLE,COMMUNES,GOUVERNORATS,REGION_NATURELLE;
--        commit;
                     
          /*
        DIFFERENCE ENTRE REVENU GLOBALE ET REVENUE LOCALISEE
        
        */
    
       select sum(ERS_TOTAL_AMOUNT)  into  revgbl 
       from IT_MK_ERS_REFILL_AMOUNT
       WHERE SUBSTR(TRANSACTION_DATE,1,8)= record_cursor_table.day_name2 ; --TO_CHAR(sysdate-19,'yyyymmdd');
       
         select sum(R2S_TOTAL_AMOUNT) into revloc
         from IT_MIS_DR_R2S_LOAD_AREA_RPT2 
         where DATE_REFILL=record_cursor_table.date_name ;--to_date(to_char(sysdate-19,'dd/mm/yyyy'),'dd/mm/yyyy');  
        
                if revgbl>revloc then
                 
                begin
                
                        insert into IT_MIS_DR_R2S_LOAD_AREA_RPT2      
                        select 'UNKNOWN' ,'UNKNOWN' ,'UNKNOWN' ,'UNKNOWN' ,0,revgbl-revloc,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,record_cursor_table.date_name ,'NA'  
                        from dual;
                        
                        commit;    
                        
--                          insert into IT_MIS_DR_R2S_LOAD_AREA_RPT2@MKDBLINK      
--                        select 'UNKNOWN' ,'UNKNOWN' ,'UNKNOWN' ,'UNKNOWN' ,0,revgbl-revloc,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,record_cursor_table.date_name -- ,'NA'  
--                        from dual;
--                        
--                        commit;    
                        
               end;
               end if;         
-----sript for regularisation

--select DATE_REFILL,sum(R2S_TOTAL_AMOUNT) from IT_MIS_DR_R2S_LOAD_AREA_RPT2
--where DATE_REFILL>= to_date(to_char(sysdate-31,'dd/mm/yyyy'),'dd/mm/yyyy')
--group by DATE_REFILL

--select * from IT_MIS_DR_R2S_LOAD_AREA_RPT2
--where DATE_REFILL= to_date(to_char(sysdate-19,'dd/mm/yyyy'),'dd/mm/yyyy')

--delete from IT_MIS_DR_R2S_LOAD_AREA_RPT2
--where DATE_REFILL>= to_date(to_char(sysdate-19,'dd/mm/yyyy'),'dd/mm/yyyy')

--select *  from IT_MIS_DR_R2S_LOAD_AREA2
--where TO_DATE(SUBSTR(DATE_REFILL,1,10),'DD/MM/YYYY')=to_date(to_char(sysdate-19,'dd/mm/yyyy'),'dd/mm/yyyy')

--delete  from IT_MIS_DR_R2S_LOAD_AREA2
--where TO_DATE(SUBSTR(DATE_REFILL,1,10),'DD/MM/YYYY')=to_date(to_char(sysdate-19,'dd/mm/yyyy'),'dd/mm/yyyy')

                
        end loop;  
        
               close cursor_table;
                   
     end;


END;
/


delete from IT_MIS_DR_R2S_LOAD_AREA_RPT2@MKDBLINK
where DATE_REFILL= to_date(to_char(sysdate-19,'dd/mm/yyyy'),'dd/mm/yyyy');
commit;

insert into IT_MIS_DR_R2S_LOAD_AREA_RPT2@MKDBLINK
select * from IT_MIS_DR_R2S_LOAD_AREA_RPT2
where DATE_REFILL= to_date(to_char(sysdate-19,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;


delete  from IT_MIS_DR_R2S_LOAD_AREA2@MKDBLINK
where TO_DATE(SUBSTR(DATE_REFILL,1,10),'DD/MM/YYYY')=to_date(to_char(sysdate-19,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

insert into IT_MIS_DR_R2S_LOAD_AREA2@MKDBLINK
select * from IT_MIS_DR_R2S_LOAD_AREA2
where TO_DATE(SUBSTR(DATE_REFILL,1,10),'DD/MM/YYYY')=to_date(to_char(sysdate-19,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;


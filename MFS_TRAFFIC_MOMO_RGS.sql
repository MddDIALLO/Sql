-- drop table IT_MIS_MFS_TRAFFIC_MOMO_RGS cascade constraints purge;

create table IT_MIS_MFS_TRAFFIC_MOMO_RGS as 
SELECT to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy') REPORT_DATE,
       to_char(sysdate-31,'yyyy-mm-dd') || ' ---> '||to_char(sysdate-1,'yyyy-mm-dd') Period,              
         a.MSISDN,
          a.CASH_IN_TOTAL_TRANSACTION,
          a.CASH_IN_TRANSACTION_AMOUNT,
          a.CASH_OUT_TOTAL_TRANSACTION,
          a.CASH_OUT_TRANSACTION_AMOUNT,
          a.CASH_OUT_FEE,
          a.CASH_OUT_ATM_TOTAL_TRANSACTION,
          a.CASH_OUT_ATM_TRANSACT_AMOUNT,
          a.CASH_OUT_ATM_FEE,
          a.BILL_PAYMT_TOTAL_TRANSACTION,
          a.BILL_PAYMT_TRANSACTION_AMOUNT,
          a.BILL_PAYMT_FEE,
          a.P2P_TOTAL_TRANSACTION,
          a.P2P_TRANSACTION_AMOUNT,
          a.P2P_FEE,
          a.INT_TRANSFER_TOTAL_TRANSACTION,
          a.INT_TRANSFER_TRANSACT_AMOUNT,
          a.INT_TRANSFER_FEE,
          a.BANK_2WALLET_TOTAL_TRANSACTION,
          a.BANK_2WALLET_TRANSACTION_AMNT,
          a.WALLET_2BANK_TOTAL_TRANSACTION,
          a.WALLET_2BANK_TRANSACTION_AMNT,
          a.WALLET_2BANK_FEE,          
          a.AIRTIME_TOTAL_TRANSACTION,
          a.AIRTIME_TRANSACTION_AMOUNT, 
          b.DATA_BUNDLE440_TYPE,
          b.TOTAL_DATA_BUNDLE_VIA_440,
          b.AMOUNT_DATA_BUNDLE_VIA_440, 
          e.DATA_BUNDLE100_TYPE, 
          e.TOTAL_DATA_BUNDLE_VIA_100,
          e.AMOUNT_DATA_BUNDLE_VIA_100, 
          f.BUNDLE_SMS_TYPE,
          f.TOTAL_DATA_BUNDLE_SMS,
          f.AMOUNT_DATA_BUNDLE_SMS,  
          g.EVD_TYPE,
          g.TOTAL_EVD_BUYED,
          g.AMOUNT_EVD_BUYED,     
          a.TOTAL_MFS_REVENUE   
from (select MSISDN,
         SUM(CASH_IN_TOTAL_TRANSACTION) CASH_IN_TOTAL_TRANSACTION,
          SUM(CASH_IN_TRANSACTION_AMOUNT) CASH_IN_TRANSACTION_AMOUNT,
          SUM(CASH_OUT_TOTAL_TRANSACTION) CASH_OUT_TOTAL_TRANSACTION,
          SUM(CASH_OUT_TRANSACTION_AMOUNT) CASH_OUT_TRANSACTION_AMOUNT,
          SUM(CASH_OUT_FEE) CASH_OUT_FEE,
          SUM(CASH_OUT_ATM_TOTAL_TRANSACTION) CASH_OUT_ATM_TOTAL_TRANSACTION,
          SUM(CASH_OUT_ATM_TRANSACT_AMOUNT) CASH_OUT_ATM_TRANSACT_AMOUNT,
          SUM(CASH_OUT_ATM_FEE) CASH_OUT_ATM_FEE,
          SUM(BILL_PAYMT_TOTAL_TRANSACTION) BILL_PAYMT_TOTAL_TRANSACTION,
          SUM(BILL_PAYMT_TRANSACTION_AMOUNT) BILL_PAYMT_TRANSACTION_AMOUNT,
          SUM(BILL_PAYMT_FEE) BILL_PAYMT_FEE,
          SUM(P2P_TOTAL_TRANSACTION) P2P_TOTAL_TRANSACTION,
          SUM(P2P_TRANSACTION_AMOUNT) P2P_TRANSACTION_AMOUNT,
          SUM(P2P_FEE) P2P_FEE,
          SUM(INT_TRANSFER_TOTAL_TRANSACTION) INT_TRANSFER_TOTAL_TRANSACTION,
          SUM(INT_TRANSFER_TRANSACT_AMOUNT) INT_TRANSFER_TRANSACT_AMOUNT,
          SUM(INT_TRANSFER_FEE) INT_TRANSFER_FEE,
          SUM(AIRTIME_TOTAL_TRANSACTION) AIRTIME_TOTAL_TRANSACTION,
          SUM(AIRTIME_TRANSACTION_AMOUNT) AIRTIME_TRANSACTION_AMOUNT,
          SUM(BANK_2WALLET_TOTAL_TRANSACTION) BANK_2WALLET_TOTAL_TRANSACTION,
          SUM(BANK_2WALLET_TRANSACTION_AMNT) BANK_2WALLET_TRANSACTION_AMNT,
          SUM(WALLET_2BANK_TOTAL_TRANSACTION) WALLET_2BANK_TOTAL_TRANSACTION,
          SUM(WALLET_2BANK_TRANSACTION_AMNT) WALLET_2BANK_TRANSACTION_AMNT,
          SUM(WALLET_2BANK_FEE) WALLET_2BANK_FEE,                     
          SUM(CASH_OUT_FEE)+SUM(CASH_OUT_ATM_FEE)+SUM(BILL_PAYMT_FEE)+SUM(P2P_FEE)+SUM(INT_TRANSFER_FEE)+sum(WALLET_2BANK_FEE) TOTAL_MFS_REVENUE                       
     FROM IT_MFS_GROUP_FINANCIAL_CVM
    WHERE to_date(DATETIME,'dd/mm/yyyy') between to_date(to_char(sysdate-31,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
    GROUP BY MSISDN) a,(select d.MSISDN,d.BUNDLE_TYPE DATA_BUNDLE440_TYPE,c.TOTAL_DATA_BUNDLE_VIA_440,c.AMOUNT_DATA_BUNDLE_VIA_440
                         from
                     (SELECT distinct MSISDN, 
                               BUNDLE_TYPE         
                         FROM IT_MFS_GROUP_FINANCIAL_CVM
                        WHERE to_date(DATETIME,'dd/mm/yyyy') between to_date(to_char(sysdate-31,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
                        and BUNDLE_TYPE not like'%@ecobank.EGN%'
                        and BUNDLE_TYPE like'%@databundle%'
                        --GROUP BY MSISDN,BUNDLE_TYPE 
                        ) d,
                     (SELECT distinct MSISDN,
                              sum(BUNDLE_TOTAL_BUYED) TOTAL_DATA_BUNDLE_VIA_440,
                              sum(BUNDLE_TOTAL_BUYED_AMOUNT) AMOUNT_DATA_BUNDLE_VIA_440        
                         FROM IT_MFS_GROUP_FINANCIAL_CVM
                        WHERE to_date(DATETIME,'dd/mm/yyyy') between to_date(to_char(sysdate-31,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
                        and BUNDLE_TYPE not like'%@ecobank.EGN%'
                        and BUNDLE_TYPE like'%@databundle%'
                        GROUP BY MSISDN 
                        ) c   
                        where c.MSISDN=d.MSISDN
    
                       ) b,
                       (select d.MSISDN,d.BUNDLE_TYPE DATA_BUNDLE100_TYPE,c.TOTAL_DATA_BUNDLE_VIA_100,c.AMOUNT_DATA_BUNDLE_VIA_100
                         from
                     (SELECT distinct MSISDN, 
                               BUNDLE_TYPE         
                         FROM IT_MFS_GROUP_FINANCIAL_CVM
                        WHERE to_date(DATETIME,'dd/mm/yyyy') between to_date(to_char(sysdate-31,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
                        and BUNDLE_TYPE not like'%@ecobank.EGN%'
                        and BUNDLE_TYPE like'%mtn.sp%(DATA_BUNDLE_BUYED%via%*100# )%'
                        --GROUP BY MSISDN,BUNDLE_TYPE 
                        ) d,
                     (SELECT distinct MSISDN,
                              sum(BUNDLE_TOTAL_BUYED) TOTAL_DATA_BUNDLE_VIA_100,
                              sum(BUNDLE_TOTAL_BUYED_AMOUNT) AMOUNT_DATA_BUNDLE_VIA_100        
                         FROM IT_MFS_GROUP_FINANCIAL_CVM
                        WHERE to_date(DATETIME,'dd/mm/yyyy') between to_date(to_char(sysdate-31,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
                        and BUNDLE_TYPE not like'%@ecobank.EGN%'
                        and BUNDLE_TYPE like'%mtn.sp%(DATA_BUNDLE_BUYED%via%*100# )%'
                        GROUP BY MSISDN 
                        ) c   
                        where c.MSISDN=d.MSISDN) e,
                        (select d.MSISDN,d.BUNDLE_TYPE BUNDLE_SMS_TYPE,c.TOTAL_DATA_BUNDLE_SMS,c.AMOUNT_DATA_BUNDLE_SMS
                         from
                     (SELECT distinct MSISDN, 
                               BUNDLE_TYPE         
                         FROM IT_MFS_GROUP_FINANCIAL_CVM
                        WHERE to_date(DATETIME,'dd/mm/yyyy') between to_date(to_char(sysdate-31,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
                        and BUNDLE_TYPE not like'%@ecobank.EGN%'
                        and BUNDLE_TYPE like'%@smspack.sp%'
                        --GROUP BY MSISDN,BUNDLE_TYPE 
                        ) d,
                     (SELECT distinct MSISDN,
                              sum(BUNDLE_TOTAL_BUYED) TOTAL_DATA_BUNDLE_SMS,
                              sum(BUNDLE_TOTAL_BUYED_AMOUNT) AMOUNT_DATA_BUNDLE_SMS        
                         FROM IT_MFS_GROUP_FINANCIAL_CVM
                        WHERE to_date(DATETIME,'dd/mm/yyyy') between to_date(to_char(sysdate-31,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
                        and BUNDLE_TYPE not like'%@ecobank.EGN%'
                        and BUNDLE_TYPE like'%@smspack.sp%'
                        GROUP BY MSISDN 
                        ) c   
                        where c.MSISDN=d.MSISDN) f,
                        (select d.MSISDN,d.BUNDLE_TYPE EVD_TYPE,c.TOTAL_EVD_BUYED,c.AMOUNT_EVD_BUYED
                         from
                     (SELECT distinct MSISDN, 
                               BUNDLE_TYPE         
                         FROM IT_MFS_GROUP_FINANCIAL_CVM
                        WHERE to_date(DATETIME,'dd/mm/yyyy') between to_date(to_char(sysdate-31,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
                        and BUNDLE_TYPE not like'%@ecobank.EGN%'
                        and BUNDLE_TYPE like'%@EVDGN.sp%'
                        --GROUP BY MSISDN,BUNDLE_TYPE 
                        ) d,
                     (SELECT distinct MSISDN,
                              sum(BUNDLE_TOTAL_BUYED) TOTAL_EVD_BUYED,
                              sum(BUNDLE_TOTAL_BUYED_AMOUNT) AMOUNT_EVD_BUYED        
                         FROM IT_MFS_GROUP_FINANCIAL_CVM
                        WHERE to_date(DATETIME,'dd/mm/yyyy') between to_date(to_char(sysdate-31,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
                        and BUNDLE_TYPE not like'%@ecobank.EGN%'
                        and BUNDLE_TYPE like'%@EVDGN.sp%'
                        GROUP BY MSISDN 
                        ) c   
                        where c.MSISDN=d.MSISDN) g
    where a.MSISDN=b.MSISDN(+)
    and a.MSISDN=e.MSISDN(+)
    and a.MSISDN=f.MSISDN(+)
    and a.MSISDN=g.MSISDN(+);
    
commit;    
 
grant select on IT_MIS_MFS_TRAFFIC_MOMO_RGS to public;

commit; 

/* Formatted on 26/04/2018 10:18:42 (QP5 v5.215.12089.38647) */
CREATE OR REPLACE FORCE VIEW REPORT_USER.IT_MIS_MOMO_TRAFFIC_RGS AS
select distinct a.*,b.BALANCE,b.ACCOUNTSTATUS,b.LASTACTIVITYTIME
from IT_MIS_MFS_TRAFFIC_MOMO_RGS a,(select distinct MSISDN,BALANCE,ACCOUNTSTATUS,LASTACTIVITYTIME
                                        from IT_EOD_USER_BALANCE
                                        WHERE MSISDN is not null
                                        and ACCOUNTTYPE='Mobile Money') b
where a.MSISDN=b.MSISDN;

commit;

SELECT DISTINCT 'D20180701' TRANSACTION_DATE,
               INITIATOR_MSISDN,RECEIVER_MSISDN,
               sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
                      FROM report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW PARTITION (D20180701_TDR_DETAIL_CELLID_NW)
                     WHERE --to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date('01/04/2018','dd/mm/yyyy') and to_date('04/07/2018','dd/mm/yyyy')
                               --and
                               UPPER (RESULT_STATUS) = 'SUCCESS'
                           AND UPPER (TRANSACTION_TYPE) = 'TRANSFER'
                           AND UPPER (SENDER_RESELLER_TYPE) LIKE 'SD%'
                           AND UPPER (RECEIVER_AMOUNT_VALUE) <> '\N'
                           AND UPPER (REQUEST_AMOUNT_VALUE) <> '\N'
                           and (INITIATOR_MSISDN='224664034207' or RECEIVER_MSISDN='224664034207')
                  GROUP BY TO_DATE (TO_CHAR (END_TIME, 'dd/mm/yyyy'),
                                    'dd/mm/yyyy'),
                           INITIATOR_MSISDN, 
                           RECEIVER_MSISDN      
UNION ALL
SELECT DISTINCT 'D20180702' TRANSACTION_DATE,
               INITIATOR_MSISDN,RECEIVER_MSISDN,
               sum(REQUEST_AMOUNT_VALUE/100) AMOUNT_SENT,sum(RECEIVER_AMOUNT_VALUE/100) AMOUNT_RECEIVED
                      FROM report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW  PARTITION (D20180702_TDR_DETAIL_CELLID_NW)
                     WHERE --to_date(to_char(END_TIME ,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date('01/04/2018','dd/mm/yyyy') and to_date('04/07/2018','dd/mm/yyyy')
                               --and
                               UPPER (RESULT_STATUS) = 'SUCCESS'
                           AND UPPER (TRANSACTION_TYPE) = 'TRANSFER'
                           AND UPPER (SENDER_RESELLER_TYPE) LIKE 'SD%'
                           AND UPPER (RECEIVER_AMOUNT_VALUE) <> '\N'
                           AND UPPER (REQUEST_AMOUNT_VALUE) <> '\N'
                           and (INITIATOR_MSISDN='224664034207' or RECEIVER_MSISDN='224664034207')
                  GROUP BY TO_DATE (TO_CHAR (END_TIME, 'dd/mm/yyyy'),
                                    'dd/mm/yyyy'),
                           INITIATOR_MSISDN, 
                           RECEIVER_MSISDN

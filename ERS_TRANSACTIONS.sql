select END_TIME TRANSACTION_DATE,INITIATOR_MSISDN,RECEIVER_MSISDN,TRANSACTION_PROFILE,RESULT_STATUS,
REQUEST_AMOUNT_VALUE/100 REQUEST_AMOUNT_VALUE,
RECEIVER_AMOUNT_VALUE/100 RECEIVER_AMOUNT_VALUE,
SENDER_BALANCE_VALUE_BEFORE/100 SENDER_BALANCE_VALUE_BEFORE,
SENDER_BALANCE_VALUE_AFTER/100 SENDER_BALANCE_VALUE_AFTER,
RECEIVER_BALANCE_VALUE_BEFORE/100 RECEIVER_BALANCE_VALUE_BEFORE,
RECEIVER_BALANCE_VALUE_AFTER/100 RECEIVER_BALANCE_VALUE_AFTER
FROM (SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190101_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190102_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190103_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190104_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190105_TDR_DETAIL_CELLID_NW)
union all
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190106_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190107_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190108_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190109_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190110_TDR_DETAIL_CELLID_NW)
union all
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190111_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190112_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190113_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190114_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190115_TDR_DETAIL_CELLID_NW)
union all
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190116_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190117_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190118_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190119_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190120_TDR_DETAIL_CELLID_NW)
union all
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190121_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190122_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190123_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190124_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190125_TDR_DETAIL_CELLID_NW)
union all
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190126_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190127_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190128_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190129_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190130_TDR_DETAIL_CELLID_NW)
union all 
SELECT * FROM REPORT_USER.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition(D20190131_TDR_DETAIL_CELLID_NW)
) where RECEIVER_MSISDN != '\N' AND REQUEST_AMOUNT_VALUE != '\N' AND RECEIVER_AMOUNT_VALUE != '\N' AND SENDER_BALANCE_VALUE_BEFORE != '\N'
AND INITIATOR_MSISDN IN('224666092018') or RECEIVER_MSISDN  IN('224666092018')
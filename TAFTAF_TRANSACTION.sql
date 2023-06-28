select TRANSACTION_DATE,
         SENDERMSISDN SENDER,
         SENDERRESELLERID SENDER_ACCOUNT_ID,
         SENDER_REGION RECEIVER_ACCOUNT_ID,
         PRODUCT RECEIVER,
         replace(RECEIVER_ID,'.',',')/100 AMOUNT_SENT,
         RECEIVER_TYPES/100 AMOUNT_RECEIVED from (

select   * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171001_TDR_DETAIL_CELLID)
         
union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171002_TDR_DETAIL_CELLID) 

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171003_TDR_DETAIL_CELLID) 

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171004_TDR_DETAIL_CELLID)

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171005_TDR_DETAIL_CELLID)

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171006_TDR_DETAIL_CELLID) 

union all

select   * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171007_TDR_DETAIL_CELLID) 

union all

select * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171008_TDR_DETAIL_CELLID) 

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171009_TDR_DETAIL_CELLID) 

union all

select * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171010_TDR_DETAIL_CELLID)

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171011_TDR_DETAIL_CELLID)

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171012_TDR_DETAIL_CELLID) 

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171013_TDR_DETAIL_CELLID) 

union all

select * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171014_TDR_DETAIL_CELLID) 

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171015_TDR_DETAIL_CELLID)

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171016_TDR_DETAIL_CELLID) 

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171017_TDR_DETAIL_CELLID)

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171018_TDR_DETAIL_CELLID)

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171019_TDR_DETAIL_CELLID) 

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171020_TDR_DETAIL_CELLID)

union all

select * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171021_TDR_DETAIL_CELLID)

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171022_TDR_DETAIL_CELLID)

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171023_TDR_DETAIL_CELLID)

union all

select * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171024_TDR_DETAIL_CELLID)


union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171025_TDR_DETAIL_CELLID)

union all

select * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171026_TDR_DETAIL_CELLID)

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171027_TDR_DETAIL_CELLID) 

union all

select * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171028_TDR_DETAIL_CELLID)

union all

select * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171029_TDR_DETAIL_CELLID)


union all

select   * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171030_TDR_DETAIL_CELLID)

union all

select * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLID partition (D20171031_TDR_DETAIL_CELLID)
)
where SENDERMSISDN in ('224669225260',
'224664034065',
'224664034207',
'224660747045',
'224661553462',
'224664758220',
'224660567786',
'224662302689'

)
and SENDERAMOUNT='SUCCESS'


select END_TIME,
         INITIATOR_ID SENDER,
         INITIATOR_RESELLER_ID SENDER_ACCOUNT_ID,
         RECEIVER_RESELLER_ID RECEIVER_ACCOUNT_ID,
         RECEIVER_ID RECEIVER,
         replace(REQUEST_AMOUNT_VALUE,',','.')/100 REQUEST_AMOUNT_VALUE,
         replace(RECEIVER_AMOUNT_VALUE,',','.')/100 AMOUNT_RECEIVED  
        from (

select   * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171201_TDR_DETAIL_CELLID_NW)
         
union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171202_TDR_DETAIL_CELLID_NW) 

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171203_TDR_DETAIL_CELLID_NW) 

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171204_TDR_DETAIL_CELLID_NW)

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171205_TDR_DETAIL_CELLID_NW)

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171206_TDR_DETAIL_CELLID_NW) 

union all

select   * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171207_TDR_DETAIL_CELLID_NW) 

union all

select * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171208_TDR_DETAIL_CELLID_NW) 

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171208_TDR_DETAIL_CELLID_NW) 

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171209_TDR_DETAIL_CELLID_NW) 

union all

select * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171210_TDR_DETAIL_CELLID_NW)

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171211_TDR_DETAIL_CELLID_NW)

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171212_TDR_DETAIL_CELLID_NW) 

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171213_TDR_DETAIL_CELLID_NW) 

union all

select * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171214_TDR_DETAIL_CELLID_NW) 

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171214_TDR_DETAIL_CELLID_NW) 

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171215_TDR_DETAIL_CELLID_NW)

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171216_TDR_DETAIL_CELLID_NW) 

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171217_TDR_DETAIL_CELLID_NW)

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171218_TDR_DETAIL_CELLID_NW)

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171219_TDR_DETAIL_CELLID_NW) 

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171220_TDR_DETAIL_CELLID_NW)

union all

select * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171221_TDR_DETAIL_CELLID_NW)

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171222_TDR_DETAIL_CELLID_NW)

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171223_TDR_DETAIL_CELLID_NW)

union all

select * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171224_TDR_DETAIL_CELLID_NW)


union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171225_TDR_DETAIL_CELLID_NW)

union all

select * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171226_TDR_DETAIL_CELLID_NW)

union all

select  * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171227_TDR_DETAIL_CELLID_NW) 

union all

select * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171228_TDR_DETAIL_CELLID_NW)

union all

select * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171229_TDR_DETAIL_CELLID_NW)


union all

select   * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171230_TDR_DETAIL_CELLID_NW)

union all

select * FROM  report_user.IT_MIS_ERS_TDR_DETAIL_CELLIDNW partition (D20171231_TDR_DETAIL_CELLID_NW)
)
where INITIATOR_ID in ('224669286902')
and RESULT_STATUS='SUCCESS'  
and SENDER_TYPE <>'\N'


------------GLOBALR PREPAID-----------------------------------------------------------------------------------
select 'Billed ON-NET' TYPE, sum(DURATION_ONNET)/60 DURATION
from
(

select sum(DURATION_ONNET_MA_CONTRIBUTION)+sum(DURATION_ONNET_CFW)+sum(DURATION_ONNET_MOC_CAPV2)+sum(DURATION_ONNET_MTC_CAPV2) DURATION_ONNET
from MCKINSEY_USER.IT_MK_BILLED_NON_BILLED_TBL
where ((MAIN_ACCOUNT_ID =0 and DEDICATED_ACCOUNT_ID not in (4,15) ))
and REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
 

union all

select sum(DURATION_ONNET)+sum(DURATION_ONNET_CFW)+sum(DURATION_ONNET_MOC_CAPV2)+sum(DURATION_ONNET_MTC_CAPV2) DURATION_ONNET
from MCKINSEY_USER.IT_MK_BILLED_NON_BILLED_TBL
where ((MAIN_ACCOUNT_ID is null and DEDICATED_ACCOUNT_ID in (4,15) ) 
or(MAIN_ACCOUNT_ID =0 and DEDICATED_ACCOUNT_ID is null )
or(MAIN_ACCOUNT_ID =0 and DEDICATED_ACCOUNT_ID in (4,15) ))
and REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')

union all

select sum(DURATION_ONNET)+sum(DURATION_ONNET_CFW)+sum(DURATION_ONNET_MOC_CAPV2)+sum(DURATION_ONNET_MTC_CAPV2) DURATION_ONNET
from MCKINSEY_USER.IT_MK_NON_BILLED_MN_TCT_Z
where BILLED_TYPE='BILLED_TCT_ONLY'
and REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')

)

union all

---------- NON Billed ON-NET 

select 'NON Billed ON-NET' TYPE, sum(DURATION_ONNET)/60 DURATION
from
(
--- NON BILLEZD MN for Call done on more than three Accounts 

select sum(DURATION_ONNET) DURATION_ONNET 
from MCKINSEY_USER.IT_MK_NON_BILLED_MN_3DA_TBL
where REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
--and SERVICE_CLASS_ID not in ( '5','6','15','30')  

union all

--- NON BILLEZD MN for Call done on DA only 
select sum(DURATION_ONNET)+sum(DURATION_ONNET_CFW) DURATION_ONNET
from MCKINSEY_USER.IT_MK_NON_BILLED_MN_TBL
where REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
and DEDICATED_ACCOUNT_ID not in (4,15) 
and MAIN_ACCOUNT_ID is null
--and SERVICE_CLASS_ID not in ( '5','6','15','30')  

union all

--- NON BILLEZD MN for Call done DA and main Account 
select sum(DURATION_ONNET_MA_DA_CONTRI)+sum(DURATION_ONNET_CFW) DURATION_ONNET
from MCKINSEY_USER.IT_MK_NON_BILLED_MN_TBL
where REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
and MAIN_ACCOUNT_ID = 0
--and SERVICE_CLASS_ID not in ( '5','6','15','30')  

union all

select sum(DURATION_ONNET_MTC_CAPV2) from MCKINSEY_USER.IT_MK_NON_BILLED_MN_TCT_Z 
where BILLED_TYPE='NO_BILLED_ZERO_COST'
and REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
--and SERVICE_CLASS_ID not in ( '5','6','15','30')  

)

union all

----------FREE ONNET

select 'FREE ONNET' TYPE, (sum(DURATION_ONNET) +sum(DURATION_OFFNET_GLOBAL)+sum(DURATION_INTERNATIONAL)+sum(DURATION_ONNET_CFW))/60 DURATION
from MCKINSEY_USER.IT_MK_NON_BILLED_MN_TCT_Z 
where BILLED_TYPE='NO_BILLED_ZERO_COST'
and REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
--and SERVICE_CLASS_ID not in ( '5','6','15','30')  

union all

---------- Billed OFF-NET 
select 'Billed OFF-NET' TYPE, sum(DURATION_ONFNET)/60 DURATION
from
(
select sum(DURATION_OFFNET_GLOBAL)+sum(DURATION_OFFNET_CFW_GLOBAL) DURATION_ONFNET
from MCKINSEY_USER.IT_MK_BILLED_NON_BILLED_TBL
where (MAIN_ACCOUNT_ID =0 and DEDICATED_ACCOUNT_ID not in (4,15) )
and REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
--and SERVICE_CLASS_ID not in ( '5','6','15','30')  

union all

select sum(DURATION_OFFNET_GLOBAL)+sum(DURATION_OFFNET_CFW_GLOBAL) DURATION_ONFNET  
from MCKINSEY_USER.IT_MK_BILLED_NON_BILLED_TBL
where ((MAIN_ACCOUNT_ID is null and DEDICATED_ACCOUNT_ID in (4,15) ) 
or(MAIN_ACCOUNT_ID =0 and  DEDICATED_ACCOUNT_ID is null )
or(MAIN_ACCOUNT_ID =0 and DEDICATED_ACCOUNT_ID in (4,15) ))
and REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
--and SERVICE_CLASS_ID not in ( '5','6','15','30')  

union all

select sum(DURATION_OFFNET_GLOBAL)+sum(DURATION_OFFNET_CFW_GLOBAL) DURATION_ONFNET  
from MCKINSEY_USER.IT_MK_NON_BILLED_MN_TCT_Z
where BILLED_TYPE='BILLED_TCT_ONLY'
and REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
--and SERVICE_CLASS_ID not in ( '5','6','15','30')  
                
)

                
union all


---------- Billed International  
select 'Billed International' TYPE, sum(DURATION_INTERNATIONAL)/60 DURATION
from
(
select sum(DURATION_INTERNATIONAL) DURATION_INTERNATIONAL 
from MCKINSEY_USER.IT_MK_BILLED_NON_BILLED_TBL
where (MAIN_ACCOUNT_ID =0 and DEDICATED_ACCOUNT_ID not in (4,15) )
and REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
--and SERVICE_CLASS_ID not in ( '5','6','15','30')  

union all

select sum(DURATION_INTERNATIONAL) DURATION_INTERNATIONAL
from MCKINSEY_USER.IT_MK_BILLED_NON_BILLED_TBL
where ((MAIN_ACCOUNT_ID is null and DEDICATED_ACCOUNT_ID in (4,15) ) 
or(MAIN_ACCOUNT_ID =0 and  DEDICATED_ACCOUNT_ID is null )
or(MAIN_ACCOUNT_ID =0 and DEDICATED_ACCOUNT_ID in (4,15) ))
and REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
--and SERVICE_CLASS_ID not in ( '5','6','15','30')  

union all

select sum(DURATION_INTERNATIONAL) DURATION_INTERNATIONAL
from MCKINSEY_USER.IT_MK_NON_BILLED_MN_TCT_Z
where BILLED_TYPE='BILLED_TCT_ONLY'
and REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
--and SERVICE_CLASS_ID not in ( '5','6','15','30')  
                
)

------------GLOBALR PREPAID SMS----
---- Billed ON-NET SMS
select 'Billed_ON_NET_SMS', sum(OPCALLS)+sum(PCALLS) Billed_ON_NET_SMS
from report_user.IT_MIS_CRS_REV_MONTHLY_FINAL3
where REPORT_DATE between '20190101' and '20190131'
and TRANSACTION_TYPE in ('SMS 1717',
'SMS 8102',
'SMS 8103',
'SMS Areeba',
'SMS DHL PACKAGE TRACKING',
'SMS FACEBOOK',
'SMS GUINEE GAMES',
'SMS ME2U 1020',
'SMS SYLI FOOT',
'SMS_RBT ACT')

UNION ALL

---- BILLED , NON BILLED  and FREE SMS 
select  charge_type,sum(total_sms) total_sms 
from report_user.IT_MIS_BILLED_NON_BILLED_SMS
where report_date between to_date('01/01/2019','dd/mm/yyyy') and  to_date('31/01/2019','dd/mm/yyyy')
group by charge_type

UNION ALL
----Free_ON_NET_SMS
select 'Free_ON_NET_SMS',sum(OPCALLS)+sum(PCALLS) Free_ON_NET_SMS 
from report_user.IT_MIS_CRS_REV_MONTHLY_FINAL3
where REPORT_DATE between '20190101' and '20190131'
and TRANSACTION_TYPE in (
'SMS 1050 SMS & INTERNET BUNDLE',
'SMS 1520',
'SMS 1530',
'SMS 1616 CALL ME',
'SMS 202 AREEBAPLAY',
'SMS VOTING',
'SMS WINBACK'
)

UNION ALL
----Billed_OFF_NET_Intern
select 'Billed_OFF_NET_Intern',sum(OPCALLS)+sum(PCALLS) Billed_OFF_NET_Intern
from report_user.IT_MIS_CRS_REV_MONTHLY_FINAL3
where REPORT_DATE between '20190101' and '20190131'
and TRANSACTION_TYPE in (
'SMS CELLCOM',
'SMS Intercell',
'SMS International',
'SMS ORANGE'
)

-----GLOBAL PREPAID REVENUE DATA 
select  charge_type,sum(total_duration) total_duration 
from report_user.IT_MIS_BILLED_NON_BILLED_DATA
where report_date between to_date('01/01/2019','dd/mm/yyyy') and  to_date('31/01/2019','dd/mm/yyyy')
group by charge_type


------------CONSUMER PREPAID----------------------------------------------------------------------------------------------

----------Billed ON-NET 
select 'Billed ON-NET' TYPE, sum(DURATION_ONNET)/60 DURATION
from
(
select sum(DURATION_ONNET_MA_CONTRIBUTION)+sum(DURATION_ONNET_CFW)+sum(DURATION_ONNET_MOC_CAPV2)+sum(DURATION_ONNET_MTC_CAPV2) DURATION_ONNET  
from MCKINSEY_USER.IT_MK_BILLED_NON_BILLED_TBL
where (MAIN_ACCOUNT_ID =0 and DEDICATED_ACCOUNT_ID not in (4,15) )
and REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
and SERVICE_CLASS_ID not in ( '5','6','15','30')  

union all

select sum(DURATION_ONNET)+sum(DURATION_ONNET_CFW)+sum(DURATION_ONNET_MOC_CAPV2)+sum(DURATION_ONNET_MTC_CAPV2) DURATION_ONNET 
from MCKINSEY_USER.IT_MK_BILLED_NON_BILLED_TBL
where ((MAIN_ACCOUNT_ID is null and DEDICATED_ACCOUNT_ID in (4,15) ) 
or(MAIN_ACCOUNT_ID =0 and  DEDICATED_ACCOUNT_ID is null )
or(MAIN_ACCOUNT_ID =0 and DEDICATED_ACCOUNT_ID in (4,15) ))
and REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
and SERVICE_CLASS_ID not in ( '5','6','15','30')  

union all

select sum(DURATION_ONNET)+sum(DURATION_ONNET_CFW)+sum(DURATION_ONNET_MOC_CAPV2)+sum(DURATION_ONNET_MTC_CAPV2) DURATION_ONNET 
from MCKINSEY_USER.IT_MK_NON_BILLED_MN_TCT_Z
where BILLED_TYPE='BILLED_TCT_ONLY'
and REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
and SERVICE_CLASS_ID not in ( '5','6','15','30')  
)

union all

---------- NON Billed ON-NET 

select 'NON Billed ON-NET' TYPE, sum(DURATION_ONNET)/60 DURATION
from
(
--- NON BILLEZD MN for Call done on more than three Accounts 
select sum(DURATION_ONNET) DURATION_ONNET 
from MCKINSEY_USER.IT_MK_NON_BILLED_MN_3DA_TBL
where REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
and SERVICE_CLASS_ID not in ( '5','6','15','30')  

union all

--- NON BILLEZD MN for Call done on DA only 
select sum(DURATION_ONNET)+sum(DURATION_ONNET_CFW) DURATION_ONNET
from MCKINSEY_USER.IT_MK_NON_BILLED_MN_TBL
where REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
and DEDICATED_ACCOUNT_ID not in (4,15) 
and MAIN_ACCOUNT_ID is null
and SERVICE_CLASS_ID not in ( '5','6','15','30')  

union all

--- NON BILLEZD MN for Call done DA and main Account 
select sum(DURATION_ONNET_MA_DA_CONTRI)+sum(DURATION_ONNET_CFW) DURATION_ONNET
from MCKINSEY_USER.IT_MK_NON_BILLED_MN_TBL
where REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
and MAIN_ACCOUNT_ID = 0
and SERVICE_CLASS_ID not in ( '5','6','15','30')  

union all

select sum(DURATION_ONNET_MTC_CAPV2) from MCKINSEY_USER.IT_MK_NON_BILLED_MN_TCT_Z 
where BILLED_TYPE='NO_BILLED_ZERO_COST'
and REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
and SERVICE_CLASS_ID not in ( '5','6','15','30')  

)

union all
----------FREE ONNET

select 'FREE ONNET' TYPE, (sum(DURATION_ONNET) +sum(DURATION_OFFNET_GLOBAL)+sum(DURATION_INTERNATIONAL)+sum(DURATION_ONNET_CFW))/60 DURATION
from MCKINSEY_USER.IT_MK_NON_BILLED_MN_TCT_Z 
where BILLED_TYPE='NO_BILLED_ZERO_COST'
and REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
and SERVICE_CLASS_ID not in ( '5','6','15','30')  

union all

---------- Billed OFF-NET 
select 'Billed OFF-NET' TYPE, sum(DURATION_ONFNET)/60 DURATION
from
(
select sum(DURATION_OFFNET_GLOBAL)+sum(DURATION_OFFNET_CFW_GLOBAL) DURATION_ONFNET  
from MCKINSEY_USER.IT_MK_BILLED_NON_BILLED_TBL
where (MAIN_ACCOUNT_ID =0 and DEDICATED_ACCOUNT_ID not in (4,15) )
and REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
and SERVICE_CLASS_ID not in ( '5','6','15','30')  

union all

select sum(DURATION_OFFNET_GLOBAL)+sum(DURATION_OFFNET_CFW_GLOBAL) DURATION_ONFNET  
from MCKINSEY_USER.IT_MK_BILLED_NON_BILLED_TBL
where ((MAIN_ACCOUNT_ID is null and DEDICATED_ACCOUNT_ID in (4,15) ) 
or(MAIN_ACCOUNT_ID =0 and  DEDICATED_ACCOUNT_ID is null )
or(MAIN_ACCOUNT_ID =0 and DEDICATED_ACCOUNT_ID in (4,15) ))
and REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
and SERVICE_CLASS_ID not in ( '5','6','15','30')  

union all

select sum(DURATION_OFFNET_GLOBAL)+sum(DURATION_OFFNET_CFW_GLOBAL) DURATION_ONFNET  
from MCKINSEY_USER.IT_MK_NON_BILLED_MN_TCT_Z
where BILLED_TYPE='BILLED_TCT_ONLY'
and REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
and SERVICE_CLASS_ID not in ( '5','6','15','30')  
                
)

union all               
                


---------- Billed International  
select 'Billed International' TYPE, sum(DURATION_INTERNATIONAL)/60
from
(
select sum(DURATION_INTERNATIONAL) DURATION_INTERNATIONAL 
from MCKINSEY_USER.IT_MK_BILLED_NON_BILLED_TBL
where (MAIN_ACCOUNT_ID =0 and DEDICATED_ACCOUNT_ID not in (4,15) )
and REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
and SERVICE_CLASS_ID not in ( '5','6','15','30')  

union all

select sum(DURATION_INTERNATIONAL) DURATION_INTERNATIONAL
from MCKINSEY_USER.IT_MK_BILLED_NON_BILLED_TBL
where ((MAIN_ACCOUNT_ID is null and DEDICATED_ACCOUNT_ID in (4,15) ) 
or(MAIN_ACCOUNT_ID =0 and  DEDICATED_ACCOUNT_ID is null )
or(MAIN_ACCOUNT_ID =0 and DEDICATED_ACCOUNT_ID in (4,15) ))
and REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
and SERVICE_CLASS_ID not in ( '5','6','15','30')  

union all

select sum(DURATION_INTERNATIONAL) DURATION_INTERNATIONAL
from MCKINSEY_USER.IT_MK_NON_BILLED_MN_TCT_Z
where BILLED_TYPE='BILLED_TCT_ONLY'
and REPORT_DATE between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
and SERVICE_CLASS_ID not in ( '5','6','15','30')  
                
)               


---PREPAID BUSINESS  SMS

select  charge_type,sum(total_sms) total_sms 
from report_user.IT_MIS_BUSINESS_BILLED_SMS
where report_date between to_date('01/01/2019','dd/mm/yyyy') and  to_date('31/01/2019','dd/mm/yyyy')
group by charge_type

---PREPAID BUSINESS  DATA

select  charge_type,sum(total_duration) total_duration 
from report_user.IT_MIS_BUSINESS_BILLED_DATA
where report_date between to_date('01/01/2019','dd/mm/yyyy') and  to_date('31/01/2019','dd/mm/yyyy')
group by charge_type

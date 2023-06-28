---CUG RGS90-------------------
select count(msisdn)  
from REPORT_USER.IT_MIS_RGS90_MOC_MTC_DTL_OCT18
where operator_name='Areeba' 
and report_date = to_date('09/12/2018','dd/mm/yyyy')
and MSISDN in(select '224'||ACCOUNT_MSISDN from REPORT_USER.it_dr_in_status_subscribers where account_class in(6,15))

---CUG RGS90-------------------
select count(msisdn)  
from REPORT_USER.IT_MIS_RGS90_MOC_MTC_DETAIL
where operator_name='Areeba' 
and report_date = to_date('09/12/2018','dd/mm/yyyy')
and MSISDN in(select '224'||ACCOUNT_MSISDN from REPORT_USER.it_dr_in_status_subscribers where account_class in('6','15'))

---CUG RGS30------------------
select count(msisdn)  
from REPORT_USER.IT_MIS_RGS30_MOC_MTC_DETAIL_H
where operator_name='Areeba' 
and report_date = to_date('09/12/2018','dd/mm/yyyy')
and MSISDN in(select '224'||ACCOUNT_MSISDN from REPORT_USER.it_dr_in_status_subscribers where account_class in('6','15'))

-------------ARPT POSTPAID RGS----------------------------------------
--RGS90
select count(*) 
from REPORT_USER.IT_MIS_RGS90_MOC_MTC_DETAIL a,IT_DR_IN_STATUS_SUBSCRIBERS b
where RGS_TYPE='RGS90_MOC_MTC'  
and Operator_name ='Areeba' 
and REPORT_DATE=to_date('31/12/2018','dd/mm/yyyy')
and '224'||account_msisdn=msisdn
and account_class=80

--RGS30
select count(*) 
from IT_MIS_RGS30_MOC_MTC_DETAIL_H a,IT_DR_IN_STATUS_SUBSCRIBERS b
where '224'||account_msisdn=msisdn
AND rgs_type='RGS30_MOC_MTC'
and account_class=80
and report_date=to_date('31/12/2018','dd/mm/yyyy');

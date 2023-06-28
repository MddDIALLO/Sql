---------------------RGS90

select count(*) from REPORT_USER.IT_MIS_RGS90_MOC_MTC_DETAIL 
where RGS_TYPE='RGS90_MOC_MTC'  
and Operator_name ='Areeba' 
and REPORT_DATE=to_date(to_char(sysdate-7,'dd/mm/yyyy'),'dd/mm/yyyy') 
and msisdn in (select '224'||ACCOUNT_MSISDN from REPORT_USER.IT_DR_IN_STATUS_SUBSCRIBERS
where ACCOUNT_CLASS=80)


-------------------------------------RGS30

select count(*) from REPORT_USER.IT_MIS_RGS30_MOC_MTC_DETAIL_H 
where RGS_TYPE='RGS30_MOC_MTC'  
and Operator_name ='Areeba' 
and REPORT_DATE=to_date(to_char(sysdate-7,'dd/mm/yyyy'),'dd/mm/yyyy') 
and msisdn in (select '224'||ACCOUNT_MSISDN from REPORT_USER.IT_DR_IN_STATUS_SUBSCRIBERS
where ACCOUNT_CLASS=80)

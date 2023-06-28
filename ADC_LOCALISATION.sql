-----ADC_LOCALISATION----------
select * 
from REPORT_USER.IT_MIS_MOC_MTC_MJRCELL a,REPORT_USER.IT_MIS_MSISDN_DMC b
where gsm=substr(msisdn,2)
and UMTS_900 ='1'

---MTN COMBO COMJAIM REVENUE REPORT-------------
select * from report_user.IT_COMBO_COMJAIM_TRANSAC
where DAY_DATE between to_date('01/09/2018','dd/MM/yyyy') and to_date('28/09/2018','dd/MM/yyyy')
order by DAY_DATE, HEUR
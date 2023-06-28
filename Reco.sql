--Suppression de la ligne sur FACTS--
DELETE FROM mckinsey_user.IT_MK_DAILY_FISRT_CALL_GLOBAL k
WHERE k.ACTIVATION_DATE BETWEEN to_date('17/07/2018','dd/mm/yyyy') and to_date('17/07/2018','dd/mm/yyyy');


select c.REPORT_DATE,b.periods,b.RGS90_GROSSADD,c.TOTAL_FIRST_CALL,b.RGS90_GROSSADD-c.TOTAL_FIRST_CALL TOTAL_RETOURNER 
from report_user.IT_MK_RGS_TRACKING_REPORT b,(SELECT a.REPORT_DATE REPORT_DATE,a.TOTAL_FIRST_CALL TOTAL_FIRST_CALL
                                    FROM report_user.IT_MK_DASHBOARD_REPORT_IN a
                                    where a.REPORT_DATE=TO_DATE('17/07/2018','dd/mm/yyyy')) c
where b.periods=c.REPORT_DATE
and b.OPERATORS='Areeba'
and b.periods =TO_DATE('17/07/2018','dd/mm/yyyy')

 
 select count(distinct MSISDN)
FROM  report_user.IT_MIS_RGS90_CHURN_GROSSADD
WHERE  RGS_TYPE = 'RECO'
AND report_date =TO_DATE('17/07/2018','dd/mm/yyyy')

select 1022-180 from dual

delete FROM  report_user.IT_MIS_RGS90_CHURN_GROSSADD
WHERE  RGS_TYPE = 'RECO'
AND report_date =TO_DATE('17/07/2018','dd/mm/yyyy')
AND rownum<=842


exec REPORT_USER.IT_MIS_GADD_DEL_4_REGUL1;
exec REPORT_USER.IT_MIS_TRACKING_FC_NEW_TMP; 

DELETE FROM IT_MK_DAILY_FC_REPART_GLOBAL@MKDBLINK p
WHERE p.ACTIVATION_DATE BETWEEN to_date('17/07/2018','dd/mm/yyyy') and to_date('17/07/2018','dd/mm/yyyy');

COMMIT;

insert into IT_MK_DAILY_FC_REPART_GLOBAL@MKDBLINK
select * FROM REPORT_USER.IT_MIS_DAILY_FC_REPART_GLOBAL p
WHERE p.ACTIVATION_DATE BETWEEN to_date('17/07/2018','dd/mm/yyyy') and to_date('17/07/2018','dd/mm/yyyy');

COMMIT;

DELETE FROM IT_MK_DAILY_FISRT_CALL_GLOBAL@MKDBLINK k
WHERE k.ACTIVATION_DATE BETWEEN to_date('17/07/2018','dd/mm/yyyy') and to_date('17/07/2018','dd/mm/yyyy');

COMMIT; 

insert into IT_MK_DAILY_FISRT_CALL_GLOBAL@MKDBLINK
select * FROM REPORT_USER.IT_MIS_DAILY_FISRT_CALL_GLOBAL k
WHERE k.ACTIVATION_DATE BETWEEN to_date('17/07/2018','dd/mm/yyyy') and to_date('17/07/2018','dd/mm/yyyy');

COMMIT; 

DELETE FROM IT_MK_DAILY_FIRST_CALL_BALANC2@MKDBLINK
WHERE daily_conso BETWEEN to_date('17/07/2018','dd/mm/yyyy') and to_date('17/07/2018','dd/mm/yyyy');

COMMIT;

insert into IT_MK_DAILY_FIRST_CALL_BALANC2@MKDBLINK
select * FROM REPORT_USER.IT_MK_DAILY_FIRST_CALL_BALANC2
WHERE daily_conso BETWEEN to_date('17/07/2018','dd/mm/yyyy') and to_date('17/07/2018','dd/mm/yyyy');

COMMIT;



SELECT  TO_DATE(a.NAME,'dd/mm/yyyy') NAME2,SUBSTR(a.NAME,1,2) day_name, to_char(to_date(a.name,'dd/mm/yyyy'),'yyyymmdd') NAME,substr(b.FULL_NAMES_ENGLISH,1,3)||substr(b.YEARS,-2,2) MONTHS
    FROM REPORT_USER.IT_DAY_TO_DAY a,REPORT_USER.IT_MONTH_TO_YEAR b
    where substr(a.name,-4,4)=b.YEARS
    AND trim(to_char(to_date(a.name,'dd/mm/yyyy'),'MONTH'))=trim(b.FULL_NAMES_ENGLISH)
   -- and to_date(a.name,'dd/mm/yyyy')  between to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy') 
    and to_date(name,'dd/mm/yyyy')  between  to_date('17/07/2018','dd/mm/yyyy') and to_date('17/07/2018','dd/mm/yyyy') 
    order by substr(a.name,1,2)
    
    
select to_char(to_date(a.name,'dd/mm/yyyy'),'MONTH')--substr(a.name,-4,4) --to_char(to_date(a.name,'dd/mm/yyyy'),'MONTH')
FROM REPORT_USER.IT_DAY_TO_DAY a
where to_date(name,'dd/mm/yyyy')  between  to_date('17/07/2018','dd/mm/yyyy') and to_date('17/07/2018','dd/mm/yyyy') 


select *
from REPORT_USER.IT_MONTH_TO_YEAR b    
where b.YEARS='2018'

----- MOMO RGS30 PER TRANSACTION TYPE
select * 
FROM report_user.IT_MIS_RGS_MOMO_TRASTYPE_STAT
WHERE REPORT_DATE=to_date(to_char(sysdate-1,'yyyy-mm-dd'),'yyyy-mm-dd');

----- MOMO AIRTIME LOAD PER SITE
select * from report_user.IT_MOMO_AIRTIME_TRANS_DAILY 
where DATETIME=to_char(sysdate-1,'yyyy-mm-dd')

----- MOMO TOTAL TRANSACTION PER SITE
select *  from report_user.IT_MOMO_TRANS_PER_SITE_CODE 
where SUBSTR(DATETIME,4,7)=TO_CHAR(sysdate-1,'mm/yyyy')

----- MOMO DEPOSIT TOTAL AMOUNT TRANSACTION PER SITE
select * from report_user.IT_MOMO_DEPOSIT_TRANS_DAILY c
where SUBSTR(c.DATETIME,1,7)=TO_CHAR(sysdate-1,'yyyy-mm')

----- MOMO CASH_IN CASH_OUT AMOUNT PER SITE
select * from report_user.IT_MOMO_CASH_IN_OUT_SITE_CODE b
where SUBSTR(b.DATETIME,4,7)=TO_CHAR(sysdate-1,'mm/yyyy')

----- MOMO PENETRATION AMOUNT PER SITE
select * from report_user.IT_MOMO_PENETRATION_PER_SITE
where SUBSTR(DATETIME,4,7)=TO_CHAR(sysdate-1,'mm/yyyy')

----- MOMO SUBSCRIBER RGS30 PER SITE
select * from report_user.IT_MIS_RGS_MOMO_DTL_PER_SITE
WHERE REPORT_DATE=to_date(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')

----- MOMO SUBSCRIBER DETAIL REPORT
select * from report_user.IT_MOMO_SUBSCRIBER_PER_SITE
where to_date(DATETIME,'dd/mm/yyyy')=to_date(TO_CHAR(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')

----- MOMO BUNDLE PURCHASSED DAIL REPORT
select * from report_user.IT_MIS_DAILY_MOMO_BUNDLE_BUYED
where to_date(DATETIME,'dd/mm/yyyy')=to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;

----- MOMO_FIRST_CASHIN_BULK_REG >=2000 REPORT (activation_date=cashin_date)
SELECT *
FROM report_user.IT_MIS_FIRST_CASHIN_BULK_REG

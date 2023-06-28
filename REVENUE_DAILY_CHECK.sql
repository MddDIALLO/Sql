-----------------------Prepaid  REVENUE without bonus
select * from report_user.IT_MIS_CRS_PREP_REV_CALCUL
where report_date between TO_CHAR(SYSDATE-28,'YYYYMMDD') and TO_CHAR(SYSDATE-1,'YYYYMMDD')

----- REVENUE MAIN ACCOUT(DA=0) AND OTHERS DsA (4,27,33 and 38)---------
select REPORT_DATE,replace(sum(replace(TOTAL_AMOUNT,',','.')),'.',',')
from report_user.IT_MIS_PREP_REVENUE_PER_ACC
where STAT_REPORT between to_date(to_char(SYSDATE-28,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(SYSDATE-1,'dd/mm/yyyy'),'dd/mm/yyyy')
and ACCOUNT_ID=38
group by REPORT_DATE
order by REPORT_DATE asc

select replace(sum(replace(TOTAL_AMOUNT,',','.')),'.',',')
from report_user.IT_MIS_PREP_REVENUE_PER_ACC
where STAT_REPORT between to_date('01/03/2019','dd/mm/yyyy') and to_date('31/03/2019','dd/mm/yyyy')
and ACCOUNT_ID not in (0,4,27,33,38,80,81,82)


------WITHOUT PER AREA REPORTDB
select REPORT_DATE,sum(TOTAL_SERVICE_FEE_AMOUNT)+sum(TOTAL_REVENUE) AMOUNT from report_user.IT_MIS_PRE_REV_USAGE_SRV_FEE_F
group by REPORT_DATE
order by REPORT_DATE desc


select REPORT_DATE,sum(nvl(TOTAL_REVENUE+TOTAL_SERVICE_FEE_AMOUNT,TOTAL_REVENUE)) TOTAL_REVENUE
from report_user.IT_MIS_PRE_REV_USAGE_SRV_FEE_F
where REPORT_DATE between to_date(to_char(SYSDATE-28,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(SYSDATE-1,'dd/mm/yyyy'),'dd/mm/yyyy')
group by REPORT_DATE
order by REPORT_DATE asc

----- RGS REPORTDB
select * from report_user.IT_MIS_RGS_STATS
where REPORT_DATE between to_date(to_char(SYSDATE-28,'dd/mm/yyyy'),'dd/mm/yyyy') and to_date(to_char(SYSDATE-1,'dd/mm/yyyy'),'dd/mm/yyyy')

------ DR--------------------
select * from report_user.IT_MIS_DR_INPUT_OUTPUT_TBL
where REPORT_DATE BETWEEN TRUNC(SYSDATE-28,'month') AND TO_DATE(TO_CHAR(SYSDATE-1,'DD/MM/YYYY'),'DD/MM/YYYY')

------DANS MCKINSEY ON LANCE CES SCRIPTS POUR LE MANUAL BALANCE-------------------
select distinct 'D20190301' PERIOD,SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190301_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190302' PERIOD,SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190302_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190303' PERIOD,SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190303_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190304' PERIOD,SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190304_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190305' PERIOD,SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190305_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190306' PERIOD,SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190306_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190307' PERIOD,SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190307_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190308' PERIOD,SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190308_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190309' PERIOD,SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190309_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190310' PERIOD,SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190310_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190311' PERIOD,
      SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190311_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190312' PERIOD,SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190312_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190313' PERIOD,SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190313_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190314' PERIOD,SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190314_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190315' PERIOD,SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190315_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190316' PERIOD,SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190316_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190317' PERIOD,
      SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190317_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190318' PERIOD,
      SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190318_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190319' PERIOD,
      SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190319_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190320' PERIOD,
      SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190320_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190321' PERIOD,
      SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190321_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190322' PERIOD,
      SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190322_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190323' PERIOD,
      SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190323_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190324' PERIOD,
      SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190324_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190325' PERIOD,
      SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190325_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190326' PERIOD,
      SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190326_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190327' PERIOD,
      SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190327_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190328' PERIOD,
      SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190328_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190329' PERIOD,
      SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190329_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190330' PERIOD,
      SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190330_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT
UNION ALL
select distinct 'D20190331' PERIOD,
      SERVICE_CLASS_CURRENT,sum(MAIN_AMOUNT)
from AIR_ACCOUNT_EVENTS_STG_MAIN  partition(D20190331_AIR_ACC_EV_STG_M) a 
where trim(ORIG_NODE_ID) in ('CBS_CBS','CLM_CLM','EXT_TestClient','EXT_EXT')
and  SERVICE_CLASS_CURRENT not in ('30','15','6')
GROUP BY SERVICE_CLASS_CURRENT

------DANS REPORTDB ON LANCE CES SCRIPTS POUR LES CLEARANCE----------------
SELECT  
ACCOUNT_ID,SUM(replace(TOTAL_AMOUNT,',','.')) Amount
---TO_DATE(SUBSTR(REPORT_DATE,1,10),'DD/MM/YY') Report_date
from report_user.IT_MIS_DR_CLEARANCENW1
where ACCOUNT_ID not in (81,101,80,82,102)
and length(ACCOUNT_ID)<4
and STAT_REPORT between  trunc(SYSDATE-28,'month')  and to_date(to_char(SYSDATE-1,'dd/mm/yyyy'),'dd/mm/yyyy')
GROUP BY ACCOUNT_ID


select CASH_ACCOUNT_ID ,
nvl(sum(amount),0) amount
FROM (select * from sdp_journal_entries partition(D20190301_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190302_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190303_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190304_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190305_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190306_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190307_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190308_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190309_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190310_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190311_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190312_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190313_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190314_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190315_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190316_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190317_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190318_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190319_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190320_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190321_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190322_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190323_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190324_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190325_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190326_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190327_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190328_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190329_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190330_ACC_JOU_ENT)
union all
select * from sdp_journal_entries partition(D20190331_ACC_JOU_ENT)
)
WHERE journal_type_id = 5
group by CASH_ACCOUNT_ID



-- Backup RGS MOC,MTC 30 and 90 fot the previous month
insert into IT_MIS_RGS30_MOC_DETAIL_HIST
select * from IT_MIS_RGS30_MOC_DETAIL
where rgs_type='RGS30_MOC';
 
commit;
 
insert into IT_MIS_RGS30_MTC_DETAIL_HIST
select * from IT_MIS_RGS30_MTC_DETAIL
where rgs_type='RGS30_MTC';
commit;
 
insert into IT_MIS_RGS30_MOC_MTC_DTL_HIST
select * from IT_MIS_RGS30_MOC_MTC_DETAIL_H
where rgs_type='RGS30_MOC_MTC'
and report_date=to_date('31/01/2019','dd/mm/yyyy');
commit;
 
 
insert into IT_MIS_RGS90_MOC_MTC_DTL_HIST
select * from IT_MIS_RGS90_MOC_MTC_DETAIL
where rgs_type='RGS90_MOC_MTC'
and report_date=to_date('31/01/2019','dd/mm/yyyy');
commit;
 
 
CREATE TABLE REPORT_USER.IT_MIS_RGS90_MOC_MTC_DTL_JAN19
(
  RGS_TYPE       VARCHAR2(20 BYTE),
  PERIOD         VARCHAR2(30 BYTE),
  MSISDN         VARCHAR2(20 BYTE),
  OPERATOR_NAME  VARCHAR2(20 BYTE),
  REPORT_DATE    DATE
)
TABLESPACE DATA
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING
NOCOMPRESS
NOCACHE
NOPARALLEL
MONITORING;
 
 
CREATE INDEX REPORT_USER.INDX_RGS90_REPOTR_DATE_JAN19 ON REPORT_USER.IT_MIS_RGS90_MOC_MTC_DTL_JAN19
(REPORT_DATE)
LOGGING
TABLESPACE "INDEX"
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;
 
 
-- Backup RGS90 for churn and Gross Add Calculation
insert into  IT_MIS_RGS90_MOC_MTC_DTL_JAN19
select * from IT_MIS_RGS90_MOC_MTC_DETAIL
where rgs_type='RGS90_MOC_MTC'
and report_date=to_date('31/01/2019','dd/mm/yyyy');
commit;
 
 
 
-------- Load RGS 30  into BI DB
 
---- Load RGS30 for Areeba
--insert into B_RGS30_AREEBA_1501
--select distinct msisdn 
--from REPORT_USER.IT_MIS_RGS30_MOC_MTC_DTL_HIST@MISDBLINK
--where report_date = to_date('31/01/2019','dd/mm/yyyy')
--and rgs_type='RGS30_MOC_MTC'
--and  operator_name ='Areeba';
 
--commit;
 
 
---- Load RGS30 for Orange
--insert into B_RGS30_ORANGE_1501
--select distinct msisdn 
--from REPORT_USER.IT_MIS_RGS30_MOC_MTC_DTL_HIST@MISDBLINK
--where report_date = to_date('31/01/2019','dd/mm/yyyy')
--and rgs_type='RGS30_MOC_MTC'
--and  operator_name ='Orange';
 
--commit;
 
 
---- Load RGS30 for Intercell 
--insert into B_RGS30_INTERCELL_1501
--select distinct msisdn 
--from REPORT_USER.IT_MIS_RGS30_MOC_MTC_DTL_HIST@MISDBLINK
--where report_date = to_date('31/01/2019','dd/mm/yyyy')
--and rgs_type='RGS30_MOC_MTC'
--and  operator_name ='Intercell';
 
--commit;
 
---- Load RGS30 for Cellcom
--insert into B_RGS30_CELLCOM_1501
--select distinct msisdn 
--from REPORT_USER.IT_MIS_RGS30_MOC_MTC_DTL_HIST@MISDBLINK
--where report_date = to_date('31/01/2019','dd/mm/yyyy')
--and rgs_type='RGS30_MOC_MTC'
--and  operator_name ='Cellcom';
 
--commit;


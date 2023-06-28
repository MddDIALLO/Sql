------------------ LOADER CELLID MAPPING FILE-----------
1) se connecter dans la base MCKINSEY puis vider les données de la table IT_MK_CELLID_FINAL_2013_BKP  
delete from MCKINSEY_USER.IT_MK_CELLID_FINAL_2013_BKP

2) puis recharger les données reçu des Sales 

3)verifier si nous avons des doublons de cellid dans les données reçu
select CELLID,count(*) 
from MCKINSEY_USER.IT_MK_CELLID_FINAL_2013_BKP
group by CELLID
having count(*) >1


4) s'il n'y a pas de doublons de cellid Exécuter les scripts suivants   

delete from MCKINSEY_USER.it_mk_cellid_final_2013;

commit;

MCKINSEY_USER.IT_MK_CELLID_FINAL_2013_BKP

insert into MCKINSEY_USER.it_mk_cellid_final_2013
select *
from MCKINSEY_USER.IT_MK_CELLID_FINAL_2013_BKP;

commit;

delete from REPORT_USER.it_mis_cellid_final_2013@REPORTDBDBLINK;

commit;

insert into REPORT_USER.it_mis_cellid_final_2013@REPORTDBDBLINK
select *
from MCKINSEY_USER.it_mk_cellid_final_2013;

commit;




-----------------------------------------------------------------

select CELLID,count(*) 
from mdndiallo.IT_MIS_CELLID_FINAL_TEMP@REPORTDBDBLINK
group by CELLID
having count(*) >1

delete from MCKINSEY_USER.IT_MK_CELLID_FINAL_2013_BKP
where CELLID not in (select CELLID from MCKINSEY_USER.IT_MK_CELLID_FINAL_2013_BKP);

commit;
  
insert into  MCKINSEY_USER.IT_MK_CELLID_FINAL_2013_BKP
select * 
from mdndiallo.IT_MIS_CELLID_FINAL_TEMP@REPORTDBDBLINK
where CELLID not in (select CELLID from MCKINSEY_USER.IT_MK_CELLID_FINAL_2013_BKP);

commit;

delete from MCKINSEY_USER.it_mk_cellid_final_2013
where CELLID not in (select CELLID from MCKINSEY_USER.it_mk_cellid_final_2013);

commit;

insert into MCKINSEY_USER.it_mk_cellid_final_2013
select *
from MCKINSEY_USER.IT_MK_CELLID_FINAL_2013_BKP
where CELLID not in (select CELLID from MCKINSEY_USER.it_mk_cellid_final_2013);

commit;

delete from REPORT_USER.it_mis_cellid_final_2013@REPORTDBDBLINK
where CELLID not in (select CELLID from REPORT_USER.it_mis_cellid_final_2013@REPORTDBDBLINK);

commit;

insert into REPORT_USER.it_mis_cellid_final_2013@REPORTDBDBLINK
select *
from MCKINSEY_USER.it_mk_cellid_final_2013
where CELLID not in (select CELLID from REPORT_USER.it_mis_cellid_final_2013@REPORTDBDBLINK);

commit;

--DANS REPORTDB POUR AXON--
delete from kyc.STG_CAPTUREDCELLID_REGION@AXEONDBLINK;

commit;

insert into kyc.STG_CAPTUREDCELLID_REGION@AXEONDBLINK
select CELLID,REGION_NATURELLE from REPORT_USER.IT_MIS_CELLID_FINAL_2013;

commit;

------------------CELLID NOT LOCALIZED------------------------
select MAJOR_CELLID,sum(CONTENT_REV)+sum(GPRS_REVENUE)+sum(SMS_REV)+sum(TOTAL_USAGE) TOTAL_USAGE
FROM IT_MIS_CONSO_SMSCONTGPRS_AREA
where MAJOR_CELLID in(
SELECT DISTINCT to_char(MAJOR_CELLID) CELLID 
FROM IT_MIS_CONSO_SMSCONTGPRS_AREA
WHERE TRANSACTION_DATE BETWEEN TO_DATE('01/02/2019','DD/MM/YYYY') AND  TO_DATE('19/02/2019','DD/MM/YYYY') 
and to_char(MAJOR_CELLID)!='0'
and to_char(MAJOR_CELLID) not like'%-%'
  
MINUS
  
SELECT DISTINCT CELLID 
FROM IT_MIS_CELLID_FINAL_2013)
group by MAJOR_CELLID


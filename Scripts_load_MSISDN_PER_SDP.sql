truncate table IT_DR_IN_STATUS_SUBSCRIBER_SDP;

alter table IT_MIS_DR_SDP_DUMP_ACCOUNT LOCATION (DR_DIR_SDPDUMP_FILES:'20052021_SDP07_Account.csv');
commit;
                        
insert into IT_DR_IN_STATUS_SUBSCRIBER_SDP 
select 'Grace',ACCOUNT_MSISDN,ACCOUNT_CLASS,ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy') FIRST_CALL_DATE,ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_FEE_PERIOD,ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_EXPIRY_DATE,'SDP07' SDP_NAME 
from IT_MIS_DR_SDP_DUMP_ACCOUNT 
where to_date(ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy')<>to_date('01/01/1970','dd/mm/yyyy') 
and to_date(sysdate,'dd/mm/yyyy') >=  to_date(ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy') and to_date(sysdate,'dd/mm/yyyy') < to_date(ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy') ; 
 
                                          
insert into IT_DR_IN_STATUS_SUBSCRIBER_SDP 
select 'Expired',ACCOUNT_MSISDN,ACCOUNT_CLASS,ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy') FIRST_CALL_DATE,ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_FEE_PERIOD,ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_EXPIRY_DATE,'SDP07' SDP_NAME 
from IT_MIS_DR_SDP_DUMP_ACCOUNT 
where to_date(ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy')<>to_date('01/01/1970','dd/mm/yyyy') 
and ACCOUNT_CLASS='41' and ACCOUNT_CLASS<>'NULL' ; 

insert into IT_DR_IN_STATUS_SUBSCRIBER_SDP 
select 'Installed', ACCOUNT_MSISDN,ACCOUNT_CLASS,ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy') FIRST_CALL_DATE,ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_FEE_PERIOD,ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_EXPIRY_DATE,'SDP07' SDP_NAME 
from IT_MIS_DR_SDP_DUMP_ACCOUNT 
where ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy')=to_date('01/01/1970','dd/mm/yyyy')  ; 

insert into IT_DR_IN_STATUS_SUBSCRIBER_SDP 
select 'Full Service', ACCOUNT_MSISDN,ACCOUNT_CLASS,ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy') FIRST_CALL_DATE,ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_FEE_PERIOD,ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_EXPIRY_DATE,'SDP07' SDP_NAME 
from IT_MIS_DR_SDP_DUMP_ACCOUNT 
where to_date(ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy')> to_date(sysdate,'dd/mm/yyyy') 
and ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy')<>to_date('01/01/1970','dd/mm/yyyy'); 

insert into IT_DR_IN_STATUS_SUBSCRIBER_SDP 
select 'Expired',ACCOUNT_MSISDN,ACCOUNT_CLASS,ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy') FIRST_CALL_DATE,ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_FEE_PERIOD,ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_EXPIRY_DATE,'SDP07' SDP_NAME 
from IT_MIS_DR_SDP_DUMP_ACCOUNT 
where to_date(ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy')<>to_date('01/01/1970','dd/mm/yyyy') 
and ACCOUNT_CLASS!='41'  and ACCOUNT_CLASS<>'NULL' 
and ACCOUNT_MSISDN not in(select ACCOUNT_MSISDN from IT_DR_IN_STATUS_SUBSCRIBER_SDP); 
                                         
COMMIT;           
                        
alter table IT_MIS_DR_SDP_DUMP_ACCOUNT LOCATION (DR_DIR_SDPDUMP_FILES:'20052021_SDP08_Account.csv');
commit;
                        
insert into IT_DR_IN_STATUS_SUBSCRIBER_SDP 
select 'Grace',ACCOUNT_MSISDN,ACCOUNT_CLASS,ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy') FIRST_CALL_DATE,ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_FEE_PERIOD,ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_EXPIRY_DATE,'SDP08' SDP_NAME 
from IT_MIS_DR_SDP_DUMP_ACCOUNT 
where to_date(ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy')<>to_date('01/01/1970','dd/mm/yyyy') 
and to_date(sysdate,'dd/mm/yyyy') >=  to_date(ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy') and to_date(sysdate,'dd/mm/yyyy') < to_date(ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy') ; 
 
                                          
insert into IT_DR_IN_STATUS_SUBSCRIBER_SDP 
select 'Expired',ACCOUNT_MSISDN,ACCOUNT_CLASS,ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy') FIRST_CALL_DATE,ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_FEE_PERIOD,ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_EXPIRY_DATE,'SDP08' SDP_NAME 
from IT_MIS_DR_SDP_DUMP_ACCOUNT 
where to_date(ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy')<>to_date('01/01/1970','dd/mm/yyyy') 
and ACCOUNT_CLASS='41' and ACCOUNT_CLASS<>'NULL' ; 

insert into IT_DR_IN_STATUS_SUBSCRIBER_SDP 
select 'Installed', ACCOUNT_MSISDN,ACCOUNT_CLASS,ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy') FIRST_CALL_DATE,ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_FEE_PERIOD,ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_EXPIRY_DATE,'SDP08' SDP_NAME 
from IT_MIS_DR_SDP_DUMP_ACCOUNT 
where ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy')=to_date('01/01/1970','dd/mm/yyyy')  ; 

insert into IT_DR_IN_STATUS_SUBSCRIBER_SDP 
select 'Full Service', ACCOUNT_MSISDN,ACCOUNT_CLASS,ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy') FIRST_CALL_DATE,ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_FEE_PERIOD,ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_EXPIRY_DATE,'SDP08' SDP_NAME 
from IT_MIS_DR_SDP_DUMP_ACCOUNT 
where to_date(ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy')> to_date(sysdate,'dd/mm/yyyy') 
and ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy')<>to_date('01/01/1970','dd/mm/yyyy'); 

insert into IT_DR_IN_STATUS_SUBSCRIBER_SDP 
select 'Expired',ACCOUNT_MSISDN,ACCOUNT_CLASS,ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy') FIRST_CALL_DATE,ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_FEE_PERIOD,ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_EXPIRY_DATE,'SDP08' SDP_NAME 
from IT_MIS_DR_SDP_DUMP_ACCOUNT 
where to_date(ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy')<>to_date('01/01/1970','dd/mm/yyyy') 
and ACCOUNT_CLASS!='41'  and ACCOUNT_CLASS<>'NULL' 
and ACCOUNT_MSISDN not in(select ACCOUNT_MSISDN from IT_DR_IN_STATUS_SUBSCRIBER_SDP); 
                                         
COMMIT;           
                        
alter table IT_MIS_DR_SDP_DUMP_ACCOUNT LOCATION (DR_DIR_SDPDUMP_FILES:'20052021_SDP11_Account.csv');
commit;
                        
insert into IT_DR_IN_STATUS_SUBSCRIBER_SDP 
select 'Grace',ACCOUNT_MSISDN,ACCOUNT_CLASS,ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy') FIRST_CALL_DATE,ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_FEE_PERIOD,ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_EXPIRY_DATE,'SDP11' SDP_NAME 
from IT_MIS_DR_SDP_DUMP_ACCOUNT 
where to_date(ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy')<>to_date('01/01/1970','dd/mm/yyyy') 
and to_date(sysdate,'dd/mm/yyyy') >=  to_date(ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy') and to_date(sysdate,'dd/mm/yyyy') < to_date(ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy') ; 
 
                                          
insert into IT_DR_IN_STATUS_SUBSCRIBER_SDP 
select 'Expired',ACCOUNT_MSISDN,ACCOUNT_CLASS,ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy') FIRST_CALL_DATE,ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_FEE_PERIOD,ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_EXPIRY_DATE,'SDP11' SDP_NAME 
from IT_MIS_DR_SDP_DUMP_ACCOUNT 
where to_date(ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy')<>to_date('01/01/1970','dd/mm/yyyy') 
and ACCOUNT_CLASS='41' and ACCOUNT_CLASS<>'NULL' ; 

insert into IT_DR_IN_STATUS_SUBSCRIBER_SDP 
select 'Installed', ACCOUNT_MSISDN,ACCOUNT_CLASS,ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy') FIRST_CALL_DATE,ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_FEE_PERIOD,ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_EXPIRY_DATE,'SDP11' SDP_NAME 
from IT_MIS_DR_SDP_DUMP_ACCOUNT 
where ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy')=to_date('01/01/1970','dd/mm/yyyy')  ; 

insert into IT_DR_IN_STATUS_SUBSCRIBER_SDP 
select 'Full Service', ACCOUNT_MSISDN,ACCOUNT_CLASS,ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy') FIRST_CALL_DATE,ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_FEE_PERIOD,ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_EXPIRY_DATE,'SDP11' SDP_NAME 
from IT_MIS_DR_SDP_DUMP_ACCOUNT 
where to_date(ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy')> to_date(sysdate,'dd/mm/yyyy') 
and ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy')<>to_date('01/01/1970','dd/mm/yyyy'); 

insert into IT_DR_IN_STATUS_SUBSCRIBER_SDP 
select 'Expired',ACCOUNT_MSISDN,ACCOUNT_CLASS,ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy') FIRST_CALL_DATE,ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_FEE_PERIOD,ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_EXPIRY_DATE,'SDP11' SDP_NAME 
from IT_MIS_DR_SDP_DUMP_ACCOUNT 
where to_date(ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy')<>to_date('01/01/1970','dd/mm/yyyy') 
and ACCOUNT_CLASS!='41'  and ACCOUNT_CLASS<>'NULL' 
and ACCOUNT_MSISDN not in(select ACCOUNT_MSISDN from IT_DR_IN_STATUS_SUBSCRIBER_SDP); 
                                         
COMMIT;           
                        
alter table IT_MIS_DR_SDP_DUMP_ACCOUNT LOCATION (DR_DIR_SDPDUMP_FILES:'20052021_SDP12_Account.csv');
commit;
                        
insert into IT_DR_IN_STATUS_SUBSCRIBER_SDP 
select 'Grace',ACCOUNT_MSISDN,ACCOUNT_CLASS,ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy') FIRST_CALL_DATE,ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_FEE_PERIOD,ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_EXPIRY_DATE,'SDP12' SDP_NAME 
from IT_MIS_DR_SDP_DUMP_ACCOUNT 
where to_date(ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy')<>to_date('01/01/1970','dd/mm/yyyy') 
and to_date(sysdate,'dd/mm/yyyy') >=  to_date(ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy') and to_date(sysdate,'dd/mm/yyyy') < to_date(ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy') ; 
 
                                          
insert into IT_DR_IN_STATUS_SUBSCRIBER_SDP 
select 'Expired',ACCOUNT_MSISDN,ACCOUNT_CLASS,ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy') FIRST_CALL_DATE,ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_FEE_PERIOD,ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_EXPIRY_DATE,'SDP12' SDP_NAME 
from IT_MIS_DR_SDP_DUMP_ACCOUNT 
where to_date(ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy')<>to_date('01/01/1970','dd/mm/yyyy') 
and ACCOUNT_CLASS='41' and ACCOUNT_CLASS<>'NULL' ; 

insert into IT_DR_IN_STATUS_SUBSCRIBER_SDP 
select 'Installed', ACCOUNT_MSISDN,ACCOUNT_CLASS,ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy') FIRST_CALL_DATE,ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_FEE_PERIOD,ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_EXPIRY_DATE,'SDP12' SDP_NAME 
from IT_MIS_DR_SDP_DUMP_ACCOUNT 
where ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy')=to_date('01/01/1970','dd/mm/yyyy')  ; 

insert into IT_DR_IN_STATUS_SUBSCRIBER_SDP 
select 'Full Service', ACCOUNT_MSISDN,ACCOUNT_CLASS,ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy') FIRST_CALL_DATE,ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_FEE_PERIOD,ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_EXPIRY_DATE,'SDP12' SDP_NAME 
from IT_MIS_DR_SDP_DUMP_ACCOUNT 
where to_date(ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy')> to_date(sysdate,'dd/mm/yyyy') 
and ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy')<>to_date('01/01/1970','dd/mm/yyyy'); 

insert into IT_DR_IN_STATUS_SUBSCRIBER_SDP 
select 'Expired',ACCOUNT_MSISDN,ACCOUNT_CLASS,ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy') FIRST_CALL_DATE,ACCOUNT_SFEE_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_FEE_PERIOD,ACCOUNT_SUP_EXPIRY_DATE+to_date('01/01/1970','dd/mm/yyyy') SERVICE_EXPIRY_DATE,'SDP12' SDP_NAME 
from IT_MIS_DR_SDP_DUMP_ACCOUNT 
where to_date(ACCOUNT_ACTIVATED+to_date('01/01/1970','dd/mm/yyyy'),'dd/mm/yyyy')<>to_date('01/01/1970','dd/mm/yyyy') 
and ACCOUNT_CLASS!='41'  and ACCOUNT_CLASS<>'NULL' 
and ACCOUNT_MSISDN not in(select ACCOUNT_MSISDN from IT_DR_IN_STATUS_SUBSCRIBER_SDP); 
                                         
COMMIT;           
                        
SELECT * FROM IT_DR_IN_STATUS_SUBSCRIBER_SDP
WHERE ACCOUNT_MSISDN IN(select ACCOUNT_MSISDN from IT_DR_IN_STATUS_SUBSCRIBER_SDP group by ACCOUNT_MSISDN having count(ACCOUNT_MSISDN)>1)
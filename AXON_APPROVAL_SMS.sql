DECLARE 

V_TOTAL  NUMBER;

V_TOTAL1  NUMBER;

V_TOTAL2  NUMBER;

V_TOTAL3  NUMBER;

V_TOTAL4  NUMBER;

V_TOTAL5  NUMBER;

V_TOTAL6  NUMBER;

V_TOTAL7  NUMBER;
V_TOT_CHECK NUMBER;

V_TOTAL8  NUMBER;

BEGIN 

--
--delete from IT_MIS_APPROVAL_TIME
--where REPORT_DATE = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy');
--
--commit;
--
--
--
--insert into IT_MIS_APPROVAL_TIME 
--            select '0-5 Mutes' NB_TIME,
--                    count(*) TOTAL_APPROVED_REJECTED,
--                    to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy') SUBMISSION_DATE,
--                    to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy') REPORT_DATE
--            from IT_MIS_AXON_REG_DTL 
--            where to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy') = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
--            and RECORD_ACTION !='REMOVE SIM'
--            -- and ficainfo.SUBMISSION_DATETIME=APPROVED_DATETIME
--            and CUSTOMER_MSISDN in (
--                                    select CUSTOMER_MSISDN--round(APPROVED_DATETIME-ficastore.DATETIME,2)*24,ficastore.DATETIME,APPROVED_DATETIME
--                                    from IT_MIS_AXON_REG_DTL 
--                                    where to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy') = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
--                                    and RECORD_ACTION !='REMOVE SIM'
--                                    and CUSTOMER_TYPE ='NEW'
--                                    group by CUSTOMER_MSISDN
--                                    having max(round(APPROVED_DATETIME-SUBMISSION_DATETIME,4)*24*60)>= 0 and max(round(APPROVED_DATETIME-SUBMISSION_DATETIME,4)*24*60)<5 
--                                    )
--            group by to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy')
--
--            union all
--
--            select '5-30 Mutes' NB_TIME,
--                    count(*) TOTAL_APPROVED_REJECTED,
--                    to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy') SUBMISSION_DATE,
--                    to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy') REPORT_DATE
--            from IT_MIS_AXON_REG_DTL 
--            where to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy') = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
--            and RECORD_ACTION !='REMOVE SIM'
--            -- and ficainfo.SUBMISSION_DATETIME=APPROVED_DATETIME
--            and CUSTOMER_MSISDN in (
--                                    select CUSTOMER_MSISDN--round(APPROVED_DATETIME-ficastore.DATETIME,2)*24,ficastore.DATETIME,APPROVED_DATETIME
--                                    from IT_MIS_AXON_REG_DTL 
--                                    where to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy') = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
--                                    and RECORD_ACTION !='REMOVE SIM'
--                                    and CUSTOMER_TYPE ='NEW'
--                                    group by CUSTOMER_MSISDN
--                                    having max(round(APPROVED_DATETIME-SUBMISSION_DATETIME,4)*24*60)>= 5 and max(round(APPROVED_DATETIME-SUBMISSION_DATETIME,4)*24*60)<30 
--                                    )
--            group by to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy')
--
--            union all
--
--            select '0.5-1 Hour' NB_TIME,
--                    count(*) TOTAL_APPROVED_REJECTED,
--                    to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy') SUBMISSION_DATE,
--                    to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy') REPORT_DATE
--            from IT_MIS_AXON_REG_DTL 
--            where to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy') = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
--            and RECORD_ACTION !='REMOVE SIM'
--            -- and ficainfo.SUBMISSION_DATETIME=APPROVED_DATETIME
--            and CUSTOMER_MSISDN in (
--                                    select CUSTOMER_MSISDN--round(APPROVED_DATETIME-ficastore.DATETIME,2)*24,ficastore.DATETIME,APPROVED_DATETIME
--                                    from IT_MIS_AXON_REG_DTL 
--                                    where to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy') = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
--                                    and RECORD_ACTION !='REMOVE SIM'
--                                    and CUSTOMER_TYPE ='NEW'
--                                    group by CUSTOMER_MSISDN
--                                    having max(round(APPROVED_DATETIME-SUBMISSION_DATETIME,4)*24*60)>= 30 and max(round(APPROVED_DATETIME-SUBMISSION_DATETIME,4)*24*60)<60 
--                                    )
--            group by to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy')
--
--            union all
--
--            select '1-2 hrs' NB_TIME,
--                    count(*) TOTAL_APPROVED_REJECTED,
--                    to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy') SUBMISSION_DATE,
--                    to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy') REPORT_DATE
--            from IT_MIS_AXON_REG_DTL 
--            where to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy') = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
--            and RECORD_ACTION !='REMOVE SIM'
--            -- and ficainfo.SUBMISSION_DATETIME=APPROVED_DATETIME
--            and CUSTOMER_MSISDN in (
--                                    select CUSTOMER_MSISDN--round(APPROVED_DATETIME-ficastore.DATETIME,2)*24,ficastore.DATETIME,APPROVED_DATETIME
--                                    from IT_MIS_AXON_REG_DTL 
--                                    where to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy') = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
--                                    and RECORD_ACTION !='REMOVE SIM'
--                                    and CUSTOMER_TYPE ='NEW'
--                                    group by CUSTOMER_MSISDN
--                                    having max(round(APPROVED_DATETIME-SUBMISSION_DATETIME,4)*24*60)>= 60 and max(round(APPROVED_DATETIME-SUBMISSION_DATETIME,4)*24*60)<120 
--                                    )
--            group by to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy')
--
--            union all
--
--            select '> 2 hrs' NB_TIME,
--                    count(*) TOTAL_APPROVED_REJECTED,
--                    to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy') SUBMISSION_DATE,
--                    to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy') REPORT_DATE
--            from IT_MIS_AXON_REG_DTL 
--            where to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy') = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
--            and RECORD_ACTION !='REMOVE SIM'
--            -- and ficainfo.SUBMISSION_DATETIME=APPROVED_DATETIME
--            and CUSTOMER_MSISDN in (
--                                    select CUSTOMER_MSISDN--round(APPROVED_DATETIME-ficastore.DATETIME,2)*24,ficastore.DATETIME,APPROVED_DATETIME
--                                    from IT_MIS_AXON_REG_DTL 
--                                    where to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy') = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
--                                    and RECORD_ACTION !='REMOVE SIM'
--                                    and CUSTOMER_TYPE ='NEW'
--                                    group by CUSTOMER_MSISDN
--                                    having max(round(APPROVED_DATETIME-SUBMISSION_DATETIME,4)*24*60)>= 120 
--                                    )
--            group by to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy')
--
--            union all
--
--            select 'TOTAL' NB_TIME,
--                    count(*) TOTAL_APPROVED_REJECTED,
--                    to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy') SUBMISSION_DATE,
--                    to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy') REPORT_DATE
--            from IT_MIS_AXON_REG_DTL 
--            where CUSTOMER_TYPE ='NEW'
--            --and APPROVAL_STATUS='OPEN'
--            and to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy') = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
--            and RECORD_ACTION !='REMOVE SIM'
--            -- and ficainfo.SUBMISSION_DATETIME=APPROVED_DATETIME          
--            group by to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy')
--
--            union all
--
--            select 'OPEN' NB_TIME,
--                    count(*) TOTAL_APPROVED_REJECTED,
--                    to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy') SUBMISSION_DATE,
--                    to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy') REPORT_DATE
--            from IT_MIS_AXON_REG_DTL 
--            where CUSTOMER_TYPE ='NEW'
--            and APPROVAL_STATUS='OPEN'
--            and to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy') = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
--            and RECORD_ACTION !='REMOVE SIM'
--            -- and ficainfo.SUBMISSION_DATETIME=APPROVED_DATETIME          
--            group by to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy')
--
--            union all
--
--            select 'APPROVED_AUTO' NB_TIME,
--                    count(*) TOTAL_APPROVED_REJECTED,
--                    to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy') SUBMISSION_DATE,
--                    to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy') REPORT_DATE
--            from IT_MIS_AXON_REG_DTL 
--            where CUSTOMER_TYPE ='NEW'
--            and APPROVAL_STATUS='APPROVED_AUTO'
--            and to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy') = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
--            and RECORD_ACTION !='REMOVE SIM'
--            -- and ficainfo.SUBMISSION_DATETIME=APPROVED_DATETIME          
--            group by to_date(to_char(SUBMISSION_DATETIME,'dd/mm/yyyy'),'dd/mm/yyyy');
--            
--commit;
--

            select sum(TOTAL_APPROVED_REJECTED) into V_TOTAL from IT_MIS_APPROVAL_TIME
            where SUBMISSION_DATE = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy') and NB_TIME not in( 'TOTAL','APPROVED_AUTO','OPEN');

            
            select count(*) into V_TOT_CHECK 
            from IT_MIS_APPROVAL_TIME
            where SUBMISSION_DATE = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
            and NB_TIME='0-5 Mutes';
            
           if V_TOT_CHECK>0 then

            select TOTAL_APPROVED_REJECTED into V_TOTAL1 
            from IT_MIS_APPROVAL_TIME
            where SUBMISSION_DATE = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
            and NB_TIME='0-5 Mutes';
            
            else V_TOTAL1:=0;
            
            end if;
            
            select count(*) into V_TOT_CHECK 
            from IT_MIS_APPROVAL_TIME
            where SUBMISSION_DATE = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
            and NB_TIME='5-30 Mutes';
            
           if V_TOT_CHECK>0 then

            select TOTAL_APPROVED_REJECTED into V_TOTAL5 
            from IT_MIS_APPROVAL_TIME
            where SUBMISSION_DATE = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
            and NB_TIME='5-30 Mutes';
            
            else V_TOTAL5:=0;
            
            end if;


--            select TOTAL_APPROVED_REJECTED into V_TOTAL6 
--            from IT_MIS_APPROVAL_TIME
--            where SUBMISSION_DATE = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
--            and NB_TIME='1-2 hrs';
            select count(*) into V_TOT_CHECK 
            from IT_MIS_APPROVAL_TIME
            where SUBMISSION_DATE = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
            and NB_TIME='0.5-1 Hour';
            
           if V_TOT_CHECK>0 then
            select TOTAL_APPROVED_REJECTED into V_TOTAL7 
            from IT_MIS_APPROVAL_TIME
            where SUBMISSION_DATE = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
            and NB_TIME='0.5-1 Hour';
            
            else V_TOTAL7:=0;
            
            end if;
           
           select count(*) into V_TOT_CHECK -- REPORT_DATE, TOTAL_APPROVED_REJECTED  
            from IT_MIS_APPROVAL_TIME
            where SUBMISSION_DATE = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
            and NB_TIME='1-2 hrs';
            
            if V_TOT_CHECK>0 then
             
            select distinct nvl(TOTAL_APPROVED_REJECTED,0) into V_TOTAL6
            from(
            select REPORT_DATE, TOTAL_APPROVED_REJECTED  
            from IT_MIS_APPROVAL_TIME
            where SUBMISSION_DATE = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
            and NB_TIME='1-2 hrs') a,
            (
            select REPORT_DATE from IT_MIS_APPROVAL_TIME
            where SUBMISSION_DATE = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
            ) b
            where a.REPORT_DATE(+)=b.REPORT_DATE;
     
     else V_TOTAL6:=0;
     
     end if;
--            select TOTAL_APPROVED_REJECTED into V_TOTAL8 
--            from IT_MIS_APPROVAL_TIME
--            where SUBMISSION_DATE = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
--            and NB_TIME='> 2 hrs';
            
          select count(*) into V_TOT_CHECK -- REPORT_DATE, TOTAL_APPROVED_REJECTED  
            from IT_MIS_APPROVAL_TIME
            where SUBMISSION_DATE = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
            and NB_TIME='> 2 hrs';
            
            if V_TOT_CHECK>0 then
             
            select distinct nvl(TOTAL_APPROVED_REJECTED,0) into V_TOTAL8
            from(
            select REPORT_DATE, TOTAL_APPROVED_REJECTED  
            from IT_MIS_APPROVAL_TIME
            where SUBMISSION_DATE = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
            and NB_TIME='> 2 hrs') a,
            (
            select REPORT_DATE from IT_MIS_APPROVAL_TIME
            where SUBMISSION_DATE = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
            ) b
            where a.REPORT_DATE(+)=b.REPORT_DATE;
            
            else V_TOTAL8:=0;
     
           end if;
           
            select TOTAL_APPROVED_REJECTED into V_TOTAL2
            from IT_MIS_APPROVAL_TIME
            where SUBMISSION_DATE = to_date(to_char(sysdate-4,'dd/mm/yyyy'),'dd/mm/yyyy')
            and NB_TIME='TOTAL';

            
              
 INSERT INTO RXSENDER@DBLINKUSSD(RXFROM,RXNUM,RXMSG1,SMS_FLAG,DATE_RECEIVE)
SELECT 'AXONGN','224664222518',to_char(sysdate-4,'yyyymmdd')|| CHR(13) || CHR(10) ||'TOTAL: '||V_TOTAL2||CHR(13) || CHR(10) ||'0-5 M: '||V_TOTAL1||' ('||trim(to_char(round(V_TOTAL1/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'5-30 M: '||V_TOTAL5||' ('||trim(to_char(round(V_TOTAL5/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'30-60 M: '||V_TOTAL7||' ('||trim(to_char(round(V_TOTAL7/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'60-120 M: '||V_TOTAL6||' ('||trim(to_char(round(V_TOTAL6/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'>120 M: '||V_TOTAL8||' ('||trim(to_char(round(V_TOTAL8/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) ' || CHR(13) || CHR(10) ||'QUE: '||trim(to_char(round(V_TOTAL2-V_TOTAL,0),'999G999G999G999G999')) ,'1',sysdate FROM dual; --FROM IT_MIS_DAILY_RGS_SMS_TEXT

COMMIT;     
  
 INSERT INTO RXSENDER@DBLINKUSSD(RXFROM,RXNUM,RXMSG1,SMS_FLAG,DATE_RECEIVE)
SELECT 'AXONGN','224664222517',to_char(sysdate-4,'yyyymmdd')|| CHR(13) || CHR(10) ||'TOTAL: '||V_TOTAL2||CHR(13) || CHR(10) ||'0-5 M: '||V_TOTAL1||' ('||trim(to_char(round(V_TOTAL1/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'5-30 M: '||V_TOTAL5||' ('||trim(to_char(round(V_TOTAL5/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'30-60 M: '||V_TOTAL7||' ('||trim(to_char(round(V_TOTAL7/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'60-120 M: '||V_TOTAL6||' ('||trim(to_char(round(V_TOTAL6/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'>120 M: '||V_TOTAL8||' ('||trim(to_char(round(V_TOTAL8/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) ' || CHR(13) || CHR(10) ||'QUE: '||trim(to_char(round(V_TOTAL2-V_TOTAL,0),'999G999G999G999G999')) ,'1',sysdate FROM dual; --FROM IT_MIS_DAILY_RGS_SMS_TEXT

COMMIT;  
 
 INSERT INTO RXSENDER@DBLINKUSSD(RXFROM,RXNUM,RXMSG1,SMS_FLAG,DATE_RECEIVE)
SELECT 'AXONGN','224664222556',to_char(sysdate-4,'yyyymmdd')|| CHR(13) || CHR(10) ||'TOTAL: '||V_TOTAL2||CHR(13) || CHR(10) ||'0-5 M: '||V_TOTAL1||' ('||trim(to_char(round(V_TOTAL1/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'5-30 M: '||V_TOTAL5||' ('||trim(to_char(round(V_TOTAL5/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'30-60 M: '||V_TOTAL7||' ('||trim(to_char(round(V_TOTAL7/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'60-120 M: '||V_TOTAL6||' ('||trim(to_char(round(V_TOTAL6/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'>120 M: '||V_TOTAL8||' ('||trim(to_char(round(V_TOTAL8/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) ' || CHR(13) || CHR(10) ||'QUE: '||trim(to_char(round(V_TOTAL2-V_TOTAL,0),'999G999G999G999G999')) ,'1',sysdate FROM dual; --FROM IT_MIS_DAILY_RGS_SMS_TEXT

COMMIT;

 INSERT INTO RXSENDER@DBLINKUSSD(RXFROM,RXNUM,RXMSG1,SMS_FLAG,DATE_RECEIVE)
SELECT 'AXONGN','224664222565',to_char(sysdate-4,'yyyymmdd')|| CHR(13) || CHR(10) ||'TOTAL: '||V_TOTAL2||CHR(13) || CHR(10) ||'0-5 M: '||V_TOTAL1||' ('||trim(to_char(round(V_TOTAL1/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'5-30 M: '||V_TOTAL5||' ('||trim(to_char(round(V_TOTAL5/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'30-60 M: '||V_TOTAL7||' ('||trim(to_char(round(V_TOTAL7/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'60-120 M: '||V_TOTAL6||' ('||trim(to_char(round(V_TOTAL6/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'>120 M: '||V_TOTAL8||' ('||trim(to_char(round(V_TOTAL8/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) ' || CHR(13) || CHR(10) ||'QUE: '||trim(to_char(round(V_TOTAL2-V_TOTAL,0),'999G999G999G999G999')) ,'1',sysdate FROM dual; --FROM IT_MIS_DAILY_RGS_SMS_TEXT

COMMIT;

 INSERT INTO RXSENDER@DBLINKUSSD(RXFROM,RXNUM,RXMSG1,SMS_FLAG,DATE_RECEIVE)
SELECT 'AXONGN','224664222544',to_char(sysdate-4,'yyyymmdd')|| CHR(13) || CHR(10) ||'TOTAL: '||V_TOTAL2||CHR(13) || CHR(10) ||'0-5 M: '||V_TOTAL1||' ('||trim(to_char(round(V_TOTAL1/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'5-30 M: '||V_TOTAL5||' ('||trim(to_char(round(V_TOTAL5/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'30-60 M: '||V_TOTAL7||' ('||trim(to_char(round(V_TOTAL7/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'60-120 M: '||V_TOTAL6||' ('||trim(to_char(round(V_TOTAL6/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'>120 M: '||V_TOTAL8||' ('||trim(to_char(round(V_TOTAL8/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) ' || CHR(13) || CHR(10) ||'QUE: '||trim(to_char(round(V_TOTAL2-V_TOTAL,0),'999G999G999G999G999')) ,'1',sysdate FROM dual; --FROM IT_MIS_DAILY_RGS_SMS_TEXT

COMMIT;

 INSERT INTO RXSENDER@DBLINKUSSD(RXFROM,RXNUM,RXMSG1,SMS_FLAG,DATE_RECEIVE)
SELECT 'AXONGN','224664222735',to_char(sysdate-4,'yyyymmdd')|| CHR(13) || CHR(10) ||'TOTAL: '||V_TOTAL2||CHR(13) || CHR(10) ||'0-5 M: '||V_TOTAL1||' ('||trim(to_char(round(V_TOTAL1/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'5-30 M: '||V_TOTAL5||' ('||trim(to_char(round(V_TOTAL5/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'30-60 M: '||V_TOTAL7||' ('||trim(to_char(round(V_TOTAL7/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'60-120 M: '||V_TOTAL6||' ('||trim(to_char(round(V_TOTAL6/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'>120 M: '||V_TOTAL8||' ('||trim(to_char(round(V_TOTAL8/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) ' || CHR(13) || CHR(10) ||'QUE: '||trim(to_char(round(V_TOTAL2-V_TOTAL,0),'999G999G999G999G999')) ,'1',sysdate FROM dual; --FROM IT_MIS_DAILY_RGS_SMS_TEXT

COMMIT;

 INSERT INTO RXSENDER@DBLINKUSSD(RXFROM,RXNUM,RXMSG1,SMS_FLAG,DATE_RECEIVE)
SELECT 'AXONGN','224664222057',to_char(sysdate-4,'yyyymmdd')|| CHR(13) || CHR(10) ||'TOTAL: '||V_TOTAL2||CHR(13) || CHR(10) ||'0-5 M: '||V_TOTAL1||' ('||trim(to_char(round(V_TOTAL1/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'5-30 M: '||V_TOTAL5||' ('||trim(to_char(round(V_TOTAL5/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'30-60 M: '||V_TOTAL7||' ('||trim(to_char(round(V_TOTAL7/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'60-120 M: '||V_TOTAL6||' ('||trim(to_char(round(V_TOTAL6/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'>120 M: '||V_TOTAL8||' ('||trim(to_char(round(V_TOTAL8/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) ' || CHR(13) || CHR(10) ||'QUE: '||trim(to_char(round(V_TOTAL2-V_TOTAL,0),'999G999G999G999G999')) ,'1',sysdate FROM dual; --FROM IT_MIS_DAILY_RGS_SMS_TEXT

COMMIT;

 INSERT INTO RXSENDER@DBLINKUSSD(RXFROM,RXNUM,RXMSG1,SMS_FLAG,DATE_RECEIVE)
SELECT 'AXONGN','224664222500',to_char(sysdate-4,'yyyymmdd')|| CHR(13) || CHR(10) ||'TOTAL: '||V_TOTAL2||CHR(13) || CHR(10) ||'0-5 M: '||V_TOTAL1||' ('||trim(to_char(round(V_TOTAL1/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'5-30 M: '||V_TOTAL5||' ('||trim(to_char(round(V_TOTAL5/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'30-60 M: '||V_TOTAL7||' ('||trim(to_char(round(V_TOTAL7/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'60-120 M: '||V_TOTAL6||' ('||trim(to_char(round(V_TOTAL6/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'>120 M: '||V_TOTAL8||' ('||trim(to_char(round(V_TOTAL8/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) ' || CHR(13) || CHR(10) ||'QUE: '||trim(to_char(round(V_TOTAL2-V_TOTAL,0),'999G999G999G999G999')) ,'1',sysdate FROM dual; --FROM IT_MIS_DAILY_RGS_SMS_TEXT

COMMIT;

 INSERT INTO RXSENDER@DBLINKUSSD(RXFROM,RXNUM,RXMSG1,SMS_FLAG,DATE_RECEIVE)
SELECT 'AXONGN','224664222150',to_char(sysdate-4,'yyyymmdd')|| CHR(13) || CHR(10) ||'TOTAL: '||V_TOTAL2||CHR(13) || CHR(10) ||'0-5 M: '||V_TOTAL1||' ('||trim(to_char(round(V_TOTAL1/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'5-30 M: '||V_TOTAL5||' ('||trim(to_char(round(V_TOTAL5/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'30-60 M: '||V_TOTAL7||' ('||trim(to_char(round(V_TOTAL7/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'60-120 M: '||V_TOTAL6||' ('||trim(to_char(round(V_TOTAL6/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'>120 M: '||V_TOTAL8||' ('||trim(to_char(round(V_TOTAL8/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) ' || CHR(13) || CHR(10) ||'QUE: '||trim(to_char(round(V_TOTAL2-V_TOTAL,0),'999G999G999G999G999')) ,'1',sysdate FROM dual; --FROM IT_MIS_DAILY_RGS_SMS_TEXT

COMMIT;

 INSERT INTO RXSENDER@DBLINKUSSD(RXFROM,RXNUM,RXMSG1,SMS_FLAG,DATE_RECEIVE)
SELECT 'AXONGN','224664222103',to_char(sysdate-4,'yyyymmdd')|| CHR(13) || CHR(10) ||'TOTAL: '||V_TOTAL2||CHR(13) || CHR(10) ||'0-5 M: '||V_TOTAL1||' ('||trim(to_char(round(V_TOTAL1/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'5-30 M: '||V_TOTAL5||' ('||trim(to_char(round(V_TOTAL5/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'30-60 M: '||V_TOTAL7||' ('||trim(to_char(round(V_TOTAL7/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'60-120 M: '||V_TOTAL6||' ('||trim(to_char(round(V_TOTAL6/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'>120 M: '||V_TOTAL8||' ('||trim(to_char(round(V_TOTAL8/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) ' || CHR(13) || CHR(10) ||'QUE: '||trim(to_char(round(V_TOTAL2-V_TOTAL,0),'999G999G999G999G999')) ,'1',sysdate FROM dual; --FROM IT_MIS_DAILY_RGS_SMS_TEXT

COMMIT;

 INSERT INTO RXSENDER@DBLINKUSSD(RXFROM,RXNUM,RXMSG1,SMS_FLAG,DATE_RECEIVE)
SELECT 'AXONGN','224664222349',to_char(sysdate-4,'yyyymmdd')|| CHR(13) || CHR(10) ||'TOTAL: '||V_TOTAL2||CHR(13) || CHR(10) ||'0-5 M: '||V_TOTAL1||' ('||trim(to_char(round(V_TOTAL1/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'5-30 M: '||V_TOTAL5||' ('||trim(to_char(round(V_TOTAL5/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'30-60 M: '||V_TOTAL7||' ('||trim(to_char(round(V_TOTAL7/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'60-120 M: '||V_TOTAL6||' ('||trim(to_char(round(V_TOTAL6/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'>120 M: '||V_TOTAL8||' ('||trim(to_char(round(V_TOTAL8/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) ' || CHR(13) || CHR(10) ||'QUE: '||trim(to_char(round(V_TOTAL2-V_TOTAL,0),'999G999G999G999G999')) ,'1',sysdate FROM dual; --FROM IT_MIS_DAILY_RGS_SMS_TEXT

COMMIT;

 INSERT INTO RXSENDER@DBLINKUSSD(RXFROM,RXNUM,RXMSG1,SMS_FLAG,DATE_RECEIVE)
SELECT 'AXONGN','224664222666',to_char(sysdate-4,'yyyymmdd')|| CHR(13) || CHR(10) ||'TOTAL: '||V_TOTAL2||CHR(13) || CHR(10) ||'0-5 M: '||V_TOTAL1||' ('||trim(to_char(round(V_TOTAL1/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'5-30 M: '||V_TOTAL5||' ('||trim(to_char(round(V_TOTAL5/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'30-60 M: '||V_TOTAL7||' ('||trim(to_char(round(V_TOTAL7/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'60-120 M: '||V_TOTAL6||' ('||trim(to_char(round(V_TOTAL6/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'>120 M: '||V_TOTAL8||' ('||trim(to_char(round(V_TOTAL8/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) ' || CHR(13) || CHR(10) ||'QUE: '||trim(to_char(round(V_TOTAL2-V_TOTAL,0),'999G999G999G999G999')) ,'1',sysdate FROM dual; --FROM IT_MIS_DAILY_RGS_SMS_TEXT

COMMIT;

 INSERT INTO RXSENDER@DBLINKUSSD(RXFROM,RXNUM,RXMSG1,SMS_FLAG,DATE_RECEIVE)
SELECT 'AXONGN','224664222342',to_char(sysdate-4,'yyyymmdd')|| CHR(13) || CHR(10) ||'TOTAL: '||V_TOTAL2||CHR(13) || CHR(10) ||'0-5 M: '||V_TOTAL1||' ('||trim(to_char(round(V_TOTAL1/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'5-30 M: '||V_TOTAL5||' ('||trim(to_char(round(V_TOTAL5/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'30-60 M: '||V_TOTAL7||' ('||trim(to_char(round(V_TOTAL7/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'60-120 M: '||V_TOTAL6||' ('||trim(to_char(round(V_TOTAL6/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) '  || CHR(13) || CHR(10) ||'>120 M: '||V_TOTAL8||' ('||trim(to_char(round(V_TOTAL8/V_TOTAL2*100,0),'999G999G999G999G999'))||'%) ' || CHR(13) || CHR(10) ||'QUE: '||trim(to_char(round(V_TOTAL2-V_TOTAL,0),'999G999G999G999G999')) ,'1',sysdate FROM dual; --FROM IT_MIS_DAILY_RGS_SMS_TEXT

COMMIT;

 
end;
end;
/

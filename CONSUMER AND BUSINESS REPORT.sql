/*select */ delete from REPORT_USER.IT_MIS_PREP_REV_USAGE_SRV_FEE
where REPORT_DATE=to_date('18/04/2021','dd/mm/yyyy'); commit;

alter table IT_MIS_PREP_REV_USAGE_DTL LOCATION (MK_DIR_USAGE_FILES:'WITHOUT20210418.csv'); commit;

insert into IT_MIS_PREP_REV_USAGE_SRV_FEE 
        select a.REPORT_DATE,
           a.MSISDN,
           VOICE_ONNET_REVENUE,
           VOICE_OFFNET_REVENUE,
           VOICE_INTER_REVENUE,
           VOICE_TOTAL_REVENUE,
           SMS_ONNET_REVENUE,
           SMS_OFFNET_REVENUE,
           SMS_INTER_REVENUE,
           SMS_TOTAL_REVENUE,
           GPRS_PAYG_REVENUE,
           GPRS_BUNDLE_REVENUE,
           GPRS_TOTAL_REVENUE,
           CONTENT_REVENUE,
           CALL_FORWARD_REVENUE,
           ORIG_CAPV2_REVENUE,
           TERMI_CAPV2_REVENUE,
           TOTAL_REVENUE,
           TOTAL_OTHERS_USAGE,
           TOTAL_USAGE,
           SMS_BUNDLE_FEE,
           THREEINONE_FEE,
           DAILY_BUNDLE_FEE,
           DATA_NVP_DEDUCTION,
           EASTER_FEE,
           HVC_BUNDLE_FEE,
           TOTAL_SERVICE_FEE_AMOUNT,
           COMBOWEEK_FEE,
           COMBODAILY_FEE,
           GTM_MICROBUNDLING_FEE,
           DURATION,
           a.SERVICE_CLASS,
           a.BONUS_ON_REFILL,
           a.WAOUH_ONNET_DA,
           a.WAOUH_ALL_DEST_DA
          from ( -------------TABLE OF PREPAID REVENUE AND USAGE FOR EACH MSISDN
                select to_date(REPORT_DATE,'dd/mm/yyyy') REPORT_DATE,
               MSISDN,
               sum(replace(VOICE_ONNET_REVENUE,'.',',')) VOICE_ONNET_REVENUE,
               sum(replace(VOICE_OFFNET_REVENUE,'.',',')) VOICE_OFFNET_REVENUE,
               sum(replace(VOICE_INTER_REVENUE,'.',',')) VOICE_INTER_REVENUE,
               sum(replace(VOICE_TOTAL_REVENUE,'.',',')) VOICE_TOTAL_REVENUE,
               sum(replace(SMS_ONNET_REVENUE,'.',',')) SMS_ONNET_REVENUE,
               sum(replace(SMS_OFFNET_REVENUE,'.',',')) SMS_OFFNET_REVENUE,
               sum(replace(SMS_INTER_REVENUE,'.',',')) SMS_INTER_REVENUE,
               sum(replace(SMS_TOTAL_REVENUE,'.',',')) SMS_TOTAL_REVENUE,
               sum(replace(GPRS_PAYG_REVENUE,'.',',')) GPRS_PAYG_REVENUE,
               sum(replace(GPRS_BUNDLE_REVENUE,'.',',')) GPRS_BUNDLE_REVENUE,
               sum(replace(GPRS_TOTAL_REVENUE,'.',',')) GPRS_TOTAL_REVENUE,
               sum(replace(CONTENT_REVENUE,'.',',')) CONTENT_REVENUE,
               sum(replace(CALL_FORWARD_REVENUE,'.',',')) CALL_FORWARD_REVENUE,
               sum(replace(ORIG_CAPV2_REVENUE,'.',',')) ORIG_CAPV2_REVENUE,
               sum(replace(TERMI_CAPV2_REVENUE,'.',',')) TERMI_CAPV2_REVENUE,
               sum(replace(TOTAL_REVENUE,'.',',')) TOTAL_REVENUE,
               sum(replace(TOTAL_OTHERS_USAGE,'.',',')) TOTAL_OTHERS_USAGE,       
               sum(replace(TOTAL_USAGE,'.',',')) TOTAL_USAGE,      
               sum(replace(DURATION,'.',',')) DURATION,
               SERVICE_CLASS_ID SERVICE_CLASS,
               sum(replace(BONUS_ON_REFILL,'.',',')) BONUS_ON_REFILL,
               sum(replace(WAOUH_ONNET_DA,'.',',')) WAOUH_ONNET_DA,
               sum(replace(WAOUH_ALL_DEST_DA,'.',',')) WAOUH_ALL_DEST_DA
               from IT_MIS_PREP_REV_USAGE_DTL
               group by REPORT_DATE,MSISDN,SERVICE_CLASS_ID
         ) a ,-------------TABLE OF SERVICE FEES DEDUCTION FOR EACH MSISDN
        (select SERVED_MSISDN MSISDN,nvl(sum(case when TRANSACTION_TYPE='SMS_BUNDLE_DEDUCTION' then abs(AMOUNT) end),0 ) SMS_BUNDLE_FEE,
             nvl(sum(case when TRANSACTION_TYPE='THREEINONE_DEDUCTION' then abs(AMOUNT) end),0  ) THREEINONE_FEE,
             nvl(sum(case when TRANSACTION_TYPE='DAILY_BUNDLE_DEDUCTION' then abs(AMOUNT) end),0  ) DAILY_BUNDLE_FEE,
             nvl(sum(case when TRANSACTION_TYPE='DATA_NVP_DEDUCTION' then abs(AMOUNT) end),0  ) DATA_NVP_DEDUCTION,
             nvl(sum(case when TRANSACTION_TYPE='TCT' then abs(AMOUNT) end),0  ) EASTER_FEE,
             nvl(sum(case when TRANSACTION_TYPE='WINBACK_DEDUCTION' then abs(AMOUNT) end),0  ) HVC_BUNDLE_FEE,
             nvl(sum(abs(AMOUNT)),0) TOTAL_SERVICE_FEE_AMOUNT,
             nvl(sum(case when TRANSACTION_TYPE='COMBOWEEK_DEDUCTION' then abs(AMOUNT) end),0  ) COMBOWEEK_FEE,
             nvl(sum(case when TRANSACTION_TYPE='COMBODAILY_DEDUCTION' then abs(AMOUNT) end),0  ) COMBODAILY_FEE,
             nvl(sum(case when TRANSACTION_TYPE='GTM_MICROBUNDLING_DEDUCTION' then abs(AMOUNT) end),0  ) GTM_MICROBUNDLING_FEE,
             REPORT_DATE
        from IT_MIS_PREP_REV_SRV_FEE_DTL
        group by SERVED_MSISDN,REPORT_DATE
        ) b
        where a.MSISDN=b.MSISDN(+)
        and a.REPORT_DATE=b.REPORT_DATE(+)
        --and b.REPORT_DATE=to_date('10/06/2015','dd/mm/yyyy')

        union all

        -------------------MSISDN WHO GENERATE ONLY SERVICE FEE
        select   REPORT_DATE,SERVED_MSISDN MSISDN,to_number('0'),to_number('0'),to_number('0'),to_number('0'),to_number('0'),to_number('0'),to_number('0'),to_number('0'),to_number('0'),to_number('0'),to_number('0'),to_number('0'),to_number('0'),to_number('0'),to_number('0'),to_number('0'),to_number('0'),to_number('0'),
         nvl(sum(case when TRANSACTION_TYPE='SMS_BUNDLE_DEDUCTION' then abs(AMOUNT) end),0 ) SMS_BUNDLE_FEE,
         nvl(sum(case when TRANSACTION_TYPE='THREEINONE_DEDUCTION' then abs(AMOUNT) end),0  ) DAILY_PACK_FEE,
         nvl(sum(case when TRANSACTION_TYPE='DAILY_BUNDLE_DEDUCTION' then abs(AMOUNT) end),0  ) DAILY_BUNDLE_FEE,
         nvl(sum(case when TRANSACTION_TYPE='DATA_NVP_DEDUCTION' then abs(AMOUNT) end),0  ) DATA_NVP_DEDUCTION,
         nvl(sum(case when TRANSACTION_TYPE='TCT' then abs(AMOUNT) end),0  ) EASTER_FEE,
         nvl(sum(case when TRANSACTION_TYPE='WINBACK_DEDUCTION' then abs(AMOUNT) end),0  ) HVC_BUNDLE_FEE,
         nvl(sum(abs(AMOUNT)),0) TOTAL_SERVICE_FEE_AMOUNT,
         nvl(sum(case when TRANSACTION_TYPE='COMBOWEEK_DEDUCTION' then abs(AMOUNT) end),0  ) COMBOWEEK_FEE,
         nvl(sum(case when TRANSACTION_TYPE='COMBODAILY_DEDUCTION' then abs(AMOUNT) end),0  ) COMBODAILY_FEE,
         nvl(sum(case when TRANSACTION_TYPE='GTM_MICROBUNDLING_DEDUCTION' then abs(AMOUNT) end),0  ) GTM_MICROBUNDLING_FEE,
         to_number('0'),
         SERVICE_CLASS,
         to_number('0'),
         to_number('0'),
         to_number('0')
        from IT_MIS_PREP_REV_SRV_FEE_DTL b
        where b.SERVED_MSISDN not in (select msisdn from IT_MIS_PREP_REV_USAGE_DTL a)
        and b.REPORT_DATE = to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
        group by SERVED_MSISDN,REPORT_DATE,SERVICE_CLASS;

        commit;
        
delete from REPORT_USER.IT_MIS_PRE_REV_USAGE_SRV_FEE_F
where REPORT_DATE=to_date('18/04/2021','dd/mm/yyyy'); commit;

insert into IT_MIS_PRE_REV_USAGE_SRV_FEE_F 
          ----   LOCATED PREPAID REVENUE, USAGE and SERVICE FEES  PER AREA 
          SELECT replace(a.MAJOR_CELLID,'-','') MAJOR_CELLID,b.CELLCODE,b.SITE_NAMES,b.CELLNAMES,b.CAP_CELID_3G, b.VILLE, b.GOUVERNORATS,b.REGION_NATURELLE, 
          sum(replace(VOICE_ONNET_REVENUE,'.',',')) VOICE_ONNET_REVENUE,
          sum(replace(VOICE_OFFNET_REVENUE,'.',',')) VOICE_OFFNET_REVENUE,
          sum(replace(VOICE_INTER_REVENUE,'.',',')) VOICE_INTER_REVENUE,          
          sum(replace(VOICE_TOTAL_REVENUE,'.',',')) VOICE_TOTAL_REVENUE,
          sum(replace(SMS_ONNET_REVENUE,'.',',')) SMS_ONNET_REVENUE,
          sum(replace(SMS_OFFNET_REVENUE,'.',',')) SMS_OFFNET_REVENUE,
          sum(replace(SMS_INTER_REVENUE,'.',',')) SMS_INTER_REVENUE,
          sum(replace(SMS_TOTAL_REVENUE,'.',',')) SMS_TOTAL_REVENUE,
          sum(replace(GPRS_TOTAL_REVENUE,'.',',')) GPRS_TOTAL_REVENUE,
          sum(replace(CONTENT_REVENUE,'.',',')) CONTENT_REVENUE,
          sum(replace(CALL_FORWARD_REVENUE,'.',',')) CALL_FORWARD_REVENUE,
          sum(replace(ORIG_CAPV2_REVENUE,'.',',')) ORIG_CAPV2_REVENUE,
          sum(replace(TERMI_CAPV2_REVENUE,'.',',')) TERMI_CAPV2_REVENUE,
          sum(replace(TOTAL_OTHERS_USAGE,'.',',')) TOTAL_OTHERS_USAGE,
          sum(replace(TOTAL_REVENUE,'.',',')) TOTAL_REVENUE,
          sum(replace(SMS_BUNDLE_FEE,'.',',')) SMS_BUNDLE_FEE,
          sum(replace(DAILY_BUNDLE_FEE,'.',',')) DAILY_BUNDLE_FEE,
          sum(replace(DATA_NVP_DEDUCTION,'.',',')) DATA_NVP_DEDUCTION,
          sum(replace(EASTER_FEE,'.',',')) EASTER_FEE,
          sum(replace(HVC_BUNDLE_FEE,'.',',')) HVC_BUNDLE_FEE,
          sum(replace(TOTAL_SERVICE_FEE_AMOUNT,'.',',')) TOTAL_SERVICE_FEE_AMOUNT,
          REPORT_DATE ,
          sum(replace(THREEINONE_FEE,'.',',')) THREEINONE_FEE,
          sum(replace(COMBOWEEK_FEE,'.',',')) COMBOWEEK_FEE,
          sum(replace(COMBODAILY_FEE,'.',',')) COMBODAILY_FEE,
          sum(replace(GTM_MICROBUNDLING_FEE,'.',',')) GTM_MICROBUNDLING_FEE,
          sum(replace(DURATION,'.',',')) DURATION,
          c.SERVICE_CLASS
        FROM REPORT_USER.IT_MIS_MJR_CELLID_DAILY_FEB19 a , REPORT_USER.IT_MIS_CELLID_FINAL_2013 b ,IT_MIS_PREP_REV_USAGE_SRV_FEE c
        WHERE a.MAJOR_CELLID=b.CELLID(+) ---and a.MAJOR_CELLID not like '%-%'
        AND  a.MSISDN(+)=c.MSISDN
        and a.TRANSACTION_DATE(+)=c.REPORT_DATE 
        and c.REPORT_DATE = to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy')
        GROUP BY a.MAJOR_CELLID,b.CELLCODE,b.SITE_NAMES,b.CELLNAMES,b.CAP_CELID_3G, b.VILLE, b.GOUVERNORATS,b.REGION_NATURELLE,REPORT_DATE,c.SERVICE_CLASS;

            commit;          

delete from IT_MIS_PRE_REV_USAGE_SRV_FEE_F@mkdblink
where REPORT_DATE = to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');

insert into IT_MIS_PRE_REV_USAGE_SRV_FEE_F@mkdblink
select *
from IT_MIS_PRE_REV_USAGE_SRV_FEE_F
where REPORT_DATE = to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');

commit;


---MCKINSEY_USER.IT_MIS_CUG_WITHOUT_PROC 
delete from IT_MIS_CUG_CRS_PREP_REV_FINAL 
where REPORT_DATE = to_date('18/04/2021','dd/mm/yyyy');

commit;
            
insert into IT_MIS_CUG_CRS_PREP_REV_FINAL
select * from IT_MIS_CUG_CRS_PREP_REV_FINAL@REPORTDBDBLINK
where REPORT_DATE = to_date('18/04/2021','dd/mm/yyyy');
            
commit;
            
  delete from IT_MIS_SUBS_CRS_PREP_REV_FINAL
where REPORT_DATE = '20210418';

commit;

insert into IT_MIS_SUBS_CRS_PREP_REV_FINAL
select * from IT_MIS_SUBS_CRS_PREP_REV_FINAL@REPORTDBDBLINK
where REPORT_DATE = '20210418';
              
commit;

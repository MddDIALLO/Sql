create table report_user.B_MOC_201805  as
 select served_msisdn msisdn,
 --- MOC ONNET
 sum(moc_onnet_voice_call) moc_onnet_voice_call,
sum(moc_onnet_voice_duration) moc_onnet_voice_duration ,
sum(moc_onnet_voice_rev) moc_onnet_voice_rev,
  --- MOC OFFNET
 sum(MOC_OFFNET_CELLCOM_VOICE_CALL)+sum(MOC_OFFNET_INTERCEL_VOICE_CALL)+sum(MOC_OFFNET_ORANGE_VOICE_CALL) moc_offnet_voice_call,
sum(MOC_OFFNET_CELLCOM_VOICE_DUR)+sum(MOC_OFFNET_INTERCELL_VOICE_DUR)+sum(MOC_OFFNET_ORANGE_VOICE_DUR) moc_offnet_voice_duration,
sum(MOC_OFFNET_CELLCOM_VOICE_REV)+sum(MOC_OFFNET_INTERCELL_VOICE_REV)+sum(MOC_OFFNET_ORANGE_VOICE_REV) moc_offnet_voice_rev,
  --- MOC INTER
 sum(moc_inter_voice_call) moc_inter_voice_call,
sum(moc_inter_voice_duration) moc_inter_voice_duration,
sum(moc_inter_voice_rev) moc_inter_voice_rev,
  
   --- MOC SMS ONNET,OFFNET and INTER
sum(moc_total_onnet_sms) moc_total_onnet_sms,
sum(moc_total_offnet_sms) moc_total_offnet_sms,
sum(moc_total_inter_sms) moc_total_inter_sms
from
    (select *
    from report_user.IT_MIS_MOC_REV_GLOBAL_MAY18 --partition (D20120913_USAGE_EVENTS)  
    where ( (substr(SERVED_MSISDN,1,2) like '66%' and length(SERVED_MSISDN) =9 )
--                                or (  substr(SERVED_MSISDN,1,3) like '662%' and length(SERVED_MSISDN) =9 )
--                                or (  substr(SERVED_MSISDN,1,3) like '666%' and length(SERVED_MSISDN) =9 )
--                                or (  substr(SERVED_MSISDN,1,3) like '669%' and length(SERVED_MSISDN) =9 )
                                or (SERVED_MSISDN like '22466%' and length(SERVED_MSISDN) =12 )
--                                or (SERVED_MSISDN like '224666%'  and length(SERVED_MSISDN) =12 )
--                                or (SERVED_MSISDN like '224669%'  and length(SERVED_MSISDN) =12 )  
--                                or (SERVED_MSISDN like '224662%'  and length(SERVED_MSISDN) =12 )  
                          )
 
    
     ) t1
 
    group by served_msisdn;
   
  --- Load MTC Transaction 
    create table report_user.B_MTC_201805 as
 select served_msisdn,
 
  -- MTC MOC
sum(mtc_onnet_voice_call) mtc_onnet_voice_call,
sum(mtc_onnet_voice_duration) mtc_onnet_voice_duration,
 -- MTC OFFNET
sum(mtc_offnet_voice_call) mtc_offnet_voice_call,
sum(mtc_offnet_voice_duration) mtc_offnet_voice_duration,
  -- MTC INTER
sum(mtc_inter_voice_call) mtc_inter_voice_call,
sum(mtc_inter_voice_duration) mtc_inter_voice_duration,
 -- MTC SMS ONNET  AND OFFNET
sum(mtc_onnet_sms) mtc_onnet_sms,
sum(mtc_offnet_sms) mtc_offnet_sms
from
     (select   served_msisdn,mtc_onnet_voice_call,mtc_onnet_voice_duration,mtc_offnet_voice_call,mtc_offnet_voice_duration,mtc_inter_voice_call,mtc_inter_voice_duration,mtc_onnet_sms,mtc_offnet_sms,mtc_inter_sms,transaction_date mtc_transaction_date
    from report_user.IT_MIS_MTC_REV_GLOBAL_MAY18 --partition(D20120913_MTC_EVENTS)
    where ((substr(served_msisdn,1,2) like '66%' and length(served_msisdn) =9 )
--                                or (  substr(served_msisdn,1,3) like '662%' and length(served_msisdn) =9 )
--                                or (  substr(served_msisdn,1,3) like '666%' and length(served_msisdn) =9 )
--                                or (  substr(served_msisdn,1,3) like '669%' and length(served_msisdn) =9 )
                                or (served_msisdn like '22466%' and length(served_msisdn) =12 )
--                                or (served_msisdn like '224666%'  and length(served_msisdn) =12 )
--                                or (served_msisdn like '224669%'  and length(served_msisdn) =12 )  
--                                or (served_msisdn like '224662%'  and length(served_msisdn) =12 )  
                          )
     )
    group by served_msisdn;
 
  
 
 
--- Load MTC and ALL MOC transactions
create table report_user.B_MOC_ALL_201805 as
 select  *
from(
 select msisdn,
 --- MOC ONNET
 sum(moc_onnet_voice_call) moc_onnet_voice_call,
sum(moc_onnet_voice_duration) moc_onnet_voice_duration ,
sum(moc_onnet_voice_rev) moc_onnet_voice_rev,
  --- MOC OFFNET
 sum(moc_offnet_voice_call) moc_offnet_voice_call,
sum(moc_offnet_voice_duration) moc_offnet_voice_duration,
sum(moc_offnet_voice_rev) moc_offnet_voice_rev,
  --- MOC INTER
 sum(moc_inter_voice_call) moc_inter_voice_call,
sum(moc_inter_voice_duration) moc_inter_voice_duration,
sum(moc_inter_voice_rev) moc_inter_voice_rev,
  
   --- MOC SMS ONNET,OFFNET and INTER
sum(moc_total_onnet_sms) moc_total_onnet_sms,
sum(moc_total_offnet_sms) moc_total_offnet_sms,
sum(moc_total_inter_sms) moc_total_inter_sms,
 -- MTC MOC
sum(mtc_onnet_voice_call) mtc_onnet_voice_call,
sum(mtc_onnet_voice_duration) mtc_onnet_voice_duration,
  -- MTC OFFNET
sum(mtc_offnet_voice_call) mtc_offnet_voice_call,
sum(mtc_offnet_voice_duration) mtc_offnet_voice_duration,
  -- MTC INTER
sum(mtc_inter_voice_call) mtc_inter_voice_call,
sum(mtc_inter_voice_duration) mtc_inter_voice_duration,
-- MTC SMS ONNET  AND OFFNET
sum(mtc_onnet_sms) mtc_onnet_sms,
sum(mtc_offnet_sms) mtc_offnet_sms
     from
    (  select *
    from report_user.B_MTC_201805
   
   ) t1, 
 (select  *
     from report_user.B_MOC_201805  --partition (D20120913_USAGE_EVENTS)  
    where ( (substr(msisdn,1,2) like '66%' and length(msisdn) =9 )
--                                or (  substr(msisdn,1,3) like '662%' and length(msisdn) =9 )
--                                or (  substr(msisdn,1,3) like '666%' and length(msisdn) =9 )
--                                or (  substr(msisdn,1,3) like '669%' and length(msisdn) =9 )
                                or (msisdn like '22466%' and length(msisdn) =12 )
--                                or (msisdn like '224666%'  and length(msisdn) =12 )
--                                or (msisdn like '224669%'  and length(msisdn) =12 )  
--                                or (msisdn like '224662%'  and length(msisdn) =12 )  
                          )
 
    )

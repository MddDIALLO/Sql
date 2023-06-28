------------------ CVM :1GB à 10k    :Ci-dessous  le script   dans reportdb :

------------------ CVM :1GB à 10k    :Ci-dessous  le script   dans reportdb :

select a.* from (
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180515_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180516_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180517_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180518_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180519_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180520_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180521_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180522_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180523_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180524_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180525_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180526_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180527_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180528_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180529_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180530_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180531_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180601_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180602_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180603_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180604_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180605_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180606_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180607_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180608_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180609_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180610_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180611_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180612_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180613_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180614_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180615_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180616_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180617_USAGE_EVENTS) 
union all
select  *   from  report_user.IT_MIS_USAGE_EVENTS_DTL_12  partition(D20180618_USAGE_EVENTS)) a ,it_mis_msisdn_tmp
WHERE ORIGIN_REALM in ('mc.com') and SERVICE_IDENTIFIER_ID  in ('84025') 
and TRAFFIC_TYPE_ID='2000006'
and a.served_msisdn=msisdn

-------HVC :VOICE BUNDLE 5k------------

select a.* from HVCBUNDLES_TRANSAC@mis2app a,report_user.it_mis_msisdn b
where CREATE_DATE between to_date('15/05/2018 00:00:01','dd/mm/yyyy hh24:mi:ss') and to_date('18/06/2018 23:59:59','dd/mm/yyyy hh24:mi:ss')
and '224'||a.msisdn=b.msisdn
and PRICE=5000

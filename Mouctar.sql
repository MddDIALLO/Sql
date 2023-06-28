select SERVED_MSISDN, SUM(MOC_ONNET_VOICE_CALL+MOC_OFFNET_ORANGE_VOICE_CALL+MOC_OFFNET_CELLCOM_VOICE_CALL+MOC_OFFNET_INTERCEL_VOICE_CALL+MOC_INTER_VOICE_CALL) TOTAL_VOICE,
SUM(MOC_ONNET_VOICE_REV+MOC_OFFNET_ORANGE_VOICE_REV+MOC_OFFNET_CELLCOM_VOICE_REV+MOC_OFFNET_INTERCELL_VOICE_REV+MOC_INTER_VOICE_REV) VOICE_REVENUE,
SUM(MOC_ONNET_SMS+MOC_TOTAL_OFFNET_SMS+MOC_TOTAL_INTER_SMS) TOTAL_SMS,
SUM(MOC_ONNET_SMS+MOC_OFFNET_SMS+MOC_INTER_SMS) SMS_REVENUE
from(
select * from IT_MIS_MOC_REV_GLOBAL_AUG18
union all
select * from IT_MIS_MOC_REV_GLOBAL_SEP18
union all
select * from IT_MIS_MOC_REV_GLOBAL_OCT18
union all
select * from IT_MIS_MOC_REV_GLOBAL_NOV18
union all
select * from IT_MIS_MOC_REV_GLOBAL_DEC18
union all
select * from IT_MIS_MOC_REV_GLOBAL_JAN19
union all
select * from IT_MIS_MOC_REV_GLOBAL_FEB19
union all
select * from IT_MIS_MOC_REV_GLOBAL_MAR19
union all
select * from IT_MIS_MOC_REV_GLOBAL_APR19
)where SERVED_MSISDN in (select '224'||MSISDN from mdndiallo.IT_MSISDN_CHECK1)
GROUP BY SERVED_MSISDN


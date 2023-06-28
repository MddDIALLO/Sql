select * --substr(TERMINATING_MSG,1,8),SID,count(*)
from REPORT_USER.IT_MIS_SMSC_TRANSAC
where STATUS_ST='ST:0' and SID = 'SID:331' --and MSG_TERMI_TYPE='DMsg:MT'
order by DATES

group by substr(TERMINATING_MSG,1,8),SID

----
select *
from REPORT_USER.IT_MIS_SMSC_TRANSAC_MTS
SID = 'SID:331' --and STATUS_ST='ST:0' and MSG_TERMI_TYPE='DMsg:MT'
order by DATES
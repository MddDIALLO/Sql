alter TABLE MCKINSEY_USER.CALL_HISTORY_ARPT_TMP LOCATION (CRS_DIR_FILES2:'ARPT_CALL_HISTORY_NUMBER20180420.csv');

 
 

-----arpt call history

select SERVED_MSISDN APPELANTS,

       CALLED_NUMBER APPELES,

       SUBSTR(UTC_TIMESTAMP,1,LENGTH(UTC_TIMESTAMP)-1) DATES,

       substr(UTC_TIMESTAMP,12,2) HEURES,

       DURATION DUREE,

       SERVED_IMSI IMSI,

       SERVED_IMEI IMEI,

       GOUVERNORATS LOCALISATION,

       CELL_ID CELLULE_ID,

       CELLNAMES CELLULE_NAME,

       VILLE,

       COMMUNES PREFECTURE,

       REGION_NATURELLE REGION,

       CALL_TYPE TYPE

from MCKINSEY_USER.CALL_HISTORY_ARPT_TMP a, MCKINSEY_USER.IT_MK_CELLID_FINAL_2013 b where b.CELLID=a.CELL_ID
and to_date(substr(UTC_TIMESTAMP,1,10),'dd/mm/yyyy') between   to_date('05/12/2017','dd/mm/yyyy') and to_date('20/04/2018','dd/mm/yyyy')
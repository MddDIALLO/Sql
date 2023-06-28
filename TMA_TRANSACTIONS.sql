select a.TMA_POS_MSISDN, b.RESELLER_MSISDN POS_MSISDN,CUSTOMER_MSISDN, b.PRICE, b.COMMISSION,RESELLER_TYPE, to_date(to_char(b.CREATED_DATE,'dd/mm/yyyy'),'dd/mm/yyyy') tranc_date
from TMA_POS_TRANSACTION@MIS2APP2 a,MTNCOMJAIM_COMMISSION@MIS2APP2 b
where a.POS_MSISDN=b.RESELLER_MSISDN
and to_date(to_char(b.CREATED_DATE,'dd/mm/yyyy'),'dd/mm/yyyy') between to_date('01/01/2019','dd/mm/yyyy') and to_date('31/01/2019','dd/mm/yyyy')
--and TMA_POS_MSISDN='661007118'
--group by TMA_POS_MSISDN
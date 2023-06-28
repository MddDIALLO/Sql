------------------CLEARENCE--------------------------------------
 
select ACCOUNT_ID,sum(replace(TOTAL_AMOUNT,'.',',')) from IT_MIS_DR_CLEARANCENW1
group by ACCOUNT_ID


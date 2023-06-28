select * from HVCBUNDLES_TRANSAC@mis2app
where MSISDN in ( select MSISDN from report_user.it_mis_msisdn)
and CREATE_DATE between to_date('01/03/2018 00:00:01','dd/mm/yyyy hh24:mi:ss') and to_date('07/06/2018 23:59:59','dd/mm/yyyy hh24:mi:ss')
and PRICE=5000

select * from HVCBUNDLES_TRANSAC@mis2app
where CREATE_DATE between to_date('01/03/2018 00:00:01','dd/mm/yyyy hh24:mi:ss') and to_date('07/06/2018 23:59:59','dd/mm/yyyy hh24:mi:ss')
and PRICE=5000

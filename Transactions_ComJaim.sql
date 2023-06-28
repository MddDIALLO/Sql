select * from report_user.IT_COMBO_COMJAIM_TRANSAC
where DAY_DATE between to_date('01/08/2018','dd/MM/yyyy') and to_date('13/09/2018','dd/MM/yyyy')
order by DAY_DATE,HEUR
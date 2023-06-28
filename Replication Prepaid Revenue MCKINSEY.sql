delete from mckinsey_user.IT_MIS_CRS_REV_GLOBAL_REPORT
where to_date(DATES_HOUR,'dd/mm/yyyy') between to_date(to_char(trunc(sysdate-3,'MONTH'),'dd/mm/yyyy'),'dd/mm/yyyy')  and to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy') ;
commit;

        
insert into mckinsey_user.IT_MIS_CRS_REV_GLOBAL_REPORT 
select * from IT_MIS_CRS_REV_GLOBAL_REPORT@REPORTDBDBLINK
where to_char(to_date(dates_hour,'dd/mm/yyyy'),'yyyymmdd') between '20180901' and '20180913'; -- to_date(to_char(sysdate-1,'dd/mm/yyyy'),'dd/mm/yyyy');
commit;  

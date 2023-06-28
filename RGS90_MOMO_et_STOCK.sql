------SCRIPT MOMO RGS90
SELECT *
FROM IT_MIS_RGS_MOMO_DETAILS
WHERE RGS_TYPE='RGS90_MOC_MTC'
and REPORT_DATE=to_date('18/07/2018','dd/mm/yyyy')


----SCRIPT VERIFICATION SERIE DANS STOCK
select * from [dbo].[VW_STOCKDEPOT]
where '922454647305' between SerieDebut and SerieFin
-----DANS REPORT_DB
select * from "dbo".VW_STOCKDEPOT@SL1000
where '922449990218' between "SerieDebut" and "SerieFin"

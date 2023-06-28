select * from COMBOBUNDLES_TRANSAC@mis2app
where MSISDN in (select * from it_mis_msisdn_tmp2)
and RESPONSE='Vous avez souscrit avec succes au forfait en attente Combo_5000 . Merci de votre fidelite'

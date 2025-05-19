use SampleSales
go
/* --Derived Table (Türetilmiþ Tablo) 
Derived table, bir SQL sorgusunun içinde, 
FROM ifadesi içinde tanýmlanan geçici bir alt sorgudur. 
CTE’ye (Common Table Expression) benzer þekilde kullanýlýr ama CTE gibi yukarýda tanýmlanmaz
doðrudan FROM içinde yazýlýr.

Derived table, bir SELECT ifadesi içinde, 
FROM içinde kullanýlan ve parantezle çevrilen alt sorgudur.

-- Nerede Bulurum / Nerede Kullanýlýr?
SQL sorgularýnýn içinde doðrudan kullanýlýr, bir tablo gibi davranýr ama geçicidir.

VIEW veya CTE oluþturmak istemediðin ama bir alt sorgunun sonucuna ad verip devam etmek istediðin yerlerde kullanýlýr.
Özellikle:
Gruplama yapýlmýþ sonuçlarý baþka iþlemlere tabi tutmak,
Karmaþýk hesaplamalarý modüler hale getirmek,
JOIN iþlemlerinde alt sorgularla veri birleþtirmek için tercih edilir.*/



--- **** ORTAK SÜTUNU OLMAYAN TABLOLARI BÝRLEÞTÝRME ****---
-- SÝPARÝÞLERÝ ÝKÝ ATLAYARAK HER ÜÇTE BÝRÝNÝ YAZDIRMA


with recur as 
(
    select 1 as num 
    union all 
    select num + 5
    from recur 
    where num < 100
)
select num, t.order_id, t.order_date, t.shipped_date 
from recur join (
				select * from sale.orders  --Derived Table (Türetilmiþ Tablo)
				) as t 
				on recur.num=t.order_id
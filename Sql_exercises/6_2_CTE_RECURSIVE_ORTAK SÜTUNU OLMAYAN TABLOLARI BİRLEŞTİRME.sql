use SampleSales
go
/* --Derived Table (T�retilmi� Tablo) 
Derived table, bir SQL sorgusunun i�inde, 
FROM ifadesi i�inde tan�mlanan ge�ici bir alt sorgudur. 
CTE�ye (Common Table Expression) benzer �ekilde kullan�l�r ama CTE gibi yukar�da tan�mlanmaz
do�rudan FROM i�inde yaz�l�r.

Derived table, bir SELECT ifadesi i�inde, 
FROM i�inde kullan�lan ve parantezle �evrilen alt sorgudur.

-- Nerede Bulurum / Nerede Kullan�l�r?
SQL sorgular�n�n i�inde do�rudan kullan�l�r, bir tablo gibi davran�r ama ge�icidir.

VIEW veya CTE olu�turmak istemedi�in ama bir alt sorgunun sonucuna ad verip devam etmek istedi�in yerlerde kullan�l�r.
�zellikle:
Gruplama yap�lm�� sonu�lar� ba�ka i�lemlere tabi tutmak,
Karma��k hesaplamalar� mod�ler hale getirmek,
JOIN i�lemlerinde alt sorgularla veri birle�tirmek i�in tercih edilir.*/



--- **** ORTAK S�TUNU OLMAYAN TABLOLARI B�RLE�T�RME ****---
-- S�PAR��LER� �K� ATLAYARAK HER ��TE B�R�N� YAZDIRMA


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
				select * from sale.orders  --Derived Table (T�retilmi� Tablo)
				) as t 
				on recur.num=t.order_id
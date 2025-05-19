USE SampleSales


/* --CTE (Common Table Expression)
CTE (Common Table Expression), SQL Server dahil olmak üzere birçok iliþkisel veritabaný sisteminde kullanýlan geçici, 
adlandýrýlmýþ bir sorgu bloðudur. 
CTE'ler sorgularýn okunabilirliðini artýrmak, tekrar eden alt sorgulardan kaçýnmak ve 
özellikle özyinelemeli (recursive) iþlemleri kolaylaþtýrmak için kullanýlýr.

CTE, bir SELECT, INSERT, UPDATE veya DELETE sorgusunun hemen öncesinde tanýmlanan, geçici bir sonuç kümesidir. 
Kalýcý deðildir, yani fiziksel olarak veri tabanýnda bir tabloya ya da kayda dönüþmez.
CTE veritabanýna kalýcý bir þey yazmaz, sadece geçici bir "adlandýrýlmýþ alt sorgu" gibi çalýþýr. 
Bir #temp veya @table gibi fiziksel veya bellek içi tablo oluþturmaz.

--CTE’nin Amacý Nedir?
Kodun okunabilirliðini artýrmak
Karmaþýk sorgularý bölmek
Tekrarlanan alt sorgulardan kurtulmak
Recursive sorgular (örneðin: kategori hiyerarþisi, organizasyon yapýsý) yazmak

--CTE Nasýl Çalýþýr?
Sorgu çalýþtýðýnda CTE bellekte oluþturulur ve sadece o sorgu için geçerlidir.
Sorgu çalýþmasý bitince CTE yok olur.
CTE, bir geçici sonuç kümesi gibidir.
Genellikle karmaþýk sorgularý bölüp daha okunabilir hale getirmek için kullanýlýr.
Recursive CTE'ler ile aðaç yapýlarý, organizasyon þemalarý, parent-child iliþkileri gibi yapýlar kolayca modellenebilir.

--Ne Zaman CTE Kullanmalý?
Karmaþýk SELECT sorgularýný bölmek istiyorsan
Alt sorgu tekrar ediyorsa
Recursive iþlemler (aðaç yapýsý gibi) varsa
Kod okunabilirliði önemliyse

--Ne Zaman Kullanmamalý?
Ayný veri kümesine birden fazla eriþim gerekiyorsa ve her seferinde tekrar çalýþmasý maliyetliyse 
(çünkü CTE her çaðrýldýðýnda tekrar hesaplanýr)
Çok büyük veri setleri varsa ve performans kritikse
CTE içinde kullanýlan sorgular iyi optimize edilmemiþse

Sonuç
CTE çok güçlü ve okunabilirliði yüksek bir araçtýr. Ancak:
	*Tekrar kullanýlamaz
	*Indexlenemez
	*Performans açýsýndan temp table kadar esnek deðildir.

Bu yüzden doðru durumda kullanmak çok önemlidir.*/

---------------------------------------
-- Sharyn Hopkins isimli müþterinin son sipariþinden önce sipariþ vermiþ 
--ve San Diego þehrinde ikamet eden müþterileri listeleyin.


WITH T1 AS
(
SELECT	max(order_date) last_purchase    --Sharyn Hopkins isimli müþterinin son sipariþi 2020-04-01
FROM	sale.customer A, sale.orders B
WHERE	A.customer_id = B.customer_id
AND		A.first_name = 'Sharyn'
AND		A.last_name = 'Hopkins'
) 
SELECT	DISTINCT A.order_date, A.order_id, B.customer_id, B.first_name, B.last_name, B.city  --müþterileri listeleyin.
FROM	sale.orders A, sale.customer B, T1
WHERE	A.customer_id = B.customer_id
AND		A.order_date < T1.last_purchase  --Sharyn Hopkinsden önce sipariþ vermiþ 
AND		B.city = 'San Diego' --San Diego þehrinde ikamet eden 

-- Abby	Parks isimli müþterinin alýþveriþ yaptýðý tarihte/tarihlerde alýþveriþ yapan tüm müþterileri listeleyin.
-- Müþteri adý, soyadý ve sipariþ tarihi bilgilerini listeleyin.

WITH T1 AS
(
SELECT	order_date   --2019-02-09 ve 2020-04-15
FROM	sale.customer A, sale.orders B
WHERE	A.customer_id = B.customer_id
AND		A.first_name = 'Abby'
AND		A.last_name = 'Parks'
)
SELECT	A.order_date, A.order_id, B.first_name, B.last_name
FROM	sale.orders A, sale.customer B, T1
WHERE	A.customer_id  = B.customer_id 
AND		A.order_date = T1.order_date
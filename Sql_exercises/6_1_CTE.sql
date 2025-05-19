USE SampleSales


/* --CTE (Common Table Expression)
CTE (Common Table Expression), SQL Server dahil olmak �zere bir�ok ili�kisel veritaban� sisteminde kullan�lan ge�ici, 
adland�r�lm�� bir sorgu blo�udur. 
CTE'ler sorgular�n okunabilirli�ini art�rmak, tekrar eden alt sorgulardan ka��nmak ve 
�zellikle �zyinelemeli (recursive) i�lemleri kolayla�t�rmak i�in kullan�l�r.

CTE, bir SELECT, INSERT, UPDATE veya DELETE sorgusunun hemen �ncesinde tan�mlanan, ge�ici bir sonu� k�mesidir. 
Kal�c� de�ildir, yani fiziksel olarak veri taban�nda bir tabloya ya da kayda d�n��mez.
CTE veritaban�na kal�c� bir �ey yazmaz, sadece ge�ici bir "adland�r�lm�� alt sorgu" gibi �al���r. 
Bir #temp veya @table gibi fiziksel veya bellek i�i tablo olu�turmaz.

--CTE�nin Amac� Nedir?
Kodun okunabilirli�ini art�rmak
Karma��k sorgular� b�lmek
Tekrarlanan alt sorgulardan kurtulmak
Recursive sorgular (�rne�in: kategori hiyerar�isi, organizasyon yap�s�) yazmak

--CTE Nas�l �al���r?
Sorgu �al��t���nda CTE bellekte olu�turulur ve sadece o sorgu i�in ge�erlidir.
Sorgu �al��mas� bitince CTE yok olur.
CTE, bir ge�ici sonu� k�mesi gibidir.
Genellikle karma��k sorgular� b�l�p daha okunabilir hale getirmek i�in kullan�l�r.
Recursive CTE'ler ile a�a� yap�lar�, organizasyon �emalar�, parent-child ili�kileri gibi yap�lar kolayca modellenebilir.

--Ne Zaman CTE Kullanmal�?
Karma��k SELECT sorgular�n� b�lmek istiyorsan
Alt sorgu tekrar ediyorsa
Recursive i�lemler (a�a� yap�s� gibi) varsa
Kod okunabilirli�i �nemliyse

--Ne Zaman Kullanmamal�?
Ayn� veri k�mesine birden fazla eri�im gerekiyorsa ve her seferinde tekrar �al��mas� maliyetliyse 
(��nk� CTE her �a�r�ld���nda tekrar hesaplan�r)
�ok b�y�k veri setleri varsa ve performans kritikse
CTE i�inde kullan�lan sorgular iyi optimize edilmemi�se

Sonu�
CTE �ok g��l� ve okunabilirli�i y�ksek bir ara�t�r. Ancak:
	*Tekrar kullan�lamaz
	*Indexlenemez
	*Performans a��s�ndan temp table kadar esnek de�ildir.

Bu y�zden do�ru durumda kullanmak �ok �nemlidir.*/

---------------------------------------
-- Sharyn Hopkins isimli m��terinin son sipari�inden �nce sipari� vermi� 
--ve San Diego �ehrinde ikamet eden m��terileri listeleyin.


WITH T1 AS
(
SELECT	max(order_date) last_purchase    --Sharyn Hopkins isimli m��terinin son sipari�i 2020-04-01
FROM	sale.customer A, sale.orders B
WHERE	A.customer_id = B.customer_id
AND		A.first_name = 'Sharyn'
AND		A.last_name = 'Hopkins'
) 
SELECT	DISTINCT A.order_date, A.order_id, B.customer_id, B.first_name, B.last_name, B.city  --m��terileri listeleyin.
FROM	sale.orders A, sale.customer B, T1
WHERE	A.customer_id = B.customer_id
AND		A.order_date < T1.last_purchase  --Sharyn Hopkinsden �nce sipari� vermi� 
AND		B.city = 'San Diego' --San Diego �ehrinde ikamet eden 

-- Abby	Parks isimli m��terinin al��veri� yapt��� tarihte/tarihlerde al��veri� yapan t�m m��terileri listeleyin.
-- M��teri ad�, soyad� ve sipari� tarihi bilgilerini listeleyin.

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
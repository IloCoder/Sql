use SampleSales
go

/*INTERSECT
SQL'de INTERSECT, iki SELECT sorgusunun ortak (kesi�en) sonu�lar�n� d�nd�ren bir k�me i�lemidir. 
Yani her iki sorgunun da d�nd�rd��� sat�rlarda ortak olanlar� listeler.*/

--Hem 2018 y�l�nda hem de 2019 y�l�nda �r�n� olan markalar� getiriniz
SELECT	B.brand_name
FROM	product.product A, product.brand B
WHERE	A.brand_id = B.brand_id
AND		A.model_year = 2018

SELECT	B.brand_name
FROM	product.product A, product.brand B
WHERE	A.brand_id = B.brand_id
AND		A.model_year = 2019

---------

SELECT	B.brand_name
FROM	product.product A, product.brand B
WHERE	A.brand_id = B.brand_id
AND		A.model_year = 2018

INTERSECT

SELECT	B.brand_name
FROM	product.product A, product.brand B
WHERE	A.brand_id = B.brand_id
AND		A.model_year = 2019
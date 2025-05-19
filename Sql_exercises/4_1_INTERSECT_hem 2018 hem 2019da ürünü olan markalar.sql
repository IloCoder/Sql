use SampleSales
go

/*INTERSECT
SQL'de INTERSECT, iki SELECT sorgusunun ortak (kesiþen) sonuçlarýný döndüren bir küme iþlemidir. 
Yani her iki sorgunun da döndürdüðü satýrlarda ortak olanlarý listeler.*/

--Hem 2018 yýlýnda hem de 2019 yýlýnda ürünü olan markalarý getiriniz
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
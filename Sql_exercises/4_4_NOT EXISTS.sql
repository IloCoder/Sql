use SampleSales
go

/* NOT EXISTS SQL'de kullanýlan bir koþuldur ve alt sorgunun hiçbir satýr döndürmemesi durumunu kontrol eder. 
Yani, bir þeyin "var olmamasý" durumuna göre iþlem yapmaný saðlar.

NOT EXISTS, genellikle bir alt sorgu (subquery) ile birlikte kullanýlýr ve eðer alt sorgu sonuç döndürmüyorsa, 
dýþ sorgunun o satýrý seçmesini saðlar.

EXISTS	Alt sorgu en az bir sonuç döndürürse true
NOT EXISTS	Alt sorgu hiçbir sonuç döndürmezse true
*/

/*
*** Correlated Subquery
Alt sorgunun, dýþ sorgudan bir deðer kullanarak çalýþmasý durumudur. 
Yani alt sorgu, dýþ sorgunun her satýrý için tekrar tekrar çalýþýr.

X dýþ sorgudaki sale.customer alias'ý.

X.state = D.state satýrý, alt sorgunun dýþ sorgudaki X.state deðerini kullandýðýný gösteriyor.

Bu nedenle: Alt sorgu, dýþ sorgudaki her bir X.state deðeri için ayrý çalýþýr.

Nasýl Çalýþýr?

1.sale.customer tablosundan her bir satýr (müþteri) alýnýr.

2.Her müþteri için X.state deðeri alýnýr.

3.Alt sorgu, o X.state için 'Trek Remedy 9.8 - 2019' adlý ürün alýnmýþ mý diye kontrol eder.

4.Eðer alýnmamýþsa (alt sorgu sonuç döndürmezse), o state dýþ sorgunun sonucuna dahil edilir.

*/

--'Trek Remedy 9.8 - 2019' ürününün sipariþ verilmediði state/state'leri getiriniz.


SELECT *
FROM	SALE.customer

SELECT DISTINCT state
FROM sale.customer as X
WHERE	NOT EXISTS
					(
					SELECT A.product_id, A.product_name, B.product_id, B.order_id, C.order_id, C.customer_id, D.*
					FROM	product.product A, sale.order_item B, sale.orders C, sale.customer D
					WHERE	A.product_id = B.product_id
					AND		B.order_id = C.order_id
					AND		C.customer_id = D.customer_id
					AND		A.product_name = 'Trek Remedy 9.8 - 2019'
					AND		X.state = D.state
					)

/*Trek Remedy 9.8 - 2019' adlý ürünü hiç kimsenin satýn almadýðý eyaletleri (state) listele.
Eðer bir eyalette bu ürün hiç alýnmamýþsa, o eyalet listelenir.Eðer bir kiþi bile almýþsa, o eyalet dýþlanýr.*/


----

use SampleSales
go

/* NOT EXISTS SQL'de kullan�lan bir ko�uldur ve alt sorgunun hi�bir sat�r d�nd�rmemesi durumunu kontrol eder. 
Yani, bir �eyin "var olmamas�" durumuna g�re i�lem yapman� sa�lar.

NOT EXISTS, genellikle bir alt sorgu (subquery) ile birlikte kullan�l�r ve e�er alt sorgu sonu� d�nd�rm�yorsa, 
d�� sorgunun o sat�r� se�mesini sa�lar.

EXISTS	Alt sorgu en az bir sonu� d�nd�r�rse true
NOT EXISTS	Alt sorgu hi�bir sonu� d�nd�rmezse true
*/

/*
*** Correlated Subquery
Alt sorgunun, d�� sorgudan bir de�er kullanarak �al��mas� durumudur. 
Yani alt sorgu, d�� sorgunun her sat�r� i�in tekrar tekrar �al���r.

X d�� sorgudaki sale.customer alias'�.

X.state = D.state sat�r�, alt sorgunun d�� sorgudaki X.state de�erini kulland���n� g�steriyor.

Bu nedenle: Alt sorgu, d�� sorgudaki her bir X.state de�eri i�in ayr� �al���r.

Nas�l �al���r?

1.sale.customer tablosundan her bir sat�r (m��teri) al�n�r.

2.Her m��teri i�in X.state de�eri al�n�r.

3.Alt sorgu, o X.state i�in 'Trek Remedy 9.8 - 2019' adl� �r�n al�nm�� m� diye kontrol eder.

4.E�er al�nmam��sa (alt sorgu sonu� d�nd�rmezse), o state d�� sorgunun sonucuna dahil edilir.

*/

--'Trek Remedy 9.8 - 2019' �r�n�n�n sipari� verilmedi�i state/state'leri getiriniz.


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

/*Trek Remedy 9.8 - 2019' adl� �r�n� hi� kimsenin sat�n almad��� eyaletleri (state) listele.
E�er bir eyalette bu �r�n hi� al�nmam��sa, o eyalet listelenir.E�er bir ki�i bile alm��sa, o eyalet d��lan�r.*/


----

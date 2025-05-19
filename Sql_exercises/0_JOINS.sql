


use SampleSales
go
------ INNER JOIN ------

SELECT		A.product_name, B.category_id, B.category_name
FROM		product.product AS A
INNER JOIN	product.category AS B ON A.category_id = B.category_id

SELECT		A.first_name, A.last_name, B.store_name
FROM		sale.staff A
INNER JOIN	sale.store B ON A.store_id = B.store_id

SELECT A.product_id, A.product_name
FROM product.product A
INNER JOIN (
			SELECT	A.product_id
			FROM	sale.order_item A, sale.orders B
			WHERE	A.order_id = B.order_id
			AND		B.order_date BETWEEN '2019-01-01' AND '2019-12-31'
			) B
ON	A.product_id = B.product_id

-- JOIN YAPMADAN ��Z�M�:
SELECT	COUNT (DISTINCT A.product_id)
FROM	sale.order_item A, sale.orders B
WHERE	A.order_id = B.order_id
AND		B.order_date LIKE '2019%'

------ LEFT JOIN ------
-- Ma�aza �al��anlar�n� yapt�klar� sat��lar ile birlikte listeleyin

SELECT		A.staff_id, A.first_name, B.order_id, B.staff_id 
FROM		sale.staff A 
LEFT JOIN	SALE.orders B ON A.staff_id = B.staff_id
ORDER BY	B.order_id 

-- Hi� sipari� edilmemi� �r�nleri d�nd�ren bir sorgu yaz�n

SELECT		A.product_id, A.product_name, B.order_id
FROM		product.product A LEFT JOIN	sale.order_item B ON A.product_id = B.product_id
WHERE		B.order_id IS NULL

--Ma�azalarda �r�n kodu 310'dan b�y�k olan �r�nlerin stok durumunu raporlay�n.

SELECT		A.product_id, A.product_name, B.store_id, B.quantity
FROM		product.product A 
LEFT JOIN	product.stock B  ON A.product_id = B.product_id
WHERE		A.product_id > 310
ORDER BY	store_id

------ RIGHT JOIN ------

SELECT		A.product_id, B.product_name, A.store_id, A.quantity
FROM		product.stock A 
RIGHT JOIN	product.product B  ON A.product_id = B.product_id
WHERE		B.product_id > 310
ORDER BY	store_id

---T�m personel taraf�ndan yap�lan sipari� bilgilerini raporlay�n.

SELECT COUNT (DISTINCT A.staff_id)
FROM	sale.staff A INNER JOIN sale.orders B ON A.staff_id = B.staff_id

SELECT	A.staff_id, A.first_name, A.last_name, B.order_id
FROM	sale.staff A LEFT JOIN sale.orders B ON A.staff_id = B.staff_id

------ FULL OUTER JOIN ------
--T�m �r�nler i�in stok ve sipari� bilgilerini birlikte d�nd�ren bir sorgu yaz�n. (�LK 20)

SELECT	top 20*
FROM	SALE.order_item A FULL OUTER JOIN product.stock B ON A.product_id = B.product_id
ORDER BY	B.product_id, A.order_id

-- SELF JOIN
-- Personeli y�neticileriyle birlikte d�nd�ren bir sorgu yaz�n.

SELECT * 
FROM sale.staff AS A
JOIN sale.staff AS B
ON A.manager_id = B.staff_id

-- CROSS JOIN  (THERE IS NO "ON" WITH CROSS JOIN)
-- T�m marka x kategori olas�l�klar�n� d�nd�ren bir sorgu yaz�n.

SELECT A.brand_id, A.brand_name, B.category_id, B.category_name
FROM product.brand AS A
CROSS JOIN product.category AS B

-- Product tablosunda bulunan ancak stok tablosunda bulunmayan �r�nleri stoklar tablosuna quantity = 0 olacak �ekilde eklemek i�in kullan�lacak tabloyu d�nd�ren bir sorgu yaz�n. 
-- (T�m ma�azalara �r�n eklemeyi unutmay�n.)
-- baz� �r�nler stoklar tablosunda yer almamaktad�r, 
-- Stok listesinde olmayan ancak �r�n listesinde bulunan kalem say�s�
-- Soruyu anlamak i�in kontrol edelim
SELECT * FROM product.stock
SELECT * FROM product.product

SELECT * FROM product.product AS A
WHERE A.product_id NOT IN (SELECT product_id FROM product.stock);

-- Hangi �r�n_id'sinin ma�azalarda oldu�unu ancak stoklarda olmad���n� buluyoruz

SELECT B.store_id, A.product_id, A.product_name, 0 quantity
FROM product.product AS A
CROSS JOIN sale.store AS B
WHERE A.product_id NOT IN (SELECT product_id FROM product.stock)
ORDER BY A.product_id, B.store_id




/*UNION, iki (veya daha fazla) SELECT sorgusunun sonuçlarını birleştirmek için kullanılır.
Sonuçlar tek bir liste olarak döner.

 **UNION
Tekrar eden kayıtları kaldırır.
Sonuçlar benzersiz (distinct) olur.
Daha yavaştır (çünkü tekrarları kontrol eder).

**UNION ALL
Tekrar eden kayıtları da dahil eder.
Sonuçlar olduğu gibi listelenir.
Daha hızlıdır (çünkü ayıklama yapmaz).

*/

-- Sacramento şehrindeki müşteriler ile Monroe şehrindeki müşterilerin soyisimlerini listeleyin

--UNION ALL
SELECT	last_name FROM	sale.customer WHERE	city = 'Sacramento'
UNION ALL
SELECT	last_name FROM	sale.customer WHERE	city = 'Monroe'
ORDER BY last_name

---UNION

SELECT	last_name FROM	sale.customer WHERE	city = 'Sacramento'
UNION 
SELECT	last_name FROM	sale.customer WHERE	city = 'Monroe'
ORDER BY last_name

--adı carter veya soyadı carter olan müşterileri listeleyin (or kullanmayınız)

select first_name, last_name from sale.customer where first_name= 'Carter'
UNION ALL
select first_name, last_name from sale.customer where last_name= 'Carter'

----
select first_name, last_name, customer_id from sale.customer
where first_name= 'Carter'
UNION ALL
select first_name, last_name, customer_id from sale.customer
where last_name= 'Carter'



---Recursive CTE yapısı

WITH T1 AS
(
SELECT 0 AS NUM
UNION ALL
SELECT NUM + 2 
FROM	T1
WHERE	NUM < 9
)
SELECT *
FROM T1
;

/*
Bu sorguda SQL’in özyinelemeli (recursive) CTE yapısı (WITH ... AS) kullanılıyor.
İlk satır NUM = 0 olarak başlar.
Her adımda NUM değeri 2 artırılır ve NUM < 9 olduğu sürece işlem devam eder.

Dikkat: WHERE NUM < 9 koşulu, bir sonraki satır için NUM + 2 uygulanmadan önce kontrol edildiğinden, 
son değer 10 da dahil edilir.

NUM = 8 → 8 < 9   → NUM + 2 = 10 eklenir

NUM = 10 → 10 < 9  → Durur

0'dan başlayarak

2’şer 2’şer artırarak

10’a kadar sayılar üretir.

Ve bunu kendi kendini çağırarak yapar.

*/


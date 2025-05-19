use SampleSales
go


--Bu sorgu, farklı gruplama kombinasyonları ile birden çok toplulaştırmayı (aggregation) tek bir sorguda yapmanı sağlar.
--group by satırında gruplandırdığımız sütunlar SELECT'te aynen olmalı!!
--aşağıdaki 4 işlemi birden GROUP BY GROUPING SETS((...),(...),(...)) ile yapacağız.

SELECT *
FROM	sale.sales_summary

----1. Toplam sales miktarını hesaplayınız.

SELECT	SUM(total_sales_price) FROM	sale.sales_summary

--2. Markaların toplam sales miktarını hesaplayınız

SELECT	brand, SUM(total_sales_price) total_sales
FROM	sale.sales_summary 
GROUP BY	brand

--3. Kategori bazında yapılan toplam sales miktarını hesaplayınız

SELECT	Category, SUM(total_sales_price) total_sales
FROM	sale.sales_summary 
GROUP BY	Category

--4. Marka ve kategori kırılımındaki toplam sales miktarını hesaplayınız

SELECT	brand, Category, SUM(total_sales_price) total_sales
FROM	sale.sales_summary GROUP BY	brand, Category ORDER BY brand
----------------
SELECT	brand, category, SUM(total_sales_price) 
FROM	sale.sales_summary
GROUP BY	GROUPING SETS ((brand, category),
						 (brand),
						 (category),
						 ())
ORDER BY	brand, category
-----------------
SELECT		brand, category,model_year, SUM(total_sales_price) as Total_Sales
FROM		sale.sales_summary
GROUP BY	GROUPING SETS ((brand,category,model_year), -- en detaylı: her marka + kategori + yıl için
						   (brand,category),			-- marka + kategori toplamı (yıllardan bağımsız)
						   (brand),						-- sadece marka bazlı toplam
						   ())							-- Genel toplam (her şeyin toplamı)
ORDER BY	Brand, Category;


-- GROUP BY ROLLUP(...), sıralı olarak gruplama yapar ve her seviye için ara toplamları (subtotal) ve
-- en sonunda genel toplamı (grand total) döndürür.

-- SQL'de ROLLUP ifadesi, çok seviyeli özet raporlar (subtotal ve grand total) oluşturmak için sık kullanılır.
-- Sana hem örnek hem açıklamasını adım adım vereyim:

---Same result can be achieved by ROLLUP

SELECT		brand, category,model_year, SUM(total_sales_price) as Total_Sales
FROM		sale.sales_summary
GROUP BY	ROLLUP (brand,category, model_year)
ORDER BY	Brand, Category, model_year;

/* ROLLUP(brand, category, model_year) şu grupları otomatik üretir:
	brand + category + model_year → Detay satırlar
	brand + category (model_year NULL) → Alt toplam
	brand (category & model_year NULL) → Daha genel toplam
	NULL, NULL, NULL                   → Genel toplam   
*/

-- GROUPS:
-- c1,c2,c3
-- c1,c2,Null
-- c1,Null,Null
-- Null,Null,Null

--CUBE
--Generate different grouping variations that can be produced with the brand and category columns using 'CUBE'.

SELECT		brand, category, model_year, SUM(total_sales_price) 
FROM		sale.sales_summary
GROUP BY	CUBE (brand,category, model_year)
ORDER BY	brand, category;
-- GROUPS:
-- c1,c2,c3
-- c1,c2,Null
-- c1,c3,Null
-- c2,c3,Null
-- c1,Null,Null
-- c2,Null,Null
-- c3,Null,Null
-- Null,Null,Null



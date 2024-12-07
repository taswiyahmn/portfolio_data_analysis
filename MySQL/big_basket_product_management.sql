SET SQL_SAFE_UPDATES = 0;

SELECT * FROM big_basket_produk.big_basket_product_baru;

-- drop unnecessary column
ALTER TABLE big_basket_product_baru DROP COLUMN MyUnknownColumn;

-- adding new column named discount
ALTER TABLE big_basket_product_baru ADD COLUMN discount DECIMAL(3,1) AFTER rating;

-- adding value to discount column
UPDATE big_basket_product_baru 
SET discount = (market_price-sale_price) / market_price;

-- Which products have the highest discounts?
SELECT * FROM big_basket_product_baru
ORDER BY discount DESC;

-- What is the average price of products within each category and sub-category?
SELECT 
	category,
	sub_category,
	AVG(sale_price) AS sale_price_avg,
    AVG(market_price) AS market_price_avg
FROM big_basket_product_baru
GROUP BY category, sub_category
ORDER BY category, sub_category;

-- Are there specific categories or brands where discounts are more prevalent?    
SELECT 
	category, 
    brand,
    AVG (discount) AS avg_discount
    -- discount
FROM big_basket_product_baru
GROUP BY category, brand
ORDER BY category, brand;

-- Which products have the highest ratings?
SELECT * FROM big_basket_product_baru
ORDER BY rating DESC;

-- Are there any brands with consistently high or low-rated products?
SELECT brand, category, rating
FROM big_basket_product_baru
GROUP BY category, brand
ORDER BY rating DESC;

-- Do higher-priced products have better ratings?
SELECT sub_category, category, rating, sale_price, market_price
FROM big_basket_product_baru
GROUP BY category, sub_category
ORDER BY 
	rating DESC, 
    -- market_price,
    sale_price DESC;

-- Are certain sub-categories or types performing better in terms of pricing or ratings    
SELECT 
	category, 
	sub_category, 
    AVG(sale_price) AS avg_sale_price,
    AVG(market_price) AS avg_market_price
FROM big_basket_product_baru
GROUP BY category, sub_category
ORDER BY category;

-- Which categories have the most products listed?
SELECT
    category,
    COUNT(*) AS product_count
FROM 
    big_basket_product_baru
GROUP BY 
    category
ORDER BY 
    product_count DESC;


-- Are there low-cost products with exceptional ratings or high-cost products with poor ratings?
SELECT 
	sale_price,
    market_price,
    rating
FROM big_basket_product_baru
GROUP BY sale_price, market_price
ORDER BY 
	-- market_price DESC, 
    sale_price DESC;
    
-- -----------------------------------------------------
-- 	BUSINESS Logics
-- -----------------------------------------------------

-- # 1. Top  10 High Rated Products

SELECT product_id,product_name,rating from products
WHERE rating >= 4.5
order by rating DESC
LIMIT 10;


-- # 2 . Most Reviewd Products 
SELECT * FROM products;
SELECT * FROM reviews;

SELECT p.product_id,p.product_name,COUNT(r.rating_count) AS total_reviews
FROM products p
JOIN reviews r ON r.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_reviews DESC
LIMIT 10;


-- # 3. Average Discount by Category

SELECT category, ROUND(AVG(discount_percentage), 2) 
AS avg_discount from products
GROUP by category
order by avg_discount DESC;

-- # 4. Fake Review Detection - Find products with many rating but with low reviews

SELECT * FROM products;

SELECT * from reviews;

SELECT product_id, product_name, rating
FROM products
WHERE rating < 2.5
ORDER BY rating ASC;

SELECT 
    p.product_id, 
    p.product_name, 
    COUNT(r.review_id) AS total_reviews, 
    p.rating
FROM products p
JOIN reviews r ON r.product_id = p.product_id
WHERE p.rating < 2.5
GROUP BY p.product_id, p.product_name, p.rating
HAVING COUNT(r.review_id) > 5
ORDER BY total_reviews DESC;


-- # 5. Top Active Reviewers - Users who review the most products (engagement analysis):


SELECT * FROM users;

SELECT * from reviews;

SELECT u.user_id , u.user_name, COUNT(r.review_id) AS total_reviews from users u 
JOIN reviews r ON u.user_id = r.user_id
GROUP BY u.user_id, u.user_name
ORDER BY total_reviews ;

# 6. Best category based on Average Ratings;

SELECT category, ROUND(AVG(rating),2) AS avg_rating FROM products
group by category 
ORDER BY avg_rating DESC
LIMIT 10;


# 7. TOP products with highest discounts 

SELECT product_id,product_name, actual_price, discounted_price, discount_percentage
FROM products
ORDER BY discount_percentage DESC LIMIT 10;

# 8 . Create VIEW : Discount Dashboard
CREATE VIEW discount_insights AS
SELECT product_id, product_name, actual_price, discounted_price, discount_percentage
FROM products
WHERE discount_percentage > 50;

SELECT * FROM discount_insights;

#9. Stored Procedure: Get Top Rated Products in a Category

DELIMITER //

CREATE PROCEDURE TopRatedProductsByCategory(IN input_category VARCHAR(255))
BEGIN
    SELECT product_id, product_name, rating
    FROM products
    WHERE category = input_category
    ORDER BY rating DESC
    LIMIT 10;
END //

DELIMITER ;


#10. 📊 Rating Distribution (Using CASE for Buckets)

SELECT 
	CASE
		WHEN rating BETWEEN 4.5 AND 5 THEN 'Excellent'
        WHEN rating BETWEEN 3.5 AND 4.49 THEN 'Good'
        WHEN rating BETWEEN 2.5 AND 3.49 THEN 'Average'
		ELSE 'Poor'
	END AS rating_category,
    COUNT(*) AS total_products
FROM products
GROUP BY rating_category;
        
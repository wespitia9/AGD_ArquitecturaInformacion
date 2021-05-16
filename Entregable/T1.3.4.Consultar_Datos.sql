select  p.seller_id as vendedor, count(r.review_score) as conteo, r.review_score as calificacion from producto as p, resena as r where
r.product_id = p.product_id and review_score <=3 group by p.seller_id, r.review_score order by r.review_score


select c.category_name, count(p.product_id) as conteo_productos, avg(r.review_score) as calificacion from categoria as c, producto as p,
         resena as r where r.product_id = p.product_id and p.category_id = c.category_id and r.review_score<=3
		 group by c.category_name order by calificacion
		 
		 
select c.city_name, avg(r.review_score) as calificacion from ciudad as c, resena as r, producto as p, orden as o, cliente as cl, ubicacion as u 
	   where r.product_id = p.product_id and r.order_id = o.order_id and o.customer_id = cl.customer_id and
	   cl.zip_code_prefix = u.zip_code_prefix and u.id_city = c.id_city and r.review_score<=3   
		 group by c.city_name order by calificacion

	
select ROUND ( ( cast (resenas_malas as decimal)/ cast(total as decimal) * 100),2)  as porcentaje_malas from 
	   ( select count(*) as resenas_malas, ( select count(*) from resena ) as total from resena where review_score <=3 ) as division 
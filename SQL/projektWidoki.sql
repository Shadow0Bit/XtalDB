-- widok dla sklepu
CREATE VIEW productIDview AS 
SELECT product_id, name FROM idprojekt.products
ORDER BY name;

-- widok 
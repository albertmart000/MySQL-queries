USE tienda;
#1 Nom de tots els productes:
SELECT nombre FROM producto;
#2 Noms i els preus de tots els productes.
SELECT nombre, precio FROM producto;
#3 Totes les columnes de la taula producto.
SELECT * FROM producto;
#4 Nom dels productes, preu en euros i preu en dòlars.
SELECT nombre, precio, ROUND(precio*0.99, 3) FROM producto;
#5 Nom dels productes, preu en euros i preu en dòlars fent servir àlies.
SELECT nombre AS 'nom del producte' , precio AS 'euros' , ROUND(precio*0.99, 3) AS 'dolars' FROM producto;
#6 Nom i preus de tots els productes, convertint els noms a majúscula.
SELECT UPPER(nombre), precio FROM producto;
#7 Nom i preu de tots els productes, convertint els noms a minúscula.
SELECT LOWER(nombre), precio FROM producto;
#8 Nom de tots els fabricants en una columna, i en una altra columna els dos primers caràcters del nom del fabricant en majúscules.
SELECT nombre, UPPER(LEFT(nombre, 2)) FROM fabricante;
#9 Nom i els preus de tots els productes, arrodonint el valor del preu.
SELECT nombre, ROUND(precio, 0) FROM producto;
#10 Noms i els preus de tots els productes, truncant el valor del preu per a mostrar-lo sense cap xifra decimal.
SELECT nombre, FLOOR(precio) FROM producto;
#11 Codi dels fabricants que tenen productes en la taula producto.
SELECT codigo_fabricante FROM producto;
#12 Codi dels fabricants que tenen productes en la taula producto, eliminant els codis repetits.
SELECT DISTINCT codigo_fabricante FROM producto;
#13 Nom dels fabricants ordenats de manera ascendent.
SELECT nombre FROM fabricante ORDER BY nombre ASC;
#14 Nom dels fabricants ordenats de manera descendent.
SELECT nombre FROM fabricante ORDER BY nombre DESC;
#15 Nom dels productes ordenats, en primer lloc, pel nom de manera ascendent i, en segon lloc, pel preu de manera descendent.
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;
#16 Les 5 primeres files de la taula fabricante.
SELECT * FROM fabricante LIMIT 5;
#17 2 files a partir de la quarta fila de la taula fabricante incloent La quarta fila.
SELECT * FROM fabricante LIMIT 3, 2;
#18 Nom i el preu del producte més barat utilitzant solament les clàusules ORDER BY i LIMIT. NOTA: Aquí no podria usar MIN(preu), necessitaria GROUP BY.
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;
#19 Nom i el preu del producte més car utilitzant solament les clàusules ORDER BY i LIMIT. NOTA: Aquí no podria usar MAX(preu), necessitaria GROUP BY.
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
#20 Nom de tots els productes del fabricant el codi del qual és igual a 2.
SELECT nombre FROM producto WHERE codigo_fabricante = 2;
#21 Nom del producte, preu i nom de fabricant de tots els productes.
SELECT producto.nombre, precio, fabricante.nombre FROM producto INNER JOIN fabricante ON fabricante.codigo = codigo_fabricante;
#22 Nom del producte, preu i nom de fabricant de tots els productes ordenats pel nom del fabricant, per ordre alfabètic.
SELECT producto.nombre, precio, fabricante.nombre FROM producto INNER JOIN fabricante ON fabricante.codigo = codigo_fabricante ORDER BY fabricante.nombre ASC;
#23 Codi del producte, nom del producte, codi del fabricant i nom del fabricant, de tots els productes.
SELECT producto.codigo, producto.nombre, fabricante.codigo, fabricante.nombre FROM producto INNER JOIN fabricante ON fabricante.codigo = codigo_fabricante;
#24 Nom del producte, preu i el nom del fabricant del producte més barat.
SELECT producto.nombre, precio, fabricante.nombre FROM producto INNER JOIN fabricante ON fabricante.codigo = codigo_fabricante ORDER BY precio ASC LIMIT 1;
#25 Nom del producte, preu i el nom del fabricant del producte més car.
SELECT producto.nombre, precio, fabricante.nombre FROM producto INNER JOIN fabricante ON fabricante.codigo = codigo_fabricante ORDER BY precio DESC LIMIT 1;
#26 Productes del fabricant Lenovo.
SELECT producto.* FROM producto INNER JOIN fabricante ON codigo_fabricante = fabricante.codigo AND fabricante.nombre = 'Lenovo';
#27 Productes del fabricant Crucial que tinguin un preu major de 200 €.
SELECT producto.* FROM producto INNER JOIN fabricante ON codigo_fabricante = fabricante.codigo AND fabricante.nombre = 'Crucial' AND precio > 200;
#28 Productes dels fabricants Asus, Hewlett-Packard y Seagate sense utilitzar l'operador IN.
SELECT producto.*, fabricante.nombre FROM producto INNER JOIN fabricante ON codigo_fabricante = fabricante.codigo WHERE fabricante.nombre='Asus' OR fabricante.nombre='Hewlett-Packard' OR fabricante.nombre='Seagate';
#29 Productes dels fabricants Asus, Hewlett-Packard y Seagate fent servir l'operador IN.
SELECT producto.* FROM producto INNER JOIN fabricante ON codigo_fabricante = fabricante.codigo AND fabricante.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');
#30 Nom i preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e.
SELECT fabricante.nombre, producto.nombre, precio FROM producto INNER JOIN fabricante ON codigo_fabricante = fabricante.codigo AND fabricante.nombre LIKE '%E';
#31 Nom i el preu de tots els productes dels fabricant el nom dels quals contingui el caràcter w.
SELECT fabricante.nombre, producto.nombre, precio FROM producto INNER JOIN fabricante ON codigo_fabricante = fabricante.codigo AND fabricante.nombre LIKE '%W%';
#32 Nom de producte, preu i nom de fabricant, de tots els productes que amb un preu major o igual a 180 € ordenats en primer lloc pel preu (en ordre descendent) i, en segon lloc, pel nom (en ordre ascendent).
SELECT producto.nombre, precio, fabricante.nombre FROM producto INNER JOIN fabricante ON codigo_fabricante = fabricante.codigo AND precio >= 180 ORDER BY precio DESC, producto.nombre ASC;
#33 Codi i el nom dels fabricant que tenen productes associats en la base de dades.
SELECT DISTINCT fabricante.* FROM producto INNER JOIN fabricante ON fabricante.codigo = codigo_fabricante;
#34 Fabricants amb els productes que té cadascun d'ells incluint els fabricants que no tenen productes.
SELECT fabricante.* , producto.* FROM fabricante LEFT JOIN producto ON fabricante.codigo=codigo_fabricante;
#35 Fabricants que no tenen cap producte associat.
SELECT fabricante.nombre FROM fabricante LEFT JOIN producto ON fabricante.codigo=producto.codigo_fabricantE WHERE producto.codigo IS NULL GROUP BY fabricante.nombre;
#36 Productes del fabricador Lenovo. (Sense utilitzar INNER JOIN).
SELECT producto.* FROM producto, fabricante WHERE codigo_fabricante = fabricante.codigo AND fabricante.nombre = 'Lenovo';
#37 Productes que tenen el mateix preu que el producte més car del fabricant Lenovo. (Sense usar INNER JOIN).
SELECT producto.* FROM producto, fabricante WHERE codigo_fabricante = fabricante.codigo AND precio=(SELECT MAX(precio) FROM producto,fabricante WHERE codigo_fabricante = fabricante.codigo AND fabricante.nombre='Lenovo');
#38 Nom del producte més car del fabricant Lenovo.
SELECT producto.nombre FROM producto INNER JOIN fabricante ON codigo_fabricante = fabricante.codigo AND fabricante.nombre = 'Lenovo' AND precio=(SELECT MAX(precio) FROM producto,fabricante WHERE codigo_fabricante = fabricante.codigo AND fabricante.nombre='Lenovo');
#39 Nom del producte més barat del fabricant Hewlett-Packard.
SELECT producto.* FROM producto, fabricante WHERE codigo_fabricante = fabricante.codigo AND fabricante.nombre = 'Hewlett-Packard' AND precio=(SELECT MIN(precio) FROM producto,fabricante WHERE codigo_fabricante = fabricante.codigo AND fabricante.nombre='Hewlett-Packard');
#40 Productes de la base de dades que tenen un preu major o igual al producte més car del fabricant Lenovo.
SELECT producto.* FROM producto, fabricante WHERE codigo_fabricante = fabricante.codigo AND precio >= (SELECT MAX(precio) FROM producto,fabricante WHERE codigo_fabricante = fabricante.codigo AND fabricante.nombre='Lenovo');
#41 Productes del fabricant Asus que tenen un preu superior al preu mitjà de tots els seus productes.
SELECT producto.* FROM producto INNER JOIN fabricante ON codigo_fabricante = fabricante.codigo AND fabricante.nombre = 'Asus' AND precio > (SELECT AVG(precio) FROM producto,fabricante WHERE codigo_fabricante = fabricante.codigo AND fabricante.nombre='Asus');
USE universidad;

#1 Primer cognom, segon cognom i el nom de tots els/les alumnes ordenat alfabèticament de menor a major.
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo='alumno' ORDER BY apellido1 ASC, apellido2 ASC, persona.nombre ASC;
#2 Nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo='alumno' AND telefono IS NULL;
#3 Alumnes que van néixer en 1999.
SELECT persona.* FROM persona WHERE tipo='alumno' AND YEAR(fecha_nacimiento)='1999';
#4 Professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT persona.* FROM persona WHERE tipo='profesor' AND telefono IS NULL AND nif LIKE '%K';
#5 Assignatures del primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT asignatura.* FROM asignatura WHERE cuatrimestre=1 AND curso=3 AND id_grado=7;
#6 Primer cognom, segon cognom, nom i nom del departament dels professors/es ordenats alfabèticament de menor a major pels cognoms i el nom.
SELECT persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre FROM persona INNER JOIN profesor ON persona.id=id_profesor INNER JOIN departamento ON departamento.id=id_departamento ORDER BY apellido1 ASC, apellido2 ASC, persona.nombre ASC;
#7 Nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT asignatura.nombre, anyo_inicio, anyo_fin FROM persona INNER JOIN alumno_se_matricula_asignatura ON persona.id=id_alumno INNER JOIN asignatura ON id_asignatura=asignatura.id INNER JOIN curso_escolar ON id_curso_escolar=curso_escolar.id WHERE nif='26902806M';
#8 Nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT departamento.nombre FROM departamento INNER JOIN profesor ON departamento.id=id_departamento INNER JOIN asignatura ON asignatura.id_profesor=profesor.id_profesor INNER JOIN grado ON asignatura.id_grado=id_grado WHERE grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)' GROUP BY departamento.nombre;
#9 Alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT persona.* FROM persona INNER JOIN alumno_se_matricula_asignatura ON persona.id=id_alumno INNER JOIN curso_escolar ON id_curso_escolar=curso_escolar.id WHERE curso_escolar.anyo_inicio ='2018' GROUP BY persona.id;

#Clàusules LEFT JOIN i RIGHT JOIN.

/*Per comprovar les queries 1 i 2 he afegit un professor i he canviat un valor de la taula profesor per a poder obtenir camps nuls. Si no tornava la taula buida i no podia estar segur de si la query estava plantejada correctament. Despres he desfet els canvis per poder segui amb l'exercici.*/

ALTER TABLE profesor MODIFY  id_departamento INT UNSIGNED NULL;
INSERT INTO persona VALUES (25, '00000000V', 'Profesor', 'Sin', 'Departamento', 'Barcelona', 'C/ Mayor', '678812017', '1994/06/24', 'M', 'profesor');
INSERT INTO profesor VALUES (25, null);

#1 Nom de tots els professors/es i els departaments que tenen vinculats ordenats alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre FROM persona LEFT JOIN profesor ON profesor.id_profesor=persona.id LEFT JOIN departamento ON profesor.id_departamento=departamento.id WHERE tipo='profesor' ORDER BY departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre;
#2 Nom dels professors/es que no estan associats a cap departament.
SELECT persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre FROM persona LEFT JOIN profesor ON profesor.id_profesor=persona.id LEFT JOIN departamento ON profesor.id_departamento=departamento.id WHERE tipo='profesor' AND departamento.id IS NULL ORDER BY departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre;

DELETE FROM profesor WHERE id_profesor=25;
DELETE FROM persona WHERE id=25;
ALTER TABLE profesor MODIFY  id_departamento INT UNSIGNED NOT NULL;

#3 Departaments que no tenen professors/es associats.
SELECT departamento.nombre FROM departamento LEFT JOIN profesor ON departamento.id=id_departamento WHERE id_profesor IS NULL GROUP BY departamento.nombre;
#4 Professors/es que no imparteixen cap assignatura.
SELECT persona.apellido1, persona.apellido2, persona.nombre FROM persona INNER JOIN profesor ON profesor.id_profesor=persona.id LEFT JOIN asignatura ON profesor.id_profesor=asignatura.id_profesor WHERE asignatura.id_profesor IS NULL;
#5 Assignatures que no tenen un professor/a assignat.
SELECT asignatura.* FROM profesor RIGHT JOIN asignatura ON profesor.id_profesor=asignatura.id_profesor WHERE asignatura.id_profesor IS NULL;
#6 Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT departamento.nombre FROM departamento LEFT JOIN profesor ON departamento.id=profesor.id_departamento LEFT JOIN asignatura ON asignatura.id_profesor=profesor.id_departamento WHERE asignatura.id_profesor IS NULL GROUP BY departamento.nombre;


# Consultes resum: 
#1 Nombre total d'alumnes.
SELECT COUNT(id) FROM persona WHERE tipo='alumno';
#2 Nombre d'alumnes que van néixer en 1999.
SELECT COUNT(id) FROM persona WHERE tipo='alumno' AND YEAR(fecha_nacimiento)='1999';
#3 Nombre professors/es hi ha en cada departament mostrant dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es ordenada de major a menor pel nombre de professors/es.
SELECT departamento.nombre, COUNT(id_profesor) FROM profesor INNER JOIN departamento ON id_departamento=departamento.id GROUP BY departamento.nombre ORDER BY COUNT(id_profesor) DESC;
#4 Departaments i el nombre de professors/es que hi ha en cadascun d'ells.
SELECT departamento.nombre, COUNT(id_profesor) FROM profesor RIGHT JOIN departamento ON departamento.id=profesor.id_departamento GROUP BY departamento.nombre ORDER BY COUNT(id_profesor) DESC;
SELECT departamento.nombre, COUNT(id_profesor) FROM departamento LEFT JOIN profesor ON departamento.id=profesor.id_departamento GROUP BY departamento.nombre ORDER BY COUNT(id_profesor) DESC;
#5 Graus i nombre d'assignatures que té cadascun ordenats de major a menor pel nombre d'assignatures.
SELECT grado.nombre, COUNT(asignatura.id) FROM grado LEFT JOIN asignatura ON grado.id=asignatura.id_grado GROUP BY grado.nombre ORDER BY COUNT(asignatura.id) DESC, grado.nombre; 
#6 Nom de tots els graus existents i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT grado.nombre, COUNT(asignatura.id) FROM grado JOIN asignatura ON grado.id=asignatura.id_grado GROUP BY grado.nombre HAVING COUNT(asignatura.id)>40; 
#7 Graus, tipus d'assignatura i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura.
SELECT grado.nombre, asignatura.tipo, SUM(asignatura.creditos) FROM asignatura JOIN grado ON grado.id=asignatura.id_grado GROUP BY grado.nombre, asignatura.tipo ORDER BY grado.nombre, SUM(asignatura.creditos) DESC;
#8 Nombre d'alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars.
SELECT curso_escolar.anyo_inicio, COUNT(DISTINCT alumno_se_matricula_asignatura.id_curso_escolar) FROM alumno_se_matricula_asignatura JOIN curso_escolar ON alumno_se_matricula_asignatura.id_asignatura=curso_escolar.ID GROUP BY curso_escolar.anyo_inicio;
# 9 Id, nom, primer cognom, segon cognom i nombre d'assignatures de cada professor/a tenint en compte aquells professors/es que no imparteixen cap assignatura.
SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2, COUNT(asignatura.id) FROM persona LEFT JOIN profesor ON persona.id=profesor.id_profesor LEFT JOIN asignatura ON profesor.id_profesor=asignatura.id_profesor WHERE persona.tipo='profesor' GROUP BY persona.id, persona.nombre, persona.apellido1, persona.apellido2 ORDER BY COUNT(asignatura.id) DESC, persona.nombre, persona.apellido1, persona.apellido2;
# 10  Retorna totes les dades de l'alumne/a més jove.
SELECT persona.* FROM persona WHERE fecha_nacimiento=(SELECT MIN(fecha_nacimiento) FROM persona where tipo= 'alumno');
# 11 Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
SELECT persona.apellido1, persona.apellido2, persona.nombre FROM persona INNER JOIN profesor ON profesor.id_profesor=persona.id LEFT JOIN asignatura ON profesor.id_profesor=asignatura.id_profesor WHERE asignatura.id_profesor IS NULL;

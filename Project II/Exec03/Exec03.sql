/****** Questão 3 ******/
/* Query 1: tipos distintos de atendimento */
SELECT DISTINCT(de_tipo_atendimento) as "Tipos de atendimento" FROM desfechos;

/* Query 2: desfechos distintos */
SELECT DISTINCT(de_desfecho) as "Desfechos distintos" FROM desfechos;

/* Query 3: desfechos com registro "óbito" e variações */
SELECT * FROM desfechos WHERE LOWER(de_desfecho) LIKE '%óbito%';

/* Query 4: desfecho igual a "Alta médica curado" */
SELECT * FROM desfechos WHERE de_desfecho = 'Alta médica curado';

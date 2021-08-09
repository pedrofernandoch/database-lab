/****** Questão 2 ******/
/* Query 1: data do exame mais recente e o mais antigo */
SELECT MAX(dt_coleta) AS "Mais recente", MIN(dt_coleta) AS "Mais antigo" FROM exames;

/* Query 2: contagem de exames do tipo "covid" e variações */
SELECT COUNT(*) AS "Quantidade de exames de covid" FROM exames WHERE LOWER(de_exame) LIKE '%covid%';

/* Query 3: exames com resultado "detectado" */
SELECT * FROM exames WHERE LOWER(de_resultado) = 'detectado';

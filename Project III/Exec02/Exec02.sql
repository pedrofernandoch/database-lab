/****** Questão 2 ******/	
/*
	Recupere os tipos de exames realizados para cada gênero, considerando os exames
	originados entre 10 e 20 clinicas distintas. Retorne, para cada tupla, o tipo de exame,
	gÊnero e contagem de exames realizados, ordenando de modo decrescente em relação à contagem.
*/
SELECT de_exame, ic_sexo, COUNT(id_exame) as qtd_exames
	FROM exames INNER JOIN pacientes ON exames.id_paciente = pacientes.id_paciente
	GROUP BY de_exame, ROLLUP(ic_sexo)
	HAVING COUNT(DISTINCT(de_origem)) BETWEEN 10 AND 20
	ORDER BY qtd_exames DESC;
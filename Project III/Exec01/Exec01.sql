/****** Questão 1 ******/	
/*
	Recupere, para cada paciente da cidade de São Paulo, a quantidade de exames e tipos
	de exames que foram realizados. Ordene de forma decrescente pela contagem do tipo de exame
*/
SELECT pacientes.id_paciente, COUNT(id_exame) as qtd_exames, COUNT(DISTINCT(de_exame)) as qtd_tipos
	FROM pacientes INNER JOIN exames ON pacientes.id_paciente = exames.id_paciente
	WHERE cd_municipio = 'SAO PAULO'
	GROUP BY ROLLUP(pacientes.id_paciente, de_exame)
	ORDER BY qtd_tipos DESC;
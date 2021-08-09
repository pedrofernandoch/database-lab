/****** Questão 3 ******/	
/*
	Crie uma tabela adicional, nomeada por “HistExamDesfechos” para organizar a sequência
	de exames e de desfechos de pacientes, criando um histórico de atividades de cada paciente.
	
	Esse histórico deve ter todos os atributos de exames e desfechos,
	ordenados pela data (de coleta e desfecho) e também pelo tipo de exame e analito colhido.
	
	Para organizar o histórico, obtenha identificadores sequencias das atividades por data, com
	contagem de resultados obtidos por exames.
	
	Para validar sua execução, retorne a contagem de tuplas da tabela e as vinte primeiras
	tuplas com as datas mais recentes (consultas separadas)
*/
CREATE TABLE hist_exam_desfechos AS 
	SELECT e.id_paciente, e.id_atendimento, e.id_exame, e.dt_coleta, e.de_origem, e.de_exame,
	e.de_analito, e.de_resultado, e.cd_unidade, e.de_valor_referencia, e.id_hospital,
	d.de_tipo_atendimento, d.id_clinica, d.dt_desfecho, d.de_desfecho,
	COUNT(e.de_resultado) OVER(PARTITION BY e.id_paciente),
	Row_Number() OVER(ORDER BY e.dt_coleta ASC, d.dt_desfecho ASC) "R#"
	FROM exames e LEFT JOIN desfechos d ON e.id_paciente = d.id_paciente
	ORDER BY e.dt_coleta ASC, d.dt_desfecho ASC, e.de_exame ASC, e.de_analito ASC;
	
	SELECT COUNT(*) FROM hist_exam_desfechos;
	
	SELECT * FROM hist_exam_desfechos 
	ORDER BY dt_coleta ASC, dt_desfecho ASC
	LIMIT 20;
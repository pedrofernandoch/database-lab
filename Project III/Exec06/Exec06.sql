/****** Questão 6 ******/
/*
	Recupere os dados de cada atendimento registrado, juntamente com o respectivo desfecho.
	Para cada tupla, retorne todos os atributos registrados em atendimento, incluindo
	a data e tipo do desfecho do atendimento, e também o total de exames de cada atendimento.
*/
-- Obs: Não houve necessidade do uso de Window Functions
SELECT atendimento.*, desfechos.dt_desfecho, desfechos.de_desfecho
	FROM atendimento LEFT JOIN desfechos ON atendimento.id_atendimento = desfechos.id_atendimento;
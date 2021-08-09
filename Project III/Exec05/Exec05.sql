/****** Questão 5 ******/
/* 
	Recupere quantos exames cada paciente realizou em cada atendimento registrado. Para
	cada tupla, retorne a identificação do paciente, as datas de internação e alta, o hospital
	e a quantidade de exames. 
*/
-- Obs: Não houve necessidade do uso de Window Function
SELECT id_paciente, interna, alta, id_hospital, totexam FROM atendimento;
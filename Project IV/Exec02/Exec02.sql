/****** Questão 2 ******/
CREATE OR REPLACE PROCEDURE RecuperaDesfechos(id_do_paciente TEXT, operador INTEGER)
LANGUAGE plpgsql
AS $$
	DECLARE reg RECORD;
		MessageText TEXT;
		HintText TEXT;
	BEGIN
		IF operador = 1 THEN 
			FOR reg IN -- Imprimindo tipos de desfechos encontrados
				SELECT DISTINCT(de_desfecho),
					MAX(dt_desfecho) OVER(PARTITION BY de_desfecho) AS dt_desfecho,
					COUNT(*) OVER(PARTITION BY de_desfecho) AS qtd
					FROM desfechos
			LOOP
				RAISE NOTICE '% | % | %', reg.de_desfecho, reg.dt_desfecho, reg.qtd;
			END LOOP;
		ELSEIF operador = 2 THEN
			IF id_do_paciente IS NULL OR id_do_paciente = '' THEN -- Conferindo se não é nulo
				RAISE EXCEPTION null_value_not_allowed USING MESSAGE = 'Id do paciente nulo.', HINT = 'Insira o ID do paciente a ser consultado!';
			ELSEIF (SELECT EXISTS(SELECT * FROM pacientes WHERE id_paciente = id_do_paciente)) IS FALSE THEN -- Conferindo se o paciente exsite
				RAISE EXCEPTION no_data_found USING MESSAGE = 'Id do paciente não foi encontrado.', HINT = 'Insira um ID de paciente válido.';
			ELSE
				FOR reg IN -- Imprimindo exames com desfecho encontrados
					SELECT e.de_exame, e.dt_coleta, d.dt_atendimento, d.dt_desfecho, d.id_hospital
						FROM exames e INNER JOIN pacientes pc ON e.id_paciente = pc.id_paciente
						LEFT JOIN desfechos d ON e.id_atendimento = d.id_atendimento
						WHERE e.id_paciente = id_do_paciente
				LOOP
					RAISE NOTICE '% | % | % | % | %', reg.de_exame, reg.dt_coleta, reg.dt_atendimento, reg.dt_desfecho, reg.id_hospital;
				END LOOP;
			END IF;
		ELSE
			IF id_do_paciente IS NULL OR id_do_paciente = '' THEN
				RAISE EXCEPTION null_value_not_allowed USING MESSAGE = 'Id do paciente nulo.', HINT = 'Insira o ID do paciente a ser consultado!';
			ELSEIF (SELECT EXISTS(SELECT * FROM pacientes WHERE id_paciente = id_do_paciente)) IS FALSE THEN
				RAISE EXCEPTION no_data_found USING MESSAGE = 'Id do paciente não foi encontrado.', HINT = 'Insira um ID de paciente válido.';
			ELSE
				FOR reg IN -- Imprimindo atendimentos encontrados usando a materialized view atendimentos
					SELECT * FROM atendimento WHERE id_paciente = id_do_paciente
				LOOP
					RAISE NOTICE '% | % | % | % | % | %', reg.id_paciente, reg.id_atendimento, reg.interna, reg.alta, reg.totexam, reg.id_hospital;
				END LOOP;
			END IF;
		END IF;
		EXCEPTION
			WHEN OTHERS THEN -- Imprimindo exceções encontradas
				GET STACKED DIAGNOSTICS MessageText = MESSAGE_TEXT,	HintText = PG_EXCEPTION_HINT;
				RAISE NOTICE E'Erro: %\nMensagem: %\nDica: %',
				SQLSTATE, MessageText, HintText;
	END;
$$
-- Testando
CALL recuperadesfechos(NULL, NULL);
CALL recuperadesfechos('', NULL);
CALL recuperadesfechos('123', NULL);
CALL recuperadesfechos(NULL, 1);
CALL recuperadesfechos('14AA36297925D3C82891D74FA28D7DF1', 2);
CALL recuperadesfechos('14AA36297925D3C82891D74FA28D7DF1', NULL);
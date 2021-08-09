/****** Questão 1 ******/
CREATE OR REPLACE PROCEDURE RecuperarExamesPaciente(id_do_paciente TEXT, tipo_de_exame TEXT, periodo INTEGER)
LANGUAGE plpgsql
AS $$
	DECLARE maxDate DATE;
		examesRecuperados REFCURSOR; 
		reg RECORD;
		MessageText TEXT;
		HintText TEXT;
	BEGIN
		IF id_do_paciente IS NULL OR id_do_paciente = '' THEN -- Conferindo se não é nulo
			RAISE EXCEPTION null_value_not_allowed USING MESSAGE = 'Id do paciente nulo.', HINT = 'Insira o ID do paciente a ser consultado!';
		ELSEIF (SELECT EXISTS(SELECT * FROM pacientes WHERE id_paciente = id_do_paciente)) IS FALSE THEN -- Conferindo se o paciente exsite
			RAISE EXCEPTION no_data_found USING MESSAGE = 'Id do paciente não foi encontrado.', HINT = 'Insira um ID de paciente válido.';
		ELSE
			SELECT MAX(dt_coleta) INTO maxDate FROM exames WHERE id_paciente = id_do_paciente; -- Pegando exame coletado mais recente do paciente
			IF tipo_de_exame IS NULL OR tipo_de_exame = '' THEN -- Todos os exames
				IF periodo IS NULL OR periodo <= 0 THEN -- Última semana
					OPEN examesRecuperados FOR SELECT pc.id_paciente, pc.cd_municipio, pc.id_hospital, e.id_atendimento,
					e.dt_coleta, e.de_origem, e.de_exame, e.de_analito, e.de_resultado, e.cd_unidade, e.de_valor_referencia
					FROM exames e INNER JOIN pacientes pc ON e.id_paciente = pc.id_paciente
					WHERE e.id_paciente = id_do_paciente AND e.dt_coleta >= (maxDate - 6);
				ELSE -- Período específico
					OPEN examesRecuperados FOR SELECT pc.id_paciente, pc.cd_municipio, pc.id_hospital, e.id_atendimento,
					e.dt_coleta, e.de_origem, e.de_exame, e.de_analito, e.de_resultado, e.cd_unidade, e.de_valor_referencia
					FROM exames e INNER JOIN pacientes pc ON e.id_paciente = pc.id_paciente
					WHERE e.id_paciente = id_do_paciente AND e.dt_coleta >= (maxDate - (periodo * 6));
				END IF;
			ELSE -- Exame específico
				IF periodo IS NULL OR periodo <= 0 THEN -- Última semana
					OPEN examesRecuperados FOR SELECT pc.id_paciente, pc.cd_municipio, pc.id_hospital, e.id_atendimento,
					e.dt_coleta, e.de_origem, e.de_exame, e.de_analito, e.de_resultado, e.cd_unidade, e.de_valor_referencia
					FROM exames e INNER JOIN pacientes pc ON e.id_paciente = pc.id_paciente
					WHERE e.id_paciente = id_do_paciente AND e.de_exame = tipo_de_exame AND e.dt_coleta >= (maxDate - 6);
				ELSE -- Período específico
					OPEN examesRecuperados FOR SELECT pc.id_paciente, pc.cd_municipio, pc.id_hospital, e.id_atendimento,
					e.dt_coleta, e.de_origem, e.de_exame, e.de_analito, e.de_resultado, e.cd_unidade, e.de_valor_referencia
					FROM exames e INNER JOIN pacientes pc ON e.id_paciente = pc.id_paciente
					WHERE e.id_paciente = id_do_paciente AND e.de_exame = tipo_de_exame AND e.dt_coleta >= (maxDate - (periodo * 6));
				END IF;
			END IF;
		END IF;
		LOOP -- Imprimindo registros encontrados
			FETCH examesRecuperados INTO reg;
			EXIT WHEN FOUND IS FALSE;
			RAISE NOTICE '% | % | % | % | % | % | % | % | % | % | %', reg.id_paciente, reg.cd_municipio, reg.id_hospital, reg.id_atendimento,
					reg.dt_coleta, reg.de_origem, reg.de_exame, reg.de_analito, reg.de_resultado, reg.cd_unidade, reg.de_valor_referencia;
		END LOOP;
		CLOSE examesRecuperados;
		EXCEPTION -- Imprimindo exceções encontradas
			WHEN OTHERS THEN
				GET STACKED DIAGNOSTICS MessageText = MESSAGE_TEXT,	HintText = PG_EXCEPTION_HINT;
				RAISE NOTICE E'Erro: %\nMensagem: %\nDica: %',
				SQLSTATE, MessageText, HintText;
	END;
$$
-- Testando
CALL recuperarexamespaciente(NULL, NULL, NULL);
CALL recuperarexamespaciente('', NULL, NULL);
CALL recuperarexamespaciente('123', NULL, NULL);
CALL recuperarexamespaciente('14AA36297925D3C82891D74FA28D7DF1', NULL, NULL);
CALL recuperarexamespaciente('14AA36297925D3C82891D74FA28D7DF1', 'fibrinogênio, dosagem do', NULL);
CALL recuperarexamespaciente('14AA36297925D3C82891D74FA28D7DF1', 'fibrinogênio, dosagem do', 3);
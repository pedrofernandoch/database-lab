/****** Questão 3 ******/
CREATE EXTENSION pgcrypto;
CREATE OR REPLACE FUNCTION password_hash(passwordString TEXT)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
	DECLARE MessageText TEXT;
		HintText TEXT;
	BEGIN
		IF passwordString IS NULL OR passwordString = '' THEN -- Conferindo se não é nulo
			RAISE EXCEPTION null_value_not_allowed USING MESSAGE = 'Senha nula', HINT = 'Insira uma senha para ober seu retorno criptografado';
			RETURN NULL;
		ELSE -- Retornando senha criptografada
			RETURN crypt(passwordString, gen_salt('md5'));
		END IF;
	EXCEPTION -- Imprimindo exceções encontradas
			WHEN OTHERS THEN
				GET STACKED DIAGNOSTICS MessageText = MESSAGE_TEXT,	HintText = PG_EXCEPTION_HINT;
				RAISE NOTICE E'Erro: %\nMensagem: %\nDica: %',
				SQLSTATE, MessageText, HintText;
	END;
$$
-- Imprimindo casos de teste
DO $$
	BEGIN
		RAISE NOTICE 'Senha original: scc0541LabBD, Hash: %', password_hash('scc0541LabBD');
		RAISE NOTICE 'Senha original: covid19-Fapesp, Hash: %', password_hash('covid19-Fapesp');
		RAISE NOTICE 'Senha original: BˆrJgb, Hash: %', password_hash('BˆrJgb');
		RAISE NOTICE 'Senha original: Z67&*T, Hash: %', password_hash('Z67&*T');
	END;
$$
/****** Questão 4 ******/
-- Adicionando campo pwd na tabela pacientes
ALTER TABLE pacientes
    ADD COLUMN pwd text;

-- Criando tabela temporária
CREATE TABLE temp_pacientes AS 
	SELECT * FROM pacientes LIMIT 5;

-- Atualizando senhas usando função de hash
UPDATE temp_pacientes
	SET pwd = password_hash(CONCAT(id_paciente, ic_sexo, aa_nascimento));

-- Verificando atualização
SELECT * FROM pacientes LIMIT 5;
SELECT * FROM temp_pacientes;

-- Testando autenticação
SELECT (pwd = crypt(CONCAT(id_paciente, ic_sexo, aa_nascimento), pwd)) AS pswmatch FROM temp_pacientes WHERE id_paciente = '8F3A4E28494D5DC7CE33BCB1DD4A3B50';
-- Retorno esperado: true
SELECT (pwd = crypt(CONCAT('senha errada'), pwd)) AS pswmatch FROM temp_pacientes WHERE id_paciente = '8F3A4E28494D5DC7CE33BCB1DD4A3B50';
-- Retorno esperado: false

-- Removendo tabela temporária
DROP TABLE temp_pacientes;

-- Atualizando senhas usando função hash
UPDATE pacientes
	SET pwd = password_hash(CONCAT(id_paciente, ic_sexo, aa_nascimento));
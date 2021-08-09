/****** Questão 1 ******/
/* Query 1: quantidade de homens e mulheres registrados */
SELECT ic_sexo, COUNT(ic_sexo) FROM pacientes GROUP BY ic_sexo; 

/* Query 2: ano de nascimento do paciente mais idoso */
SELECT MIN(aa_nascimento) as "Mais velho", MAX(aa_nascimento) as "Mais novo" FROM pacientes;

/* Query 3: quantidade de anos de nascimento distintos */
SELECT COUNT(DISTINCT(aa_nascimento)) as "Quantidade de anos de nascimento distintos" FROM pacientes;

/****** Questão 2 ******/
/* Query 1: data do exame mais recente e o mais antigo */
SELECT MAX(dt_coleta) AS "Mais recente", MIN(dt_coleta) AS "Mais antigo" FROM exames;

/* Query 2: contagem de exames do tipo "covid" e variações */
SELECT COUNT(*) AS "Quantidade de exames de covid" FROM exames WHERE LOWER(de_exame) LIKE '%covid%';

/* Query 3: exames com resultado "detectado" */
SELECT * FROM exames WHERE LOWER(de_resultado) = 'detectado';

/****** Questão 3 ******/
/* Query 1: tipos distintos de atendimento */
SELECT DISTINCT(de_tipo_atendimento) as "Tipos de atendimento" FROM desfechos;

/* Query 2: desfechos distintos */
SELECT DISTINCT(de_desfecho) as "Desfechos distintos" FROM desfechos;

/* Query 3: desfechos com registro "óbito" e variações */
SELECT * FROM desfechos WHERE LOWER(de_desfecho) LIKE '%óbito%';

/* Query 4: desfecho igual a "Alta médica curado" */
SELECT * FROM desfechos WHERE de_desfecho = 'Alta médica curado';

/****** Questão 4 ******/
/* Query 1: alterar o tipo de dados do atributo “id hospital” para o tipo TEXT */
ALTER TABLE pacientes
    ALTER COLUMN id_hospital TYPE text;
ALTER TABLE exames
    ALTER COLUMN id_hospital TYPE text;
ALTER TABLE desfechos
    ALTER COLUMN id_hospital TYPE text;

/* Query 2: atualizar atributo id_hospital, “0” para “HCFMUSP” e “1” para “HSL” */
UPDATE pacientes SET id_hospital = CASE id_hospital WHEN '0' THEN 'HCFMUSP' WHEN '1' THEN 'HSL' END;
UPDATE exames SET id_hospital = CASE id_hospital WHEN '0' THEN 'HCFMUSP' WHEN '1' THEN 'HSL' END;
UPDATE desfechos SET id_hospital = CASE id_hospital WHEN '0' THEN 'HCFMUSP' WHEN '1' THEN 'HSL' END;

/****** Questão 5 ******/
/* Query 1: criar nova tabela Exames_UTI a partir da tabela exames que a origem seja UTI */
CREATE TABLE Exames_UTI AS SELECT * FROM exames WHERE de_origem = 'UTI';

/* Query 2: contagem de exames da tabela Exames_UTI */
SELECT COUNT(*) FROM Exames_UTI;
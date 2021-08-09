/* CRIANDO TABELA HOSPITAL */
CREATE TABLE hospital (
	id SERIAL,
	nome character varying(100) NOT NULL,
	PRIMARY KEY (id)
);

/* INSERINDO OS DOIS HOSPITAIS A SEREM TRABALHADOS */
INSERT INTO hospital (nome)
	VALUES('Hospital Sírio-Libanês');
	
INSERT INTO hospital (nome)
	VALUES('Hospital das Clínicas da Faculdade de Medicina da Universidade de São Paulo');

/* CRIANDO TABELA PACIENTE COM HOSPITAL DEFAULT SÍRIO-LIBANÊS */
CREATE TABLE paciente(
	id_paciente character(32) NOT NULL,
	ic_sexo char NOT NULL,
	aa_nascimento character(4) NOT NULL,
	cd_pais character(2),
	cd_uf character(2),
	cd_municipio character varying(100),
	cd_cepreduzio character(5),
	id_hospital smallint NOT NULL DEFAULT 1,
	PRIMARY KEY(id_paciente, id_hospital),
	CONSTRAINT fk_hospital
		FOREIGN KEY(id_hospital)
			REFERENCES hospital(id)
				ON DELETE CASCADE
				ON UPDATE CASCADE
);

/* COPIANDO DADOS DOS PACIENTES DO HOSPITAL SÍRIO-LIBANÊS PARA A TABELA PACIENTE */
COPY paciente (id_paciente, ic_sexo, aa_nascimento, cd_pais, cd_uf, cd_municipio, cd_cepreduzio)
	FROM 'C:\Users\Public\Documents\HSL_Janeiro2021\HSL_Pacientes_3.csv'
		DELIMITER '|' CSV HEADER;

/* ALTERANDO DEFAULT PARA HOSPITAL DAS CLÍNICAS */
ALTER TABLE paciente
    ALTER COLUMN id_hospital SET DEFAULT 2;
	
/* COPIANDO DADOS DOS PACIENTES DO HOSPITAL DAS CLÍNICAS PARA A TABELA PACIENTE */
COPY paciente (id_paciente, ic_sexo, aa_nascimento, cd_pais, cd_uf, cd_municipio, cd_cepreduzio)
	FROM 'C:\Users\Public\Documents\HC_Janeiro2021\HC_PACIENTES_1.csv'
		DELIMITER '|' CSV HEADER;

/* NÚMERO DE PACIENTES NO TOTAL */
SELECT COUNT(*) FROM paciente

/* NÚMERO DE PACIENTES DISTINTOS NO TOTAL */
SELECT COUNT(DISTINCT(id_paciente)) FROM paciente

/* CRIANDO TABELA EXAME_TEMP TEMPORARIA COM HOSPITAL DEFAULT SÍRIO-LIBANÊS */
CREATE TABLE exame_temp(
	id_exame SERIAL,
	id_paciente character(32) NOT NULL,
	id_atendimento character(32) NOT NULL,
	dt_coleta date NOT NULL,
	de_origem character(100) NOT NULL,
	de_exame character(1000) NOT NULL,
	de_analito character(1000) NOT NULL,
	de_resultado text,
	cd_unidade character(30),
	de_valor_referencia text,
	id_hospital smallint NOT NULL DEFAULT 1,
	PRIMARY KEY(id_exame),
	CONSTRAINT fk_paciente
		FOREIGN KEY(id_paciente, id_hospital)
			REFERENCES paciente(id_paciente, id_hospital)
);

/* COPIANDO DADOS DOS EXAMES DO HOSPITAL SÍRIO-LIBANÊS PARA A TABELA EXAME_TEMP */
COPY exame_temp (id_paciente, id_atendimento, dt_coleta, de_origem, de_exame, de_analito, de_resultado, cd_unidade, de_valor_referencia)
	FROM 'C:\Users\Public\Documents\HSL_Janeiro2021\HSL_Exames_3.csv'
		DELIMITER '|' CSV HEADER;
		
/* ALTERANDO DEFAULT PARA HOSPITAL DAS CLÍNICAS */
ALTER TABLE exame_temp
    ALTER COLUMN id_hospital SET DEFAULT 2;

/* COPIANDO DADOS DOS EXAMES DO HOSPITAL DAS CLÍNICAS PARA A TABELA EXAME_TEMP */
COPY exame_temp (id_paciente, id_atendimento, dt_coleta, de_origem, de_exame, de_analito, de_resultado, cd_unidade, de_valor_referencia)
	FROM 'C:\Users\Public\Documents\HC_Janeiro2021\HC_EXAMES_1.csv'
		DELIMITER '|' CSV HEADER;

/* CRIANDO TABELA DESFECHO_TEMP TEMPORARIA COM HOSPITAL DEFAULT SÍRIO-LIBANÊS */
CREATE TABLE desfecho_temp(
	id_paciente character(32) NOT NULL,
	id_atendimento character(32) NOT NULL,
	dt_atendimento character(10) NOT NULL, /* OBS: Foi preciso colocar a data como character devido inconsistência dos dados disponibilizados */
	de_tipo_atendimento text NOT NULL,
	id_clinica integer NOT NULL,
	de_clinica text NOT NULL,
	dt_desfecho character(10) NOT NULL, /* OBS: Foi preciso colocar a data como character devido inconsistência dos dados disponibilizados */
	de_desfecho text NOT NULL,
	id_hospital smallint NOT NULL DEFAULT 1,
	PRIMARY KEY(id_paciente, id_atendimento),
	CONSTRAINT fk_paciente
		FOREIGN KEY(id_paciente, id_hospital)
			REFERENCES paciente(id_paciente, id_hospital)
);

/* COPIANDO DADOS DOS DESFECHOS DO HOSPITAL SÍRIO-LIBANÊS PARA A TABELA DESFECHO_TEMP */
COPY desfecho_temp (id_paciente, id_atendimento, dt_atendimento, de_tipo_atendimento, id_clinica, de_clinica, dt_desfecho, de_desfecho)
	FROM 'C:\Users\Public\Documents\HSL_Janeiro2021\HSL_Desfechos_3.csv'
		DELIMITER '|' CSV HEADER;

/* CRIANDO TABELA CLINICA */
CREATE TABLE clinica(
	id_clinica integer NOT NULL,
	de_clinica text NOT NULL,
	PRIMARY KEY(id_clinica)
);

/* COPIANDO AS CLÍNICAS DISTINTAS DA TABELA DESFECHO_TEMP PARA A TABELA CLINICA */
INSERT INTO clinica (id_clinica, de_clinica)
	SELECT DISTINCT id_clinica, de_clinica
		FROM desfecho_temp;
		
/* NUMERO DE CLÍNICAS NO TOTAL */
SELECT COUNT(*) FROM clinica

/* CRIANDO TABELA ATENDIMENTO */
CREATE TABLE atendimento(
	id_paciente character(32) NOT NULL,
	id_hospital smallint NOT NULL,
	id_atendimento character(32) NOT NULL,
	dt_atendimento character(10), /* OBS: Foi preciso colocar a data como character devido inconsistência dos dados disponibilizados */
	de_tipo_atendimento text,
	id_clinica integer,
	PRIMARY KEY(id_atendimento),
	CONSTRAINT fk_paciente
		FOREIGN KEY(id_paciente, id_hospital)
			REFERENCES paciente(id_paciente, id_hospital)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
	CONSTRAINT fk_clinica
		FOREIGN KEY(id_clinica)
			REFERENCES clinica(id_clinica)
);

/* COPIANDO OS ATENDIMENTOS DA TABELA EXAMES_TEMP PARA A TABELA ATENDIMENTO */
INSERT INTO atendimento (id_paciente, id_hospital, id_atendimento)
	SELECT DISTINCT id_paciente, id_hospital, id_atendimento
		FROM exame_temp;

/* COPIANDO OS ATENDIMENTOS DA TABELA DESFECHO_TEMP PARA A TABELA ATENDIMENTO */
INSERT INTO atendimento (id_paciente, id_hospital, id_atendimento, dt_atendimento, de_tipo_atendimento, id_clinica)
	SELECT id_paciente, id_hospital, id_atendimento, dt_atendimento, de_tipo_atendimento, id_clinica
		FROM desfecho_temp
			ON CONFLICT DO NOTHING;
		
/* NUMERO DE ATENDIMENTOS NO TOTAL */
SELECT COUNT(*) FROM atendimento

/* CRIANDO TABELA DESFECHO */
CREATE TABLE desfecho(
	id_atendimento character(32) NOT NULL,
	dt_desfecho character(10) NOT NULL, /* OBS: Foi preciso colocar a data como character devido inconsistência dos dados disponibilizados */
	de_desfecho text NOT NULL,
	PRIMARY KEY(id_atendimento),
	CONSTRAINT fk_atendimento
		FOREIGN KEY(id_atendimento)
			REFERENCES atendimento(id_atendimento)
				ON DELETE CASCADE
				ON UPDATE CASCADE
);

/* COPIANDO OS DESFECHOS DA TABELA DESFECHO_TEMP PARA A TABELA DESFECHO */
INSERT INTO desfecho (id_atendimento, dt_desfecho, de_desfecho)
	SELECT id_atendimento, dt_desfecho, de_desfecho
		FROM desfecho_temp;

/* NUMERO DE DESFECHOS NO TOTAL */
SELECT COUNT(*) FROM desfecho
		
/* CRIANDO TABELA EXAME */
CREATE TABLE exame(
	id_exame integer NOT NULL,
	id_atendimento character(32) NOT NULL,
	dt_coleta date NOT NULL,
	de_origem character(100) NOT NULL,
	de_exame character(1000) NOT NULL,
	de_analito character(1000) NOT NULL,
	de_resultado text,
	cd_unidade character(30),
	de_valor_referencia text,
	PRIMARY KEY(id_exame),
	CONSTRAINT fk_atendimento
		FOREIGN KEY(id_atendimento)
			REFERENCES atendimento(id_atendimento)
				ON DELETE CASCADE
				ON UPDATE CASCADE
);

/* COPIANDO OS EXAMES DA TABELA EXAME_TEMP PARA A TABELA EXAME */
INSERT INTO exame (id_exame, id_atendimento, dt_coleta, de_origem, de_exame, de_analito, de_resultado, cd_unidade, de_valor_referencia)
	SELECT id_exame, id_atendimento, dt_coleta, de_origem, de_exame, de_analito, de_resultado, cd_unidade, de_valor_referencia
		FROM exame_temp;
		
/* NUMERO DE EXAMES NO TOTAL */
SELECT COUNT(*) FROM exame

/* NUMERO DE EXAMES DISTINTOS NO TOTAL */
SELECT COUNT(DISTINCT(LOWER(de_exame))) FROM exame
	
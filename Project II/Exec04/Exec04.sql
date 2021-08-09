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

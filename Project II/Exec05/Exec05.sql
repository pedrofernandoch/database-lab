/****** Questão 5 ******/
/* Query 1: criar nova tabela Exames_UTI a partir da tabela exames que a origem seja UTI */
CREATE TABLE Exames_UTI AS SELECT * FROM exames WHERE de_origem = 'UTI';

/* Query 2: contagem de exames da tabela Exames_UTI */
SELECT COUNT(*) FROM Exames_UTI;

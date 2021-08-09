/****** Questão 1 ******/
/* Query 1: quantidade de homens e mulheres registrados */
SELECT ic_sexo, COUNT(ic_sexo) FROM pacientes GROUP BY ic_sexo; 

/* Query 2: ano de nascimento do paciente mais idoso */
SELECT MIN(aa_nascimento) as "Mais velho", MAX(aa_nascimento) as "Mais novo" FROM pacientes;

/* Query 3: quantidade de anos de nascimento distintos */
SELECT COUNT(DISTINCT(aa_nascimento)) as "Quantidade de anos de nascimento distintos" FROM pacientes;

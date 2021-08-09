UPDATE exames    -- in 5 min 28 secs
    SET DE_Exame=
	   regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
	   regexp_replace(
	   regexp_replace(DE_Exame, '.*', lower(DE_Exame))
	       , '(atico|ático|actico|áctico)', 'ático', 'g')
		   , '(erica)', 'érica', 'g')
		   , '(urica)', 'úrica', 'g')
		   , '(erico)', 'érico', 'g')
		   , '(urico)', 'úrico', 'g')
		   , '(anico)', 'ânico', 'g')
		   , '(alico)', 'álico', 'g')
		   , '(elico)', 'élico', 'g')
		   , '(ilico)', 'ílico', 'g')
		   , '(olico)', 'ólico', 'g')
		   , '(onica)\M', 'ônica', 'g')
		   , '(onico)', 'ônico', 'g')
		   , '(proico)', 'próico', 'g')
		   , '(virus)', 'vírus', 'g')
		   , '(proteina)', 'proteína', 'g')
		   , '(minio)', 'mínio', 'g')
		   , '(monia)\M', 'mônia', 'g')
		   , '(acteria)', 'actéria', 'g')
		   , '(acido)', 'ácido', 'g')
		   , '(rapid)', 'rápid', 'g'),
    DE_Analito=       
	   regexp_replace(
	   regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
       regexp_replace(
	   regexp_replace(DE_Exame, '.*', lower(DE_Exame))
	       , '(atico|ático|actico|áctico)', 'ático', 'g')
		   , '(erica)', 'érica', 'g')
		   , '(urica)', 'úrica', 'g')
		   , '(erico)', 'érico', 'g')
		   , '(urico)', 'úrico', 'g')
		   , '(anico)', 'ânico', 'g')
		   , '(alico)', 'álico', 'g')
		   , '(elico)', 'élico', 'g')
		   , '(ilico)', 'ílico', 'g')
		   , '(olico)', 'ólico', 'g')
		   , '(onica)\M', 'ônica', 'g')
		   , '(onico)', 'ônico', 'g')
		   , '(proico)', 'próico', 'g')
		   , '(virus)', 'vírus', 'g')
		   , '(proteina)', 'proteína', 'g')
		   , '(minio)', 'mínio', 'g')
		   , '(monia)\M', 'mônia', 'g')
		   , '(acteria)', 'actéria', 'g')
		   , '(acido)', 'ácido', 'g')
		   , '(rapid)', 'rápid', 'g');

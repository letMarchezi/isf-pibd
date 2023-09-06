-- AUTOR: Matheus da Silv Vieira 791085
-- verificaProficiencia -> Verifica a proficiência do professor

CREATE OR REPLACE FUNCTION valida_proficiencia(input_proficiencia VARCHAR)
RETURN BOOLEAN AS $$
BEGIN 
	SELECT 
		nivel
	FROM curso_idioma
	CASE 
		WHEN UPPER(nivel) = 'A1' THEN 6
		WHEN UPPER(nivel) = 'A2' THEN 5
		WHEN UPPER(nivel) = 'B1' THEN 4 
		WHEN UPPER(nivel) = 'B2' THEN 3
		WHEN UPPER(nivel) = 'C1' THEN 2
		WHEN UPPER(nivel) = 'C2' THEN 1
	END AS 'curso_nivel_num'
	CASE 
		WHEN UPPER(input_proficiencia) = 'A1' THEN 6
		WHEN UPPER(input_proficiencia) = 'A2' THEN 5
		WHEN UPPER(input_proficiencia) = 'B1' THEN 4 
		WHEN UPPER(input_proficiencia) = 'B2' THEN 3
		WHEN UPPER(input_proficiencia) = 'C1' THEN 2
		WHEN UPPER(input_proficiencia) = 'C2' THEN 1
	END AS 'input_prof_num'
	IF input_prof_num >= curso_nivel_num THEN
		RETURN TRUE;
	ELSE
		RETURN FALSE;
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION valida_proficiencia_trigger()
RETURNS TRIGGER AS $$
BEGIN 
	IF NOT valida_proficiencia(NEW.proficiencia) THEN
		RAISE EXCEPTION 'Nível mínimo de proficiência não foi atendido';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE VIEW ApresentaProficienciaCursoProf AS
SELECT 
	id_turma_espec,
	cpf_docente,
	nivel_curso,
	i_profisf.proficiencia AS proficiencia_prof,
	i_profisf.idioma AS idioma_prof
FROM
( 
	SELECT 
		doc_turma_espec.id_turma_especializacao AS id_turma_espec,
		doc_turma_espec.cpf_docente AS cpf_docente,
		c_idioma.nivel AS nivel_curso
	FROM docente_ministrante_leciona_turma_especializacao doc_turma_espec
	INNER JOIN curso_idioma c_idioma ON c_idioma.id_curso_idioma = doc_turma_espec.id_turma_especializacao
)subquery1
INNER JOIN idioma_professor_isf i_profisf ON i_profisf.cpf_professor_isf = subquery1.cpf_docente;

CREATE TRIGGER validar_profic
BEFORE INSERT OR UPDATE ON ApresentaProficienciaCursoProf
FOR EACH ROW
EXECUTE FUNCTION valida_proficiencia_trigger();
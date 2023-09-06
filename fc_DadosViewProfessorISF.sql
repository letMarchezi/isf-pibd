-- Autor: Matheus da Silva Vieira 791085 BCC
-- DadosViewProfessorISF -> ITVF para voltar uma tabela com os dados do professorISF agrupados por idioma e proficiência
CREATE OR REPLACE FUNCTION GetDadosProfessorISF()

RETURNS TABLE (
	idioma VARCHAR(30),
	proficiencia VARCHAR(5)
)

AS $$

BEGIN
	
	RETURN QUERY

	SELECT 
		idm_prof.idioma AS idioma, 
		idm_prof.proficiencia AS proficiencia
	FROM 
		idioma_professor_isf idm_prof
	INNER JOIN 
		professor_isf pisf ON idm_prof.cpf_professor_isf = pisf.cpf_professor_isf;
		
END;
$$ LANGUAGE plpgsql;





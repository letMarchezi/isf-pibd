-- DROP FUNCTION get_estat_turma_especializacao();
CREATE OR REPLACE FUNCTION get_estat_turma_especializacao()
RETURNS TABLE (
    cpf VARCHAR(11),  
    situacao_da_matricula VARCHAR(20)
) AS $$
BEGIN
    RETURN QUERY
    SELECT
      cpf_aluno,
	  situacao_aluno
    FROM
      aluno_especializacao_cursa_turma;
END;
$$ LANGUAGE plpgsql;

-- TEST
SELECT * FROM get_estat_turma_especializacao();
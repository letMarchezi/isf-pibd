CREATE OR REPLACE FUNCTION get_professores_isf_agrupados_por_orientador() RETURNS TABLE (
    orientador VARCHAR(11),
    cpf_professor_isf VARCHAR(11),
    primeiro_nome VARCHAR(50),
    sobrenome VARCHAR(50),
    genero VARCHAR(20),
    data_nascimento DATE,
    numero INTEGER,
    complemento VARCHAR(100),
    cep_usuario VARCHAR(8),
    cnpj_ies_associada VARCHAR(14)
) LANGUAGE plpgsql AS
$$
BEGIN
    RETURN QUERY
    SELECT
        COALESCE(o.cpf_docente, 'Não Orientado') AS orientador,
        p.cpf_professor_isf,
        u.primeiro_nome,
        u.sobrenome,
        u.genero,
        u.data_nascimento,
        u.numero,
        u.complemento,
        u.cep_usuario,
        u.cnpj_ies_associada
    FROM
        professor_isf p
    LEFT JOIN
        docente_orientador_orienta_professorIsf o ON p.cpf_professor_isf = o.cpf_professor_isf
    LEFT JOIN
        usuario u ON p.cpf_professor_isf = u.cpf
    order by
    	orientador;
END;
$$;
--SELECT * FROM get_professores_isf_agrupados_por_orientador();


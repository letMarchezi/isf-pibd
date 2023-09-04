------------------------------------- ListaTurmaIdiomaDataFimASC -------------------------------------
DROP FUNCTION lista_turma_idioma_data_fim_ASC();
CREATE OR REPLACE FUNCTION lista_turma_idioma_data_fim_ASC()
RETURNS TABLE (
    turma_coletiva INTEGER,  
    curso_idioma INTEGER,        

    sigla VARCHAR(10),
    perfil_universidade DECIMAL(1),

    vagas_reservadas DECIMAL(4),
    inicio TIMESTAMP,
    fim TIMESTAMP,
    vagas DECIMAL(4)
) AS $$
BEGIN
    RETURN QUERY
    SELECT
            id_turma_coletiva,
			id_curso_idioma,        

			sigla_turma,
			semestre, 

			qtde_vagas_reservadas,
			hora_inicio,
			hora_fim,
			qtde_vagas
    FROM
        turma_oferta_coletiva
    ORDER BY
        hora_fim ASC;
END;
$$
LANGUAGE plpgsql;

/*USO:
SELECT * FROM lista_turma_idioma_data_fim_ASC();
*/

--FUNCTION)
--ITVF para voltar estatísticas das turmas de idioma 
--nome do arquivo: GetEstatTurmaIdioma.sql

CREATE OR REPLACE FUNCTION get_estatisticas_turma_coletiva()
    RETURNS TABLE (
        id_turma_coletiva INT,
        id_curso_idioma INT,
        sigla_turma VARCHAR(10),
        semestre DECIMAL(1),
        qtde_vagas_reservadas DECIMAL(4),
        qtde_vagas DECIMAL(4),
        vagas_disponiveis DECIMAL(4),
        hora_inicio TIMESTAMP,
        hora_fim TIMESTAMP
    ) LANGUAGE plpgsql AS
    $$ BEGIN
        RETURN QUERY 
            SELECT
                toc.id_turma_coletiva,
                toc.id_curso_idioma,
                toc.sigla_turma,
                toc.semestre,
                toc.qtde_vagas_reservadas,
                toc.qtde_vagas,
                (toc.qtde_vagas - COALESCE(toc.qtde_vagas_reservadas,0)) AS vagas_disponiveis,
                toc.hora_inicio,
                toc.hora_fim
            FROM turma_oferta_coletiva toc;
        END; 
     $$;
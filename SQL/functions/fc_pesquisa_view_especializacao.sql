CREATE OR REPLACE FUNCTION buscar_turma_especializacao(pesquisa TEXT)
RETURNS TABLE (
    id_turma_especializacao INT,
    nome_componente VARCHAR(100),
    sigla VARCHAR(15),
    semestre DECIMAL(1),
    hora_inicio TIMESTAMP,
    hora_fim TIMESTAMP,
    qtde_vagas DECIMAL(4)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        te.id_turma_especializacao,
        te.nome_componente,
        te.sigla,
        te.semestre,
        te.hora_inicio,
        te.hora_fim,
        te.qtde_vagas
    FROM
        view_turma_especializacao te
    WHERE
        CAST(te.id_turma_especializacao AS TEXT) ILIKE '%' || pesquisa || '%'
        OR te.nome_componente ILIKE '%' || pesquisa || '%'
        OR te.sigla ILIKE '%' || pesquisa || '%'
        OR CAST(te.semestre AS TEXT) ILIKE '%' || pesquisa || '%'
		OR CAST(te.hora_inicio AS TEXT) ILIKE '%' || pesquisa || '%'
		OR CAST(te.hora_fim AS TEXT) ILIKE '%' || pesquisa || '%'
		OR CAST(te.qtde_vagas AS TEXT) ILIKE '%' || pesquisa || '%';
END;
$$ LANGUAGE plpgsql;

--select * from turma_especializacao;
--SELECT * FROM buscar_turma_especializacao('Componente2');
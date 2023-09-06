-- Esta função foi criada para buscar informações nas turmas de idioma usando os parâmetros fornecidos.
CREATE OR REPLACE FUNCTION function_busca_view_turmas_idioma(
    search_nome_componente VARCHAR(100) DEFAULT NULL, -- Parâmetro: Nome do componente de especialização a ser pesquisado
    search_sigla VARCHAR(15) DEFAULT NULL, -- Parâmetro: Sigla da turma a ser pesquisada
    search_semestre DECIMAL(1) DEFAULT NULL, -- Parâmetro: Semestre da turma a ser pesquisado
    search_vagas_disponiveis VARCHAR DEFAULT NULL -- Parâmetro: Vagas disponíveis na turma a ser pesquisada
)
RETURNS TABLE (
    nome_componente VARCHAR(100), -- Coluna: Nome do componente de especialização
    sigla VARCHAR(15), -- Coluna: Sigla da turma
    semestre DECIMAL(1), -- Coluna: Semestre da turma
    vagas_disponiveis TEXT -- Coluna: Vagas disponíveis na turma
) AS $$
BEGIN
    -- Retorna uma consulta que seleciona informações das turmas de idioma usando os parâmetros fornecidos
    RETURN QUERY
    SELECT 
        te.nome_componente,
        te.sigla,
        te.semestre,
        te.vagas_disponiveis::TEXT -- Garante que o tipo de dados corresponde à view
    FROM vw_turma_especializacao_agrupada AS te
    WHERE
        -- Aplica filtros com base nos parâmetros fornecidos
        (search_nome_componente IS NULL OR te.nome_componente = search_nome_componente)
        AND (search_sigla IS NULL OR te.sigla = search_sigla)
        AND (search_semestre IS NULL OR te.semestre = search_semestre)
        AND (search_vagas_disponiveis IS NULL OR te.vagas_disponiveis = search_vagas_disponiveis);
END;
$$ LANGUAGE plpgsql;






--TESTE
-- Insert a new componente_curricular
INSERT INTO componente_curricular (nome_componente) VALUES ('Language Class A');

-- Now, you can insert data into turma_especializacao with the existing nome_componente value
INSERT INTO turma_especializacao (nome_componente, sigla, semestre, hora_inicio, hora_fim, qtde_vagas)
VALUES ('Language Class A', 'LC1', 1, '2023-09-03 09:00:00', '2023-09-03 12:00:00', 20);


-- Insert sample data into the turma_especializacao table
INSERT INTO turma_especializacao (nome_componente, sigla, semestre, hora_inicio, hora_fim, qtde_vagas)
VALUES
    ('Language Class A', 'LC1', 1, '2023-09-03 09:00:00', '2023-09-03 12:00:00', 20);


CREATE VIEW vw_turma_especializacao_agrupada AS
SELECT
    nome_componente,
    sigla,
    semestre,
    STRING_AGG(CAST(qtde_vagas AS VARCHAR), ', ') AS vagas_disponiveis
FROM
    turma_especializacao
GROUP BY
    nome_componente,
    sigla,
    semestre
ORDER BY
    semestre;


SELECT *
FROM function_busca_view_turmas_idioma(
    search_sigla := 'LC1'
);
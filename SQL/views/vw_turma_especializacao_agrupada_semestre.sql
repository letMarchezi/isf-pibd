-- Este código cria uma visão que agrupa informações de turmas de especialização
CREATE VIEW vw_turma_especializacao_agrupada AS
-- Seleciona os campos que serão exibidos na visão
SELECT
    nome_componente, -- Nome do componente de especialização
    sigla, -- Sigla da turma
    semestre, -- Semestre da turma
    -- Concatena a quantidade de vagas disponíveis em uma única string separada por vírgula
    STRING_AGG(CAST(qtde_vagas AS VARCHAR), ', ') AS vagas_disponiveis
FROM
    turma_especializacao -- Tabela de turmas de especialização
GROUP BY
    nome_componente,  -- Agrupa pelo nome do componente de especialização
    sigla, -- Agrupa pela sigla da turma
    semestre -- Agrupa pelo semestre da turma
-- Ordena o resultado da consulta pelo semestre
ORDER BY
    semestre;

--TESTE 
select * from vw_turma_especializacao_agrupada
------------------------------------------- GetCatalogoCursosNivel -------------------------------------------

-- Autor: Bruno Luis R Medri - 790004
-- Descrição: Retornar o catálogo de cursos ordenado por nível

-- Cria ou substitui uma função chamada "GetCatalogoCursosNivel"
CREATE OR REPLACE FUNCTION GetCatalogoCursosNivel()


-- Define o tipo de retorno da função como uma tabela com as colunas especificadas.
RETURNS TABLE (
    id_curso_idioma SERIAL,
    nome_completo VARCHAR(256),
    idioma VARCHAR(16),
    nivel VARCHAR(16),
    categoria VARCHAR(16),
    carga_horaria INTEGER,
    link_ementa VARCHAR(256)
)

AS $$

BEGIN

    -- Retorna um conjunto de resultados da consulta a seguir.
    RETURN QUERY


    SELECT
        id_curso_idioma,
        nome_completo,
        idioma,
        nivel,
        categoria,
        carga_horaria,
        link_ementa

    -- Seleciona os campos especificados da tabela "curso_idioma".
    FROM
        curso_idioma


    -- Ordena os resultados por "nivel".
    ORDER BY
        nivel;


END;
$$ LANGUAGE plpgsql;
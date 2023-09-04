--VIEW)
-- View com os dados do componente agrupado por categoria 
-- arquivo apresentaDadosComponentePorCategoria.sql
CREATE VIEW vw_componente_curricular_agrupado_por_tipo AS
SELECT
    tcc.tipo_disciplina,
    COUNT(cc.nome_componente) AS quantidade_componentes,
    SUM(cc.carga_horaria_pratica) AS total_carga_horaria_pratica,
    SUM(cc.carga_horaria_teorica) AS total_carga_horaria_teorica
FROM componente_curricular cc
JOIN tipo_componente_curricular tcc ON cc.nome_componente = tcc.nome_completo
GROUP BY tcc.tipo_disciplina;
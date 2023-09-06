-- Autor : Augusto dos Santos
CREATE OR REPLACE VIEW apresenta_dados_turma_idioma AS
SELECT 
    toc.id_turma_coletiva as id_turma,
    toc.id_curso_idioma AS id_curso,
    ci.nome_completo,
    toc.sigla_turma,
    ci.idioma,
    ci.nivel,
    ci.categoria,
    ci.carga_horaria,
    toc.semestre,
    toc.qtde_vagas_reservadas,
    toc.hora_inicio,
    toc.hora_fim,
    toc.qtde_vagas,
    -- toc.dia_da_semana
    ci.link_ementa
    FROM turma_oferta_coletiva toc
    JOIN curso_idioma ci ON toc.id_curso_idioma = ci.id_curso_idioma;
-- SELECT * FROM apresenta_dados_turma_idioma

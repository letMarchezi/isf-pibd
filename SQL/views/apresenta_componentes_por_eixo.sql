CREATE OR REPLACE VIEW apresenta_componentes_por_tematico AS
SELECT 
    nome_componente,
    nome_idioma,
    carga_horaria_pratica,
    carga_horaria_teorica,
    obrigatoriedade,
    eixo_tematico
FROM componente_curricular
ORDER BY eixo_tematico;
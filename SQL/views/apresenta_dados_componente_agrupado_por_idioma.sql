/*
VIEW DE DADOS DO COMPONENTES AGRUPADOS POR IDIOMA
*/

CREATE OR REPLACE VIEW dados_componentes_agrupados_por_idioma AS
SELECT nome_componente, nome_idioma,
    carga_horaria_pratica, carga_horaria_teorica,
    obrigatoriedade, eixo_tematico
FROM componente_curricular
GROUP BY nome_idioma, nome_componente,
    carga_horaria_pratica, carga_horaria_teorica,
    obrigatoriedade, eixo_tematico;

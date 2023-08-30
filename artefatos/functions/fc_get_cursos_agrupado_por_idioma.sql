CREATE OR REPLACE FUNCTION get_cursos_agrupado_por_idioma()
    RETURNS TABLE (
        id_curso_idioma INT,
        nome_completo VARCHAR(256),
        idioma VARCHAR(16),
        nivel VARCHAR(16),
        categoria VARCHAR(16),
        link_ementa VARCHAR(256)
    ) LANGUAGE plpgsql AS
        $$ BEGIN
            RETURN QUERY 
                SELECT
                    ci.id_curso_idioma,
                    ci.nome_completo,
                    ci.idioma,
                    ci.nivel,
                    ci.categoria,
                    ci.link_ementa
                FROM curso_idioma ci
                GROUP BY ci.idioma, ci.id_curso_idioma, ci.nome_completo, ci.nivel, ci.categoria, ci.link_ementa;
            END; $$
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
            END; 
         $$;
          
--Testes 
/*

INSERT INTO curso_idioma (
    nome_completo, 
    idioma, nivel, 
    categoria, 
    carga_horaria, 
    link_ementa
)
VALUES (
    'Batatinha', 
    'Inglês', 
    'A2', 
    'Coletiva', 
    69::smallint, 
    'http://www.owo.com/ementa'
),(
    'Cenourinha', 
    'Espanhol', 
    'A3', 
    'Coletiva', 
    69::smallint, 
    'http://www.owo.com/ementa'
),(
    'Hellow Hellow', 
    'Ingles', 
    'A3', 
    'Coletiva', 
    69::smallint, 
    'http://www.owo.com/ementa'
),(
    'BOLOOOO', 
    'Portugues', 
    'A3', 
    'Coletiva', 
    69::smallint, 
    'http://www.owo.com/ementa'
),(
    'Spikando Inglish', 
    'Ingles', 
    'A1', 
    'Coletiva', 
    69::smallint, 
    'http://www.owo.com/ementa'
),(
    'Hablas mucho', 
    'Espanhol', 
    'C3', 
    'Coletiva', 
    69::smallint, 
    'http://www.owo.com/ementa'
);

--Select da tabela física
SELECT * FROM curso_idioma;

--Select da ITVF
SELECT * FROM get_cursos_agrupado_por_idioma();
*/

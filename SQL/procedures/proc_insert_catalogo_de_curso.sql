CREATE OR REPLACE PROCEDURE insert_catalogo_de_curso(
    p_nome_completo VARCHAR(256), 
    p_idioma VARCHAR(16), 
    p_nivel VARCHAR(16), 
    p_categoria VARCHAR(16), 
    p_carga_horaria INT, 
    p_link_ementa VARCHAR(256)
) 
LANGUAGE plpgsql 
AS $$
DECLARE
    curso_exists INT;
BEGIN
    -- Verifica se o curso já existe
    SELECT COUNT(*) INTO curso_exists FROM curso_idioma WHERE nome_completo = p_nome_completo AND idioma = p_idioma;

    -- Se o curso já existe, levanta uma exceção, senão insere o novo curso
    IF curso_exists > 0 THEN
        RAISE EXCEPTION 'Curso com nome % e idioma % já existe!', p_nome_completo, p_idioma;
    ELSE
        INSERT INTO curso_idioma (nome_completo, idioma, nivel, categoria, carga_horaria, link_ementa)
        VALUES (p_nome_completo, p_idioma, p_nivel, p_categoria, p_carga_horaria, p_link_ementa);
    END IF;
    
END;
$$;
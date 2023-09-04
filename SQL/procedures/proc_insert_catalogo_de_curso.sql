-- PROCEDURE)
-- stored procedures inserção catálogo de curso
-- arquivo proc_insert_catalogo_de_curso.sql

CREATE OR REPLACE PROCEDURE insert_catalogo_de_curso(
    IN p_nome_completo character varying, 
    IN p_idioma character varying, 
    IN p_nivel character varying, 
    IN p_categoria character varying, 
    IN p_carga_horaria smallint, 
    IN p_link_ementa character varying
) LANGUAGE plpgsql AS 
    $$ DECLARE
            curso_ja_existe CURSOR FOR 
                SELECT * FROM curso_idioma WHERE nome_completo = p_nome_completo AND idioma = p_idioma;
                
            curso_row curso_idioma%ROWTYPE;
        BEGIN
            OPEN curso_ja_existe;
            
            FETCH curso_ja_existe INTO curso_row;
            
            IF FOUND THEN
                RAISE EXCEPTION 'Curso com nome % e idioma % já existe!', p_nome_completo, p_idioma;
            ELSE
                INSERT INTO curso_idioma (nome_completo, idioma, nivel, categoria, carga_horaria, link_ementa)
                VALUES (p_nome_completo, p_idioma, p_nivel, p_categoria, p_carga_horaria, p_link_ementa);
            END IF;
            
            CLOSE curso_ja_existe;
        END;
    $$;
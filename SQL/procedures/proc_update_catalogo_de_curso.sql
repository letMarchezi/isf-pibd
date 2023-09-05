CREATE OR REPLACE PROCEDURE update_catalogo_de_curso(
    IN p_id_curso_idioma integer, 
    IN p_nome_completo character varying, 
    IN p_idioma character varying, 
    IN p_nivel character varying, 
    IN p_categoria character varying, 
    IN p_carga_horaria smallint, 
    IN p_link_ementa character varying
) LANGUAGE plpgsql AS 
    $$ DECLARE
            curso_para_atualizar CURSOR FOR 
                SELECT * FROM curso_idioma WHERE id_curso_idioma = p_id_curso_idioma;
                
            curso_ja_existe CURSOR FOR 
                SELECT * FROM curso_idioma WHERE nome_completo = p_nome_completo AND idioma = p_idioma;
                
            curso_row curso_idioma%ROWTYPE;
        BEGIN
            OPEN curso_ja_existe;
            
            FETCH curso_ja_existe INTO curso_row;
            
            IF FOUND THEN
                RAISE EXCEPTION 'Curso com nome % e idioma % já existe!', p_nome_completo, p_idioma;
            END IF;
             
            CLOSE curso_ja_existe;
            
            OPEN curso_para_atualizar;
            
            FETCH curso_para_atualizar INTO curso_row;
            
            IF NOT FOUND THEN
                RAISE EXCEPTION 'Curso com nome % e idioma % não encontrado!', p_nome_completo, p_idioma;
            ELSIF FOUND THEN
                UPDATE public.curso_idioma 
                SET 
                    nome_completo = p_nome_completo, 
                    idioma = p_idioma, nivel = p_nivel, 
                    categoria = p_categoria, 
                    carga_horaria = p_carga_horaria, 
                    link_ementa = p_link_ementa 
                WHERE CURRENT OF curso_para_atualizar;
            END IF;
            
            CLOSE curso_para_atualizar;
        END;
    $$;
    
   
--TESTES
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
);

SELECT * FROM curso_idioma;

--Teste de alteração com sucesso
CALL update_catalogo_de_curso(
    1,
    'Potatinho', 
    'Batatanês', 
    'C3', 
    'Local', 
    621::smallint, 
    'http://www.uwu.com/ementa'
);

--Chamando uma segunda vez, deve voltar mensagem de que ja existe esse curso
CALL update_catalogo_de_curso(
    1,
    'Potatinho', 
    'Batatanês', 
    'C3', 
    'Local', 
    621::smallint, 
    'http://www.uwu.com/ementa'
);

--Teste para mensagem de curso nao existe

CALL update_catalogo_de_curso(
    999999,
    'EuNaoExiste', 
    'NaoExistês', 
    'C3', 
    'Local', 
    621::smallint, 
    'http://www.uwu.com/ementa'
); 

*/
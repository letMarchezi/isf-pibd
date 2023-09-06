-- Autor : Augusto dos Santos
-- Função que coleta dados da view do professores ISF

CREATE OR REPLACE FUNCTION get_dados_professor_isf(cpf_pesquisa VARCHAR(11))
    RETURNS TABLE (
        cpf_professor_isf VARCHAR(11),
        primeiro_nome VARCHAR(50),
        sobrenome VARCHAR(50),
        genero VARCHAR(20),
        data_nascimento DATE,
        -- idioma VARCHAR(30),
        -- proficiencia VARCHAR(5),
        numero INTEGER,
        complemento VARCHAR(100),
        cep_usuario VARCHAR(8),
        cnpj_ies_associada VARCHAR(20)
    )LANGUAGE plpgsql AS
    $$ BEGIN
        RETURN QUERY
            SELECT
                vw.cpf_professor_isf,
                vw.primeiro_nome,
                vw.sobrenome,
                vw.genero,
                vw.data_nascimento,
                vw.numero,
                vw.complemento,
                vw.cep_usuario,
                vw.cnpj_ies_associada
            FROM vw_professor_isf AS vw
            WHERE vw.cpf_professor_isf = cpf_pesquisa;
        END;
    $$;
/* Para teste da funcao*/
-- Usuários
-- INSERT INTO usuario VALUES('70332434199', 'augusto', 'santos', 'masculino', '2022-10-14');
-- INSERT INTO usuario VALUES('70332994199', 'gaby', 'castilho', 'feminino', '2022-09-31');
-- INSERT INTO usuario VALUES('10332994199', 'heitor', 'pinheiro', 'masculino', '2015-12-30');

-- -- professor ISF
-- INSERT INTO professor_isf VALUES ('70332434199');
-- INSERT INTO professor_isf VALUES ('70332994199');
-- INSERT INTO professor_isf VALUES ('10332994199');

-- SELECT * FROM get_dados_professor_isf('70332434199')
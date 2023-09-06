-- procedure de insercao de um prof isf no sistema
CREATE OR REPLACE PROCEDURE insereProfISF(
        cpf_param VARCHAR(11),
        primeiro_nome_param VARCHAR(50),
        sobrenome_param VARCHAR(50),
        genero_param VARCHAR(20),
        data_nascimento_param DATE,
        rua_param VARCHAR(50),
        bairro_nome_param VARCHAR(50),
        numero_param INTEGER,
        complemento_param VARCHAR(100),
        cep_usuario_param VARCHAR(8),
        cidade_param VARCHAR(30),
        estado_param VARCHAR(2),
        pais_param VARCHAR(30),
        cnpj_ies_associada_param VARCHAR(20),
        idioma_param VARCHAR(30),
        proficiencia_param VARCHAR(5),
        declaracao_proficiencia_param VARCHAR(256),
        email_usuario_param VARCHAR(320),
        email_tipo_param VARCHAR(50)
    ) LANGUAGE plpgsql AS $$ BEGIN -- Insere email do usuário
INSERT INTO email (endereco_email, tipo)
VALUES (email_usuario_param, email_tipo_param);
-- Insere o endereço do cep
INSERT INTO cep_endereco (cep, rua, bairro, cidade, estado, pais)
VALUES (
        cep_usuario_param,
        rua_param,
        bairro_nome_param,
        cidade_param,
        estado_param,
        pais_param
    );
-- Insere o usuário
INSERT INTO usuario (
        cpf,
        primeiro_nome,
        sobrenome,
        genero,
        data_nascimento,
        numero,
        complemento,
        cep_usuario,
        cnpj_ies_associada
    )
VALUES (
        cpf_param,
        primeiro_nome_param,
        sobrenome_param,
        genero_param,
        data_nascimento_param,
        numero_param,
        complemento_param,
        cep_usuario_param,
        cnpj_ies_associada_param
    );
INSERT INTO professor_isf(
        -- criando relação usuario e professor isf
        cpf_professor_isf
    )
VALUES(cpf_param);
INSERT INTO idioma_professor_isf (
        cpf_professor_isf,
        idioma,
        proficiencia,
        declaracao_proficiencia
    )
VALUES (
        cpf_param,
        idioma_param,
        proficiencia_param,
        declaracao_proficiencia_param
    );
COMMIT;
END;
$$;
--teste
CALL insereProfISF(
    '12345678901'::VARCHAR,
    'João'::VARCHAR,
    'Silva'::VARCHAR,
    'Masculino'::VARCHAR,
    '1980-01-15'::DATE,
    'Rua das Flores'::VARCHAR,
    'Centro'::VARCHAR,
    123::INTEGER,
    'Apto 4B'::VARCHAR,
    '12345678'::VARCHAR,
    'São Paulo'::VARCHAR,
    'SP'::VARCHAR,
    'Brasil'::VARCHAR,
    '9876543210001'::VARCHAR,
    'Inglês'::VARCHAR,
    'Avançado'::VARCHAR,
    'Certificado de proficiência em Inglês'::VARCHAR,
    'joao.silva@example.com'::VARCHAR,
    'gmail'::VARCHAR
);
SELECT *
FROM professor_isf;
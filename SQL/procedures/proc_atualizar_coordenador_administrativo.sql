-- Este procedimento foi refeito por Matheus Paladini, substituindo uma função original de outro autor que não estava funcionando corretamente.
CREATE OR REPLACE PROCEDURE proc_atualizar_coordenador_administrativo(
    cpf_coordenador_param VARCHAR(11), -- Parâmetro: CPF do coordenador a ser atualizado
    funcao_na_instituicao_param VARCHAR(100), -- Parâmetro: Nova função na instituição do coordenador
    curriculo_lates_param VARCHAR(255), -- Parâmetro: Novo currículo Lattes do coordenador
    data_cadastro_param DATE, -- Parâmetro: Nova data de cadastro do coordenador
    poca_param VARCHAR(50) -- Parâmetro: Nova posição na instituição do coordenador
)
LANGUAGE plpgsql -- Define a linguagem do procedimento como PL/pgSQL
AS $$
DECLARE
    cpf_coordenador_atual VARCHAR(11); -- Variável para armazenar o CPF atual do coordenador
BEGIN

    -- Procura o CPF do coordenador na tabela "coordenador_administrativo" e o armazena na variável "cpf_coordenador_atual"
    SELECT cpf_coordenador INTO cpf_coordenador_atual
    FROM coordenador_administrativo
    WHERE cpf_coordenador = cpf_coordenador_param;

    -- Verifica se o CPF do coordenador foi encontrado
    IF cpf_coordenador_atual IS NOT NULL THEN

        -- Atualiza os campos da tabela "coordenador_administrativo" com os novos valores fornecidos como parâmetros
        UPDATE coordenador_administrativo
        SET
            funcao_na_instituicao = funcao_na_instituicao_param,
            curriculo_lates = curriculo_lates_param,
            data_cadastro = data_cadastro_param,
            poca = poca_param
        WHERE cpf_coordenador = cpf_coordenador_param; -- Atualiza apenas o registro com o CPF correspondente
    END IF;
END;
$$;
--TESTE
INSERT INTO cep_endereco (cep, rua, bairro, cidade, estado, pais)
VALUES
    ('12345678', 'Rua A', 'Bairro A', 'Cidade A', 'CA', 'Pais A'),
    ('87654321', 'Rua B', 'Bairro B', 'Cidade B', 'CB', 'Pais B');

-- Insert data into email table
INSERT INTO email (endereco_email, tipo)
VALUES
    ('johndoe@gmail.com', 'pessoal'),
    ('janedoe@gmail.com', 'pessoal');

-- Insert data into ies table
INSERT INTO ies (cnpj, sigla, participou_isf, tem_lab_mais_unidos, possui_nucleo_ativo, cep_ies, numero, complemento, link_politica_ling, data_politica_ling, doc_politica_ling, campus, nome_principal)
VALUES
    ('12345678901234', 'IESA', true, true, true, '12345678', 1, 'Complemento 1', 'Link 1', '2023-01-01', 'Doc 1', 'Campus A', 'University A'),
    ('98765432109876', 'IESB', false, false, false, '87654321', 2, 'Complemento 2', 'Link 2', '2023-02-02', 'Doc 2', 'Campus B', 'University B');

INSERT INTO usuario (cpf, primeiro_nome, sobrenome, genero, data_nascimento, numero, complemento, cep_usuario, cnpj_ies_associada)
VALUES ('98765432101', 'John', 'Doe', 'Male', '1990-01-15', 123, 'Apt 4B', '12345678', 'valid_cnpj_value');

-- Insert sample data for coordenador administrativo
INSERT INTO coordenador_administrativo (cpf_coordenador, funcao_na_instituicao, curriculo_lates, data_cadastro, poca)
VALUES ('98765432101', 'Coordenador de Administração', 'https://example.com/curriculo', '2023-09-06', 'POCA');




CALL proc_atualizar_coordenador_administrativo(
    '98765432101',                -- cpf_coordenador_param
    'New Function',               -- funcao_na_instituicao_param
    'https://new-curriculum.com', -- curriculo_lates_param
    '2023-09-06',                -- data_cadastro_param (date in 'YYYY-MM-DD' format)
    'New POCA'                    -- poca_param
);

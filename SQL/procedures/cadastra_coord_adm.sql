CREATE OR REPLACE PROCEDURE cadastra_coord_adm(
    cpf_ca VARCHAR(11),
    primeiro_nome_ca VARCHAR(50),
    sobrenome_ca VARCHAR(50),
    genero_ca VARCHAR(20),
    data_nascimento_ca DATE,
    rua_ca VARCHAR(100),
    numero_ca INTEGER,
    complemento_ca VARCHAR(100),
    bairro_ca VARCHAR(50),
    cidade_ca VARCHAR(50),
    estado_ca VARCHAR(2),
    pais_ca VARCHAR(50),
    cep_ca VARCHAR(8),
    cnpj_ies_associada_ca VARCHAR(14),
    funcao_na_instituicao_ca VARCHAR(100),
    curriculo_lates_ca VARCHAR(255),
    poca_ca VARCHAR(50),
    ddd_telefone_ca VARCHAR(3),
    ddi_telefone_ca VARCHAR(3),
    numero_telefone_ca VARCHAR(15),
    endereco_email_ca VARCHAR(320),
    tipo_email_ca VARCHAR(50) 
) AS $$
DECLARE
    cnpj_busca VARCHAR(14);  
    cep_busca VARCHAR(8);
BEGIN
    -- Verificar se existe ies
    SELECT cnpj INTO cnpj_busca FROM ies WHERE cnpj = cnpj_ies_associada_ca;

    -- Se não existe, inserir uma nova IES vazia
    IF cnpj_busca IS NULL THEN
        -- Verificar se existe cep indeterminado 00000-000 só para poder adicionar a ies
        SELECT cep INTO cep_busca FROM cep_endereco WHERE cep = '00000000';

        -- Se não existe, inserir o endereco
        IF cep_busca IS NULL THEN
            INSERT INTO cep_endereco (cep, rua, bairro, cidade, estado, pais)
            VALUES ('00000000', 'Endereço Inválido', 'Inválido', 'Inválido', '--', 'Inválido');
        END IF;

        -- Inserir a nova IES com o CEP padrão
        INSERT INTO ies (cnpj, cep_ies)
        VALUES (cnpj_ies_associada_ca, '00000000');
    END IF;

    -- Verificar se existe cep do coordenador adm
    SELECT cep INTO cep_busca FROM cep_endereco WHERE cep = cep_ca;

    -- Se não existe, inserir o endereco
    IF cep_busca IS NULL THEN
        INSERT INTO cep_endereco (cep, rua, bairro, cidade, estado, pais)
        VALUES (cep_ca, rua_ca, bairro_ca, cidade_ca, estado_ca, pais_ca);
    END IF;

    -- Inserir na tabela "usuario"
    INSERT INTO usuario (cpf, primeiro_nome, sobrenome, genero, data_nascimento, numero, complemento, cep_usuario, cnpj_ies_associada)
    VALUES (cpf_ca, primeiro_nome_ca, sobrenome_ca, genero_ca, data_nascimento_ca, numero_ca, complemento_ca, cep_ca, cnpj_ies_associada_ca);

    -- Inserir o telefone
    INSERT INTO telefone_usuario (cpf_usuario, ddd, ddi, numero)
    VALUES (cpf_ca, ddd_telefone_ca, ddi_telefone_ca, numero_telefone_ca);

    -- Inserir o e-mail na tabela "email"
    INSERT INTO email (endereco_email, tipo)
    VALUES (endereco_email_ca, tipo_email_ca);

    -- Inserir o e-mail na tabela "email_usuario"
    INSERT INTO email_usuario (email_usuario, cpf_usuario)
    VALUES (endereco_email_ca, cpf_ca);

    -- Inserir na tabela "coordenador_administrativo"
    INSERT INTO coordenador_administrativo (cpf_ca, funcao_na_instituicao_ca, curriculo_lates_ca, poca_ca)
    VALUES (cpf_ca, funcao_na_instituicao_ca, curriculo_lates_ca, poca_ca);

END;
$$ LANGUAGE plpgsql;

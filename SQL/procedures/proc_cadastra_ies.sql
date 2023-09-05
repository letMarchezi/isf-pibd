CREATE OR REPLACE PROCEDURE proc_cadastra_ies(
    p_CNPJ VARCHAR(14),
    p_sigla VARCHAR(10),
    p_participou_isf BOOLEAN,
    p_tem_lab_mais_unidos BOOLEAN,
    p_possui_nucleo_ativo BOOLEAN,
    p_CEP_IES VARCHAR(8),
    p_rua VARCHAR(100),
    p_bairro VARCHAR(50),
    p_cidade VARCHAR(50),
    p_estado VARCHAR(2),
    p_pais VARCHAR(50),
    p_numero INTEGER,
    p_complemento VARCHAR(100),
    p_link_politica_ling VARCHAR(255),
    p_data_politica_ling DATE,
    p_doc_politica_ling VARCHAR(255),
    p_campus VARCHAR(100),
    p_nome_principal VARCHAR(100),
    p_DDD VARCHAR(3),
    p_DDI VARCHAR(3),
    p_telefone VARCHAR(15)
)
AS
$$
BEGIN
    -- Insert into CepEndereco table
    INSERT INTO cep_endereco (CEP, rua, bairro, cidade, estado, pais)
    VALUES (p_CEP_IES, p_rua, p_bairro, p_cidade, p_estado, p_pais);

    -- Insert into IES table
    INSERT INTO ies (
        CNPJ, sigla, participou_isf, tem_lab_mais_unidos, possui_nucleo_ativo,
        CEP_IES, numero, complemento, link_politica_ling, data_politica_ling,
        doc_politica_ling, campus, nome_principal
    )
    VALUES (
        p_CNPJ, p_sigla, p_participou_isf, p_tem_lab_mais_unidos, p_possui_nucleo_ativo,
        p_CEP_IES, p_numero, p_complemento, p_link_politica_ling, p_data_politica_ling,
        p_doc_politica_ling, p_campus, p_nome_principal
    );

    -- Insert into TelefoneIES table
    INSERT INTO telefone_ies (CNPJ_IES, DDD, DDI, numero)
    VALUES (p_CNPJ, p_DDD, p_DDI, p_telefone);
END;
$$ LANGUAGE plpgsql;


/*CALL proc_cadastra_ies(
    '11111111111',    -- CNPJ
    'ABC Univ',          -- Sigla
    true,                -- Participou ISF
    false,               -- Tem Lab Mais Unidos
    true,                -- Possui Núcleo Ativo
    '12345678',          -- CEP
    '123 Main St',         -- Rua
    'Downtown',            -- Bairro
    'Metropolis',          -- Cidade
    'MP',                  -- Estado
    'Country',              -- País
    42,                  -- Número
    'Sala 101',          -- Complemento
    'http://example.com/policy',  -- Link Política Ling
    '2023-08-29',        -- Data Política Ling
    'policy123.pdf',     -- Doc Política Ling
    'Main Campus',       -- Campus
    'John Doe',          -- Nome Principal
    '011',               -- DDD
    '001',               -- DDI
    '5551234567'         -- Telefone
);
*/
CREATE OR REPLACE PROCEDURE AdicionarDocenteAutor(
    cpf_param VARCHAR(11),
    primeiro_nome_param VARCHAR(50),
    sobrenome_param VARCHAR(50),
    genero_param VARCHAR(20),
    data_nascimento_param DATE,
    numero_param INTEGER,
    complemento_param VARCHAR(100),
    cep_usuario_param VARCHAR(8),
    cnpj_ies_associada_param VARCHAR(20),
    data_credenciamento_param DATE,
    curriculo_param VARCHAR(256),
    titulacao_param VARCHAR(16),
    poca_file_param VARCHAR(255),
    vinculo_file_param VARCHAR(255),
    link_cnpq_param VARCHAR(255)
    
)
LANGUAGE plpgsql
AS $$
BEGIN
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
    ) VALUES (
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
    
    INSERT INTO docente_especialista(
            cpf_docente,
            data_credenciamento, 
            curriculo, 
            titulacao, 
            poca_file, 
            vinculo_file, 
            link_cnpq, 
            is_orientador, 
            is_autor, 
            is_ministrante, 
            is_coordenador_pedagogico
        ) VALUES (
            cpf_param, 
            data_credenciamento_param, 
            curriculo_param, 
            titulacao_param, 
            poca_file_param, 
            vinculo_file_param, 
            link_cnpq_param, 
            false,  -- is_orientador
            true,   -- is_autor
            false,  -- is_ministrante
            false   -- is_coordenador_pedagogico
    );


    COMMIT;
END;
$$;

/*
CALL AdicionarDocenteAutor(
    '12345678901',
    'João',
    'Silva',
    '1990-01-15',
    123,
    'Apto 301',
    '12345678',
    '9876543210',
    '2023-09-04',
    'Currículo do Docente',
    'Doutor',
    'poca_file.pdf',
    'vinculo_file.pdf',
    'xxxx'
);
*/
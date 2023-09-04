CREATE OR REPLACE PROCEDURE AdicionarDocenteAutor(
    cpf_param VARCHAR(11),
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
    INSERT INTO docente_especialista (
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

/* CALL AdicionarUsuarioAutor(
    '12345678901',
    'João',
    'Silva',
    'Masculino',
    '1990-01-15',
    123,
    'Apto 301',
    '12345678',
    '12345678901234',
    '2023-09-04',
    'Currículo do Docente',
    'Doutor',
    'poca_file.pdf',
    'vinculo_file.pdf',
    'xxxx'
);

*/
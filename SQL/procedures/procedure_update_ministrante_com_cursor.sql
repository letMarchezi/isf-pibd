CREATE OR REPLACE PROCEDURE atualizar_docente_ministrante(
    IN cpf_docente_param VARCHAR(11),
    IN novo_data_credenciamento DATE DEFAULT NULL,
    IN novo_curriculo VARCHAR(256) DEFAULT NULL,
    IN novo_titulacao VARCHAR(16) DEFAULT NULL,
    IN novo_poca_file VARCHAR(255) DEFAULT NULL,
    IN novo_vinculo_file VARCHAR(255) DEFAULT NULL,
    IN novo_link_cnpq VARCHAR(255) DEFAULT NULL,
    IN novo_is_orientador BOOLEAN DEFAULT NULL,
    IN novo_is_autor BOOLEAN DEFAULT NULL,
    IN novo_is_ministrante BOOLEAN DEFAULT NULL,
    IN novo_is_coordenador_pedagogico BOOLEAN DEFAULT NULL
) AS $$
DECLARE
    docente_cur CURSOR FOR
        SELECT *
        FROM docente_especialista
        WHERE cpf_docente = cpf_docente_param AND is_ministrante = TRUE;

    docente_row docente_especialista%ROWTYPE;
BEGIN
    -- Abre o cursor para selecionar o docente com base no CPF fornecido
    OPEN docente_cur;

    -- Obtém o registro do cursor
    FETCH docente_cur INTO docente_row;

    -- Verifica se o registro foi encontrado
    IF FOUND THEN
        -- Atualiza os campos do docente com base nos parâmetros fornecidos
        UPDATE docente_especialista
        SET
            data_credenciamento = COALESCE(novo_data_credenciamento, docente_row.data_credenciamento),
            curriculo = COALESCE(novo_curriculo, docente_row.curriculo),
            titulacao = COALESCE(novo_titulacao, docente_row.titulacao),
            poca_file = COALESCE(novo_poca_file, docente_row.poca_file),
            vinculo_file = COALESCE(novo_vinculo_file, docente_row.vinculo_file),
            link_cnpq = COALESCE(novo_link_cnpq, docente_row.link_cnpq),
            is_orientador = COALESCE(novo_is_orientador, docente_row.is_orientador),
            is_autor = COALESCE(novo_is_autor, docente_row.is_autor),
            is_ministrante = COALESCE(novo_is_ministrante, docente_row.is_ministrante),
            is_coordenador_pedagogico = COALESCE(novo_is_coordenador_pedagogico, docente_row.is_coordenador_pedagogico)
        WHERE cpf_docente = cpf_docente_param;
    ELSE
        -- Lidar com a situação em que o registro não foi encontrado ou não é um ministrante
       
        RAISE EXCEPTION 'Docente com CPF % não encontrado ou não é um ministrante', cpf_docente_param;
    END IF;

    -- Fecha o cursor
    CLOSE docente_cur;
END;
$$ LANGUAGE plpgsql;

/*SELECT * FROM docente_especialista;

--e ministrante
CALL atualizar_docente_ministrante(
    '12345678901', -- Substitua pelo CPF de um registro existente
    '2023-09-01', -- Data de credenciamento válida
    'http://invalid-url', -- Link do currículo inválido
    'Doutor', -- Titulação com números (violando a regra)
    'arquivo.pdf',
    'documento.pdf',
    'https://valid-link.com', -- Link do CNPQ válido
    TRUE,
    FALSE,
    TRUE,
    FALSE
);

--nao e mistrante
CALL atualizar_docente_ministrante(
    '98765432101', -- Substitua pelo CPF de um registro existente
    '2023-09-01', -- Data de credenciamento válida
    'http://invalid-url', -- Link do currículo inválido
    'Doutor', -- Titulação com números (violando a regra)
    'arquivo.pdf',
    'documento.pdf',
    'https://valid-link.com', -- Link do CNPQ válido
    TRUE,
    FALSE,
    TRUE,
    FALSE
);*/
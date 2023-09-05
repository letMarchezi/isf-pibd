-- Crie a procedure cadastrar_docente_ministrante
CREATE OR REPLACE PROCEDURE cadastrar_docente_ministrante(
    cpf_docente VARCHAR(11),
    primeiro_nome VARCHAR(50),
    sobrenome VARCHAR(50),
    genero VARCHAR(20),
    data_nascimento DATE,
    id_turma_especializacao INTEGER,
    horario_disponivel TIME,
    data_credenciamento DATE,
    curriculo VARCHAR(256),
    titulacao VARCHAR(16),
    poca_file VARCHAR(255),
    vinculo_file VARCHAR(255),
    link_cnpq VARCHAR(255),
    is_orientador BOOLEAN,
    is_autor BOOLEAN,
    is_ministrante BOOLEAN,
    is_coordenador_pedagogico BOOLEAN
)
LANGUAGE plpgsql AS $$
BEGIN
    -- Inserir o registro na tabela usuario
    INSERT INTO usuario (
        cpf,
        primeiro_nome,
        sobrenome,
        genero,
        data_nascimento
    ) VALUES (
        cpf_docente,
        primeiro_nome,
        sobrenome,
        genero,
        data_nascimento
    );

    -- Inserir o registro na tabela docente_especialista
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
    );

    -- Inserir o registro na tabela horarios_disponiveis_docente_ministrante
    INSERT INTO horarios_disponiveis_docente_ministrante (CPF_docente, horario_disponivel)
    VALUES (cpf_docente, horario_disponivel);

    -- Relacionar o docente com a turma de especialização
    INSERT INTO docente_ministrante_leciona_turma_especializacao (ID_turma_especializacao, CPF_docente)
    VALUES (id_turma_especializacao, cpf_docente);
END;
$$;

/*
-- TESTE (apague a barra invertida e o asterisco acima e abaixo)
-- Inserir um componente curricular com nome 'Nome da Turma' na tabela componente_curricular apenas para fins de testes
INSERT INTO componente_curricular (nome_componente)
VALUES ('Nome da Turma');
-- Inserir uma turma com ID 1 na tabela turma_especializacao com horários válidos apenas para fins de testes
INSERT INTO turma_especializacao (id_turma_especializacao, nome_componente, sigla, semestre, hora_inicio, hora_fim, qtde_vagas)
VALUES (1, 'Nome da Turma', 'SIGLA', 1, '2023-09-04 08:00:00', '2023-09-04 10:00:00', 20);


-- Chame o procedimento para inserir dados de exemplo
CALL cadastrar_docente_ministrante(
    '12345678912',
    'Joao',
    'Da Silva',
    'Masculino',
    '1998-07-11',
    1,              
    '08:00:00',     
    '2023-09-04',   
    'Currículo do Ministrante',
    'titulacao',
    'pocafile',
    'vinculo_file',
    'link.com.br.ministrante',
    false,        
    false,
    true,
    false
);



-- Em seguida, você pode usar um SELECT para verificar os dados inseridos
SELECT * FROM horarios_disponiveis_docente_ministrante;
SELECT * FROM docente_ministrante_leciona_turma_especializacao;
-- Verificar a corretude da inserção do docente ministrante
SELECT *
FROM docente_ministrante_leciona_turma_especializacao
WHERE ID_turma_especializacao = 1
AND CPF_docente = '12345678912';
*/
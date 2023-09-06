-- Este procedimento foi criado para cadastrar um aluno em uma turma de especialização.
CREATE OR REPLACE PROCEDURE cadastrar_aluno_em_aula(
    IN p_cpf_aluno VARCHAR(11), -- Parâmetro: CPF do aluno a ser cadastrado
    IN p_nome_componente VARCHAR(100), -- Parâmetro: Nome do componente de especialização
    IN p_sigla VARCHAR(15), -- Parâmetro: Sigla da turma a ser cadastrada
    IN p_semestre NUMERIC -- Parâmetro: Semestre da turma a ser cadastrada
)
LANGUAGE SQL -- Define a linguagem do procedimento como SQL
AS $$
INSERT INTO aluno_especializacao_cursa_turma (cpf_aluno, id_turma_especializacao, situacao_aluno, frequencia)
SELECT
    p_cpf_aluno, -- Insere o CPF do aluno
    te.id_turma_especializacao, -- Obtém o ID da turma de especialização correspondente
    'CURSANDO', -- Define a situação do aluno como 'CURSANDO'
    99.9 -- Define uma frequência inicial de 99.9 (por exemplo)
FROM turma_especializacao te
INNER JOIN componente_curricular cc ON te.nome_componente = cc.nome_componente
WHERE cc.nome_componente = p_nome_componente -- Condição: Nome do componente corresponde ao parâmetro
    AND te.sigla = p_sigla -- Condição: Sigla da turma corresponde ao parâmetro
    AND te.semestre = p_semestre; -- Condição: Semestre da turma corresponde ao parâmetro
$$;


--TESTE
-- Dummy Data Script (Part 1)
-- Insert data into cep_endereco table
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

-- Insert data into usuario table
INSERT INTO usuario (cpf, primeiro_nome, sobrenome, genero, data_nascimento, numero, complemento, cep_usuario, cnpj_ies_associada)
VALUES
    ('12345678901', 'John', 'Doe', 'Male', '1990-01-01', 10, 'Complemento 10', '12345678', '12345678901234'),
    ('98765432109', 'Jane', 'Doe', 'Female', '1995-02-02', 20, 'Complemento 20', '87654321', '98765432109876');

-- Insert data into email_usuario table
INSERT INTO email_usuario (email_usuario, cpf_usuario)
VALUES
    ('johndoe@gmail.com', '12345678901'),
    ('janedoe@gmail.com', '98765432109');


-- Dummy Data Script (Part 2)
-- Insert data into professor_isf table
INSERT INTO professor_isf (cpf_professor_isf)
VALUES
    ('12345678901'),
    ('98765432109');

-- Insert data into idioma_professor_isf table
INSERT INTO idioma_professor_isf (cpf_professor_isf, idioma, proficiencia, declaracao_proficiencia)
VALUES
    ('12345678901', 'English', 'C1', 'Declaration 1'),
    ('12345678901', 'French', 'B2', 'Declaration 2'),
    ('98765432109', 'German', 'A2', 'Declaration 3');

-- Insert data into aluno_especializacao table
INSERT INTO aluno_especializacao (cpf_aluno_especializacao, titulacao, data_ingresso, data_conclusao, matricula_ativa, diploma_file)
VALUES
    ('12345678901', 'M.Sc', '2020-01-01', '2022-12-31', true, 'Diploma 1.pdf'),
    ('98765432109', 'Ph.D', '2018-03-15', '2023-06-30', true, 'Diploma 2.pdf');

INSERT INTO repositorio (titulo, link, data_inclusao)
VALUES
    ('Repositorio A', 'Link A', '2022-01-01'),
    ('Repositorio B', 'Link B', '2023-02-15');

-- Insert data into aluno_especializacao_produz_repositorio table
INSERT INTO aluno_especializacao_produz_repositorio (cpf_aluno_especializacao, repositorio_titulo, foi_validado_pelo_orientador)
VALUES
    ('12345678901', 'Repositorio A', true),
    ('98765432109', 'Repositorio B', false);

-- Insert data into repositorio table


--TESTE DO CADASTRAMENTO
CALL cadastrar_aluno_em_aula(
    '12345678901',
    'Language Class A',
    'LC1',
    1
);

------------------------------------------- ApresentaDadosProfessorISF -------------------------------------------

-- Autor: Bruno Luis R Medri - 790004
-- Descrição: Mostrar os dados do Professor ISF

-- Cria ou substitui a view chamada "vw_professor_isf".
CREATE OR REPLACE VIEW vw_professor_isf AS

-- Selecioa os bangui
SELECT
    pi.cpf_professor_isf, 
    u.primeiro_nome,
    u.sobrenome,
    u.genero,
    u.data_nascimento,
    u.numero,
    u.complemento,
    u.cep_usuario,
    u.cnpj_ies_associada

FROM
    -- A tabela "professor_isf" referenciada como "pi" para ser usada na consulta.
    professor_isf pi

JOIN
    -- Realiza uma junção (JOIN) entre a tabela "professor_isf" e "usuario" com base no CPF, 
    -- relacionando os dados do professor ISF aos dados do usuário associado.
    usuario u ON pi.cpf_professor_isf = u.cpf;
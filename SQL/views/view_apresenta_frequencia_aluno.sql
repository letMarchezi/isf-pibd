CREATE VIEW ApresentaFrequenciaAluno AS
SELECT
    cpf_aluno,
    id_turma_especializacao,
    frequencia
FROM
    aluno_especializacao_cursa_turma
WHERE
    situacao_aluno = 'CURSANDO';
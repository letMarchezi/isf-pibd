CREATE OR REPLACE VIEW atividades_alunos_especializacao_view AS
SELECT
    ae.cpf_aluno AS cpf_aluno,
    t.nome_componente AS nome_componente,
    t.sigla AS sigla,
    t.semestre AS semestre,
    aa.atividade AS atividade,
    aa.nota AS nota,
    t.id_turma_especializacao AS id_turma_especializacao
FROM
    aluno_especializacao_cursa_turma ae
JOIN
    atividades_aluno_especializacao aa
ON
    ae.cpf_aluno = aa.cpf_aluno
    AND ae.id_turma_especializacao = aa.id_turma_especializacao
JOIN
    turma_especializacao t
ON
    ae.id_turma_especializacao = t.id_turma_especializacao;
--SELECT * FROM atividades_alunos_especializacao_view;



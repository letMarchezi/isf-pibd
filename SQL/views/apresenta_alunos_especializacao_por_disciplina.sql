CREATE OR REPLACE VIEW View_Alunos_por_disciplina AS
SELECT
    ae.cpf_aluno_especializacao,
    u.primeiro_nome,
    u.sobrenome,
    CASE
        WHEN ae.matricula_ativa THEN 'Ativo'
        ELSE 'Inativo'
    END AS tipo_docente,
    te.nome_componente,
    te.sigla,
    te.hora_inicio,
    te.hora_fim
FROM
    aluno_especializacao_cursa_turma cursando
    JOIN 
    aluno_especializacao ae ON ae.cpf_aluno_especializacao = cursando.cpf_aluno
    JOIN
    turma_especializacao te ON te.id_turma_especializacao = cursando.id_turma_especializacao
  	LEFT JOIN
    usuario u ON ae.cpf_aluno_especializacao = u.cpf
ORDER BY te.nome_componente;
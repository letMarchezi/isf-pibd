CREATE OR REPLACE VIEW View_Aluno_Especializacao AS
SELECT 
	a.primeiro_nome, a.sobrenome, a.genero, 
	e.email_usuario,
	t.frequencia,
	o.primeiro_nome AS primeiro_nome_orientador, o.sobrenome AS sobrenome_orientador,
	at.atividade, at.nota
FROM usuario a
INNER JOIN email_usuario e ON a.cpf = e.cpf_usuario
INNER JOIN aluno_especializacao_cursa_turma t ON a.cpf = t.cpf_aluno
INNER JOIN atividades_aluno_especializacao at ON a.cpf = at.cpf_aluno
INNER JOIN docente_orientador_orienta_professorIsf r ON a.cpf = r.CPF_professor_isf
INNER JOIN usuario o ON r.CPF_docente = o.cpf
ORDER BY a.cpf;

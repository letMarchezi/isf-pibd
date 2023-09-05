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

-- TESTES --
-- usuario
INSERT INTO usuario(
	cpf, primeiro_nome, sobrenome, data_nascimento
)
VALUES
	('11122233344', 'Ana', 'Clara', '1998-12-12'),
  	('55566677788', 'João', 'Pedro', '1996-11-11'),
  	('11122277788', 'Andre', 'Rubens', '1994-10-10')
;

INSERT INTO professor_isf(
	cpf_professor_isf
)
VALUES
	('11122233344'),
    ('55566677788'),
    ('11122277788')
;

-- aluno especializacao
INSERT INTO aluno_especializacao(
	cpf_aluno_especializacao, data_ingresso, matricula_ativa, titulacao
)
VALUES
	('11122233344', '2022-12-10', TRUE, 'Doutor'),
    ('55566677788', '2022-12-10', TRUE, 'Mestre'),
    ('11122277788', '2022-12-10', TRUE, 'Mestre')
;

INSERT INTO proficiencia_idioma_componente(
	nome_idioma
)
VALUES
	('Ingles'), ('Alemao'), ('Japones');

INSERT INTO componente_curricular(
	nome_componente, nome_idioma, carga_horaria_pratica, carga_horaria_teorica
)
VALUES
	('Ingles for dummies', 'Ingles', 40, 60),
    ('Alemao so alemao', 'Alemao', 40, 60),
    ('Japones para ocidentais', 'Japones', 40, 60)
;

-- turma especializacao
INSERT INTO turma_especializacao(
	id_turma_especializacao, nome_componente, sigla, semestre
)
VALUES
	(1, 'Ingles for dummies', 'ENB-fd', 1),
    (2, 'Alemao so alemao', 'ALI-sa', 1),
    (3, 'Japones para ocidentais', 'JPI-po', 1)
;

-- relacao aluno-turma
INSERT INTO aluno_especializacao_cursa_turma(
	id_turma_especializacao, cpf_aluno
)
VALUES
	(1, '11122233344'),
    (1, '55566677788'),
    (2, '11122277788')
;

SELECT * FROM view_alunos_por_disciplina;

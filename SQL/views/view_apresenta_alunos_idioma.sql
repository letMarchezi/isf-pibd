-- View para mostrar TODOS os alunos de oferta coletiva ja cadastrados no sistema
-- Mostrando situação da matricula antes (poderia ser um filtro?)
create or replace view apresenta_alunos_idioma as
	select m.situacao_matricula, u.* 
	from usuario u
		join aluno_oferta_coletiva a
			on a.cpf_aluno = u.cpf
		join aluno_inscreve_turma_oferta i
			on i.cpf_aluno = a.cpf_aluno
		join aluno_matricula_turma_oferta m
			on m.id_inscricao = i.id_inscricao

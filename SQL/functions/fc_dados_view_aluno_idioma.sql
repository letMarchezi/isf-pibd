-- ITVF para filtrar a view de alunos por CPF
create or replace function DadosViewAlunosIdioma(cpf_busca varchar)
returns table (
	-- Dados a serem apresentados
	situacao_matricula varchar,
	cpf varchar,
	primeiro_nome varchar,
	sobrenome varchar,
	genero varchar,
	data_nascimento date,
	numero int,
	complemento varchar,
	cep_usuario varchar,
	cnpj_ies_associada varchar)
as $$
begin 
		return query
			select u.situacao_matricula,
				   u.cpf,
				   u.primeiro_nome,
				   u.sobrenome, 
				   u.genero, 
				   u.data_nascimento, 
				   u.numero, 
				   u.complemento, 
				   u.cep_usuario, 
				   u.cnpj_ies_associada
				   
			from apresenta_alunos_idioma u
			-- Filtro de retorno (cpf)
			where u.cpf ilike '%' || cpf_busca || '%';
end;
$$ language plpgsql;

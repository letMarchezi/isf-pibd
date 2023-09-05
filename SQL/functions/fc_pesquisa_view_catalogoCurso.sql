-- CRIAR FUNCTION
-- PESQUISAR turma da especialização
-- tabela "turma_especializacao"
create or replace function pesquisa_catalgo_curso(nome_curs_pesq varchar, nivl_pesq varchar)
	returns table (
		id_curso_pesq int4,
		nome_curso_pesq varchar,
		idioma_pesq varchar,
		nivel_curs_pesq varchar,
		categ_pesq varchar,
		carga_horar_pesq int4,
		link_pesq varchar
	)
	language plpgsql
as $$
begin
	-- pesquisa os dados dentro das condições
	--'::int4', garante a conversão desses campos para inteiro
	return query
	select
		id_curso_idioma::int4, nome_completo, idioma,
		nivel, categoria, carga_horaria::int4, link_ementa 
	from catalgo_curso_idioma
	where nome_completo ilike nome_curs_pesq and nivel ilike nivl_pesq;

end; $$

-- Chamada da function pesquisa_catalgo_curso
select * from pesquisa_catalgo_curso('Disc_%', 'med%');


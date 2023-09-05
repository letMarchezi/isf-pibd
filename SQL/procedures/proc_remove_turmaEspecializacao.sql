-- CRIAR PROCEDURE
-- remover turma da especialização
-- tabela "turma_especializacao"
create or replace procedure remover_turma_espec(
   id_turma_remv int
)
language plpgsql    
as $$
begin
    -- remover da tabela como mesmo id passado nos parametros
	delete from turma_especializacao
	where id_turma_especializacao = id_turma_remv;
    
    commit;
end;$$

valor_idTurmaEspecializacao int
-- Chamada da procedure remover_turma_espec
call remover_turma_espec(valor_idTurmaEspecializacao);
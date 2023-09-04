-- Trigger que verifica antes do insert se o valor seria aceitável (14 caracteres)
-- Criar esta função para ser chamada no trigger
create or replace function ValidaCPF_Professor_Isf() returns trigger as $$
begin
    if lenght(new.cpf_professor_isf) != 14 then
    	-- Cancelar inserção
        return null; 
    end if;
   		-- Permite Inserção
    	return new; 
end;
$$ language plpgsql;

-- Trigger que verifica se o CPF tentado adicionar foi com 14 caracteres
create or replace trigger ValidaInsercaoProfISF
before insert on Professor_isf
	-- A cada valor inserido, verificará se o cpf pode ser aceito
	for each row
		execute function ValidaCPF_Professor_Isf();
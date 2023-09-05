-- Procedure para validar a inserção de um valor na tablea "professor_isf"
CREATE OR REPLACE PROCEDURE insereprofisf(id varchar) AS $$
declare
	-- variáveis
    existe boolean;
    repetido boolean;
BEGIN
    -- Existe em "usuário"?
    SELECT EXISTS (SELECT 1 FROM usuario WHERE cpf = id) INTO existe;
	select exists (select * from PROFESSOR_ISF where CPF_PROFESSOR_ISF = id) into repetido;
    IF existe THEN
        -- Existe este cpf, então aceito
    	if not repetido then
        	INSERT INTO professor_isf VALUES (id);
        else
        	RAISE EXCEPTION 'CPF já cadastrado em Prof. ISF.';
        end if;
    ELSE
        -- Não existe este cpf, então não adiciona
        RAISE EXCEPTION 'Não foi encontrado CPF em "Usuário".';
    END IF;
END;
$$ LANGUAGE plpgsql;
--PROCEDURE COM CURSOR EXPLICITO)
--nome: proc_update_aluno_idioma.sql

CREATE OR REPLACE PROCEDURE update_aluno_oferta_coletiva(
    IN p_cpf_aluno VARCHAR(11), 
    IN p_vinculo_file VARCHAR(255)
) LANGUAGE plpgsql AS 
$$ 
DECLARE
    aluno_para_atualizar CURSOR FOR 
        SELECT * FROM aluno_oferta_coletiva WHERE cpf_aluno = p_cpf_aluno;

    aluno_row aluno_oferta_coletiva%ROWTYPE;

BEGIN
    OPEN aluno_para_atualizar;

    FETCH aluno_para_atualizar INTO aluno_row;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Aluno com CPF % não encontrado!', p_cpf_aluno;
    ELSIF FOUND THEN
        UPDATE aluno_oferta_coletiva 
        SET 
            vinculo_file = p_vinculo_file
        WHERE CURRENT OF aluno_para_atualizar;
    END IF;

    CLOSE aluno_para_atualizar;
END;
$$;

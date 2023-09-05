CREATE OR REPLACE PROCEDURE update_doc_nomeacao(
    IN p_cpf_gestor VARCHAR(11),
    IN p_cpf_coordenador_administrativo VARCHAR(11),
    IN p_novo_documento_de_atuacao VARCHAR(255)
) AS $$
DECLARE
    cur_cursor CURSOR FOR
        SELECT cpf_gestor_rede_andifes, cpf_coordenador_administrativo
        FROM gestor_aprova_coord_adm
        WHERE cpf_gestor_rede_andifes = p_cpf_gestor
        AND cpf_coordenador_administrativo = p_cpf_coordenador_administrativo;
    
    cur_row RECORD;
BEGIN
    -- Abre o cursor
    OPEN cur_cursor;

    -- Loop através das linhas retornadas pelo cursor
    LOOP
        FETCH cur_cursor INTO cur_row;
        EXIT WHEN NOT FOUND;

        -- Atualiza o campo documento_de_atuacao
        UPDATE gestor_aprova_coord_adm
        SET documento_de_atuacao = p_novo_documento_de_atuacao
        WHERE cpf_gestor_rede_andifes = cur_row.cpf_gestor_rede_andifes
        AND cpf_coordenador_administrativo = cur_row.cpf_coordenador_administrativo;

    END LOOP;

    -- Fecha o cursor
    CLOSE cur_cursor;
END;
$$ LANGUAGE plpgsql;

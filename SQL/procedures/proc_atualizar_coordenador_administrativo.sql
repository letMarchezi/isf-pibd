CREATE OR REPLACE FUNCTION proc_atualizar_coordenador_administrativo(
    cpf_coordenador_param VARCHAR(11),
    funcao_na_instituicao_param VARCHAR(100),
    curriculo_lates_param VARCHAR(255),
    data_cadastro_param DATE,
    poca_param VARCHAR(50)
)
RETURNS VOID AS $$
DECLARE
    cpf_coordenador_atual VARCHAR(11);
BEGIN
    -- Inicialize o cursor para buscar o registro do coordenador administrativo
    FOR cpf_coordenador_atual IN (SELECT cpf_coordenador FROM coordenador_administrativo WHERE cpf_coordenador = cpf_coordenador_param) LOOP
        -- Verifica se o registro do coordenador existe
        IF cpf_coordenador_atual IS NOT NULL THEN
            -- Atualize os dados do coordenador administrativo
            UPDATE coordenador_administrativo
            SET
                funcao_na_instituicao = funcao_na_instituicao_param,
                curriculo_lates = curriculo_lates_param,
                data_cadastro = data_cadastro_param,
                poca = poca_param
            WHERE cpf_coordenador = cpf_coordenador_param;
        END IF;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

--select * from coordenador_administrativo 


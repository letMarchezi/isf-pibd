
--Function para criar a remoção
CREATE OR REPLACE FUNCTION fc_remove_ies(cnpj_param VARCHAR(14)) RETURNS VOID AS $$
BEGIN
    DELETE FROM ies WHERE cnpj = cnpj_param; --comando postgres para remover o registro
END;
$$ LANGUAGE plpgsql;

--procedure a ser chamada
CREATE OR REPLACE PROCEDURE proc_remove_ies(cnpj_param VARCHAR(14))
LANGUAGE plpgsql
AS $$
begin --chamando function
    PERFORM fc_remove_ies(cnpj_param);
END;
$$;


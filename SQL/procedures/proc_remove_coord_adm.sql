--Function para criar a remoção
CREATE OR REPLACE FUNCTION fc_remove_coordadm(cpf_param VARCHAR(11)) RETURNS VOID AS $$
BEGIN
    DELETE FROM coordenador_administrativo WHERE cpf = cpf_param; --comando postgres para remover o registro
END;
$$ LANGUAGE plpgsql;

--procedure a ser chamada
CREATE OR REPLACE PROCEDURE proc_remove_coordadm(cpf_param VARCHAR(11))
LANGUAGE plpgsql
AS $$
begin --chamando function
    PERFORM fc_remove_coordadm(cnpj_param);
END;
$$;


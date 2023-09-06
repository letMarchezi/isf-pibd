CREATE OR REPLACE FUNCTION trigger_valida_telefone_antes_inserir()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.NUMERO !~ '^[0-9]{8}([0-9]{1})?$' THEN
        RAISE EXCEPTION 'Formato Invalido de telefone: %', NEW.DDD;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_telefone
BEFORE INSERT ON telefone_ies
FOR EACH ROW
EXECUTE FUNCTION trigger_valida_telefone_antes_inserir();

/*INSERT INTO TelefoneIES (CNPJ_IES, DDD, DDI, numero)
VALUES ('your_cnpj_here', '11', '1', '123456789');
*-/
CREATE OR REPLACE FUNCTION trigger_valida_ddd_antes_inserir()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.DDD !~ '^[0-9]{2}$' THEN
        RAISE EXCEPTION 'Formato Invalido de DDD: %', NEW.DDD;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_ddd
BEFORE INSERT ON telefone_ies
FOR EACH ROW
EXECUTE FUNCTION trigger_valida_ddd_antes_inserir();

/*INSERT INTO TelefoneIES (CNPJ_IES, DDD, DDI, numero)
VALUES ('your_cnpj_here', '11', '1', '123456789');

*INSERT INTO TelefoneIES (CNPJ_IES, DDD, DDI, numero)
VALUES ('your_cnpj_here', '011', '1', '123456789');
*-/
CREATE OR REPLACE FUNCTION ValidaDDDAntesInserir()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.DDD !~ '^[0-9]{2}$' THEN
        RAISE EXCEPTION 'Formato Invalido de DDD: %', NEW.DDD;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER CheckDDD
BEFORE INSERT ON TelefoneIES
FOR EACH ROW
EXECUTE FUNCTION ValidaDDDAntesInserir();

/*INSERT INTO TelefoneIES (CNPJ_IES, DDD, DDI, numero)
VALUES ('your_cnpj_here', '11', '1', '123456789');
*-/
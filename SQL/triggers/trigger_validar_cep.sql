CREATE OR REPLACE FUNCTION ValidarCEP()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se o CEP é um número de 8 dígitos
    IF NEW.cep_usuario ~ '^[0-9]{8}$' THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'CEP inválido. O CEP deve conter exatamente 8 dígitos numéricos.';
    END IF;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER Trigger_ValidarCEP
BEFORE INSERT OR UPDATE ON usuario
FOR EACH ROW
EXECUTE FUNCTION ValidarCEP();
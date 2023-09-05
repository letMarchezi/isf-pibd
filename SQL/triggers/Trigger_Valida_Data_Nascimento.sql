CREATE OR REPLACE FUNCTION Valida_Data_Nascimento()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.data_nascimento IS NULL THEN
            RAISE EXCEPTION 'Data de nascimento não pode ser nulo.';
    END IF;
    IF NEW.data_nascimento !~ '^\d{4}-\d{2}-\d{2}$' THEN
        RAISE EXCEPTION 'Formato da data de nascimento inválido: %', NEW.data_nascimento;
    END IF;
    IF NEW.data_nascimento > current_date THEN
        RAISE EXCEPTION 'Data de nascimento inválida.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER Trigger_Valida_Data_Nascimento
BEFORE INSERT ON usuario
FOR EACH ROW
EXECUTE FUNCTION Valida_Data_Nascimento();

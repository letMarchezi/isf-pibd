CREATE OR REPLACE FUNCTION valida_data_nascimento()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se a data de nascimento é válida
    IF NEW.data_nascimento IS NOT NULL AND (NEW.data_nascimento < '1923-01-01' OR NEW.data_nascimento > current_date) THEN
        RAISE EXCEPTION 'Data de nascimento inválida: %', NEW.data_nascimento;
    END IF;

    -- Retorna NEW para permitir a operação DML (inserção ou atualização)
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

-- Cria a trigger para antes de INSERT ou UPDATE
CREATE TRIGGER trigger_valida_data_nascimento
BEFORE INSERT OR UPDATE ON usuario
FOR EACH ROW
EXECUTE FUNCTION valida_data_nascimento();


/*
teste
INSERT INTO USUARIO VALUES('39312381873', 'LIPE', 'MATTOS', NULL, '1922-12-31',null, null, null,null);
*/


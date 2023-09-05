CREATE OR REPLACE FUNCTION fc_valida_numero_telefone(numero VARCHAR(15))
RETURNS BOOLEAN AS $$
BEGIN
    -- Remova caracteres não numéricos do número de telefone
    numero := regexp_replace(numero, '[^0-9]', '', 'g');
    
    -- Verifique se o número de telefone tem o comprimento correto
    IF length(numero) = 10 OR length(numero) = 11 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION verificar_formato_CEP(in_cep VARCHAR(8))
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifique se o CEP possui exatamente 8 dígitos numéricos
    IF LENGTH(in_cep) = 8 AND in_cep ~ '^[0-9]+$' THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$;

/*
SELECT verificar_formato_CEP('12345678'); --Retorna TRUE
SELECT verificar_formato_CEP('4002'); --Retorna FALSE
*/
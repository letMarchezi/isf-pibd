CREATE OR REPLACE FUNCTION valida_ddi(ddi VARCHAR(3)) RETURNS BOOLEAN AS $$
BEGIN
    -- Verificar se o DDI consiste apenas em dígitos numéricos
    IF ddi ~ '^[0-9]+$' THEN
        -- Verificar se o DDI está dentro do intervalo válido (1 a 999)
        RETURN CAST(ddi AS INTEGER) >= 1 AND CAST(ddi AS INTEGER) <= 999;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;
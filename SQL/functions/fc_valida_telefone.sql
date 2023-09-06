CREATE OR REPLACE FUNCTION valida_telefone(num_telefone VARCHAR(9)) RETURNS BOOLEAN AS
$$
BEGIN
    IF LENGTH(num_telefone) >= 8 AND num_telefone ~ '^[0-9]{8}([0-9]{1})?$' THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;

/*SELECT valida_telefone('342343231');  -- Returns TRUE
SELECT valida_telefone('921839283928'); -- Returns FALSE*/
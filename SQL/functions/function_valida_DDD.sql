CREATE OR REPLACE FUNCTION function_valida_ddd(p_DDD VARCHAR(3)) RETURNS BOOLEAN AS
$$
BEGIN
    IF LENGTH(p_DDD) = 2 AND p_DDD ~ '^[0-9]{2}$' THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;

/*SELECT ValidaDDD('01');  -- Returns TRUE
SELECT ValidaDDD('123'); -- Returns FALSE*/
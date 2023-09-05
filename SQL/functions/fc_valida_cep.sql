CREATE OR REPLACE FUNCTION function_valida_CEP(p_CEP CHARACTER VARYING) RETURNS BOOLEAN AS
$$
BEGIN
    IF LENGTH(p_CEP) = 8 AND p_CEP ~ '^[0-9]{8}$' THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- TESTES --
/*
SELECT function_valida_cep('111121212121212121');
SELECT function_valida_cep('1122');
SELECT function_valida_cep('13025630');
*/

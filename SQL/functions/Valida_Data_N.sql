CREATE OR REPLACE FUNCTION Valida_Data_N(data_nascimento DATE) RETURNS BOOLEAN AS
$$
BEGIN
    IF data_nascimento !~ '^\d{4}-\d{2}-\d{2}$' THEN
        RETURN FALSE;
    END IF;
    IF data_nascimento > current_date THEN
        RETURN FALSE;
    END IF;
    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;

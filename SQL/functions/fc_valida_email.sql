/*FUNÇÃO QUE VALIDA EMAIL */

CREATE OR REPLACE FUNCTION valida_email_formato(input_email VARCHAR)
RETURNS BOOLEAN AS $$
BEGIN
	RETURN REGEXP_LIKE(LOWER(input_email), '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$');
END;
$$ LANGUAGE plpgsql;

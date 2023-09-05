/*FUNÇÃO QUE VALIDA EMAIL INSTITUCIONAL PARA O FORMATO {}@{}.edu.br em maiúsculo ou minúsculo
*/


CREATE OR REPLACE FUNCTION valida_email_institucional(input_email VARCHAR)
RETURNS BOOLEAN AS $$
BEGIN
	RETURN REGEXP_LIKE(LOWER(input_email),'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.+-]+\.edu.br$');
END; $$ 
LANGUAGE plpgsql;

/*
SELECT valida_email_institucional('aaaaa@adu.br');
SELECT valida_email_institucional('aaaaa@edu.br');
SELECT valida_email_institucional('aaaaa@ufscar.br');
SELECT valida_email_institucional('aaaa@edu.br');
SELECT valida_email_institucional('aaaaa@ufscar.edu.br');
SELECT valida_email_institucional('AAAAA@UFSCAR.EDU.BR');

Resultado: FALSE, FALSE, FALSE, FALSE, TRUE, TRUE
*/
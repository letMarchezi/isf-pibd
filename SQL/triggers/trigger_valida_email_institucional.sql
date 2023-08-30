/*
TRIGGER PARA VALIDAR O UPDATE E INSERÇÃO DE EMAIL INSTITUCIONAL
Verifica se o tipo é igual a 'INSTITUCIONAL' e se o email respeita o formato
'{}@{}.edu.br'. Se a condição não for satisfeita, retorna um erro de formato inválido
*/						  
								  
CREATE OR REPLACE FUNCTION func_trigger_valida_email_institucional()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
BEGIN

	IF UPPER(NEW.tipo) LIKE 'INSTITUCIONAL' THEN
		IF REGEXP_LIKE(LOWER(NEW.endereco_email),'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.+-]+\.edu.br$') THEN
			RETURN NEW;
		ELSE
			RAISE EXCEPTION 'Formato de email institucional inválido';
		END IF;
	ELSE
		RETURN NEW;
	END IF;
END;
$$

CREATE OR REPLACE TRIGGER trigger_valida_email_institucional	
BEFORE UPDATE ON email
FOR EACH ROW
EXECUTE FUNCTION func_trigger_valida_email_institucional();
		
CREATE OR REPLACE TRIGGER trigger_valida_email_institucional	
BEFORE INSERT ON email
FOR EACH ROW
EXECUTE FUNCTION func_trigger_valida_email_institucional();		


/* EXEMPLO:
INSERT INTO email
VALUES ('aaa.a@gmail.com','gmail'),('aaa.a@email.com','email'),('bbb@ufscar.br','email'),('sss@r.edu.br','institucional'),('sssss@UFSCAR.edu.br','institucional');
-- SUCESSO

INSERT INTO email
VALUES ('rrr@.edu.br.com','institucional');
-- ERRO:  Formato de email institucional inválido


SELECT * FROM email;
*/			
					
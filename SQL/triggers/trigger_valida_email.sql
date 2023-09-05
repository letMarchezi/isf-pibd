/*
TRIGGER PARA VALIDAR O UPDATE E INSERÇÃO DE EMAIL
*/

CREATE OR REPLACE FUNCTION valida_email_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT valida_email_formato(NEW.endereco_email) THEN
        RAISE EXCEPTION 'E-mail inválido: %', NEW.endereco_email;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validar_email
BEFORE INSERT OR UPDATE ON email
FOR EACH ROW
EXECUTE FUNCTION valida_email_trigger();


/*

-- Inserir um registro com um e-mail válido
INSERT INTO sua_tabela (email) VALUES ('exemplo@email.com');

-- Inserir um registro com um e-mail inválido
INSERT INTO sua_tabela (email) VALUES ('email.invalido');

-- Atualizar um registro com um e-mail inválido
UPDATE sua_tabela SET email = 'email.invalido' WHERE id = 1;

*/
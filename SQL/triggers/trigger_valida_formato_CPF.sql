CREATE OR REPLACE FUNCTION validar_cpf()
RETURNS TRIGGER AS $$
BEGIN
    -- Verificar se o CPF possui exatamente 11 dígitos numéricos
    IF NEW.cpf ~ '^\d{11}$' THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'CPF inválido: %', NEW.cpf;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Crie uma trigger para a tabela usuario que chama a função validar_cpf antes da inserção
CREATE TRIGGER trigger_validar_cpf
BEFORE INSERT ON usuario
FOR EACH ROW
EXECUTE FUNCTION validar_cpf();


-- Tente inserir um registro com um CPF válido
INSERT INTO usuario (cpf, primeiro_nome, sobrenome, genero, data_nascimento)
VALUES ('12345678987', 'João', 'Silva', 'Masculino', '1990-01-01');

-- Tente inserir um registro com um CPF inválido
INSERT INTO usuario (cpf, primeiro_nome, sobrenome, genero, data_nascimento)
VALUES ('12345', 'Maria', 'Santos', 'Feminino', '1985-02-15');

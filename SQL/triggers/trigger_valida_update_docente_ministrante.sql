-- Criação do trigger BEFORE UPDATE
CREATE OR REPLACE FUNCTION validar_formato_dados_trigger_update()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica o formato da titulação (não contém números)
    IF (NEW.titulacao IS NOT NULL) AND (regexp_match(NEW.titulacao, '\d+') IS NOT NULL) THEN
        RAISE EXCEPTION 'A titulação não pode conter números';
    END IF;

    -- Verifica o formato dos links do CNPQ (começam com http:// ou https://)
    IF (NEW.link_cnpq IS NOT NULL) AND (NOT regexp_match(NEW.link_cnpq, '^(http://|https://)') IS NOT NULL) THEN
        RAISE EXCEPTION 'O link do CNPQ deve começar com http:// ou https://';
    END IF;
	
	 -- Verifica se o currículo é um URL válido
    IF (NEW.curriculo IS NOT NULL) AND (NOT regexp_match(NEW.curriculo, '^(http://|https://)') IS NOT NULL) THEN
        RAISE EXCEPTION 'O currículo deve ser um URL válido começando com http:// ou https://';
    END IF;

    -- Adicione uma instrução de retorno (RETURN) no final da função
    RETURN NEW;

EXCEPTION
    WHEN OTHERS THEN
        -- Exibe a mensagem de erro
        RAISE EXCEPTION 'Erro durante a validação dos dados: %', SQLERRM;
END;
$$ LANGUAGE plpgsql;

-- Criação do trigger BEFORE UPDATE
CREATE TRIGGER validar_formato_dados_trigger_update
BEFORE UPDATE ON docente_especialista
FOR EACH ROW
EXECUTE FUNCTION validar_formato_dados_trigger_update();
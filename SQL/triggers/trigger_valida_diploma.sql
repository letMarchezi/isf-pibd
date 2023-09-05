CREATE OR REPLACE FUNCTION check_file_extension() 
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.diploma_file NOT LIKE '%.jpeg' 
    AND NEW.diploma_file NOT LIKE '%.jpg' 
    AND NEW.diploma_file NOT LIKE '%.png' 
    AND NEW.diploma_file NOT LIKE '%.doc' 
    AND NEW.diploma_file NOT LIKE '%.docx' 
    AND NEW.diploma_file NOT LIKE '%.pdf' 
    THEN
        RAISE EXCEPTION 'Arquivo inválido. Extensão de arquivo deve ser .jpeg, .jpg, .png, .doc, .docx ou .pdf.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_diploma_file
BEFORE INSERT OR UPDATE OF diploma_file ON aluno_especializacao
FOR EACH ROW EXECUTE PROCEDURE check_file_extension();
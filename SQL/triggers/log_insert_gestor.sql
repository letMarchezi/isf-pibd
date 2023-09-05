CREATE OR REPLACE FUNCTION log_insert_gestor()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO view_log_gestor (CPF_gestor)
    VALUES (NEW.CPF_gestor);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER log_insert_gestor
AFTER INSERT ON Gestor_Rede_Andifes
FOR EACH ROW
EXECUTE FUNCTION log_insert_gestor();
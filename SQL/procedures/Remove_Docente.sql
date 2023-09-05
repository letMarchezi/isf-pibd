CREATE OR REPLACE PROCEDURE Remove_Docente (cpf_param VARCHAR) AS
$$
BEGIN
  DELETE FROM docente_especialista WHERE cpf_docente = cpf_param;
  
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Docente com CPF % não encontrado.', cpf_param;
  END IF;
  
  COMMIT;
END;
$$
LANGUAGE plpgsql;


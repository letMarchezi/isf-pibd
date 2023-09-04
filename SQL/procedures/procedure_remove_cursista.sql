------------------------------------------- RemoveCursista -------------------------------------------
CREATE OR REPLACE PROCEDURE remove_cursista(cpf_param VARCHAR) AS
$$
BEGIN
  DELETE FROM aluno_especializacao WHERE cpf_aluno_especializacao = cpf_param;
  
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Aluno com CPF % não encontrado.', cpf_param;
  END IF;
  
  COMMIT;
END;
$$
LANGUAGE plpgsql;


/*
USO:
CALL remove_cursista('39312381873');
*/

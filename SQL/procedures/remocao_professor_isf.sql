CREATE OR REPLACE PROCEDURE delete_professor(cpf_informado VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM ProfessorIsf WHERE cpf = cpf_informado;
END;
$$

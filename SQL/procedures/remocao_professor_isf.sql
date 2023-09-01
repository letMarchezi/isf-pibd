CREATE OR REPLACE FUNCTION remove_professor_isf(cpf_professor_isf VARCHAR)
RETURNS VOID AS $$
BEGIN
    DELETE FROM ProfessorIsf WHERE CPF_professor_isf = cpf_professor_isf;
END;
$$ LANGUAGE plpgsql;
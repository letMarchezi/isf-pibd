CREATE OR REPLACE FUNCTION PesquisaViewCursista(cpf_pesquisa VARCHAR(11)) 
RETURNS TABLE(
    primeiro_nome VARCHAR(50),
    sobrenome VARCHAR(50),
    genero VARCHAR(20),
    data_nascimento DATE,
    titulacao VARCHAR(40),
    data_ingresso DATE,
    data_conclusao DATE,
    matricula_ativa BOOLEAN,
    diploma_file VARCHAR(255),
    email_usuario VARCHAR(320)
) 
AS $$
BEGIN
 RETURN QUERY
 SELECT primeiro_nome, sobrenome, genero, data_nascimento, 
        titulacao, data_ingresso, data_conclusao, 
        matricula_ativa, diploma_file, email_usuario
 FROM PesquisaViewCursista
 WHERE cpf_aluno_especializacao = cpf_pesquisa;
END; $$ 
LANGUAGE plpgsql;

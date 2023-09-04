CREATE OR REPLACE PROCEDURE InsereCursista(titulacao_param VARCHAR(40),
                                           data_ingresso_param DATE,
                                           data_conclusao_param DATE,
                                           matricula_ativa_param BOOLEAN,
                                           diploma_file_param VARCHAR(255),
                                           cpf_param VARCHAR(11),
                                           primeiro_nome_param VARCHAR(50),
                                           sobrenome_param VARCHAR(50),
                                           genero_param VARCHAR(20),
                                           data_nascimento_param DATE,
                                           numero_param INTEGER,
                                           complemento_param VARCHAR(100),
                                           cep_usuario_param VARCHAR(8),
										   rua_param VARCHAR(100),
										   bairro_param VARCHAR(50),
										   cidade_param VARCHAR(50),
										   estado_param VARCHAR(2),
										   pais_param VARCHAR(50),  
                                           cnpj_ies_associada_param VARCHAR(20),
                                           email_usuario_param VARCHAR(320),  
										   email_tipo_param VARCHAR(50))
LANGUAGE plpgsql
AS $$

BEGIN
    -- Insere email do usuário
    INSERT INTO email (endereco_email, tipo)
    VALUES (email_usuario_param, email_tipo_param);

    -- Insere o endereço do cep
    INSERT INTO cep_endereco (cep, rua, bairro, cidade, estado, pais)
	VALUES (cep_usuario_param, rua_param, bairro_param, cidade_param, estado_param, pais_param);

    -- Insere o usuário
    INSERT INTO usuario (cpf, primeiro_nome, sobrenome, genero, data_nascimento, numero, complemento, cep_usuario, cnpj_ies_associada)
    VALUES (cpf_param, primeiro_nome_param, sobrenome_param, genero_param, data_nascimento_param, numero_param, complemento_param, cep_usuario_param, cnpj_ies_associada_param);

    -- Insere o professor ISF
    INSERT INTO professor_isf (cpf_professor_isf)
    VALUES (cpf_param); 

    -- Insere vínculo do email do usuário com o cpf
    INSERT INTO email_usuario (email_usuario, cpf_usuario)
    VALUES (email_usuario_param, cpf_param);  

    -- Insere o aluno de especialização
    INSERT INTO aluno_especializacao (cpf_aluno_especializacao, titulacao, data_ingresso, data_conclusao, matricula_ativa, diploma_file)
    VALUES (cpf_param, titulacao_param, data_ingresso_param, data_conclusao_param, matricula_ativa_param, diploma_file_param);
END;
$$

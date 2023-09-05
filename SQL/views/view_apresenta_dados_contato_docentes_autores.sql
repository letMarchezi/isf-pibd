-- Crie uma VIEW para obter os dados de contato de docentes autores
CREATE OR REPLACE VIEW dados_contato_docentes_autores AS
SELECT
    de.cpf_docente,
    u.primeiro_nome || ' ' || u.sobrenome AS nome_completo,
    eu.email_usuario AS endereco_email,
    u.numero AS numero_endereco,
    u.complemento AS complemento_endereco,
    u.cep_usuario,
    u.cnpj_ies_associada,
    te.ddd AS ddd_telefone,
    te.ddi AS ddi_telefone,
    te.numero AS numero_telefone
FROM
    docente_especialista de
INNER JOIN
    usuario u ON de.cpf_docente = u.cpf
LEFT JOIN
    telefone_usuario te ON u.cpf = te.cpf_usuario
LEFT JOIN
    email_usuario eu ON u.cpf = eu.cpf_usuario;

    
/*
-- Consultar a VIEW para obter os dados de contato de docentes autores
SELECT * FROM dados_contato_docentes_autores;  
-- Consultar a VIEW para obter os dados de contato de docentes autores
SELECT * FROM dados_contato_docentes_autores;
*/
CREATE OR REPLACE VIEW apresenta_coord_adm AS
SELECT
    ca.cpf_coordenador,
    u.primeiro_nome,
    u.sobrenome,
    u.genero,
    u.data_nascimento,
    ce.rua AS rua_endereco,
    u.numero AS numero_endereco,
    u.complemento AS complemento_endereco,
    ce.bairro AS bairro_endereco,
    ce.cidade AS cidade_endereco,
    ce.estado AS estado_endereco,
    ce.pais AS pais_endereco,
    ce.cep AS cep_endereco,
    e.email_usuario AS email,
    t.numero AS numero_telefone,
    t.ddd AS ddd_telefone,
    t.ddi AS ddi_telefone,
    ca.funcao_na_instituicao,
    ca.curriculo_lates,
    ca.data_cadastro,
    ca.poca
FROM coordenador_administrativo ca
INNER JOIN usuario u ON ca.cpf_coordenador = u.cpf
LEFT JOIN cep_endereco ce ON u.cep_usuario = ce.cep
LEFT JOIN email_usuario e ON u.cpf = e.cpf_usuario
LEFT JOIN telefone_usuario t ON u.cpf = t.cpf_usuario;


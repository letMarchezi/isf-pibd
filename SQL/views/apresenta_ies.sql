CREATE OR REPLACE VIEW apresenta_ies AS
SELECT
    i.cnpj,
    i.sigla,
    i.participou_isf,
    i.tem_lab_mais_unidos,
    i.possui_nucleo_ativo,
    i.cep_ies,
    ce.cep,
    ce.rua,
    ce.bairro,
    ce.cidade,
    ce.estado,
    ce.pais,
    i.numero,
    i.complemento,
    i.link_politica_ling,
    i.data_politica_ling,
    i.doc_politica_ling,
    i.campus,
    i.nome_principal,
    ti.ddd,
    ti.ddi,
    ti.numero AS telefone
FROM
    ies i
JOIN
    cep_endereco ce ON i.cep_ies = ce.cep
LEFT JOIN
    telefone_ies ti ON i.cnpj = ti.cnpj_ies;

/*SELECT * FROM apresenta_ies;*/
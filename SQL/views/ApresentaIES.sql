CREATE OR REPLACE VIEW ApresentaIES AS
SELECT
    i.CNPJ,
    i.sigla,
    i.participou_isf,
    i.tem_lab_mais_unidos,
    i.possui_nucleo_ativo,
    i.CEP_IES,
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
    ti.DDD,
    ti.DDI,
    ti.numero AS telefone
FROM
    IES i
JOIN
    CepEndereco ce ON i.CEP_IES = ce.CEP
LEFT JOIN
    TelefoneIES ti ON i.CNPJ = ti.CNPJ_IES;

/*SELECT * FROM ApresentaIES;*/
CREATE OR REPLACE VIEW view_material_ministrante AS
SELECT
    m.nome,
    m.data_criacao,
    m.arquivo,
    m.link,
    m.tipo_material,
    mcc.nome_componente,
    u.primeiro_nome
FROM
    material m
JOIN
    material_componente_curricular mcc ON m.id_material = mcc.id_material
JOIN
    docente_autor_produz_material dapm ON m.id_material = dapm.id_material
JOIN
    usuario u ON dapm.cpf_docente = u.cpf;



--SELECT * FROM view_material_ministrante
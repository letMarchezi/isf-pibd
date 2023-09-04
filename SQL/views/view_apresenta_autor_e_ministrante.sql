CREATE OR REPLACE VIEW View_Docentes AS
SELECT
    de.cpf_docente,
    u.primeiro_nome,
    u.sobrenome,
    de.data_credenciamento,
    de.curriculo,
    de.titulacao,
    de.poca_file,
    de.vinculo_file,
    de.link_cnpq,
    CASE
        WHEN de.is_autor THEN 'Autor'
        WHEN de.is_ministrante THEN 'Ministrante'
        ELSE 'Outro'
    END AS tipo_docente
FROM
    docente_especialista de
JOIN
    usuario u ON de.cpf_docente = u.cpf;

--SELECT * FROM View_Docentes
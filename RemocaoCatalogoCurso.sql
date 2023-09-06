-- Autor: Matheus da Silva Vieira 791085 BCC
-- RemocaoCatalogoCurso -> Remoção catálogo de curso

CREATE OR REPLACE FUNCTION fc_remove_catalogo_curso(id_curso_param INTEGER) RETURNS VOID AS $$
BEGIN
	DELETE FROM curso_idioma WHERE id_curso_idioma = id_curso_param;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE proc_remove_catalogo_curso(id_curso_param INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN
	PERFORM fc_remove_catalogo_curso(id_curso_param);
END;
$$;




/*
PROCEDURE QUE INSERE UM MATERIAL RELACIONADO A UMA COMPONENTE CURRICULAR E AO DOCENTE AUTOR
*/

CREATE OR REPLACE PROCEDURE insere_material_ministrante_componente_curricular(
  IN nome_m VARCHAR,
  IN data_criacao_m DATE,
  IN arquivo_m VARCHAR,
  IN link_m VARCHAR,
  IN tipo_m VARCHAR,
  IN nome_componete_curricular VARCHAR,
  IN cpf_d VARCHAR
) LANGUAGE plpgsql AS 
$$ DECLARE
    material_ja_existe CURSOR FOR 
    SELECT * FROM material WHERE nome = nome_m AND data_criacao = data_criacao_m;

    componete_curricular_existe CURSOR FOR 
    SELECT * FROM componente_curricular WHERE nome_componente = nome_componete_curricular;

    ministrante_existe CURSOR FOR 
    SELECT * FROM docente_especialista WHERE cpf_docente = cpf_d;

    material_id BIGINT;

    material_row material%ROWTYPE;
    componente_curricular_row componente_curricular%ROWTYPE;
    docente_especialista_row docente_especialista%ROWTYPE;
  BEGIN
    OPEN material_ja_existe;

    FETCH material_ja_existe INTO material_row;

    IF FOUND THEN
      RAISE EXCEPTION 'Material com nome % e data de criação % já existe!', nome_m, data_criacao_m;
    ELSE
      INSERT INTO material (nome, data_criacao, arquivo, link, tipo_material)
      VALUES (nome_m, data_criacao_m, arquivo_m, link_m, tipo_m)
      RETURNING id_material INTO material_id;

      /*material_id = SCOPE_IDENTITY();*/
    END IF;

    CLOSE material_ja_existe;

    OPEN componete_curricular_existe;
    FETCH componete_curricular_existe INTO componente_curricular_row;
    IF FOUND THEN
      INSERT INTO material_componente_curricular (id_material, nome_componente)
      VALUES (material_id, nome_componete_curricular);
    ELSE
      RAISE EXCEPTION 'Componente curricular com nome % não existe!', nome_componete_curricular;
    END IF;

    CLOSE componete_curricular_existe;

    OPEN ministrante_existe;
    FETCH ministrante_existe INTO docente_especialista_row;

    IF FOUND THEN
      INSERT INTO docente_autor_produz_material (id_material, cpf_docente)
      VALUES (material_id, cpf_d);
    ELSE
      RAISE EXCEPTION 'Ministrante com cpf % não existe!', cpf_d;
    END IF;

    CLOSE ministrante_existe;
  END;
$$;

/*CALL insere_material_ministrante_componente_curricular(
  'material',
	'2023-11-23',
	'pdf',
	'https://aaa.com.br',
	'livro',
	'Ingles para educação',
	'12345678901')*/
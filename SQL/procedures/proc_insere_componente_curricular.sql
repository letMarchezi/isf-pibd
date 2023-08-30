/*
PROCEDURE QUE INSERE UM COMPONENTE CURRICULAR
*/

CREATE OR REPLACE PROCEDURE insere_componente_curricular(nome_componente VARCHAR,
  nome_idioma VARCHAR,
  carga_horaria_pratica INTEGER,
  carga_horaria_teorica INTEGER,
  obrigatoriedade BOOLEAN,
  eixo_tematico VARCHAR
)
LANGUAGE SQL
AS $$
INSERT INTO componente_curricular VALUES (nome_componente,
								  nome_idioma,
								  carga_horaria_pratica,
								  carga_horaria_teorica,
								  obrigatoriedade,
								  eixo_tematico);
$$;

/* EXEMPLO:
INSERT INTO proficiencia_idioma_componente VALUES ('Ingles','B1');
CALL insere_componente_curricular('Ingles para educação','Ingles',20,30,true,'Avaliativo');
*/			  
							
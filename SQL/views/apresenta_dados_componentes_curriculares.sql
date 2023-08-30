/*
VIEW DE DADOS DE COMPONENTES CURRICULARES
*/

CREATE OR REPLACE VIEW dados_componentes_curriculares AS
SELECT nome_componente,nome_idioma,
	carga_horaria_pratica,carga_horaria_teorica,
	obrigatoriedade,eixo_tematico
FROM componente_curricular;
						
								  

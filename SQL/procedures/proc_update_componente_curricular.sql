CREATE OR REPLACE PROCEDURE update_componente_curricular(
    IN p_nome_componente VARCHAR(100), 
    IN p_nome_idioma VARCHAR(50), 
    IN p_carga_horaria_pratica INT, 
	IN p_carga_teorica INT,
	IN p_obrigatoriedade BOOLEAN,
    IN p_eixo_tematico VARCHAR(50)
) LANGUAGE plpgsql 
AS $$ 
DECLARE

   componente_para_atualizar CURSOR FOR 
   SELECT * FROM componente_curricular WHERE nome_componente = p_nome_componente; 
   componente_row componente_curricular%ROWTYPE;
   
   BEGIN
		
            OPEN componente_para_atualizar;
            
            FETCH componente_para_atualizar INTO componente_row;
            
            IF NOT FOUND THEN
                RAISE EXCEPTION 'Componente curricular não encontrado!';
            ELSIF FOUND THEN
                UPDATE public.componente_curricular 
                SET 
                    nome_componente = p_nome_componente, 
                    nome_idioma = p_nome_idioma, 
                    carga_horaria_pratica = p_carga_horaria_pratica, 
                    carga_horaria_teorica = p_carga_horaria_teorica,
					obrigatoriedade = p_obrigatoriedade
					eixo_tematico = p_eixo_tematico
                WHERE CURRENT OF componente_para_atualizar;
            END IF;
            
            CLOSE componente_para_atualizar;
   END;
$$;
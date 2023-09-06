-- Autor : Augusto dos Santos
CREATE OR REPLACE PROCEDURE update_docente_autor(
    IN p_cpf CHARACTER VARYING, 
    IN p_curriculo CHARACTER VARYING, 
    IN p_vinculo_file CHARACTER VARYING, 
    IN p_link_cnpq CHARACTER VARYING, 
    IN p_titulacao CHARACTER VARYING
) LANGUAGE plpgsql AS 
    $$ DECLARE
            docente_para_atualizar CURSOR FOR 
                SELECT * FROM docente_especialista WHERE cpf_docente = p_cpf;
                
            docente_row docente_especialista%ROWTYPE;
        BEGIN
            OPEN docente_para_atualizar;
            
            FETCH docente_para_atualizar INTO docente_row;
            
            IF NOT FOUND THEN
                RAISE EXCEPTION 'Não existe docente com o CPF %', p_cpf;
            ELSE IF FOUND THEN
                IF docente_para_atualizar.is_autor == True THEN
                    UPDATE public.docente_especialista 
                    SET 
                        cpf_docente = p_cpf, 
                        curriculo = p_curriculo,
                        vinculo_file = p_vinculo_file,
                        link_cnpq = p_link_cnpq,
                        titulacao = p_titulacao
                    WHERE CURRENT OF docente_para_atualizar;
                END IF;
            END IF;
            
            CLOSE docente_para_atualizar;
        END;
    $$;
-- TESTES --

INSERT INTO usuario(
	cpf,
  	primeiro_nome,
  	sobrenome,
  	genero,
  	data_nascimento,
  	numero,
  	complemento
)
VALUES(
	'52778370862',
  	'Batata',
  	'Frita',
  	'M',
  	'2000-04-20',
  	1234,
  	'casa'
);

VALUES(
	'12333165794',
  	'Dogao',
  	'cachorro quente',
  	'M',
  	'2001-04-20',
  	1234,
  	'casa'
);

INSERT INTO docente_especialista (
  cpf_docente, 
  data_credenciamento,
  curriculo,
  titulacao,
  poca_file,
  vinculo_file,
  link_cnpq,
  is_orientador,
  is_autor,
  is_ministrante,
  is_coordenador_pedagogico
)
VALUES (
    '52778370862', 
    '01/04/2022', 
    'curriculo.pdf', 
    'Doutorado', 
    'poca.pdf',
  	'vinculo.pdf',
    'http://www.cnpq.com/baTata',
  	TRUE,
  	FALSE,
  	FALSE,
  	FALSE
);
VALUES (
    '12333165794', 
    '01/04/2023', 
    'curriculo.pdf', 
    'Doutorado', 
    'poca.pdf',
  	'vinculo.pdf',
    'http://www.cnpq.com/baTata',
  	TRUE,
  	TRUE,
  	TRUE,
  	FALSE
);

SELECT * FROM docente_especialista;

CALL update_docente_autor(
  '52778370862',
  'curriculo11.pdf',
  'vinculoUFSCar.pdf',
  'http://www.cnpq.com/SergioAlmeida',
  'Doutorando'
);

SELECT * FROM docente_especialista;


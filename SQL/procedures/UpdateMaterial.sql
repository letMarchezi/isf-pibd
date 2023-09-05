------------------------------------------- UpdateMaterial -------------------------------------------

-- Autor: Bruno Luis R Medri - 790004
-- Descrição: Atualizar o material utilizando um cursor explícito

-- Cria um procedimento chamado "updateMaterial"
CREATE OR REPLACE PROCEDURE updateMaterial(
    IN material_id INT,
    IN novo_nome VARCHAR(50),
    IN nova_data_criacao DATE,
    IN novo_arquivo VARCHAR(256),
    IN novo_link VARCHAR(256),
    IN novo_tipo_material VARCHAR(10)
)

LANGUAGE plpgsql

AS $$

-- Declaração de um cursor para selecionar dados do material.
DECLARE
    material_cursor CURSOR FOR
    
    -- Seleciona os campos do material em que o Id corresponde ao valor passado como parâmetro.
    SELECT id_material, nome, data_criacao, arquivo, link, tipo_material
    FROM material
    WHERE id_material = material_id;
    
    -- Variável do tipo RECORD para armazenar as linhas do cursor.
    material_row RECORD;


BEGIN

    -- Abre o cursor para processamento.
    OPEN material_cursor;

    -- Obtém o próximo registro do cursor e armazena em "material_row".
    FETCH NEXT FROM material_cursor INTO material_row;


    -- Verifica se foi encontrado um registro no cursor.
    IF FOUND THEN

        -- Atribui os novos valores aos campos do material na variável "material_row".
        material_row.nome = novo_nome;
        material_row.data_criacao = nova_data_criacao;
        material_row.arquivo = novo_arquivo;
        material_row.link = novo_link;
        material_row.tipo_material = novo_tipo_material;

        -- Atualiza os dados na tabela "material" com os novos valores.
        UPDATE material
        SET 
            nome = material_row.nome,
            data_criacao = material_row.data_criacao,
            arquivo = material_row.arquivo,
            link = material_row.link,
            tipo_material = material_row.tipo_material
        WHERE id_material = material_id;

    END IF;
    
    CLOSE material_cursor;

END;
$$;
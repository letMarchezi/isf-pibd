CREATE OR REPLACE PROCEDURE RemoveComponenteCurricular(componente_nome VARCHAR(100)) AS $$
DECLARE
  contador INT;
BEGIN
  -- Verifica se o componente curricular existe na tabela "componente_curricular"
  IF NOT EXISTS (SELECT 1 FROM componente_curricular WHERE nome_componente = componente_nome) THEN
    -- Se o componente não existir, você pode gerar uma mensagem de aviso
    RAISE NOTICE 'O componente curricular não foi encontrado: %', componente_nome;
    RETURN;
  END IF;

  -- Verifica se há referências na tabela "turma_especializacao"
  SELECT COUNT(*) INTO contador FROM turma_especializacao WHERE nome_componente = componente_nome;
  
  IF contador = 0 THEN
    -- Se não houver referências, exclua o componente curricular
    DELETE FROM componente_curricular WHERE nome_componente = componente_nome;
  ELSE
    -- Se houver referências, não é possível excluir o componente curricular
    RAISE EXCEPTION 'Não é possível excluir o componente curricular. Existem referências na tabela turma_especializacao.';
  END IF;
END;
$$ LANGUAGE plpgsql;

--CALL RemoveComponenteCurricular('Componente1');
--DELETE FROM turma_especializacao WHERE nome_componente = 'Componente1';

--SELECT * FROM componente_curricular;
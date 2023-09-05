------------------------------------------- RemoveAlunoGraduacao -------------------------------------------

-- Autor: Bruno Luis R Medri - 790004
-- Descrição: Remover os dados de um Aluno Graduação

-- Cria ou substitui um procedimento chamado "remove_alunoGrad" com um parâmetro "cpf_param".
CREATE OR REPLACE PROCEDURE remove_alunoGrad(cpf_param VARCHAR) AS
$$

BEGIN
  -- Faz um DELETE para remover o aluno de graduação com o CPF especificado da tabela "aluno_graduacao".
  DELETE FROM aluno_graduacao WHERE cpf_aluno_graduacao = cpf_param;

  -- Verifica se a operação DELETE não encontrou nenhum registro correspondente.
  IF NOT FOUND THEN

    -- Levanta uma exceção informando que o aluno com o CPF especificado não foi encontrado.
    RAISE EXCEPTION 'Aluno com CPF % não encontrado.', cpf_param;


  END IF;
  
  COMMIT;


END;
$$
LANGUAGE plpgsql;
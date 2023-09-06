CREATE OR REPLACE PROCEDURE update_frequencia_nota_especializacao(
    IN p_cpf_aluno VARCHAR(11), 
    IN p_id_turma_especializacao INTEGER,
    IN p_nota DECIMAL(3)
) LANGUAGE plpgsql AS 
$$ 
BEGIN
    -- Atualiza a frequência do aluno na turma de especialização
    UPDATE atividades_aluno_especializacao
    SET nota = p_nota
    WHERE cpf_aluno = p_cpf_aluno AND id_turma_especializacao = p_id_turma_especializacao;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Aluno com CPF % não está matriculado na turma de especialização com ID %!', p_cpf_aluno, p_id_turma_especializacao;
    END IF;

    COMMIT;
END;
$$;


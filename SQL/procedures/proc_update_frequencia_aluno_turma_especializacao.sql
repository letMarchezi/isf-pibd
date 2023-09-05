CREATE OR REPLACE PROCEDURE update_frequencia_aluno_especializacao(
    IN p_cpf_aluno VARCHAR(11), 
    IN p_id_turma_especializacao INTEGER,
    IN p_frequencia DECIMAL(3)
) LANGUAGE plpgsql AS 
$$ 
BEGIN
    -- Atualiza a frequência do aluno na turma de especialização
    UPDATE aluno_especializacao_cursa_turma
    SET frequencia = p_frequencia
    WHERE cpf_aluno = p_cpf_aluno AND id_turma_especializacao = p_id_turma_especializacao;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Aluno com CPF % não está matriculado na turma de especialização com ID %!', p_cpf_aluno, p_id_turma_especializacao;
    END IF;

    COMMIT;
END;
$$;
-- call update_frequencia_aluno_especializacao('11111111111',1,95);

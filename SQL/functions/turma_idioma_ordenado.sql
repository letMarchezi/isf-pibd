CREATE FUNCTION Turma_Oferta_Coletiva_Ordenada()
RETURNS TABLE (
    ID_turma_coletiva INTEGER,
    ID_curso_idioma INTEGER,
    sigla_turma VARCHAR(10),
    semestre DECIMAL(1),
    qtde_vagas_Reservadas DECIMAL(4),
    hora_inicio TIMESTAMP,
    hora_fim TIMESTAMP,
    qtde_vagas DECIMAL(4)
)
AS $$
BEGIN
    RETURN QUERY
        SELECT *
        FROM Turma_Oferta_Coletiva
        ORDER BY hora_inicio;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE VIEW view_turma_especializacao AS
SELECT
    te.id_turma_especializacao,
    te.nome_componente,
    te.sigla,
    te.semestre,
    te.hora_inicio,
    te.hora_fim,
    te.qtde_vagas
FROM
    turma_especializacao te;
	
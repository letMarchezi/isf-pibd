CREATE OR REPLACE VIEW apresenta_componentes_por_carga_teorica AS
SELECT 
    nome_componente,
    nome_idioma,
    carga_horaria_pratica,
    carga_horaria_teorica,
    obrigatoriedade,
    eixo_tematico
FROM componente_curricular
ORDER BY carga_horaria_teorica;

--Testes
/*

INSERT INTO proficiencia_idioma_componente (nome_idioma, proficiencia)
VALUES 
    ('ingles', 'A1'),
    ('espanhol', 'A2'),
    ('japones', 'A3'),
    ('Frances', 'B1'),
    ('Frita', 'C3');


INSERT INTO componente_curricular (
    nome_componente, 
    nome_idioma, 
    carga_horaria_pratica, 
    carga_horaria_teorica, 
    obrigatoriedade, 
    eixo_tematico
)
VALUES 
    ('How To spikar in inglish', 'ingles', 10, 20, TRUE, 'UWU'),
    ('Como Hablar mucho', 'espanhol', 15, 69, FALSE, ' ( o.o )'),
    ('Queria saber japones', 'japones', 20, 420, TRUE, ' > ^ <'),
    ('cest la vie', 'Frances', 25, 621, FALSE, 'UWU'),
    ('Batata', 'Frita', 30, 24, TRUE, '/\_/\');

--Select da tabela normal
SELECT * FROM componente_curricular;

--Select da view
SELECT * FROM apresenta_componentes_por_carga_teorica;

*/
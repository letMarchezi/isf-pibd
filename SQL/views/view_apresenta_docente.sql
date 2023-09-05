CREATE OR REPLACE VIEW view_apresenta_docente AS
SELECT
    d.cpf_docente, -- CPF do docente
    d.data_credenciamento, -- Data de credenciamento do docente
    d.curriculo, -- Currículo do docente
    d.titulacao, -- Titulação do docente
    d.poca_file, -- Arquivo da POCA do docente
    d.vinculo_file, -- Arquivo de vínculo do docente
    d.link_cnpq, -- Link do CNPQ do docente
    d.is_orientador, -- Indicador se o docente é orientador
    d.is_autor, -- Indicador se o docente é autor
    d.is_ministrante, -- Indicador se o docente é ministrante
    d.is_coordenador_pedagogico, -- Indicador se o docente é coordenador pedagógico
    u.primeiro_nome, -- Primeiro nome do docente
    u.sobrenome, -- Sobrenome do docente
    u.genero, -- Gênero do docente
    u.data_nascimento, -- Data de nascimento do docente
    u.numero, -- Número do endereço do docente
    u.complemento, -- Complemento do endereço do docente
    u.cep_usuario, -- CEP do endereço do docente
    u.cnpj_ies_associada -- CNPJ da instituição associada do docente
FROM
    docente_especialista d
INNER JOIN
    usuario u ON d.cpf_docente = u.cpf;
    
--SELECT * FROM view_apresenta_docente;

--select * from ies ; 
--select * from usuario ; 
--select * from docente_especialista; 

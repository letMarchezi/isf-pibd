-- DESCOMENTE AS 2 LINHAS ABAIXO PARA APAGAR TODO O SCHEMA E CRIAR NOVAMENTE 
-- DROPA TODAS AS TABELAS
--DROP SCHEMA public CASCADE;
--CREATE SCHEMA public;


CREATE TABLE IF NOT EXISTS email (
	endereco_email VARCHAR(320) PRIMARY KEY,
	tipo VARCHAR(50) -- isf, isf antigo, pessoal e gmail
);


CREATE TABLE IF NOT EXISTS cep_endereco (
    cep VARCHAR(8) NOT NULL PRIMARY KEY,
    rua VARCHAR(100),
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    estado VARCHAR(2),
    pais VARCHAR(50)
);

/* IES */
CREATE TABLE IF NOT EXISTS ies (
    cnpj VARCHAR(14) NOT NULL PRIMARY KEY,
    sigla VARCHAR(10),
    participou_isf BOOLEAN,
    tem_lab_mais_unidos BOOLEAN,
    possui_nucleo_ativo BOOLEAN,
    cep_ies VARCHAR(8),
    numero INTEGER,
    complemento VARCHAR(100),
    link_politica_ling VARCHAR(255),
    data_politica_ling DATE,
    doc_politica_ling VARCHAR(255),
    campus VARCHAR(100),
    nome_principal VARCHAR(100),

    FOREIGN KEY (cep_ies) REFERENCES cep_endereco(cep)
);

CREATE TABLE IF NOT EXISTS telefone_ies (
    cnpj_ies VARCHAR(14) NOT NULL,
    ddd VARCHAR(3) NOT NULL,
    ddi VARCHAR(3) NOT NULL,
    numero VARCHAR(15) NOT NULL,

    PRIMARY KEY (cnpj_ies, ddi, ddd, numero),
    FOREIGN KEY (cnpj_ies) REFERENCES ies(cnpj)
);

/* USUÁRIO */
CREATE TABLE IF NOT EXISTS usuario (
    cpf VARCHAR(11) NOT NULL PRIMARY KEY,
    primeiro_nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50) NOT NULL,
    genero VARCHAR(20),
    data_nascimento DATE NOT NULL,
    numero INTEGER,
    complemento VARCHAR(100),
    cep_usuario VARCHAR(8),
    cnpj_ies_associada VARCHAR(20),

    FOREIGN KEY (cep_usuario) REFERENCES cep_endereco(cep),
    FOREIGN KEY (cnpj_ies_associada) REFERENCES ies(cnpj)
);

CREATE TABLE IF NOT EXISTS email_usuario(
	email_usuario VARCHAR(320) PRIMARY KEY,
	cpf_usuario VARCHAR(11),
	
 FOREIGN KEY (cpf_usuario) REFERENCES usuario(cpf),
    FOREIGN KEY (email_usuario) REFERENCES email(endereco_email)
);	


CREATE TABLE IF NOT EXISTS telefone_usuario (
    cpf_usuario VARCHAR(14) NOT NULL,
    ddd VARCHAR(3) NOT NULL,
    ddi VARCHAR(3) NOT NULL,
    numero VARCHAR(15) NOT NULL,

    PRIMARY KEY (cpf_usuario, ddi, ddd, numero),
    FOREIGN KEY (cpf_usuario) REFERENCES usuario(cpf)
);

/* COORDENADOR ADMINISTRATIVO */
CREATE TABLE IF NOT EXISTS coordenador_administrativo (
    cpf_coordenador VARCHAR(11) NOT NULL PRIMARY KEY,
    funcao_na_instituicao VARCHAR(100),
    curriculo_lates VARCHAR(255),
    data_cadastro DATE,
    poca VARCHAR(50),

    FOREIGN KEY (cpf_coordenador) REFERENCES usuario(cpf)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS coordenador_administrativo_cadastra_ies (
    cnpj_ies VARCHAR(14) NOT NULL,
    cpf_coordenador_administrativo VARCHAR(11) NOT NULL,
    termo_de_compromisso VARCHAR(255),

    PRIMARY KEY (cnpj_ies, cpf_coordenador_administrativo),
    FOREIGN KEY (cnpj_ies) REFERENCES ies(cnpj),
    FOREIGN KEY (cpf_coordenador_administrativo) REFERENCES coordenador_administrativo(cpf_coordenador)
);

/* PARCEIRO */
CREATE TABLE IF NOT EXISTS parceiro(
    cnpj VARCHAR(14) NOT NULL PRIMARY KEY,
    primeiro_nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50) NOT NULL,
    categoria_atuacao VARCHAR(500),
    cep_parceiro VARCHAR(8),
    numero DECIMAL(5),
    complemento VARCHAR(100),

    FOREIGN KEY (cep_parceiro) REFERENCES cep_endereco(cep)
);

CREATE TABLE IF NOT EXISTS telefone_parceiro(
    cnpj_parceiro VARCHAR(14) NOT NULL,
    ddi DECIMAL(3),
    ddd DECIMAL(2),
    numero DECIMAL(9) NOT NULL,

    PRIMARY KEY (cnpj_parceiro, ddi, ddd, numero),
    FOREIGN KEY (cnpj_parceiro) REFERENCES parceiro(cnpj)
);

/* GESTOR */
CREATE TABLE IF NOT EXISTS gestor_rede_andifes (
    cpf_gestor VARCHAR(11) NOT NULL PRIMARY KEY,
    data_cadastro DATE,

    FOREIGN KEY (cpf_gestor) REFERENCES usuario(cpf)
);

CREATE TABLE IF NOT EXISTS gestor_analisa_parceiro(
    cpf_gestor VARCHAR(11) NOT NULL,
    cnpj_parceiro VARCHAR(14) NOT NULL,
    status_ VARCHAR(20),  
    data_analise DATE,

    CHECK(status_ in ('APROVADO', 'REPROVADO')),

    PRIMARY KEY (cpf_gestor, cnpj_parceiro),
    FOREIGN KEY (cpf_gestor) REFERENCES gestor_rede_andifes(cpf_gestor),
    FOREIGN KEY (cnpj_parceiro) REFERENCES parceiro(cnpj)
);

CREATE TABLE IF NOT EXISTS gestor_aprova_coord_adm (
    cpf_gestor_rede_andifes VARCHAR(11) NOT NULL,
    cpf_coordenador_administrativo VARCHAR(11) NOT NULL,
    data_fim TIMESTAMP,
    data_inicio TIMESTAMP,
    documento_de_atuacao VARCHAR(255),

    CHECK (data_inicio < data_fim),

    PRIMARY KEY (cpf_gestor_rede_andifes, cpf_coordenador_administrativo),
    FOREIGN KEY (cpf_gestor_rede_andifes) REFERENCES gestor_rede_andifes(cpf_gestor),
    FOREIGN KEY (cpf_coordenador_administrativo) REFERENCES coordenador_administrativo(cpf_coordenador)
);

/* EDITAL */
CREATE TABLE IF NOT EXISTS edital(
    id_edital SERIAL,      
    numero DECIMAL(30) NOT NULL,
    ano DECIMAL(4) NOT NULL,
    semestre DECIMAL(1) NOT NULL,
    data_publicacao DATE,
    data_inicio DATE,
    data_fim DATE,
    edital_file VARCHAR(255), 
    nome VARCHAR(100) NOT NULL,

    CHECK(data_inicio < data_fim), 
    PRIMARY KEY (id_edital),
    UNIQUE (numero, ano, semestre)
);

CREATE TABLE IF NOT EXISTS edital_oferta_coletiva(
    id_edital SERIAL,      
    max_alunos_turma  DECIMAL(4),
    max_alunos_lista_espera  DECIMAL(4),
    max_vagas_reservadas_turma DECIMAL(3),
    
    PRIMARY KEY(id_edital),
    FOREIGN KEY (id_edital) REFERENCES edital(id_edital)

);

CREATE TABLE IF NOT EXISTS idiomas_edital_oferta_coletiva(
    id_edital INTEGER,      
    idioma VARCHAR(50) NOT NULL,

    PRIMARY KEY (id_edital, idioma),
    FOREIGN KEY (id_edital) REFERENCES edital_oferta_coletiva(id_edital)
);

CREATE TABLE IF NOT EXISTS edital_cred_especialista(
    id_edital SERIAL,     

    PRIMARY KEY (id_edital),
    FOREIGN KEY (id_edital) REFERENCES edital(id_edital)
);

CREATE TABLE IF NOT EXISTS edital_cred_professor_isf(
    id_edital SERIAL,      

    PRIMARY KEY (id_edital),
    FOREIGN KEY (id_edital) REFERENCES edital(id_edital)
);

CREATE TABLE IF NOT EXISTS edital_aluno_especializacao(
    id_edital SERIAL,      
    quantidade_vagas DECIMAL(4),

    PRIMARY KEY (id_edital),
    FOREIGN KEY (id_edital) REFERENCES edital(id_edital)
);

/* PROFESSOR ISF */
CREATE TABLE IF NOT EXISTS professor_isf(
    cpf_professor_isf VARCHAR(11) NOT NULL,
    
    PRIMARY KEY(cpf_professor_isf),
    FOREIGN KEY (cpf_professor_isf) REFERENCES usuario(cpf)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS idioma_professor_isf(
    cpf_professor_isf VARCHAR(11),
    idioma VARCHAR(30),
    proficiencia VARCHAR(5),
    declaracao_proficiencia VARCHAR(256),

    PRIMARY KEY(cpf_professor_isf, idioma),
    FOREIGN KEY (cpf_professor_isf) REFERENCES professor_isf(cpf_professor_isf)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/* REPOSITORIO */
CREATE TABLE IF NOT EXISTS repositorio(
    titulo VARCHAR(20) NOT NULL,
    link VARCHAR(50) NOT NULL,
    data_inclusao DATE,

    PRIMARY KEY (titulo)
);

/* ALUNO ESPECIALIZACAO */
CREATE TABLE IF NOT EXISTS aluno_especializacao(
    cpf_aluno_especializacao VARCHAR(11) NOT NULL, 
    titulacao VARCHAR(40) NOT NULL,
    data_ingresso DATE,
    data_conclusao DATE,
    matricula_ativa BOOLEAN,
    diploma_file VARCHAR(255),

    CHECK(data_ingresso < data_conclusao),
    PRIMARY KEY (cpf_aluno_especializacao),
    FOREIGN KEY (cpf_aluno_especializacao) REFERENCES professor_isf(cpf_professor_isf)
);

CREATE TABLE IF NOT EXISTS aluno_especializacao_produz_repositorio(
    cpf_aluno_especializacao VARCHAR(11) NOT NULL,
    repositorio_titulo VARCHAR(20) NOT NULL,
    foi_validado_pelo_orientador BOOLEAN,
    
    PRIMARY KEY (cpf_aluno_especializacao, repositorio_titulo),
    FOREIGN KEY (cpf_aluno_especializacao) REFERENCES aluno_especializacao(cpf_aluno_especializacao),
    FOREIGN KEY (repositorio_titulo) REFERENCES repositorio(titulo)
);

/* MATERIAIS */
CREATE TABLE IF NOT EXISTS material(
    id_material SERIAL,            
    nome VARCHAR(50),
    data_criacao DATE,
    arquivo VARCHAR(256),
    link VARCHAR(256),
    tipo_material VARCHAR(10),

    PRIMARY KEY (id_material),
    UNIQUE (nome, data_criacao)
);

/* COMPONENTE CURRICULAR */
CREATE TABLE IF NOT EXISTS proficiencia_idioma_componente(
  nome_idioma VARCHAR(50),
  proficiencia VARCHAR(10),

  PRIMARY KEY (nome_idioma)
);

CREATE TABLE IF NOT EXISTS componente_curricular(
  nome_componente VARCHAR(100) NOT NULL,
  nome_idioma VARCHAR(50),
  carga_horaria_pratica INTEGER,
  carga_horaria_teorica INTEGER,
  obrigatoriedade BOOLEAN,
  eixo_tematico VARCHAR(50),

  PRIMARY KEY (nome_componente),
  FOREIGN KEY (nome_idioma) REFERENCES proficiencia_idioma_componente(nome_idioma)
);

CREATE TABLE IF NOT EXISTS tipo_componente_curricular(
    nome_completo VARCHAR(100),
    tipo_disciplina VARCHAR(50),

    PRIMARY KEY (nome_completo),
    FOREIGN KEY (nome_completo) REFERENCES componente_curricular(nome_componente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS material_componente_curricular(
    id_material INTEGER,            
    nome_componente VARCHAR(100) NOT NULL,

    PRIMARY KEY (nome_componente, id_material),
    FOREIGN KEY (nome_componente) REFERENCES componente_curricular(nome_componente)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_material) REFERENCES material(id_material)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS dependencias_componente_curricular(
    nome_componente_requisito VARCHAR(100),
    nome_componente VARCHAR(100),

    PRIMARY KEY (nome_componente_requisito, nome_componente),
    FOREIGN KEY (nome_componente_requisito) REFERENCES componente_curricular(nome_componente)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (nome_componente) REFERENCES componente_curricular(nome_componente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/* TURMA ESPECIALIZACAO */
CREATE TABLE IF NOT EXISTS turma_especializacao(
    id_turma_especializacao SERIAL,        
    nome_componente VARCHAR(100) NOT NULL,
    sigla VARCHAR(15) NOT NULL,
    semestre DECIMAL(1) NOT NULL,

    hora_inicio TIMESTAMP,
    hora_fim TIMESTAMP,
    qtde_vagas DECIMAL(4),

    CHECK (hora_inicio < hora_fim),

    PRIMARY KEY (id_turma_especializacao),
    UNIQUE (nome_componente, sigla, semestre),
    FOREIGN KEY (nome_componente) REFERENCES componente_curricular (nome_componente)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS dias_turma_especializacao(
    id_turma_especializacao INTEGER,        
    dia_da_semana VARCHAR(3) NOT NULL,

    PRIMARY KEY (id_turma_especializacao, dia_da_semana),
    FOREIGN KEY (id_turma_especializacao) REFERENCES turma_especializacao (id_turma_especializacao)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS aluno_especializacao_cursa_turma(
    id_turma_especializacao INTEGER,     
    cpf_aluno VARCHAR(11) NOT NULL,
    situacao_aluno VARCHAR(20),
    frequencia DECIMAL(3),

    CHECK(situacao_aluno IN ('APROVADO', 'REPROVADO', 'CURSANDO', 'CANCELADO')),

    CHECK(Frequencia > 0 AND Frequencia < 100), 

    PRIMARY KEY (cpf_aluno, id_turma_especializacao),
    FOREIGN KEY (cpf_aluno) REFERENCES aluno_especializacao(cpf_aluno_especializacao),
    FOREIGN KEY (id_turma_especializacao) REFERENCES turma_especializacao(id_turma_especializacao)

);

CREATE TABLE IF NOT EXISTS atividades_aluno_especializacao(
    id_turma_especializacao INTEGER,        
    cpf_aluno VARCHAR(11) NOT NULL,
    nome_componente VARCHAR(100) NOT NULL,
    sigla VARCHAR(15) NOT NULL,
    semestre DECIMAL(1) NOT NULL,

    atividade VARCHAR(40) NOT NULL,

    nota DECIMAL(4, 2),

    CHECK(nota >= 0 AND nota <= 10),

    PRIMARY KEY (cpf_aluno, atividade, id_turma_especializacao),
    FOREIGN KEY (cpf_aluno, id_turma_especializacao) REFERENCES aluno_especializacao_cursa_turma(cpf_aluno, id_turma_especializacao)
);

CREATE TABLE IF NOT EXISTS curso_idioma(
    id_curso_idioma SERIAL,  
    nome_completo VARCHAR(256) NOT NULL,
    idioma VARCHAR(16) NOT NULL,
    nivel VARCHAR(16),
    categoria VARCHAR(16),
    carga_horaria INTEGER,
    link_ementa VARCHAR(256),

    PRIMARY KEY (id_curso_idioma),
    UNIQUE (nome_completo, idioma)
);

/* OFERTA COLETIVA */ 
CREATE TABLE IF NOT EXISTS turma_oferta_coletiva(
    id_turma_coletiva INTEGER,  
    id_curso_idioma INTEGER NOT NULL,        

    sigla_turma VARCHAR(10) NOT NULL,
    semestre DECIMAL(1) NOT NULL,

    qtde_vagas_reservadas DECIMAL(4),
    hora_inicio TIMESTAMP,
    hora_fim TIMESTAMP,
    qtde_vagas DECIMAL(4),

    CHECK (hora_inicio < hora_fim),

    PRIMARY KEY (id_turma_coletiva),
    UNIQUE (sigla_turma, semestre, id_curso_idioma),
    FOREIGN KEY (id_curso_idioma) REFERENCES curso_idioma(id_curso_idioma)
);

CREATE TABLE IF NOT EXISTS dias_turma_oferta_coletiva(
    id_turma_coletiva INTEGER,   
    dia_da_semana VARCHAR(3) NOT NULL,

    PRIMARY KEY (id_turma_coletiva, dia_da_semana),
    FOREIGN KEY (id_turma_coletiva) REFERENCES turma_oferta_coletiva(id_turma_coletiva)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS repositorio_turma(
    id_turma_coletiva INTEGER,   
    titulo_repositorio VARCHAR(100) NOT NULL,
    foi_aprovado_pelo_orientador BOOLEAN,

    PRIMARY KEY (titulo_repositorio, id_turma_coletiva),
    FOREIGN KEY (titulo_repositorio) REFERENCES repositorio (titulo),
    FOREIGN KEY (id_turma_coletiva) REFERENCES turma_oferta_coletiva(id_turma_coletiva)
);

CREATE TABLE IF NOT EXISTS professor_isf_ministra_turma(
    id_turma_coletiva INTEGER, 
    cpf_professor_isf VARCHAR(11),
    foi_validado_pelo_orientador BOOLEAN,

    PRIMARY KEY(cpf_professor_isf, id_turma_coletiva),
    FOREIGN KEY (id_turma_coletiva) REFERENCES turma_oferta_coletiva(id_turma_coletiva)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (cpf_professor_isf) REFERENCES professor_isf(cpf_professor_isf)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

/* ALUNO GRADUAÇÃO */
CREATE TABLE IF NOT EXISTS aluno_graduacao(
    cpf_aluno_graduacao VARCHAR(11),
    termo_compromisso_file VARCHAR(256),
    vinculo_file VARCHAR(256),
    poca_file VARCHAR(256),
    matricula_ativa BOOLEAN,

    PRIMARY KEY(cpf_aluno_graduacao),
    FOREIGN KEY (cpf_aluno_graduacao) REFERENCES professor_isf(cpf_professor_isf)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS edital_admite_aluno_graduacao(
    id_edital INTEGER,     
    cpf_aluno VARCHAR (11),

    PRIMARY KEY (id_edital, cpf_aluno),
    FOREIGN KEY (id_edital) REFERENCES edital(id_edital),
    FOREIGN KEY (cpf_aluno) REFERENCES aluno_graduacao(cpf_aluno_graduacao)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/* ALUNO OFERTA COLETIVA */ 
CREATE TABLE IF NOT EXISTS aluno_oferta_coletiva(
    cpf_aluno VARCHAR(11) NOT NULL,
    vinculo_file VARCHAR(255), 

    PRIMARY KEY (cpf_aluno),
    FOREIGN KEY (cpf_aluno) REFERENCES usuario(cpf)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS idioma_aluno_oferta_coletiva (
    cpf_aluno VARCHAR(11) NOT NULL,
    idioma VARCHAR(50) NOT NULL,
    proficiencia VARCHAR(50) NOT NULL,
    declaracao_proficiencia VARCHAR(100),
    
    PRIMARY KEY (cpf_aluno, idioma, proficiencia),
    FOREIGN KEY (cpf_aluno) REFERENCES aluno_oferta_coletiva(cpf_aluno)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS aluno_inscreve_turma_oferta(
    id_inscricao SERIAL,
    id_turma_coletiva INTEGER,  
    cpf_aluno VARCHAR(11) NOT NULL,
    data_inscricao TIMESTAMP NOT NULL,
    posicao_lista DECIMAL(5),
    situacao_inscricao VARCHAR(20),
  
    CHECK(situacao_inscricao IN ('CONVOCADO', 'EM ESPERA', 'INDEFERIDO')),

    PRIMARY KEY (id_inscricao),
    FOREIGN KEY (cpf_aluno) REFERENCES aluno_oferta_coletiva(cpf_aluno)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (id_turma_coletiva) REFERENCES turma_oferta_coletiva (id_turma_coletiva)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
);


CREATE TABLE IF NOT EXISTS aluno_matricula_turma_oferta(
    id_inscricao SERIAL,
    data_matricula TIMESTAMP,
    situacao_matricula VARCHAR(20),

    CHECK(situacao_matricula IN ('CONCLUINTE', 'REPROVADO', 'EVADIDO', 'CURSANDO','DESISTENTE')),

    PRIMARY KEY (id_inscricao),
    FOREIGN KEY (id_inscricao) REFERENCES aluno_inscreve_turma_oferta(id_inscricao)
        ON DELETE RESTRICT
        ON UPDATE CASCADE

);

/* DOCENTE ESPECIALISTA */

CREATE TABLE IF NOT EXISTS docente_especialista(
    cpf_docente VARCHAR(11),
    data_credenciamento DATE,
    curriculo VARCHAR(256),
    titulacao VARCHAR(16),
    poca_file VARCHAR(255),
    vinculo_file VARCHAR(255),
    link_cnpq VARCHAR(255),

    is_orientador BOOLEAN,
    is_autor BOOLEAN,
    is_ministrante BOOLEAN,
    is_coordenador_pedagogico BOOLEAN,

    CHECK((is_orientador IS true) OR 
          (is_autor IS true) OR
          (is_ministrante IS true) OR 
          (is_coordenador_pedagogico IS true)),

    PRIMARY KEY(cpf_docente),
    FOREIGN KEY (cpf_docente) REFERENCES usuario(cpf)
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS edital_admite_docente_especialista(
    id_edital INTEGER, 
    cpf_docente_especialista VARCHAR(11) NOT NULL,

    PRIMARY KEY (id_edital, cpf_docente_especialista),
    FOREIGN KEY (id_edital) REFERENCES edital(id_edital),
    FOREIGN KEY (cpf_docente_especialista) REFERENCES docente_especialista(cpf_docente)
);

CREATE TABLE IF NOT EXISTS docente_autor_produz_material(
    id_material INTEGER, 
    cpf_docente VARCHAR(11),

    PRIMARY KEY (cpf_docente, id_material),
    FOREIGN KEY (id_material) REFERENCES material(id_material),
    FOREIGN KEY (cpf_docente) REFERENCES docente_especialista(cpf_docente)
);

CREATE TABLE IF NOT EXISTS horarios_disponiveis_docente_ministrante(
    CPF_docente VARCHAR(11) NOT NULL,
    horario_disponivel TIME NOT NULL,

    PRIMARY KEY (CPF_Docente, horario_disponivel),
    FOREIGN KEY (CPF_docente) REFERENCES docente_especialista(CPF_docente)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS docente_ministrante_leciona_turma_especializacao(
    ID_turma_especializacao INTEGER,        
    CPF_docente VARCHAR(11) NOT NULL,

    PRIMARY KEY (ID_turma_especializacao, CPF_docente),
    FOREIGN KEY (ID_turma_especializacao) REFERENCES turma_especializacao(ID_turma_especializacao)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,
    FOREIGN KEY (CPF_docente) REFERENCES docente_especialista(CPF_docente)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS docente_orientador_orienta_professorIsf(
    CPF_docente VARCHAR(11) NOT NULL,
    CPF_professor_isf VARCHAR(11) NOT NULL,
    data_inicio TIMESTAMP NOT NULL,
    data_fim TIMESTAMP,

    PRIMARY KEY (CPF_docente, CPF_professor_isf, data_inicio),
    FOREIGN KEY (CPF_docente) REFERENCES docente_especialista(CPF_docente)
        ON UPDATE CASCADE,
    FOREIGN KEY (CPF_professor_isf) REFERENCES professor_isf(CPF_professor_isf)
        ON UPDATE CASCADE
);

/* FIM */

/*-------------- Tabelas ------------------ */

--Gestor

CREATE TABLE Gestor (
    CPF DECIMAL(11) PRIMARY KEY,
    Data_Cadastro DATE
);

CREATE TABLE Gestor_Analisa_Parceiro(
    CPF_Gestor DECIMAL(11),
    CNPJ_Parceiro DECIMAL(14),
    Status_ VARCHAR(100),
    Data_Analise DATE,

    PRIMARY KEY (CPF_Gestor, CNPJ_Parceiro)
);

--Parceiro

CREATE TABLE Parceiro(
  CNPJ DECIMAL(14) PRIMARY KEY,
  Nome VARCHAR(200),
  Descricao VARCHAR(500),
  CEP DECIMAL(8),
  Numero DECIMAL(5),
  Complemento VARCHAR(100)
);

CREATE TABLE EnderecoParceiro(
  CEP DECIMAL(8) PRIMARY KEY,
  Rua VARCHAR(100),
  Numero DECIMAL(5),
  Bairro VARCHAR(100),
  Cidade VARCHAR(100),
  Estado VARCHAR(100),
  Pais VARCHAR(100)
);

-- Isso tava jogado no meio do código, verificar se é algo importante
-- parceiro(PK(FK Parceiro(CEP)) rua, numero, complemento, bairro, cidade, estado, pais)

CREATE TABLE Telefone_Parceiro(
    CNPJ_Parceiro DECIMAL(14),
    DDI DECIMAL(3),
    DDD DECIMAL(2),
    Numero DECIMAL(9),

    PRIMARY KEY (CNPJ_Parceiro, DDI, DDD, Numero)
);

--Edital

CREATE TABLE Edital(
    Numero DECIMAL(30),
    Ano DECIMAL(4),
    Semestre DECIMAL(1),
    Data_Publicacao DATE,
    Data_Inicio DATE,
    Data_Fim DATE,
    Edital_File BYTEA,
    Nome VARCHAR(100),

    PRIMARY KEY (Numero, Ano, Semestre)
);

CREATE TABLE Edital_Oferta_Coletiva(
    Numero DECIMAL(30),
    Ano DECIMAL(4),
    Semestre DECIMAL(1),
    Max_Alunos_Turma  DECIMAL(4),
    Max_Alunos_Lista_Espera  DECIMAL(4),
    Max_Vagas_Reservadas_Turma DECIMAL(3),
    
    PRIMARY KEY (Numero, Ano, Semestre)
);

CREATE TABLE Idiomas_Edital_Oferta_Coletiva(
    Numero DECIMAL(30),
    Ano DECIMAL(4),
    Semestre DECIMAL(1),
    Idioma VARCHAR(50),

    PRIMARY KEY (Numero, Ano, Semestre, Idioma)
);

CREATE TABLE Edital_Cred_Especialista(
    Numero DECIMAL(30),
    Ano DECIMAL(4),
    Semestre DECIMAL(1),

    PRIMARY KEY (Numero, Ano, Semestre)
);

CREATE TABLE Edital_Cred_Prof_Isf(
    Numero DECIMAL(30),
    Ano DECIMAL(4),
    Semestre DECIMAL(1),

    PRIMARY KEY (Numero, Ano, Semestre)
);

CREATE TABLE Edital_Curso_Especializacao(
    Numero DECIMAL(30),
    Ano DECIMAL(4),
    Semestre DECIMAL(1),

    PRIMARY KEY (Numero, Ano, Semestre)
);

--Aluno Especializacao
CREATE TABLE Aluno_Especializacao(
    CPF DECIMAL(11),--FOREIGN KEY professor_isf(CPF)
    Titulacao VARCHAR(40),
    Data_Ingresso DATE,
    Data_Conclusao DATE,

    PRIMARY KEY (CPF)
);

CREATE TABLE Edital_Aluno_Especializacao(
    Numero DECIMAL(30),
    Ano DECIMAL(4),
    Semestre DECIMAL(1),
    Quantidade_Vagas DECIMAL(4),
    
    PRIMARY KEY (Numero, Ano, Semestre)
);

CREATE TABLE Edital_Admite_Docente_Especialista(
    Numero DECIMAL(30),
    Ano DECIMAL(4),
    Semestre DECIMAL(1),
    CPF_Docente_Especialista DECIMAL(11),

    PRIMARY KEY (Numero, Ano, Semestre)
);

CREATE TABLE Aluno_Especializacao_Produz_Repositorio(
    CPF_Aluno_Especializacao DECIMAL(11),
    Repositorio_Titulo VARCHAR(20),
    Foi_Validado_Pelo_Orientador BOOLEAN,
    
    PRIMARY KEY (CPF_Aluno_Especializacao, Repositorio_Titulo)
);

CREATE TABLE Aluno_Especializacao_Cursa_Turma(
    CPF_Aluno DECIMAL(11),
    Nome_Componente VARCHAR(20),
    Sigla VARCHAR(15),
    Semestre DECIMAL (1),

    PRIMARY KEY (CPF_Aluno, Nome_Componente, Sigla, Semestre)
);

CREATE TABLE Atividades_Aluno_Especializacao(
    --FK_Aluno_Especializacao_Cursa_Turma
    CPF_Aluno DECIMAL(11),
    Nome_Componente VARCHAR(20),
    Sigla VARCHAR(15),
    Semestre DECIMAL (1),

    Atividade VARCHAR(40),

    Nota DECIMAL(2),

    PRIMARY KEY (CPF_Aluno, Nome_Componente, Sigla, Semestre, Atividade)
);

-- Repositorio

CREATE TABLE Repositorio(
    Titulo VARCHAR(20),
    Link VARCHAR(50),
    Data_Inclusao DATE,

    PRIMARY KEY (Titulo)
);

CREATE TABLE Repositorio_Turma(
    Nome_Turma_Ofertada VARCHAR(20),
    Idioma_Turma_Ofertada VARCHAR(20),
    Sigla_Turma_Ofertada VARCHAR(10),
    Semestre_Turma_Ofertada DECIMAL(1),

    Titulo_Repositorio VARCHAR(20),

    Foi_Aprovado_Pelo_Orientador BOOLEAN,

    PRIMARY KEY (Nome_Turma_Ofertada, Idioma_Turma_Ofertada, Sigla_Turma_Ofertada, Semestre_Turma_Ofertada, Titulo_Repositorio)
);

-- Oferta Coletiva
CREATE TABLE Turma_Oferta_Coletiva(
    --FK_Curso_Idioma
    Nome_Completo_Idioma VARCHAR(20),
    Idioma VARCHAR(20),

    Sigla_Turma VARCHAR(10),
    Semestre DECIMAL(1),

    Qtde_Vagas_Reservadas DECIMAL(4),
    Hora_Inicio TIME,
    Hora_Fim TIME,
    Dia_Da_Semana1 VARCHAR(3),
    Dia_Da_Demana2 VARCHAR(3),
    Qtde_Vagas DECIMAL(4),
    Qtde_Reprovados DECIMAL(4),
    Qtde_Desistentes DECIMAL(4),
    Qtde_Concluintes DECIMAL(4),
    Qtde_Inscritos DECIMAL(4),
    Qtde_Evadidos DECIMAL(4),

    PRIMARY KEY (Nome_Completo_Idioma, Idioma, Sigla_Turma, Semestre)
);


CREATE TABLE Aluno_Inscreve_Turma_Oferta(
    --FK_Aluno_Oferta_Coletiva
    CPF_Aluno DECIMAL(11),
    --FK_Turma_Oferta_Coletiva
    Nome_Idioma VARCHAR(20),
    Proficiencia_Turma VARCHAR(20),
    Nome_Completo_Idioma VARCHAR(20),
    Sigla_Turma VARCHAR(10),
    Semestre DECIMAL(1),

    Data_Inscricao DATE,

    Posicao_Lista DECIMAL (5),
    Situacao_Inscricao VARCHAR(15),
    Data_Matricula DATE,
    Situacao_matricula VARCHAR(15),
    
    PRIMARY KEY (CPF_Aluno, Nome_Idioma, Proficiencia_Turma, Nome_Completo_Idioma, Sigla_Turma, Semestre, Data_Inscricao)
-- Componente Curricular
);
CREATE TABLE ProficienciaIdiomaComponente(
	Nome_idioma VARCHAR(50),
	Proficiencia VARCHAR(10),
	
	PRIMARY KEY (Nome_idioma,Proficiencia)
);

CREATE TABLE ComponenteCurricular(
	Nome_componente VARCHAR(100),
	Nome_idioma VARCHAR(50),
	Proficiencia VARCHAR(10),
	Carga_horaria_pratica INT,
	Carga_horaria_teorica INT,
	Obrigatoriedade BOOLEAN,
	Eixo_tematico VARCHAR(50),
	
	PRIMARY KEY (Nome_componente)
);

-- Tabela IES
CREATE TABLE IES (
    CNPJ VARCHAR(14) PRIMARY KEY,
    sigla VARCHAR(10),
    participou_isf BOOLEAN,
    tem_lab_mais_unidos BOOLEAN,
    possui_nucleo_ativo BOOLEAN,
    CEP DECIMAL(8),
    link_politica_ling VARCHAR(255),
    data_politica_ling DATE,
    doc_politica_ling VARCHAR(255),
    campus VARCHAR(100),
    nome_principal VARCHAR(100)
);

-- Tabela EnderecoIES
CREATE TABLE EnderecoIES (
    CEP DECIMAL(8),
    CNPJ VARCHAR(14),
    rua VARCHAR(100),
    numero VARCHAR(10),
    complemento VARCHAR(50),
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    estado VARCHAR(2),
    pais VARCHAR(50),

    PRIMARY KEY (CEP, numero)
);

-- Tabela telefoneIES
CREATE TABLE telefoneIES (
    CNPJ_IES DECIMAL(14),
    DDD VARCHAR(3),
    DDI VARCHAR(3),
    numero VARCHAR(15),

    PRIMARY KEY (CNPJ_IES, DDI, DDD, numero)
);

-- Tabela gestorAprovaCoordAdm
CREATE TABLE gestorAprovaCoordAdm (
    CPF_gestorRedeAndifes VARCHAR(11),
    CPF_coordenadorAdministrativo VARCHAR(11),
    data_fim DATE,
    data_inicio DATE,
    documento_de_atuacao VARCHAR(255),
    PRIMARY KEY (CPF_gestorRedeAndifes, CPF_coordenadorAdministrativo)
);

-- Tabela coordAdmCadastraIES
CREATE TABLE coordAdmCadastraIES (
    CNPJ_IES VARCHAR(14),
    CPF_coordenadorAdministrativo VARCHAR(11),
    termo_de_compromisso VARCHAR(255),
    PRIMARY KEY (CNPJ_IES, CPF_coordenadorAdministrativo)
);

-- Tabela coordenadorAdministrativo
CREATE TABLE coordenadorAdministrativo (
    CPF_usuario VARCHAR(11) PRIMARY KEY,
    funcao_na_instituicao VARCHAR(100),
    curriculo_lates VARCHAR(255),
    data_cadastro DATE,
    POCA VARCHAR(50)
);

/*-------------- FK CONSTRAINTS ------------------ */

--Gestor Constraints

ALTER TABLE Gestor 
ADD CONSTRAINT FK_Usuario
FOREIGN KEY (CPF) REFERENCES Usuario(CPF);

ALTER TABLE Gestor_Analisa_Parceiro 
ADD CONSTRAINT FK_Gestor
FOREIGN KEY (CPF_Gestor) REFERENCES Gestor(CPF);

ALTER TABLE Gestor_Analisa_Parceiro 
ADD CONSTRAINT FK_Parceiro  
FOREIGN KEY (CNPJ_Parceiro) REFERENCES Parceiro(CNPJ);


--Parceiro Constraints

ALTER TABLE EnderecoParceiro 
ADD CONSTRAINT FK_Parceiro  
FOREIGN KEY (CEP) REFERENCES Parceiro(CEP);

ALTER TABLE Telefone_Parceiro 
ADD CONSTRAINT FK_Parceiro  
FOREIGN KEY (CNPJ_Parceiro) REFERENCES Parceiro(CNPJ);


--Edital Constraints

ALTER TABLE Edital_Oferta_Coletiva 
ADD CONSTRAINT FK_Edital  
FOREIGN KEY (Numero, Ano, Semestre) REFERENCES Edital(Numero, Ano, Semestre);

ALTER TABLE Edital_Cred_Especialista 
ADD CONSTRAINT FK_Edital  
FOREIGN KEY (Numero, Ano, Semestre) REFERENCES Edital(Numero, Ano, Semestre);

ALTER TABLE Edital_Cred_Prof_Isf 
ADD CONSTRAINT FK_Edital  
FOREIGN KEY (Numero, Ano, Semestre) REFERENCES Edital(Numero, Ano, Semestre);

ALTER TABLE Edital_Curso_Especializacao 
ADD CONSTRAINT FK_Edital  
FOREIGN KEY (Numero, Ano, Semestre) REFERENCES Edital(Numero, Ano, Semestre);

ALTER TABLE Idiomas_Edital_Oferta_Coletiva 
ADD CONSTRAINT FK_Edital_Oferta_Coletiva  
FOREIGN KEY (Numero, Ano, Semestre) REFERENCES Edital_Oferta_Coletiva(Numero, Ano, Semestre);

ALTER TABLE Edital_Aluno_Especializacao
ADD CONSTRAINT FK_Edital
FOREIGN KEY (Numero, Ano, Semestre) REFERENCES Edital(Numero, Ano, Semestre);

ALTER TABLE Edital_Admite_Docente_Especialista
ADD CONSTRAINT FK_Edital
FOREIGN KEY (Numero, Ano, Semestre) REFERENCES Edital(Numero, Ano, Semestre);

ALTER TABLE Edital_Admite_Docente_Especialista
ADD CONSTRAINT FK_Docente_Especialista
FOREIGN KEY () REFERENCES Edital(Numero, Ano, Semestre);

--Aluno Especializacao Constraints

ALTER TABLE Aluno_Especializacao
ADD CONSTRAINT FK_Professor_Isf
FOREIGN KEY (CPF_Docente_Especialista) REFERENCES Docente_Especialista(CPF);

ALTER TABLE Aluno_Especializacao_Produz_Repositorio
ADD CONSTRAINT FK_Aluno_Especializacao
FOREIGN KEY (CPF_Aluno_Especializacao) REFERENCES Aluno_Especializacao(CPF);

ALTER TABLE Aluno_Especializacao_Cursa_Turma
ADD CONSTRAINT FK_Aluno_Especializacao
FOREIGN KEY (CPF_Aluno) REFERENCES Aluno_Especializacao(CPF);

ALTER TABLE Aluno_Especializacao_Cursa_Turma
ADD CONSTRAINT FK_Turma_Especializacao
FOREIGN KEY (Nome_Componente, Sigla, Semestre) REFERENCES Turma_Especializacao(Nome_Componente, Sigla, Semestre);

ALTER TABLE Atividades_Aluno_Especializacao
ADD CONSTRAINT FK_Aluno_Especializacao_Cursa_Turma
FOREIGN KEY (CPF_Aluno, Nome_Componente, Sigla, Semestre) REFERENCES Aluno_Especializacao_Cursa_Turma (CPF_Aluno, Nome_Componente, Sigla, Semestre);

-- Repositorios
ALTER TABLE Repositorio_Turma
ADD CONSTRAINT FK_Turma_Ofertada
FOREIGN KEY (Nome_Turma_Ofertada, Idioma_Turma_Ofertada, Sigla_Turma_Ofertada, Semestre_Turma_Ofertada) REFERENCES Turma_Ofertada (Nome_Completo, Idioma, Sigla_Turma, Semestre);

ALTER TABLE Repositorio_Turma
ADD CONSTRAINT FK_Repositorio
FOREIGN KEY (Titulo_Repositorio) REFERENCES Repositorio (Titulo);

-- Oferta Coletiva
ALTER TABLE Turma_Oferta_Coletiva
ADD CONSTRAINT FK_Curso_Idioma
FOREIGN KEY (Nome_Completo_Idioma, Idioma) REFERENCES Curso_Idioma(Nome_Completo, Idioma)


ALTER TABLE Aluno_Inscreve_Turma_Oferta
ADD CONSTRAINT FK_Aluno_Oferta_Coletiva
FOREIGN KEY (CPF_Aluno) REFERENCES Aluno_Oferta_Coletiva(CPF);

ALTER TABLE Aluno_Inscreve_Turma_Oferta
ADD CONSTRAINT FK_Turma_Oferta_Coletiva
FOREIGN KEY (Nome_Idioma, Proficiencia_Turma, Nome_Completo_Idioma, Sigla_Turma, Semestre, Data_Inscricao) REFERENCES Turma_Oferta_Coletiva(Nome_Idioma, Proficiencia, Nome_Completo, Sigla_Turma, Semestre, Data_Inscricao);
-- Componente Curricular Idioma
ALTER TABLE ComponenteCurricular 
ADD CONSTRAINT FK_IdiomaComponenteCurricular
FOREIGN KEY (Nome_idioma,Proficiencia) REFERENCES ProficienciaIdiomaComponente(Nome_idioma,Proficiencia)

-- Para EnderecoIES
ALTER TABLE EnderecoIES
ADD CONSTRAINT FK_EnderecoIES_IES
FOREIGN KEY (CEP) REFERENCES IES(CEP);

-- Para telefoneIES
ALTER TABLE telefoneIES
ADD CONSTRAINT FK_telefoneIES_IES
FOREIGN KEY (CNPJ_IES) REFERENCES IES(CNPJ);

-- Para gestorAprovaCoordAdm
ALTER TABLE gestorAprovaCoordAdm
ADD CONSTRAINT FK_gestorAprovaCoordAdm_gestorRedeAndifes
FOREIGN KEY (CPF_gestorRedeAndifes) REFERENCES gestorRedeAndifes(CPF);

ALTER TABLE gestorAprovaCoordAdm
ADD CONSTRAINT FK_gestorAprovaCoordAdm_coordenadorAdministrativo
FOREIGN KEY (CPF_coordenadorAdministrativo) REFERENCES coordenadorAdministrativo(CPF_usuario);

-- Para coordAdmCadastraIES
ALTER TABLE coordAdmCadastraIES
ADD CONSTRAINT FK_coordAdmCadastraIES_IES
FOREIGN KEY (CNPJ_IES) REFERENCES IES(CNPJ);

ALTER TABLE coordAdmCadastraIES
ADD CONSTRAINT FK_coordAdmCadastraIES_coordenadorAdministrativo
FOREIGN KEY (CPF_coordenadorAdministrativo) REFERENCES coordenadorAdministrativo(CPF_usuario);

-- Para coordenadorAdministrativo
ALTER TABLE coordenadorAdministrativo
ADD CONSTRAINT FK_coordenadorAdministrativo_usuario
FOREIGN KEY (CPF_usuario) REFERENCES usuario(CPF);
ON DELETE CASCADE
ON UPDATE CASCADE;


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

-- Componente Curricular

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

-- Aluno Oferta Coletiva

CREATE TABLE alunoOfertaColetiva(
    CPF DECIMAL(11),
    Vinculo_file VARCHAR(100),

    PRIMARY KEY (CPF, Vinculo_file)
);

CREATE TABLE idiomaAlunoOfertaColetiva (
	CPF DECIMAL(11),
	Idioma VARCHAR(50),
	Proficiencia VARCHAR(50),
	Declaracao_proficiencia VARCHAR(100),
	
	PRIMARY KEY (CPF, Idioma, Proficiencia)
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

-- Componente Curricular Idioma
ALTER TABLE ComponenteCurricular 
ADD CONSTRAINT FK_IdiomaComponenteCurricular
FOREIGN KEY (Nome_idioma,Proficiencia) REFERENCES ProficienciaIdiomaComponente(Nome_idioma,Proficiencia)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- Aluno Oferta Coletiva
-- ALTER TABLE alunoOfertaColetiva
-- ADD CONSTRAINT FK_Usuario
-- FOREIGN KEY (CPF) REFERENCES Usuario(CPF)
-- ON DELETE RESTRICT
-- ON UPDATE CASCADE;

-- ALTER TABLE idiomaAlunoOfertaColetiva
-- ADD CONSTRAINT FK_Usuario
-- FOREIGN KEY (CPF) REFERENCES Usuario(CPF)
-- ON DELETE RESTRICT
-- ON UPDATE CASCADE;


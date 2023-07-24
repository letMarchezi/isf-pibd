CREATE TABLE Gestor (
    CPF DECIMAL(11) PRIMARY KEY,
    Data_Cadastro DATE,

    FOREIGN KEY (CPF) REFERENCES Usuario (CPF)
);

CREATE TABLE Gestor_Analisa_Parceiro(
    CPF_Gestor DECIMAL(11) PRIMARY KEY,
    CNPJ_Parceiro DECIMAL(14) PRIMARY KEY,
    Status_ CHAR(100),
    Data_Analise DATE,

    FOREIGN KEY (CPF_Gestor) REFERENCES Gestor (CPF),
    FOREIGN KEY (CNPJ_Parceiro) REFERENCES Parceiro (CNPJ)
);

CREATE TABLE Parceiro(
  CNPJ DECIMAL(14) PRIMARY KEY,
  Nome CHAR(200),
  Descricao CHAR(500),
  CEP DECIMAL(8),
  Numero DECIMAL(5),
  Complemento CHAR(100)
);

CREATE TABLE EnderecoParceiro(
  CEP DECIMAL(8) PRIMARY KEY,
  Rua CHAR(100),
  Numero DECIMAL(5),
  Bairro CHAR(100),
  Cidade CHAR(100),
  Estado CHAR(100),
  Pais CHAR(100),

  FOREIGN KEY (CEP) REFERENCES Parceiro(CEP),
);

parceiro(PK(FK Parceiro(CEP)) rua, numero, complemento, bairro, cidade, estado, pais)

CREATE TABLE Telefone_Parceiro(
    CNPJ_Parceiro DECIMAL(14) PRIMARY KEY,
    DDI DECIMAL(3) PRIMARY KEY,
    DDD DECIMAL(2) PRIMARY KEY,
    Numero DECIMAL(9) PRIMARY KEY,

    FOREIGN KEY (CNPJ_Parceiro) REFERENCES Parceiro (CNPJ)
);

CREATE TABLE Edital(
    Numero DECIMAL(30) PRIMARY KEY,
    Ano DECIMAL(4) PRIMARY KEY,
    Semestre DECIMAL(1) PRIMARY KEY,
    Data_Publicacao DATE,
    Data_Inicio DATE,
    Data_Fim DATE,
    Edital_File BLOB,
    Nome CHAR(100)
);

CREATE TABLE Edital_Oferta_Coletiva(
    Numero DECIMAL(30) PRIMARY KEY,
    Ano DECIMAL(4) PRIMARY KEY,
    Semestre DECIMAL(1) PRIMARY KEY,
    Max_Alunos_Turma  DECIMAL(4),
    Max_Alunos_Lista_Espera  DECIMAL(4),
    Max_Vagas_Reservadas_Turma DECIMAL(3),

    FOREIGN KEY (Numero, Ano, Semestre) REFERENCES Edital(Numero, Ano, Semestre)
);

CREATE TABLE Idiomas_Edital_Oferta_Coletiva(
    Numero DECIMAL(30) PRIMARY KEY,
    Ano DECIMAL(4) PRIMARY KEY,
    Semestre DECIMAL(1) PRIMARY KEY,
    Idioma CHAR(50) PRIMARY KEY,

    FOREIGN KEY (Numero, Ano, Semestre) REFERENCES Edital_Oferta_Coletiva(Numero, Ano, Semestre)
);

CREATE TABLE Edital_Cred_Especialista(
    Numero DECIMAL(30) PRIMARY KEY,
    Ano DECIMAL(4) PRIMARY KEY,
    Semestre DECIMAL(1) PRIMARY KEY,

    FOREIGN KEY (Numero, Ano, Semestre) REFERENCES Edital(Numero, Ano, Semestre)
);

CREATE TABLE Edital_Cred_Prof_Isf(
    Numero DECIMAL(30) PRIMARY KEY,
    Ano DECIMAL(4) PRIMARY KEY,
    Semestre DECIMAL(1) PRIMARY KEY,

    FOREIGN KEY (Numero, Ano, Semestre) REFERENCES Edital(Numero, Ano, Semestre)
);

CREATE TABLE Edital_Curso_Especializacao(
    Numero DECIMAL(30) PRIMARY KEY,
    Ano DECIMAL(4) PRIMARY KEY,
    Semestre DECIMAL(1) PRIMARY KEY,

    FOREIGN KEY (Numero, Ano, Semestre) REFERENCES Edital(Numero, Ano, Semestre)
);
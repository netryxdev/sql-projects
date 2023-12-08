CREATE TABLE TB_CLIENTE
(
    ClienteId INT IDENTITY(1, 1),
    CONSTRAINT PK_CLIENTE_CLIENTEID PRIMARY KEY (ClienteId) --Para criar uma tabela com uma primary key padrao.
);

CREATE TABLE TB_ENDERECO
(
    EnderecoId INT IDENTITY(1, 1),
    Logradouro VARCHAR(50),
    Numero VARCHAR(20),
    Bairro VARCHAR(35),
    CEP VARCHAR(15),
    ClienteId INT NULL,
    CONSTRAINT PK_ENDERECO_EnderecoId PRIMARY KEY(EnderecoId),
    CONSTRAINT FK_ENDERECO_CLIENTE_ClienteId FOREIGN KEY(ClienteId), --Para relacionar um PK de outra tabela como uma FK Aqui.
    REFERENCES TB_CLIENTE(CLienteId)
);

ALTER TABLE TB_ENDERECO
ADD CONSTRAINT FK_ENDERECO_CLIENTE_ClienteId FOREIGN KEY(ClienteId)
REFERENCES TB_CLIENTE(ClienteId);

---------Como Deletar Constraints?-----------
ALTER TABLE TB_ENDERECO
DROP CONSTRAINT FK_ENDERECO_CLIENTE_ClienteId;

---------Como Alterar tabela para add coluna apos criacao de tabela------------
ALTER TABLE TB_ENDERECO 
ADD DataCriacao DATETIME2 DEFAULT GETDATE();

--E para dropar...;
ALTER TABLE TB_ENDERECO 
DROP DataCriacao DATETIME2 DEFAULT GETDATE();

--Para dropar uma coluna que seja FK, precisa primeiro dropar a constraint e depois a coluna.
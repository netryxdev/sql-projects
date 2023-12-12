SELECT * FROM TB_CLIENTE;


ALTER TABLE TB_CLIENTE
ADD Estado CHAR(2) NULL; -- Tem que ser null sempre que vamos add uma coluna a nao ser que vc utilize um DEFAULT para preencher as demais colunas.

UPDATE TB_CLIENTE 
SET Estado = 'PE'
WHERE Id IN (1, 2, 3);

UPDATE TB_CLIENTE 
SET Estado = 'RJ'
WHERE Id IN (8,9, 10);

INSERT INTO TB_CLIENTE
VALUES
('Miriam Souza', '12345678912', '1986-06-13 12:32:12', 'miram@email.com', 'SP'),
('Jair Batista', '74839265743', '1990-04-13 12:32:12', 'jair@email.com', 'SP'),
('Paula Silva', '00000000000', '1980-12-03 16:22:12', 'paula@email.com', 'RJ'),
('João Abreu', '09876543210', '1987-11-13 21:55:12', 'joao@email.com', 'RJ')

CREATE TABLE TB_CLIENTE_SP
(
    Id int IDENTITY (1, 1) NOT NULL,
    Nome varchar(70),
    CPF varchar (11),
    DataNascimento datetime2,
    Email varchar (70),
    Estado CHAR (2),
    CONSTRAINT PK_CLIENTE_SP PRIMARY KEY (Id)
)

INSERT TOP(5) INTO TB_CLIENTE_SP 
SELECT Nome, CPF, DataNascimento, Email, Estado FROM TB_CLIENTE
WHERE Estado = 'SP'

SELECT * FROM TB_CLIENTE_SP;
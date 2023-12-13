INSERT INTO <TABLE> 
(Campo1, Campo2, Campo3)
VALUES
('Valor1', 'Valor2', valor3); --O ultimo valor foi sem aspas porque imagine que seja um INT.

--Exemplo de insert declarativo (onde declaro quais colunas inserir)
INSERT INTO TB_CLIENTE
(Nome, CPF, DataNascimento, Email)
VALUES
('Yugi', '55555555555', '2005-08-03 12:00:00', 'yugi@gmail.com');

--Exemplo de insert posicional (onde NAO declaro quais colunas inserir pois fica implicito pela posicao dos dados inseridos em relacao a posicao das colunas no DB)
INSERT INTO TB_CLIENTE
VALUES
('Emilly', '88888888888', '1999-05-21 12:00:00', 'amigurumillyt@gmail.com');
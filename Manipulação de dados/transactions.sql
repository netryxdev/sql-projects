-- Transações no SQL Server:

-- Transação Explícita:

-- Iniciada manualmente pelo programador.
-- Usando BEGIN TRANSACTION, COMMIT, e ROLLBACK.
-- Permite maior controle sobre o escopo e a duração da transação.

-- Transação Implícita:
-- INSERT
-- UPDATE
-- DELETE
-- SELECT
-- CREATE TABLE
-- ALTER TABLE
-- DROP TABLE
-- CREATE INDEX
-- Outras instruções DDL e DML padrão do SQL
-- Iniciada automaticamente pelo sistema.
-- Cada instrução SQL é tratada como uma transação individual.
-- O sistema decide automaticamente quando fazer COMMIT ou ROLLBACK.
-- COMMIT:

-- Confirma as alterações feitas durante a transação.
-- Torna as mudanças permanentes.
-- ROLLBACK:

-- Desfaz as alterações feitas durante a transação.
-- Retorna ao estado anterior à transação.
-- Atomicidade, Consistência, Isolamento e Durabilidade (ACID):

-- Princípios garantindo confiabilidade e integridade das transações.
-- Atomicidade: Todas as operações da transação são tratadas como uma única unidade.
-- Consistência: Garante que o banco de dados permaneça em um estado consistente.
-- Isolamento: As transações não interferem umas nas outras.
-- Durabilidade: As alterações persistem mesmo em caso de falha do sistema.
-- Exemplo de Transação Explícita:

BEGIN TRANSACTION;
-- Suas instruções SQL aqui
COMMIT; -- ou ROLLBACK em caso de erro
Exemplo de Transação Implícita:

sql
Copy code
-- Cada instrução é uma transação
INSERT INTO tabela1 VALUES (1, 'Exemplo');
UPDATE tabela2 SET coluna = 'NovoValor' WHERE id = 2;
-- As alterações são automaticamente commitadas

-- Rollback: Se você iniciar uma transação (implicitamente ou explicitamente com BEGIN TRAN) e, em seguida, encontrar algum problema ou decidir que deseja desfazer as alterações feitas até o momento, você pode usar ROLLBACK. Isso desfaz todas as alterações na transação, revertendo o banco de dados ao estado inicial antes da transação.

-- Commit: Se você estiver satisfeito com as alterações feitas durante a transação e deseja torná-las permanentes, você usa COMMIT. Após o COMMIT, as alterações são confirmadas e não podem ser desfeitas.

-- Aqui está um exemplo básico para ilustrar:

BEGIN TRAN;

UPDATE tabela SET coluna = novo_valor WHERE condição;

-- Se algo der errado ou se você quiser desfazer as alterações:
ROLLBACK;

-- Se estiver satisfeito com as alterações e deseja torná-las permanentes:
-- COMMIT;

-- Se você executar ROLLBACK, as alterações feitas pela transação serão desfeitas. Se você executar COMMIT, as alterações serão confirmadas e permanentes no banco de dados.

-- É uma prática comum envolver operações de banco de dados em transações, especialmente quando se trata de operações que afetam várias tabelas ou requerem consistência. Dessa forma, você tem a opção de confirmar ou desfazer todas as alterações como uma unidade atômica.
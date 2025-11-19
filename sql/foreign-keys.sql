/*
    Script: foreign-keys.sql
    Autor: Vitor Pratt
    Projeto: All In Store Analytics
    Descrição:
    Criação de todas as chaves estrangeiras do projeto AllInStore.
    Execute após o primary-keys.sql.
*/

USE AllInStore;
GO

-- ===============================
-- Chaves Estrangeiras
-- ===============================

-- Vendas → Clientes
ALTER TABLE dbo.Vendas
ADD CONSTRAINT FK_Vendas_Clientes
FOREIGN KEY (ID_Cliente)
REFERENCES dbo.Clientes(ID_Cliente);
GO

-- Vendas → Produtos
ALTER TABLE dbo.Vendas
ADD CONSTRAINT FK_Vendas_Produtos
FOREIGN KEY (ID_Produto)
REFERENCES dbo.Produtos(ID_Produto);
GO

-- Pagamentos → Vendas
ALTER TABLE dbo.Pagamentos
ADD CONSTRAINT FK_Pagamentos_Vendas
FOREIGN KEY (ID_Venda)
REFERENCES dbo.Vendas(ID_Venda);
GO

-- Estoque → Produtos
ALTER TABLE dbo.Estoque
ADD CONSTRAINT FK_Estoque_Produtos
FOREIGN KEY (ID_Produto)
REFERENCES dbo.Produtos(ID_Produto);
GO

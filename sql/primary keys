/*
    Script: primary-keys.sql
    Autor: Vitor Pratt
    Projeto: All In Store Analytics
    Descrição:
    Criação de todas as chaves primárias do banco AllInStore.
    Execute após o create-tables.sql.
*/

USE AllInStore;
GO

-- ===============================
-- Chaves Primárias
-- ===============================

-- Clientes
ALTER TABLE dbo.Clientes
ADD CONSTRAINT PK_Clientes
PRIMARY KEY (ID_Cliente);
GO

-- Produtos
ALTER TABLE dbo.Produtos
ADD CONSTRAINT PK_Produtos
PRIMARY KEY (ID_Produto);
GO

-- Vendas
ALTER TABLE dbo.Vendas
ADD CONSTRAINT PK_Vendas
PRIMARY KEY (ID_Venda);
GO

-- Pagamentos
ALTER TABLE dbo.Pagamentos
ADD CONSTRAINT PK_Pagamentos
PRIMARY KEY (ID_Pagamento);
GO

-- Estoque
ALTER TABLE dbo.Estoque
ADD CONSTRAINT PK_Estoque
PRIMARY KEY (ID_Produto);
GO

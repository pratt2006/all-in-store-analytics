/*
    Script: create-tables.sql
    Autor: Vitor Pratt
    Projeto: All In Store Analytics
    Descrição:
    Criação de todas as tabelas utilizadas no projeto.
    Execute este script depois do create-database.sql.
*/

USE AllInStore;
GO

-- ===============================
-- Tabela Clientes (Dimensão)
-- ===============================
CREATE TABLE dbo.Clientes (
    ID_Cliente       INT          NOT NULL,
    Nome             VARCHAR(100) NOT NULL,
    Sexo             CHAR(1)      NOT NULL,
    Data_Nascimento  DATE         NOT NULL,
    Estado           CHAR(2)      NOT NULL,
    Cidade           VARCHAR(100) NOT NULL,
    Data_Cadastro    DATE         NOT NULL,
    Indicacao        VARCHAR(10)  NULL,   -- pode ser código, nome ou vazio
    Classificacao    VARCHAR(20)  NOT NULL
);
GO

-- ===============================
-- Tabela Produtos (Dimensão)
-- ===============================
CREATE TABLE dbo.Produtos (
    ID_Produto    INT           NOT NULL,
    Nome_Produto  VARCHAR(150)  NOT NULL,
    Categoria     VARCHAR(50)   NOT NULL,
    Subcategoria  VARCHAR(50)   NOT NULL,
    Preco_Custo   DECIMAL(10,2) NOT NULL,
    Preco_Venda   DECIMAL(10,2) NOT NULL,
    Marca         VARCHAR(50)   NOT NULL,
    Status        VARCHAR(20)   NOT NULL  -- Ex: Ativo / Inativo / Descontinuado
);
GO

-- ===============================
-- Tabela Vendas (Fato)
-- ===============================
CREATE TABLE dbo.Vendas (
    ID_Venda       INT           NOT NULL,
    Data_Venda     DATE          NOT NULL,
    ID_Cliente     INT           NOT NULL,
    ID_Produto     INT           NOT NULL,
    Quantidade     INT           NOT NULL,
    Preco_Unitario DECIMAL(10,2) NOT NULL,
    Valor_Total    DECIMAL(10,2) NOT NULL,
    Desconto       DECIMAL(4,2)  NOT NULL,   -- 0.15 = 15%
    Canal          VARCHAR(30)   NOT NULL,   -- Online, Loja Física, etc.
    Vendedor       VARCHAR(50)   NOT NULL
);
GO

-- ===============================
-- Tabela Pagamentos (Fato)
-- ===============================
CREATE TABLE dbo.Pagamentos (
    ID_Pagamento    INT           NOT NULL,
    ID_Venda        INT           NOT NULL,
    Forma_Pagamento VARCHAR(20)   NOT NULL,   -- Pix, Crédito, Débito, Boleto...
    Parcelas        INT           NOT NULL,
    Valor_Pago      DECIMAL(10,2) NOT NULL
);
GO

-- ===============================
-- Tabela Estoque (Dimensão de apoio)
-- ===============================
CREATE TABLE dbo.Estoque (
    ID_Produto         INT           NOT NULL,
    Quantidade_Estoque INT           NOT NULL,
    Data_Atualizacao   DATE          NOT NULL
);
GO

/*
    Script: populate-data.sql
    Autor: Vitor Pratt
    Projeto: All In Store Analytics

    Descrição:
    Popula as tabelas Clientes, Produtos, Vendas, Pagamentos e Estoque
    com dados fictícios, consistentes e prontos para análise.

    Quantidades:
    - Clientes  : 200
    - Produtos  : 80
    - Vendas    : 1500
    - Pagamentos: 1500
    - Estoque   : 80
*/

USE AllInStore;
GO

/* =====================================================
   LIMPAR TABELAS NA ORDEM CERTA (RESPEITANDO FKs)
   ===================================================== */

DELETE FROM dbo.Pagamentos;
DELETE FROM dbo.Vendas;
DELETE FROM dbo.Estoque;
DELETE FROM dbo.Clientes;
DELETE FROM dbo.Produtos;
GO


/* =====================================================
   POPULAR CLIENTES (200 REGISTROS)
   ===================================================== */

INSERT INTO dbo.Clientes (
    ID_Cliente,
    Nome,
    Sexo,
    Data_Nascimento,
    Estado,
    Cidade,
    Data_Cadastro,
    Indicacao,
    Classificacao
)
SELECT
    N.n AS ID_Cliente,
    CONCAT('Cliente ', N.n) AS Nome,
    CASE WHEN N.n % 2 = 0 THEN 'M' ELSE 'F' END AS Sexo,
    DATEADD(DAY, - (7000 + (N.n * 10)), CAST(GETDATE() AS date)) AS Data_Nascimento, -- ~25–50 anos
    CASE N.n % 5
        WHEN 0 THEN 'SP'
        WHEN 1 THEN 'RJ'
        WHEN 2 THEN 'MG'
        WHEN 3 THEN 'PR'
        ELSE 'RS'
    END AS Estado,
    CASE N.n % 5
        WHEN 0 THEN 'São Paulo'
        WHEN 1 THEN 'Rio de Janeiro'
        WHEN 2 THEN 'Belo Horizonte'
        WHEN 3 THEN 'Curitiba'
        ELSE 'Porto Alegre'
    END AS Cidade,
    DATEADD(DAY, - (N.n % 365), CAST(GETDATE() AS date)) AS Data_Cadastro,
    CASE 
        WHEN N.n % 10 = 0 THEN NULL
        ELSE CAST(((N.n - 1) % 200) + 1 AS VARCHAR(10))
    END AS Indicacao,
    CASE N.n % 4
        WHEN 0 THEN 'Bronze'
        WHEN 1 THEN 'Prata'
        WHEN 2 THEN 'Ouro'
        ELSE 'Platina'
    END AS Classificacao
FROM (
    SELECT TOP (200)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects
) AS N;
GO


/* =====================================================
   POPULAR PRODUTOS (80 REGISTROS)
   ===================================================== */

INSERT INTO dbo.Produtos (
    ID_Produto,
    Nome_Produto,
    Categoria,
    Subcategoria,
    Preco_Custo,
    Preco_Venda,
    Marca,
    Status
)
SELECT
    N.n AS ID_Produto,
    CONCAT('Produto ', N.n) AS Nome_Produto,
    CASE N.n % 4
        WHEN 0 THEN 'Eletrônicos'
        WHEN 1 THEN 'Acessórios'
        WHEN 2 THEN 'Casa'
        ELSE 'Escritório'
    END AS Categoria,
    CASE N.n % 4
        WHEN 0 THEN 'Gadgets'
        WHEN 1 THEN 'Cabo e Conexões'
        WHEN 2 THEN 'Utilidades'
        ELSE 'Organização'
    END AS Subcategoria,
    CAST(10.0 + (N.n * 1.5) AS DECIMAL(10,2)) AS Preco_Custo,
    CAST((10.0 + (N.n * 1.5)) * (1.20 + ((N.n % 5) * 0.05)) AS DECIMAL(10,2)) AS Preco_Venda,
    CONCAT('Marca ', CHAR(65 + (N.n % 5))) AS Marca,  -- Marca A, B, C...
    'Ativo' AS Status
FROM (
    SELECT TOP (80)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects
) AS N;
GO


/* =====================================================
   POPULAR VENDAS (1500 REGISTROS)
   ===================================================== */

INSERT INTO dbo.Vendas (
    ID_Venda,
    Data_Venda,
    ID_Cliente,
    ID_Produto,
    Quantidade,
    Preco_Unitario,
    Valor_Total,
    Desconto,
    Canal,
    Vendedor
)
SELECT
    N.n AS ID_Venda,
    DATEADD(DAY, - (N.n % 365), CAST(GETDATE() AS date)) AS Data_Venda,
    ((N.n - 1) % 200) + 1 AS ID_Cliente,
    ((N.n - 1) % 80) + 1  AS ID_Produto,
    Q.Qtd AS Quantidade,
    P.Preco_Venda AS Preco_Unitario,
    CAST(P.Preco_Venda * Q.Qtd * (1 - D.Desconto) AS DECIMAL(10,2)) AS Valor_Total,
    D.Desconto,
    C.Canal,
    V.Vendedor
FROM (
    SELECT TOP (1500)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects
) AS N
JOIN dbo.Produtos P
    ON P.ID_Produto = ((N.n - 1) % 80) + 1
CROSS APPLY (
    SELECT (ABS(CHECKSUM(NEWID())) % 5) + 1 AS Qtd   -- 1 a 5 unidades
) AS Q
CROSS APPLY (
    SELECT 
        CASE ABS(CHECKSUM(NEWID())) % 4
            WHEN 0 THEN 0.00
            WHEN 1 THEN 0.05
            WHEN 2 THEN 0.10
            ELSE 0.15
        END AS Desconto
) AS D
CROSS APPLY (
    SELECT 
        CASE ABS(CHECKSUM(NEWID())) % 3
            WHEN 0 THEN 'Online'
            WHEN 1 THEN 'Loja Física'
            ELSE 'Marketplace'
        END AS Canal
) AS C
CROSS APPLY (
    SELECT 
        CASE ABS(CHECKSUM(NEWID())) % 4
            WHEN 0 THEN 'Ana'
            WHEN 1 THEN 'Bruno'
            WHEN 2 THEN 'Carlos'
            ELSE 'Daniela'
        END AS Vendedor
) AS V;
GO


/* =====================================================
   POPULAR PAGAMENTOS (1 POR VENDA → 1500)
   ===================================================== */

INSERT INTO dbo.Pagamentos (
    ID_Pagamento,
    ID_Venda,
    Forma_Pagamento,
    Parcelas,
    Valor_Pago
)
SELECT
    V.ID_Venda       AS ID_Pagamento,
    V.ID_Venda       AS ID_Venda,
    CASE ABS(CHECKSUM(NEWID())) % 4
        WHEN 0 THEN 'Pix'
        WHEN 1 THEN 'Crédito'
        WHEN 2 THEN 'Débito'
        ELSE 'Boleto'
    END AS Forma_Pagamento,
    CASE ABS(CHECKSUM(NEWID())) % 4
        WHEN 0 THEN 1
        WHEN 1 THEN 2
        WHEN 2 THEN 3
        ELSE 4
    END AS Parcelas,
    V.Valor_Total AS Valor_Pago
FROM dbo.Vendas V;
GO


/* =====================================================
   POPULAR ESTOQUE (1 POR PRODUTO → 80)
   ===================================================== */

INSERT INTO dbo.Estoque (
    ID_Produto,
    Quantidade_Estoque,
    Data_Atualizacao
)
SELECT
    P.ID_Produto,
    (ABS(CHECKSUM(NEWID())) % 200) + 10 AS Quantidade_Estoque, -- 10–209
    CAST(GETDATE() AS date) AS Data_Atualizacao
FROM dbo.Produtos P;
GO


/* =====================================================
   CONFERÊNCIA FINAL
   ===================================================== */

PRINT '===== RESUMO DE REGISTROS GERADOS =====';
SELECT COUNT(*) AS Qtd_Clientes   FROM dbo.Clientes;
SELECT COUNT(*) AS Qtd_Produtos   FROM dbo.Produtos;
SELECT COUNT(*) AS Qtd_Vendas     FROM dbo.Vendas;
SELECT COUNT(*) AS Qtd_Pagamentos FROM dbo.Pagamentos;
SELECT COUNT(*) AS Qtd_Estoque    FROM dbo.Estoque;
GO

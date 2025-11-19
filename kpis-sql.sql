/*
================================================================================
    Arquivo: kpi-queries.sql
    Projeto: All In Store Analytics
    Autor: Vitor Pratt
    Descrição:
        Consultas SQL para geração de KPIs comerciais, operacionais e gerenciais
        sobre a base AllInStore. Este arquivo serve para estudos de SQL, Power BI,
        modelagem de dados e análises exploratórias.
================================================================================
*/

USE AllInStore;
GO

/* ============================================================================
    SEÇÃO 1 — KPIs DE VENDAS
============================================================================ */

/* 1) Faturamento total (R$) */
SELECT 
    SUM(Valor_Total) AS Faturamento_Total
FROM dbo.Vendas;


/* 2) Ticket médio por venda */
SELECT 
    SUM(Valor_Total) / COUNT(*) AS Ticket_Medio
FROM dbo.Vendas;


/* 3) Quantidade total de vendas */
SELECT 
    COUNT(*) AS Qtd_Vendas
FROM dbo.Vendas;


/* 4) Faturamento por mês */
SELECT
    FORMAT(Data_Venda, 'yyyy-MM') AS AnoMes,
    SUM(Valor_Total) AS Faturamento
FROM dbo.Vendas
GROUP BY FORMAT(Data_Venda, 'yyyy-MM')
ORDER BY AnoMes;


/* 5) Faturamento por canal */
SELECT
    Canal,
    SUM(Valor_Total) AS Faturamento,
    COUNT(*) AS Qtd_Vendas
FROM dbo.Vendas
GROUP BY Canal
ORDER BY Faturamento DESC;


/* ============================================================================
    SEÇÃO 2 — KPIs DE PRODUTOS
============================================================================ */

/* 6) Top 10 produtos por faturamento */
SELECT TOP 10
    p.ID_Produto,
    p.Nome_Produto,
    SUM(v.Valor_Total) AS Faturamento,
    SUM(v.Quantidade) AS Qtd_Vendida
FROM dbo.Vendas v
JOIN dbo.Produtos p ON p.ID_Produto = v.ID_Produto
GROUP BY p.ID_Produto, p.Nome_Produto
ORDER BY Faturamento DESC;


/* 7) Faturamento por categoria */
SELECT
    p.Categoria,
    SUM(v.Valor_Total) AS Faturamento,
    SUM(v.Quantidade) AS Qtd_Vendida
FROM dbo.Vendas v
JOIN dbo.Produtos p ON p.ID_Produto = v.ID_Produto
GROUP BY p.Categoria
ORDER BY Faturamento DESC;


/* 8) Desconto médio aplicado */
SELECT 
    AVG(Desconto) AS Desconto_Medio
FROM dbo.Vendas;


/* ============================================================================
    SEÇÃO 3 — KPIs DE VENDEDORES
============================================================================ */

/* 9) Distribuição de vendas por vendedor */
SELECT
    Vendedor,
    COUNT(*) AS Qtd_Vendas,
    SUM(Valor_Total) AS Faturamento
FROM dbo.Vendas
GROUP BY Vendedor
ORDER BY Faturamento DESC;


/* ============================================================================
    SEÇÃO 4 — KPIs DE CLIENTES
============================================================================ */

/* 10) Top 10 clientes mais valiosos */
SELECT TOP 10
    c.ID_Cliente,
    c.Nome,
    SUM(v.Valor_Total) AS Faturamento_Cliente,
    COUNT(*) AS Qtd_Vendas
FROM dbo.Vendas v
JOIN dbo.Clientes c ON c.ID_Cliente = v.ID_Cliente
GROUP BY c.ID_Cliente, c.Nome
ORDER BY Faturamento_Cliente DESC;


/* 11) Faturamento por Estado (UF) */
SELECT
    c.Estado,
    SUM(v.Valor_Total) AS Faturamento,
    COUNT(*) AS Qtd_Vendas
FROM dbo.Vendas v
JOIN dbo.Clientes c ON c.ID_Cliente = v.ID_Cliente
GROUP BY c.Estado
ORDER BY Faturamento DESC;


/* ============================================================================
    SEÇÃO 5 — KPIs FINANCEIROS (PAGAMENTOS)
============================================================================ */

/* 12) Faturamento por forma de pagamento */
SELECT
    Forma_Pagamento,
    COUNT(*) AS Qtd_Pagamentos,
    SUM(Valor_Pago) AS Total_Pago,
    AVG(Valor_Pago) AS Ticket_Medio
FROM dbo.Pagamentos
GROUP BY Forma_Pagamento
ORDER BY Total_Pago DESC;


/* ============================================================================
    SEÇÃO 6 — KPIs DE ESTOQUE
============================================================================ */

/* 13) Estoque total por categoria */
SELECT
    p.Categoria,
    SUM(e.Quantidade_Estoque) AS Estoque_Total
FROM dbo.Estoque e
JOIN dbo.Produtos p ON p.ID_Produto = e.ID_Produto
GROUP BY p.Categoria
ORDER BY Estoque_Total DESC;


/* 14) Produtos com baixo estoque (< 30 unidades) */
SELECT
    p.ID_Produto,
    p.Nome_Produto,
    e.Quantidade_Estoque
FROM dbo.Estoque e
JOIN dbo.Produtos p ON p.ID_Produto = e.ID_Produto
WHERE e.Quantidade_Estoque < 30
ORDER BY e.Quantidade_Estoque ASC;


/* ============================================================================
    SEÇÃO 7 — KPIs DE MARGEM E RENTABILIDADE
============================================================================ */

/* 15) Margem percentual por produto */
SELECT
    ID_Produto,
    Nome_Produto,
    Preco_Custo,
    Preco_Venda,
    CAST(((Preco_Venda - Preco_Custo) / Preco_Custo) * 100 AS DECIMAL(10,2)) AS Margem_Percentual
FROM dbo.Produtos
ORDER BY Margem_Percentual DESC;

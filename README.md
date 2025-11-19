# all-in-store-analytics
Projeto de Tratamento de Dados e análise de dados da loja All In Store
All In Store Analytics – SQL + Python + Power BI

Projeto completo de análise de dados, desde a modelagem do banco até o dashboard final.
Construído como portfólio profissional para demonstrar domínio em Engenharia de Dados, ETL, Análise e Business Intelligence.

⸻

🧭 Visão Geral do Projeto

O objetivo deste projeto é simular a operação de uma loja varejista fictícia — All In Store — e construir uma solução completa de Analytics envolvendo:
	•	Modelagem de dados (SQL Server)
	•	ETL com Python + Pandas
	•	Criação de KPIs
	•	Modelo Estrela para BI
	•	Dashboard profissional no Power BI
	•	Documentação clara e visual (GitHub)

Esse projeto demonstra o fluxo real usado em empresas para transformar dados brutos em inteligência de negócio.

Arquitetura do Projeto
CSV -> SQL Server -> Python ETL -> Power Bi -> Dashboard

✔ SQL Server

Criação do banco, tabelas, relacionamentos e KPIs analíticos via SQL.

✔ Python

Tratamento, merges, criação de métricas e análise exploratória usando Pandas.

✔ Power BI

Modelo estrela, DAX, KPIs visuais e dashboard executivo.



all-in-store-analytics/
│
├── sql/
│     ├── create-tables.sql
│     ├── import-data.sql
│     ├── primary-keys.sql
│     ├── foreign-keys.sql
│     ├── kpis.sql
│     └── README.md
│
├── python/
│     ├── 01-load-data.ipynb
│     ├── 02-cleaning.ipynb
│     ├── 03-joins-kpis.ipynb
│     └── README.md
│
├── powerbi/
│     ├── dashboard-all-in-store.pbix
│     └── README.md
│
├── data/
│     ├── clientes.csv
│     ├── produtos.csv
│     ├── vendas.csv
│     ├── pagamentos.csv
│     └── estoque.csv
│
├── LICENSE
├── .gitignore
└── README.md

KPIs Desenvolvidos

🔹 Vendas
	•	Faturamento total
	•	Ticket médio
	•	Total de vendas
	•	Taxa de crescimento mensal
	•	Faturamento por canal
	•	Faturamento por categoria de produto

🔹 Clientes
	•	Total de clientes
	•	Clientes ativos no período
	•	Faturamento por cliente
	•	Top 10 clientes

🔹 Produtos
	•	Ranking de produtos
	•	Margem total por produto
	•	% margem
	•	Curva ABC

🔹 Pagamentos
	•	Total recebido
	•	Distribuição por forma de pagamento
	•	Ticket médio por forma de pagamento

🔹 Estoque
	•	Quantidade atual
	•	Produtos com baixo estoque
	•	Estoque total por categoria

⸻

🧱 Modelo Estrela (Power BI)

Dimensões:
	•	DIM_Clientes
	•	DIM_Produtos
	•	DIM_Calendário

Fatos:
	•	FATO_Vendas
	•	FATO_Pagamentos

O modelo permite análises rápidas e escaláveis no Power BI.

⸻

📈 Dashboard – Power BI

📌 Páginas incluídas:
	•	Visão Executiva
	•	Vendas
	•	Clientes
	•	Produtos
	•	Pagamentos
	•	Estoque

📌 Contém:
	•	Medidas DAX otimizadas
	•	Gráficos profissionais
	•	Navegação por bookmarks
	•	KPIs de alto impacto

(Adicione prints aqui depois que montar o dashboard.)

⸻

🐍 ETL com Python (Pandas)

Os notebooks demonstram:

✔ Leitura de dados CSV
✔ Tratamento de datas e tipos
✔ Limpeza e padronização
✔ Joins e merges
✔ Cálculo de KPIs
✔ Exportação de dados
✔ Visualização básica (matplotlib)

⸻

🗄 SQL Server – Modelagem e KPIs

Scripts incluem:
	•	Criação do banco
	•	Criação das tabelas
	•	Primary Keys & Foreign Keys
	•	Importação dos dados
	•	Views analíticas
	•	KPIs escritos em SQL

KPIs Desenvolvidos

🔹 Vendas
	•	Faturamento total
	•	Ticket médio
	•	Total de vendas
	•	Taxa de crescimento mensal
	•	Faturamento por canal
	•	Faturamento por categoria de produto

🔹 Clientes
	•	Total de clientes
	•	Clientes ativos no período
	•	Faturamento por cliente
	•	Top 10 clientes

🔹 Produtos
	•	Ranking de produtos
	•	Margem total por produto
	•	% margem
	•	Curva ABC

🔹 Pagamentos
	•	Total recebido
	•	Distribuição por forma de pagamento
	•	Ticket médio por forma de pagamento

🔹 Estoque
	•	Quantidade atual
	•	Produtos com baixo estoque
	•	Estoque total por categoria

⸻

🧱 Modelo Estrela (Power BI)

Dimensões:
	•	DIM_Clientes
	•	DIM_Produtos
	•	DIM_Calendário

Fatos:
	•	FATO_Vendas
	•	FATO_Pagamentos

O modelo permite análises rápidas e escaláveis no Power BI.

⸻

📈 Dashboard – Power BI

📌 Páginas incluídas:
	•	Visão Executiva
	•	Vendas
	•	Clientes
	•	Produtos
	•	Pagamentos
	•	Estoque

📌 Contém:
	•	Medidas DAX otimizadas
	•	Gráficos profissionais
	•	Navegação por bookmarks
	•	KPIs de alto impacto

(Adicione prints aqui depois que montar o dashboard.)

⸻

🐍 ETL com Python (Pandas)

Os notebooks demonstram:

✔ Leitura de dados CSV
✔ Tratamento de datas e tipos
✔ Limpeza e padronização
✔ Joins e merges
✔ Cálculo de KPIs
✔ Exportação de dados
✔ Visualização básica (matplotlib)

⸻

🗄 SQL Server – Modelagem e KPIs

Scripts incluem:
	•	Criação do banco
	•	Criação das tabelas
	•	Primary Keys & Foreign Keys
	•	Importação dos dados
	•	Views analíticas
	•	KPIs escritos em SQL



Como executar o projeto

1. Clonar o repositório:

git clone https://github.com/pratt2006/all-in-store-analytics

Executar Script SQL

Rodar na seguinte ordem:
	1.	create-tables.sql
	2.	import-data.sql
	3.	primary-keys.sql
	4.	foreign-keys.sql
	5.	kpis.sql

📍 3. Abrir notebooks Python

Executar em ordem:
	•	01-load-data
	•	02-cleaning
	•	03-joins-kpis

📍 4. Abrir o Power BI
	•	Conectar ao SQL Server
	•	Atualizar tabela calendário
	•	Visualizar o dashboard

⸻

🧑‍💻 Tecnologias Utilizadas
	•	SQL Server
	•	Python 3.x
	•	Pandas
	•	Jupyter Notebook
	•	Power BI
	•	Git & GitHub

⸻

🏁 Status do Projeto

✔ Em construção
✔ Em constante evolução
✔ Parte do portfólio profissional para área de Dados

⸻




🤝 Conecte-se comigo

Se quiser trocar ideias sobre dados ou tecnologia:

🔗 LinkedIn: https://www.linkedin.com/in/vitor-pratt-07833160/



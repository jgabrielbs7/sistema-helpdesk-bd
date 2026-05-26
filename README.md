# 🧑‍💻 Sistema de Help Desk - Banco de Dados

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-000000?style=for-the-badge&logo=database&logoColor=white)
![Status](https://img.shields.io/badge/Status-Concluído-brightgreen?style=for-the-badge)

---

## 📖 Sobre o Projeto

O **Sistema de Help Desk** é um projeto acadêmico focado na modelagem e implementação de um banco de dados relacional para gerenciamento de chamados técnicos.

O sistema permite o controle completo de solicitações de suporte, desde a abertura até o encerramento, garantindo organização, rastreabilidade e eficiência no atendimento.

---

## 🎯 Objetivos

- Centralizar o registro de chamados técnicos  
- Controlar usuários e permissões  
- Organizar chamados por status, categoria e prioridade  
- Gerar relatórios para análise de suporte  
- Aplicar conceitos de modelagem relacional e normalização  

---

## 🧱 Modelagem do Banco de Dados

### 📊 Entidades principais

- Usuário
- Chamado
- Categoria
- Status
- Prioridade

---

## 🔗 Relacionamentos

- Um usuário pode abrir vários chamados  
- Cada chamado pertence a uma categoria  
- Cada chamado possui um status  
- Cada chamado possui uma prioridade  

---

## 🗂️ Estrutura das Tabelas

### 👤 usuario
- id_usuario (PK)  
- nome  
- email  
- senha  
- tipo_usuario  

### 🎫 chamado
- id_chamado (PK)  
- titulo  
- descricao  
- data_abertura  
- id_usuario (FK)  
- id_status (FK)  
- id_categoria (FK)  
- id_prioridade (FK)  

### 📌 status
- id_status (PK)  
- descricao  

### 🗂️ categoria
- id_categoria (PK)  
- descricao  

### ⚡ prioridade
- id_prioridade (PK)  
- descricao  

---

## 📊 Consultas e Relatórios

Exemplos de consultas SQL utilizadas no projeto:

```sql
-- Chamados em aberto
SELECT * FROM chamado
WHERE id_status = 1;

📌 Modelo Entidade-Relacionamento (MER)
<img width="1381" height="1051" alt="RelacionamentoHelpDesk drawio" src="https://github.com/user-attachments/assets/c9a682ed-3825-437e-a5fa-1e647f65d000" />

## 🗂️ Estrutura das Tabelas

### 👤 usuario
```sql
CREATE TABLE Usuario (
	id_usuario INT PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	email VARCHAR(100) UNIQUE,
	senha VARCHAR(100),
	tipo_usuario VARCHAR(100)
);

```sql
CREATE TABLE Tecnico(
	id_tecnico SERIAL PRIMARY KEY,
	especialidade VARCHAR(100) NOT NULL,
	ativo BOOLEAN NOT NULL,
	id_usuario INT NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

```sql
CREATE TABLE Categoria(
	id_categoria SERIAL PRIMARY KEY,
	nome_categoria VARCHAR(100) NOT NULL,
	descricao VARCHAR(500) NOT NULL
);

```sql
CREATE TABLE Chamado(
	id_chamado SERIAL PRIMARY KEY,
	titulo VARCHAR(50) NOT NULL,
	descricao VARCHAR(500) NOT NULL,
	status VARCHAR(50) NOT NULL, 
	prioridade VARCHAR(50) NOT NULL,
	solucao VARCHAR(50) NOT NULL, 
	aberto_em TIMESTAMP NOT NULL,
	encerrado_em TIMESTAMP NOT NULL,
	id_usuario INT NOT NULL,
	id_tecnico INT NOT NULL,
	id_categoria INT NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
	FOREIGN KEY (id_tecnico) REFERENCES Tecnico(id_tecnico),
	FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

```sql
CREATE TABLE Comentario(
	id_comentario SERIAL PRIMARY KEY,
	conteudo VARCHAR(500) NOT NULL,
	criado_em TIMESTAMP NOT NULL,
	id_chamado INT NOT NULL,
	id_usuario INT NOT NULL, 
	FOREIGN KEY (id_chamado) REFERENCES Chamado(id_chamado),
	FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

```sql
CREATE TABLE Historico(
	id_historico SERIAL PRIMARY KEY,
	campo_alt VARCHAR(50)NOT NULL,
	val_anterior VARCHAR(50)NOT NULL,
	val_novo VARCHAR(50)NOT NULL,
	alt_em TIMESTAMP NOT NULL,
	id_chamado INT NOT NULL,
	FOREIGN KEY (id_chamado) REFERENCES Chamado(id_chamado)
);

```sql
CREATE TABLE Relatorio(
	id_relatorio SERIAL PRIMARY KEY,
	tipo VARCHAR(100) NOT NULL,
	periodo DATE NOT NULL,
	gerado_em TIMESTAMP NOT NULL,
	id_chamado INT NOT NULL,
	FOREIGN KEY (id_chamado) REFERENCES Chamado(id_chamado)
);

🛠️ Tecnologias Utilizadas
PostgreSQL
SQL (DDL e DML)
Modelagem MER
Git & GitHub

🚀 Como Executar o Projeto
git clone https://github.com/seu-usuario/sistema-helpdesk.git
Acesse o PostgreSQL
Execute os scripts SQL na ordem:
Criação das tabelas
Inserção de dados
Consultas

📌 Funcionalidades
Cadastro de usuários
Abertura de chamados
Classificação por prioridade e categoria
Atualização de status
Consulta de histórico

📈 Melhorias Futuras
Interface web completa
API REST (Node.js ou Java Spring)
Dashboard com gráficos
Sistema de login com JWT
Notificações automáticas

👨‍💻 Autor

João Gabriel
Projeto acadêmico de Banco de Dados


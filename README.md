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

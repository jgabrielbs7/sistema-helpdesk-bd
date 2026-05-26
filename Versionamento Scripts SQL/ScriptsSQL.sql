--Criação do Banco de Dados

CREATE DATABASE SistemaDeChamados
	ENCODING 'UTF8'
	LC_COLLATE='pt_BR.UTF-8'
	LC_CTYPE='pt_BR.UTF-8';

--Criação de Tabelas

--Usuário
CREATE TABLE Usuario (
	id_usuario INT PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	email VARCHAR(100) UNIQUE,
	senha VARCHAR(100),
	tipo_usuario VARCHAR(100)
);

--Técnico
CREATE TABLE Tecnico(
	id_tecnico SERIAL PRIMARY KEY,
	especialidade VARCHAR(100) NOT NULL,
	ativo BOOLEAN NOT NULL,
	id_usuario INT NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

--Categoria
CREATE TABLE Categoria(
	id_categoria SERIAL PRIMARY KEY,
	nome_categoria VARCHAR(100) NOT NULL,
	descricao VARCHAR(500) NOT NULL
);

--Chamado
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

--Comentario
CREATE TABLE Comentario(
	id_comentario SERIAL PRIMARY KEY,
	conteudo VARCHAR(500) NOT NULL,
	criado_em TIMESTAMP NOT NULL,
	id_chamado INT NOT NULL,
	id_usuario INT NOT NULL, 
	FOREIGN KEY (id_chamado) REFERENCES Chamado(id_chamado),
	FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

--Histórico
CREATE TABLE Historico(
	id_historico SERIAL PRIMARY KEY,
	campo_alt VARCHAR(50)NOT NULL,
	val_anterior VARCHAR(50)NOT NULL,
	val_novo VARCHAR(50)NOT NULL,
	alt_em TIMESTAMP NOT NULL,
	id_chamado INT NOT NULL,
	FOREIGN KEY (id_chamado) REFERENCES Chamado(id_chamado)
);

--Relatório
CREATE TABLE Relatorio(
	id_relatorio SERIAL PRIMARY KEY,
	tipo VARCHAR(100) NOT NULL,
	periodo DATE NOT NULL,
	gerado_em TIMESTAMP NOT NULL,
	id_chamado INT NOT NULL,
	FOREIGN KEY (id_chamado) REFERENCES Chamado(id_chamado)
);


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

--Alteração devido a erros na inserção
ALTER TABLE Chamado
ALTER COLUMN encerrado_em DROP NOT NULL;

-- Alterações devido a erros na inserção
TRUNCATE TABLE Relatorio RESTART IDENTITY CASCADE;
TRUNCATE TABLE Historico RESTART IDENTITY CASCADE;
TRUNCATE TABLE Comentario RESTART IDENTITY CASCADE;
TRUNCATE TABLE Chamado RESTART IDENTITY CASCADE;
TRUNCATE TABLE Tecnico RESTART IDENTITY CASCADE;
TRUNCATE TABLE Categoria RESTART IDENTITY CASCADE;
TRUNCATE TABLE Usuario RESTART IDENTITY CASCADE;

--Inserção Usuario
INSERT INTO Usuario
(id_usuario, nome, email, senha, tipo_usuario)
VALUES
(1,'João Pedro Silva','joao.silva@gmail.com','123456','Usuario'),
(2,'Maria Eduarda Souza','maria.souza@gmail.com','123456','Usuario'),
(3,'Carlos Henrique Lima','carlos.lima@gmail.com','123456','Usuario'),
(4,'Ana Clara Ferreira','ana.ferreira@gmail.com','123456','Usuario'),
(5,'Lucas Gabriel Martins','lucas.martins@gmail.com','123456','Administrador'),
(6,'Fernanda Rocha Alves','fernanda.alves@gmail.com','123456','Usuario'),
(7,'Rafael Gomes Pereira','rafael.gomes@gmail.com','123456','Usuario'),
(8,'Patrícia Oliveira','patricia.oliveira@gmail.com','123456','Administrador'),
(9,'Bruno Henrique Costa','bruno.costa@gmail.com','123456','Usuario'),
(10,'Camila Rodrigues','camila.rodrigues@gmail.com','123456','Usuario'),
(11,'Diego Santos Lima','diego.lima@gmail.com','123456','Usuario'),
(12,'Juliana Freitas Rocha','juliana.rocha@gmail.com','123456','Usuario'),
(13,'Thiago Almeida','thiago.almeida@gmail.com','123456','Usuario'),
(14,'Larissa Mendes','larissa.mendes@gmail.com','123456','Usuario'),
(15,'Gabriel Barbosa','gabriel.barbosa@gmail.com','123456','Administrador'),
(16,'Amanda Ribeiro Costa','amanda.costa@gmail.com','123456','Usuario'),
(17,'Felipe Augusto','felipe.augusto@gmail.com','123456','Usuario'),
(18,'Renata Dias Pereira','renata.pereira@gmail.com','123456','Usuario'),
(19,'Eduardo Henrique','eduardo.henrique@gmail.com','123456','Usuario'),
(20,'Vanessa Cardoso Lima','vanessa.lima@gmail.com','123456','Administrador');

--Inserção Tecnico
INSERT INTO Tecnico
(especialidade, ativo, id_usuario)
VALUES
('Redes', TRUE, 5),
('Hardware', TRUE, 8),
('Software', TRUE, 15),
('Banco de Dados', TRUE, 20),
('Suporte', TRUE, 1),
('Hardware', FALSE, 3),
('Suporte', TRUE, 10);

--Inserção Categoria
INSERT INTO Categoria
(nome_categoria, descricao)
VALUES
('Redes', 'Problemas relacionados à conexão e infraestrutura de rede'),
('Hardware', 'Falhas físicas em computadores e equipamentos'),
('Software', 'Erros em sistemas, programas e aplicações'),
('Banco de Dados', 'Problemas em bancos de dados e consultas SQL'),
('Suporte', 'Atendimento e suporte técnico geral aos usuários');

--Inserção Chamados
INSERT INTO Chamado
(titulo, descricao, status, prioridade, solucao, aberto_em, encerrado_em, id_usuario, id_tecnico, id_categoria)
VALUES
('Internet lenta','Conexão oscilando no escritório','Aberto','Alta','Em análise','2026-05-01 08:00',NULL,1,1,1),
('Computador não liga','Desktop sem energia','Encerrado','Alta','Fonte substituída','2026-05-01 09:00','2026-05-01 10:20',2,2,2),
('Sistema travando','Software fechando sozinho','Em andamento','Média','Atualização em andamento','2026-05-01 10:00',NULL,3,3,3),
('Erro SQL','Banco não conecta','Aberto','Alta','Verificando serviço','2026-05-01 11:00',NULL,4,4,4),
('Usuário sem acesso','Erro de login no sistema','Encerrado','Baixa','Senha redefinida','2026-05-01 12:00','2026-05-01 12:30',5,5,5),

('Wi-Fi desconectando','Conexão cai frequentemente','Aberto','Média','Em análise','2026-05-02 08:00',NULL,6,1,1),
('Monitor apagado','Tela não apresenta imagem','Encerrado','Média','Cabo HDMI trocado','2026-05-02 09:00','2026-05-02 09:40',7,2,2),
('Erro no ERP','Sistema financeiro lento','Em andamento','Alta','Atualizando sistema','2026-05-02 10:00',NULL,8,3,3),
('PostgreSQL não inicia','Erro ao iniciar serviço','Aberto','Alta','Analisando logs','2026-05-02 11:00',NULL,9,4,4),
('Instalação Office','Usuário sem pacote office','Encerrado','Baixa','Office instalado','2026-05-02 12:00','2026-05-02 12:40',10,5,5),

('Rede sem internet','Switch sem comunicação','Aberto','Alta','Reiniciando equipamento','2026-05-03 08:00',NULL,11,1,1),
('Teclado não funciona','USB sem resposta','Encerrado','Baixa','Teclado substituído','2026-05-03 09:00','2026-05-03 09:25',12,2,2),
('Erro no navegador','Sistema não carrega páginas','Em andamento','Média','Limpando cache','2026-05-03 10:00',NULL,13,3,3),
('Consulta lenta','Banco demorando responder','Aberto','Alta','Otimizando query','2026-05-03 11:00',NULL,14,4,4),
('Dúvida sistema','Usuário precisa de orientação','Encerrado','Baixa','Treinamento realizado','2026-05-03 12:00','2026-05-03 12:20',15,5,5),

('Internet indisponível','Sem acesso externo','Aberto','Alta','Verificando roteador','2026-05-04 08:00',NULL,16,1,1),
('Notebook superaquecendo','Equipamento muito quente','Em andamento','Média','Limpeza interna','2026-05-04 09:00',NULL,17,2,2),
('Erro atualização','Sistema não atualiza','Aberto','Média','Download corrigido','2026-05-04 10:00',NULL,18,3,3),
('Backup falhando','Banco não realiza backup','Encerrado','Alta','Backup restaurado','2026-05-04 11:00','2026-05-04 12:00',19,4,4),
('Usuário sem permissão','Acesso bloqueado','Encerrado','Baixa','Permissão liberada','2026-05-04 12:00','2026-05-04 12:15',20,5,5),

('Rede lenta','Latência alta na rede','Em andamento','Média','Monitorando tráfego','2026-05-05 08:00',NULL,1,1,1),
('Computador reiniciando','Desktop reinicia sozinho','Aberto','Alta','Verificando memória','2026-05-05 09:00',NULL,2,2,2),
('Sistema fecha sozinho','Aplicação encerrando','Em andamento','Média','Atualização pendente','2026-05-05 10:00',NULL,3,3,3),
('Erro conexão banco','Aplicação sem acesso SQL','Aberto','Alta','Reiniciando serviço','2026-05-05 11:00',NULL,4,4,4),
('Suporte impressora','Usuário sem impressão','Encerrado','Baixa','Fila reiniciada','2026-05-05 12:00','2026-05-05 12:20',5,5,5),

('Cabo de rede rompido','Sem conexão física','Encerrado','Média','Cabo trocado','2026-05-06 08:00','2026-05-06 08:50',6,1,1),
('Mouse não funciona','Sem resposta no cursor','Encerrado','Baixa','Mouse substituído','2026-05-06 09:00','2026-05-06 09:15',7,2,2),
('Erro aplicativo','Falha ao abrir sistema','Aberto','Média','Reinstalação pendente','2026-05-06 10:00',NULL,8,3,3),
('Banco corrompido','Tabela apresentando falha','Em andamento','Alta','Restaurando backup','2026-05-06 11:00',NULL,9,4,4),
('Ajuda cadastro','Usuário com dúvidas','Encerrado','Baixa','Suporte realizado','2026-05-06 12:00','2026-05-06 12:10',10,5,5);

--Inserção Comentário
INSERT INTO Comentario
(conteudo, criado_em, id_chamado, id_usuario)
VALUES
('Chamado recebido pela equipe técnica','2026-05-01 08:10',1,1),
('Fonte do computador substituída','2026-05-01 09:40',2,2),
('Atualização do sistema iniciada','2026-05-01 10:30',3,3),
('Serviço PostgreSQL em análise','2026-05-01 11:20',4,4),
('Senha redefinida com sucesso','2026-05-01 12:15',5,5),

('Roteador reiniciado para testes','2026-05-02 08:20',6,6),
('Cabo HDMI substituído','2026-05-02 09:20',7,7),
('Equipe verificando lentidão do ERP','2026-05-02 10:25',8,8),
('Logs do PostgreSQL coletados','2026-05-02 11:15',9,9),
('Pacote Office instalado corretamente','2026-05-02 12:20',10,10),

('Switch reiniciado','2026-05-03 08:15',11,11),
('Novo teclado instalado','2026-05-03 09:10',12,12),
('Cache do navegador limpo','2026-05-03 10:20',13,13),
('Consulta SQL otimizada','2026-05-03 11:30',14,14),
('Usuário orientado sobre utilização','2026-05-03 12:10',15,15),

('Verificando estabilidade da internet','2026-05-04 08:20',16,16),
('Equipamento passou por limpeza interna','2026-05-04 09:30',17,17),
('Atualização do software corrigida','2026-05-04 10:25',18,18),
('Backup restaurado com sucesso','2026-05-04 11:40',19,19),
('Permissão de acesso liberada','2026-05-04 12:10',20,20),

('Monitoramento de tráfego iniciado','2026-05-05 08:15',21,1),
('Memória RAM sendo analisada','2026-05-05 09:20',22,2),
('Sistema será atualizado hoje','2026-05-05 10:15',23,3),
('Serviço SQL reiniciado','2026-05-05 11:20',24,4),
('Fila de impressão normalizada','2026-05-05 12:05',25,5),

('Cabeamento substituído','2026-05-06 08:30',26,6),
('Mouse trocado por novo equipamento','2026-05-06 09:05',27,7),
('Aplicação será reinstalada','2026-05-06 10:20',28,8),
('Backup antigo restaurado','2026-05-06 11:35',29,9),
('Usuário orientado via suporte','2026-05-06 12:05',30,10);

--Inserção Histórico
INSERT INTO Historico
(campo_alt, val_anterior, val_novo, alt_em, id_chamado)
VALUES
('status','Aberto','Em andamento','2026-05-01 08:30',1),
('status','Em andamento','Encerrado','2026-05-01 10:10',2),
('prioridade','Baixa','Média','2026-05-01 10:40',3),
('status','Aberto','Em andamento','2026-05-01 11:30',4),
('status','Aberto','Encerrado','2026-05-01 12:20',5),

('status','Aberto','Em andamento','2026-05-02 08:25',6),
('status','Em andamento','Encerrado','2026-05-02 09:35',7),
('prioridade','Média','Alta','2026-05-02 10:35',8),
('status','Aberto','Em andamento','2026-05-02 11:25',9),
('status','Aberto','Encerrado','2026-05-02 12:35',10),

('status','Aberto','Em andamento','2026-05-03 08:20',11),
('status','Em andamento','Encerrado','2026-05-03 09:20',12),
('prioridade','Baixa','Média','2026-05-03 10:30',13),
('status','Aberto','Em andamento','2026-05-03 11:35',14),
('status','Aberto','Encerrado','2026-05-03 12:15',15),

('status','Aberto','Em andamento','2026-05-04 08:30',16),
('prioridade','Média','Alta','2026-05-04 09:35',17),
('status','Aberto','Em andamento','2026-05-04 10:30',18),
('status','Em andamento','Encerrado','2026-05-04 11:50',19),
('status','Aberto','Encerrado','2026-05-04 12:12',20),

('status','Aberto','Em andamento','2026-05-05 08:20',21),
('prioridade','Média','Alta','2026-05-05 09:30',22),
('status','Aberto','Em andamento','2026-05-05 10:25',23),
('status','Aberto','Em andamento','2026-05-05 11:35',24),
('status','Aberto','Encerrado','2026-05-05 12:10',25),

('status','Em andamento','Encerrado','2026-05-06 08:45',26),
('status','Aberto','Encerrado','2026-05-06 09:10',27),
('prioridade','Baixa','Média','2026-05-06 10:30',28),
('status','Aberto','Em andamento','2026-05-06 11:40',29),
('status','Aberto','Encerrado','2026-05-06 12:08',30);

-- Correção da Tabela para manter o sentido do sistema
ALTER TABLE Relatorio
DROP CONSTRAINT relatorio_id_chamado_fkey;

ALTER TABLE Relatorio
DROP COLUMN id_chamado;

ALTER TABLE Relatorio
ALTER COLUMN periodo TYPE VARCHAR(20);

-- Inserção Relátorio
INSERT INTO Relatorio
(tipo, periodo, gerado_em)
VALUES
('Chamados abertos','Março/2026','2026-03-31 18:00'),
('Chamados encerrados','Março/2026','2026-03-31 18:10'),
('Chamados por categoria','Março/2026','2026-03-31 18:20'),
('Chamados por prioridade','Março/2026','2026-03-31 18:30'),
('Chamados por técnico','Março/2026','2026-03-31 18:40'),

('Chamados abertos','Abril/2026','2026-04-30 18:00'),
('Chamados encerrados','Abril/2026','2026-04-30 18:10'),
('Chamados por categoria','Abril/2026','2026-04-30 18:20'),
('Chamados por prioridade','Abril/2026','2026-04-30 18:30'),
('Chamados por técnico','Abril/2026','2026-04-30 18:40'),

('Chamados abertos','Maio/2026','2026-05-31 18:00'),
('Chamados encerrados','Maio/2026','2026-05-31 18:10'),
('Chamados por categoria','Maio/2026','2026-05-31 18:20'),
('Chamados por prioridade','Maio/2026','2026-05-31 18:30'),
('Chamados por técnico','Maio/2026','2026-05-31 18:40');

-- Selects para mostrar as tabelas
SELECT * FROM Categoria;
SELECT * FROM Chamado;
SELECT * FROM Comentario;
SELECT * FROM Historico;
SELECT * FROM Relatorio;
SELECT * FROM Tecnico;
SELECT * FROM Usuario;

--INNER JOIN'S para verificar tabelas

--Listar chamados com o nome do usuario e a categoria
SELECT
	c.id_chamado,
	c.titulo,
	c.status,
	u.nome AS usuario,
	cat.nome_categoria
FROM chamado c
INNER JOIN usuario u
	ON c.id_usuario = u.id_usuario
INNER JOIN categoria cat
	ON  c.id_categoria = cat.id_categoria;

--Listar chamados e técnicos responsáveis
SELECT
	c.id_chamado,
	c.titulo,
	t.id_tecnico AS tecnico,
	c.status
FROM chamado c
INNER JOIN tecnico t
	ON c.id_tecnico = t.id_tecnico;

--Consultar com WHERE

--Chamados em Aberto
SELECT *
FROM chamado
WHERE status = 'Aberto';

--Chamados de alta prioridade

SELECT 
	id_chamado,
	titulo,
	prioridade
FROM chamado
WHERE prioridade = 'Alta';

--Função Agregada - Quantidade Total de chamados

SELECT COUNT(*) AS total_chamados
FROM chamado;

--Chamados por status
SELECT 
	status,
	COUNT(*) AS quantidade
FROM chamado
GROUP BY status;

--Chamados por técnico
SELECT 
	t.id_tecnico AS tecnico,
	COUNT(c.id_chamado) AS total_atendimento
FROM tecnico t
LEFT JOIN chamado c
	ON t.id_tecnico = c.id_tecnico
GROUP BY t.id_tecnico

--Chamados por Categoria
SELECT
	cat.nome_categoria,
	COUNT(c.id_chamado) AS quantidade
FROM categoria cat
LEFT JOIN chamado c
	ON cat.id_categoria = c.id_categoria
GROUP BY cat.nome_categoria
ORDER BY quantidade DESC;

--COMMIT 

--Encerramento de um Chamado

START TRANSACTION;

UPDATE Chamado
SET status = 'Encerrado',
    encerrado_em = CURRENT_TIMESTAMP,
    solucao = 'Problema resolvido pelo suporte'
WHERE id_chamado = 1;

COMMIT;

--Verificação dos dados
SELECT
    id_chamado,
    status,
    encerrado_em,
    solucao
FROM Chamado
WHERE id_chamado = 1;

--ROLLBACK

--Cancelamento da operação
START TRANSACTION;

UPDATE Chamado
SET status = 'Encerrado',
    encerrado_em = CURRENT_TIMESTAMP
WHERE id_chamado = 4;

ROLLBACK;

--Verificação dos dados
SELECT
    id_chamado,
    status,
    encerrado_em
FROM Chamado
WHERE id_chamado = 4;

--Simulação de cenário real de negócio - Atribuição de técnico a um chamado aberto

START TRANSACTION;

UPDATE Chamado
SET id_tecnico = 3
WHERE id_chamado = 6;

UPDATE Chamado
SET status = 'Em andamento'
WHERE id_chamado = 6;

COMMIT;

--Verificação dos dados
SELECT
    id_chamado,
    id_tecnico,
    status
FROM Chamado
WHERE id_chamado = 6;

--Registro no Histórico durante alterações
START TRANSACTION;

UPDATE Chamado
SET status = 'Em andamento'
WHERE id_chamado = 11;

INSERT INTO Historico
(campo_alt, val_anterior, val_novo, alt_em, id_chamado)
VALUES
('status', 'Aberto', 'Em andamento', CURRENT_TIMESTAMP, 11);

COMMIT;

--Simulação com ROLLBACK no Histórico
START TRANSACTION;

UPDATE Chamado
SET status = 'Em andamento'
WHERE id_chamado = 16;

INSERT INTO Historico
(campo_alt, val_anterior, val_novo, alt_em, id_chamado)
VALUES
('status', 'Aberto', 'Em andamento', CURRENT_TIMESTAMP, 999);

ROLLBACK;


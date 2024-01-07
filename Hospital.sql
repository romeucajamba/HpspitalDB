-- Criação do banco de dados
-- CREATE DATABASE Hospital;

-- Uso do banco de dados
USE Hospital;

-- Criação da tabela Pacientes
CREATE TABLE Pacientes (
  ID_Paciente INT PRIMARY KEY,
  Nome VARCHAR(100),
  Data_Nascimento DATE,
  Genero CHAR(1),
  Endereco VARCHAR(200),
  Numero_Telefone VARCHAR(20)
);

-- Inserção de registros na tabela Pacientes
INSERT INTO Pacientes (ID_Paciente, Nome, Data_Nascimento, Genero, Endereco, Numero_Telefone)
VALUES
  (1, 'João', '1980-05-12', 'M', 'Rua A, nº 123', '123456789'),
  (2, 'Maria', '1992-10-20', 'F', 'Rua B, nº 456', '987654321'),
  (3, 'José', '1975-03-08', 'M', 'Rua C, nº 789', '456123789');

-- Criação da tabela Médicos
CREATE TABLE Medicos (
  ID_Medico INT PRIMARY KEY,
  Nome VARCHAR(100),
  Especialidade VARCHAR(100),
  Numero_Telefone VARCHAR(20)
);

-- Inserção de registros na tabela Médicos
INSERT INTO Medicos (ID_Medico, Nome, Especialidade, Numero_Telefone)
VALUES
  (1, 'Dr. Silva', 'Cardiologia', '123456789'),
  (2, 'Dra. Santos', 'Pediatria', '987654321'),
  (3, 'Dr. Souza', 'Ortopedia', '456123789');

-- Criação da tabela Consultas
CREATE TABLE Consultas (
  ID_Consulta INT PRIMARY KEY,
  ID_Paciente INT,
  ID_Medico INT,
  Data_Consulta DATE,
  Descricao VARCHAR(200),
  FOREIGN KEY (ID_Paciente) REFERENCES Pacientes(ID_Paciente),
  FOREIGN KEY (ID_Medico) REFERENCES Medicos(ID_Medico)
);

-- Inserção de registros na tabela Consultas
INSERT INTO Consultas (ID_Consulta, ID_Paciente, ID_Medico, Data_Consulta, Descricao)
VALUES
  (1, 1, 1, '2023-01-15', 'Consulta de rotina'),
  (2, 1, 2, '2023-02-02', 'Consulta pediátrica'),
  (3, 2, 3, '2023-03-10', 'Consulta ortopédica');

-- Criação da view Consultas_Pacientes_Medicos
CREATE VIEW Consultas_Pacientes_Medicos AS
SELECT c.ID_Consulta, p.Nome AS Nome_Paciente, m.Nome AS Nome_Medico, c.Data_Consulta, c.Descricao
FROM Consultas c
INNER JOIN Pacientes p ON c.ID_Paciente = p.ID_Paciente
INNER JOIN Medicos m ON c.ID_Medico = m.ID_Medico;

-- Criação de um índice na coluna Nome da tabela Pacientes
CREATE INDEX idx_Pacientes_Nome ON Pacientes (Nome);

-- Exemplo de transação
BEGIN TRANSACTION;

-- Consulta
SELECT Nome, Especialidade
FROM Medicos
WHERE Especialidade = 'Cardiologia';

-- Atualização
UPDATE Pacientes
SET Numero_Telefone = '987654321'
WHERE ID_Paciente = 1;

COMMIT;
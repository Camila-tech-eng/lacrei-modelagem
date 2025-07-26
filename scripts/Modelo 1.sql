-- === Criação do Enum para tipos de plano ===
CREATE TYPE tipo_plano AS ENUM ('Básico', 'Intermediário', 'Premium');

-- === Tabela profissional ===
CREATE TABLE profissional (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- === Tabela plano ===
CREATE TABLE plano (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo tipo_plano NOT NULL,
    operadora VARCHAR(100),
    cobertura JSONB,
    UNIQUE (nome, operadora)
);

-- === Tabela associativa profissional_plano ===
CREATE TABLE profissional_plano (
    profissional_id INT NOT NULL,
    plano_id INT NOT NULL,
    data_aceite TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (profissional_id, plano_id),
    FOREIGN KEY (profissional_id) REFERENCES profissional(id) ON DELETE CASCADE,
    FOREIGN KEY (plano_id) REFERENCES plano(id) ON DELETE CASCADE
);

-- === Índices para performance ===
CREATE INDEX idx_plano_nome ON plano (nome);
CREATE INDEX idx_profissional_email ON profissional (email);

-- === Inserção de dados exemplo na tabela profissional ===
INSERT INTO profissional (nome, cpf, email, telefone) VALUES
('Ana Silva', '12345678901', 'ana.silva@email.com', '11999999999'),
('Carlos Souza', '23456789012', 'carlos.souza@email.com', '11988888888'),
('Mariana Costa', '34567890123', 'mariana.costa@email.com', '11977777777');

-- === Inserção de dados exemplo na tabela plano ===
INSERT INTO plano (nome, tipo, operadora, cobertura) VALUES
('Plano Saúde Básico', 'Básico', 'Operadora A', '{"consultas": true, "exames": false}'),
('Plano Saúde Premium', 'Premium', 'Operadora B', '{"consultas": true, "exames": true, "internação": true}'),
('Plano Saúde Intermediário', 'Intermediário', 'Operadora C', '{"consultas": true, "exames": true}');

-- === Associação dos profissionais com os planos aceitos ===
INSERT INTO profissional_plano (profissional_id, plano_id) VALUES
(1, 1),
(1, 3),
(2, 2),
(3, 1),
(3, 2);

-- 1. Enum para tipo do plano
CREATE TYPE tipo_plano AS ENUM ('Básico', 'Intermediário', 'Premium');

-- 2. Enum para meio de atendimento
CREATE TYPE meio_atendimento AS ENUM ('Online', 'Presencial', 'Ambos');

-- 3. Tabela de especialidades
CREATE TABLE especialidade (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) UNIQUE NOT NULL
);

-- 4. Catálogo de planos (opcional)
CREATE TABLE plano (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo tipo_plano NOT NULL,
    operadora VARCHAR(100),
    UNIQUE (nome, operadora)
);

-- 5. Tabela profissional (com JSONB e referências)
CREATE TABLE profissional (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    meio_atendimento meio_atendimento NOT NULL, -- online, presencial ou ambos
    especialidade_id INT REFERENCES especialidade(id) ON DELETE SET NULL,
    planos_aceitos JSONB, -- lista de planos aceitos
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 6. Índices
CREATE INDEX idx_profissional_email ON profissional (email);
CREATE INDEX idx_planos_aceitos_gin ON profissional USING gin (planos_aceitos jsonb_path_ops);

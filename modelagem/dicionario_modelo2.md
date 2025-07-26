# 📘 Dicionário de Dados – Proposta 2 (Modelo Híbrido com JSONB)

> Este modelo combina tabelas normalizadas com campo `jsonb`, trazendo flexibilidade e agilidade na leitura de dados menos estruturados.

---

## 📌 Tabela: `especialidade`

| Campo        | Tipo         | Restrições                    | Descrição                                 |
|--------------|--------------|-------------------------------|--------------------------------------------|
| id           | SERIAL       | PK                            | Identificador único da especialidade       |
| nome         | VARCHAR(100) | NOT NULL, UNIQUE              | Nome da especialidade médica               |

---

## 📌 Enum: `meio_atendimento`

| Valor       | Descrição                              |
|-------------|----------------------------------------|
| Online      | Atende exclusivamente online           |
| Presencial  | Atende exclusivamente presencial       |
| Ambos       | Atende em ambas as modalidades         |

---

## 📌 Enum: `tipo_plano`

| Valor         | Descrição                              |
|---------------|----------------------------------------|
| Básico        | Plano com cobertura mínima             |
| Intermediário | Cobertura intermediária                |
| Premium       | Maior cobertura e benefícios           |

---

## 📌 Tabela: `plano` (catálogo opcional)

| Campo        | Tipo           | Restrições               | Descrição                                      |
|--------------|----------------|--------------------------|------------------------------------------------|
| id           | SERIAL         | PK                       | Identificador do plano                         |
| nome         | VARCHAR(100)   | NOT NULL                 | Nome do plano                                  |
| tipo         | tipo_plano     | NOT NULL                 | Tipo do plano                                  |
| operadora    | VARCHAR(100)   |                          | Nome da operadora                              |
| UNIQUE       | (nome, operadora)                        | Evita duplicidade de planos na mesma operadora |

---

## 📌 Tabela: `profissional`

| Campo             | Tipo              | Restrições                          | Descrição                                               |
|-------------------|-------------------|-------------------------------------|----------------------------------------------------------|
| id                | SERIAL            | PK                                  | Identificador do profissional                           |
| nome              | VARCHAR(100)      | NOT NULL                            | Nome completo                                           |
| cpf               | CHAR(11)          | NOT NULL, UNIQUE                    | CPF do profissional                                     |
| email             | VARCHAR(100)      | NOT NULL, UNIQUE                    | E-mail de contato                                       |
| telefone          | VARCHAR(20)       |                                     | Telefone de contato                                     |
| meio_atendimento  | meio_atendimento  | NOT NULL                            | Modalidade de atendimento (Online, Presencial, Ambos)   |
| especialidade_id  | INT               | FK → especialidade(id)              | Especialidade do profissional                           |
| planos_aceitos    | JSONB             |                                     | Lista de planos aceitos (nome, tipo, operadora etc.)    |
| data_cadastro     | TIMESTAMP         | DEFAULT CURRENT_TIMESTAMP           | Data de criação do registro                             |

---

## 🔍 Índices

- `idx_profissional_email` → índice simples para busca por e-mail
- `idx_planos_aceitos_gin` → índice GIN para acelerar buscas em campos `jsonb`

---

]


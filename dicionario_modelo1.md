# 📘 Dicionário de Dados – Modelo 1 (Relacional Clássico)


## 🔹 Tabela: `profissional`

| Campo         | Tipo         | Descrição                             | Restrições                         | Observações                       |
|---------------|--------------|---------------------------------------|------------------------------------|----------------------------------|
| id            | SERIAL       | Identificador único do profissional   | PK, NOT NULL                       | Auto-incremento                  |
| nome          | VARCHAR(100) | Nome completo                         | NOT NULL                           | —                                |
| cpf           | CHAR(11)     | CPF do profissional                   | UNIQUE, NOT NULL                   | Proteção LGPD recomendada        |
| email         | VARCHAR(100) | E-mail de contato                     | UNIQUE, NOT NULL                   | —                                |
| telefone      | VARCHAR(20)  | Telefone de contato                   | —                                  | Pode conter DDD e WhatsApp       |
| data_cadastro | TIMESTAMP    | Data de cadastro no sistema           | DEFAULT CURRENT_TIMESTAMP          | —                                |

---

## 🔹 Tabela: `plano`

| Campo      | Tipo           | Descrição                              | Restrições                        | Observações                              |
|------------|----------------|----------------------------------------|-----------------------------------|-------------------------------------------|
| id         | SERIAL         | Identificador único do plano           | PK, NOT NULL                      | Auto-incremento                           |
| nome       | VARCHAR(100)   | Nome do plano                          | NOT NULL                          | Ex: "Plano Saúde Premium"                |
| tipo       | tipo_plano     | Tipo do plano (enum)                   | NOT NULL                          | ENUM: ‘Básico’, ‘Intermediário’, ‘Premium’ |
| operadora  | VARCHAR(100)   | Nome da operadora de saúde             | —                                 | Ex: "Unimed", "Amil", etc.                |
| cobertura  | JSONB          | Informações detalhadas da cobertura    | —                                 | Ex: exames, consultas, internação         |

> 🔹 Índice em: `nome`, UNIQUE em `(nome, operadora)`

---

## 🔹 Tabela: `profissional_plano` (associativa N:N)

| Campo           | Tipo      | Descrição                                      | Restrições                                      | Observações                     |
|------------------|-----------|------------------------------------------------|-------------------------------------------------|--------------------------------|
| profissional_id  | INT       | Referência ao profissional                    | PK (com plano_id), FK → profissional(id)        | Relacionamento N:N             |
| plano_id         | INT       | Referência ao plano aceito                   | PK (com profissional_id), FK → plano(id)        | Relacionamento N:N             |
| data_aceite      | TIMESTAMP | Data em que o plano foi aceito pelo profissional | DEFAULT CURRENT_TIMESTAMP                        | Informativo, pode ser usado para histórico |

---

## 🔹 Tipo Enumerado: `tipo_plano`

| Valor           | Descrição                         |
|------------------|----------------------------------|
| 'Básico'         | Cobertura básica                 |
| 'Intermediário'  | Cobertura intermediária          |
| 'Premium'        | Cobertura completa               |

---

✅ Observações Gerais:
- Os dados sensíveis como CPF devem seguir boas práticas de segurança e LGPD.
- O campo `cobertura` usa `jsonb` por ser um conteúdo variável e semi-estruturado, facilitando extensões futuras sem alterar o esquema relacional.

      |

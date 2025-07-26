# Desafio Técnico – Modelagem de Dados (Plano de Saúde) - Lacrei Saúde

## Sobre o Projeto

Este repositório apresenta a proposta de modelagem de dados para representar os **planos de saúde aceitos por profissionais cadastrados** na plataforma Lacrei Saúde, levando em consideração:

- Segurança e integridade dos dados
- Eficiência em consultas
- Flexibilidade para expansão futura
- Conformidade com a LGPD
- Boas práticas de normalização

---

## Justificativa Técnica das Decisões

A modelagem foi feita pensando em escalabilidade e facilidade de manutenção. Por isso, foram consideradas:

- Estrutura relacional tradicional com normalização para garantir integridade e clareza.
- Abordagem alternativa com uso de **enum** e **campos jsonb** em situações que demandam mais flexibilidade e baixo acoplamento.
- Separação clara de entidades (profissionais, planos, especialidades, formas de atendimento) para permitir reuso, evitar redundâncias e facilitar consultas analíticas.

---

## Explicação das Duas Abordagens

###  Proposta 1 – Modelo Relacional Clássico

**Descrição:**
- Utiliza tabelas normalizadas para representar os profissionais, planos e relacionamentos.
- Tabela intermediária `profissional_plano` representa a associação N:N entre profissionais e planos.

**Vantagens:**
- Alta integridade referencial
- Consultas otimizadas com uso de índices
- Estrutura clara e robusta
- Simples de manter e escalar

**Desvantagens:**
- Pouca flexibilidade para armazenar dados semi-estruturados
- Requer mais tabelas e joins, o que pode impactar performance em bancos com grande volume de dados

**Quando usar:**
> Quando há necessidade de forte integridade e consistência, com regras de dados bem definidas.

---

### Proposta 2 – Modelo com Enum, JSONB e Expansões

**Descrição:**
- Uso de `enum` para o tipo de atendimento (online/presencial)
- Armazenamento de atributos complementares via `jsonb` no cadastro de planos
- Inclusão de **especialidade médica** e relacionamento com o profissional

**Vantagens:**
- Maior flexibilidade para armazenar dados variáveis
- Menor número de tabelas para atributos opcionais
- Melhor adaptação a mudanças futuras

**Desvantagens:**
- Dificuldade de aplicar integridade relacional em campos jsonb
- Consultas podem ser mais custosas
- Validação de estrutura e dados depende da aplicação

**Quando usar:**
> Em cenários com campos muito dinâmicos, dados pouco estruturados ou quando o schema pode mudar frequentemente.

---

## uso de `jsonb`

### Quando usar `jsonb`:

- Quando o schema dos dados é instável ou varia entre registros
- Para armazenar metadados, configurações ou atributos raramente consultados
- Quando a leitura de documentos completos é mais importante que filtros por campo

### ⚠️ Quando evitar `jsonb`:

- Quando os dados precisam ser validados com chaves estrangeiras
- Quando se realizam muitas buscas ou filtros por atributos internos do JSON
- Quando a performance de leitura e escrita estruturada é crítica

---




# COBOL DB2 Refatorado

> Projeto de refatoração e otimização de código COBOL com integração ao DB2, demonstrando boas práticas de desenvolvimento em ambiente mainframe.

---

## Sobre o Projeto

Este projeto tem como objetivo demonstrar a aplicação de boas práticas no desenvolvimento de aplicações COBOL para mainframe, com foco em modularização, organização e manutenibilidade do código. O sistema implementa operações CRUD (Create, Read, Update, Delete) para gerenciamento de funcionários, utilizando DB2 como banco de dados.

O projeto foi desenvolvido como parte do meu aprendizado em tecnologias mainframe e reflete conceitos modernos de engenharia de software aplicados a ambientes legados.

---

## Objetivo

Demonstrar habilidades em:
- Desenvolvimento COBOL estruturado e modular
- Integração com banco de dados DB2
- Configuração e execução de JCLs
- Aplicação de boas práticas em ambiente mainframe
- Organização de código para facilitar manutenção

---

## Tecnologias Utilizadas

- **COBOL**: Linguagem principal para lógica de negócio
- **DB2**: Sistema de gerenciamento de banco de dados relacional
- **JCL (Job Control Language)**: Automação de compilação e execução
- **SQL Embarcado**: Integração entre COBOL e DB2

---

## Estrutura de Diretórios

```
cobol-db2-refatorado/
│
├── COBLIB/          # Código-fonte dos programas COBOL
│   ├── PROGMAIN.cob     # Programa principal (coordenador)
│   ├── INCLUIR.cob      # Módulo de inclusão de funcionários
│   ├── ALTERAR.cob      # Módulo de alteração de funcionários
│   ├── EXCLUIR.cob      # Módulo de exclusão de funcionários
│   ├── ALT*.cob         # Subprogramas para alterações específicas
│   └── CONT*.cob        # Utilitários para cálculo de tamanho de strings
│
├── COPYLIB/         # Estruturas de dados reutilizáveis
│   ├── CPYACEP.cpy      # Layout de entrada de dados
│   ├── SQLVARS.cpy      # Variáveis de controle SQL
│   └── SQLTREAT.cpy     # Rotina de tratamento de SQLCODE
│
└── JOBLIB/          # Scripts JCL para compilação e execução
    ├── COMPDB2.jcl      # Compilação de programas com DB2
    ├── COMPSUB.jcl      # Compilação de subprogramas
    ├── EXECDB2.jcl      # Execução do sistema
    └── PARBIND.jcl      # Parâmetros de BIND do DB2
```

---

## Como Executar

### Pré-requisitos

- Acesso a ambiente mainframe z/OS
- Biblioteca DB2 configurada
- Permissões para compilação e execução de programas COBOL
- Base de dados `FUNCIONARIOS` criada no DB2

### Passo 1: Compilar o Programa Principal

```jcl
// Execute o JCL: COMPDB2.jcl
// Este job realiza:
//   - Pré-compilação DB2
//   - Compilação COBOL
//   - Link-edição
//   - BIND do package
```

### Passo 2: Compilar Subprogramas

```jcl
// Execute o JCL: COMPSUB.jcl
// Ajuste a variável MOD para cada subprograma:
//   - CONTNOME, CONTMAIL
//   - INCLUIR, ALTERAR, EXCLUIR
//   - ALTNOME, ALTSALAR, ALTDEPTO, etc.
```

### Passo 3: Executar o Sistema

```jcl
// Execute o JCL: EXECDB2.jcl
// Configure os parâmetros de entrada no SYSIN
```

### Formato de Entrada (SYSIN)

```
Função (1 char) | Código | Nome | Salário | Depto | Admissão | Idade
I = Incluir
A = Alterar
E = Excluir

Exemplo de inclusão:
IA001JOAO DA SILVA              01234567ABC01/01/202525
JOAO@EMAIL.COM.BR
```

---

## Boas Práticas Aplicadas

### 1. Modularização
- Cada funcionalidade isolada em um módulo específico
- Reutilização de código através de subprogramas CALL
- Separação clara entre coordenação (PROGMAIN) e execução (módulos)

### 2. Organização por Biblioteca
- **COBLIB**: Código executável
- **COPYLIB**: Estruturas de dados e rotinas compartilhadas
- **JOBLIB**: Automação de processos

### 3. Tratamento de Erros
- Centralização do tratamento de SQLCODE no COPY SQLTREAT
- Validação de integridade referencial (foreign keys)
- Mensagens descritivas para cada tipo de erro

### 4. Otimização
- Uso de VARCHAR para campos de tamanho variável
- Subprogramas utilitários para cálculo de comprimento de strings
- Transações SQL com COMMIT/ROLLBACK apropriados

### 5. Manutenibilidade
- Código comentado e autoexplicativo
- Nomenclatura padronizada
- Estrutura de fácil extensão para novas funcionalidades

---

## Funcionalidades

- ✅ **Inclusão** de funcionários com validação de departamento
- ✅ **Alteração** de dados específicos (nome, salário, departamento, idade, email, admissão)
- ✅ **Exclusão** de funcionários
- ✅ **Tratamento de erros** SQL completo
- ✅ **Validação** de integridade referencial

---

## Licença

Este projeto está licenciado sob a **Apache License 2.0**. Consulte o arquivo `LICENSE` para mais detalhes.

---

## Autor

**Thiago Souza**

Este projeto foi desenvolvido como parte do meu portfólio de aprendizado em tecnologias mainframe. Estou em constante evolução e aberto a feedbacks e sugestões para melhorias.

 Entre em contato para dúvidas ou colaborações
 [GitHub](https://github.com/thisouza01/cobol-db2-refatorado)

---

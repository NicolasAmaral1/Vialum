# Vialum

API REST profissional desenvolvida com Symfony 7.2, PostgreSQL e Docker.

## 🏗️ Arquitetura

**3 Containers Docker separados:**

- **nginx**: Servidor web (porta 80)
- **php-fpm**: API Symfony (porta 9000 interna)
- **postgresql**: Banco de dados (porta 5432)

## 🚀 Início Rápido

### Primeira vez

```bash
# Inicializar projeto (build + install + create database)
./scripts/init.sh
```

### Próximas vezes

```bash
# Iniciar containers
./scripts/start.sh

# Parar containers
./scripts/stop.sh
```

## 📁 Estrutura do Projeto

```
Vialum/
├── docker/                    # Configurações Docker
│   ├── nginx/
│   │   └── default.conf       # Config Nginx
│   └── php/
│       └── Dockerfile         # Imagem PHP customizada
├── scripts/                   # Scripts auxiliares
│   ├── init.sh                # Inicialização completa
│   ├── start.sh               # Inicia containers
│   └── stop.sh                # Para containers
├── src/
│   ├── Controller/            # Controllers da API
│   ├── Entity/                # Entidades Doctrine
│   ├── Repository/            # Repositories Doctrine
│   └── Kernel.php
├── config/                    # Configurações Symfony
├── public/
│   └── index.php              # Entry point
├── var/                       # Cache e logs (gitignored)
├── vendor/                    # Dependências (gitignored)
├── .env                       # Variáveis de ambiente
├── composer.json
└── docker-compose.yml         # Orquestração Docker
```

## 📋 Comandos Úteis

### Docker

```bash
# Ver logs
docker compose logs -f

# Ver logs do PHP
docker compose logs -f php

# Acessar container PHP
docker compose exec php bash

# Rebuild containers
docker compose build --no-cache
```

### Symfony Console

```bash
# Rodar qualquer comando Symfony
docker compose exec php bin/console [comando]

# Exemplos:
docker compose exec php bin/console debug:router
docker compose exec php bin/console cache:clear
```

### Doctrine ORM

```bash
# Criar entidade
docker compose exec php bin/console make:entity

# Criar migration
docker compose exec php bin/console make:migration

# Rodar migrations
docker compose exec php bin/console doctrine:migrations:migrate

# Ver status das migrations
docker compose exec php bin/console doctrine:migrations:status
```

### Composer

```bash
# Instalar pacote
docker compose exec php composer require [pacote]

# Remover pacote
docker compose exec php composer remove [pacote]

# Atualizar dependências
docker compose exec php composer update
```

## 🗄️ Banco de Dados

**Acesso exclusivo via Doctrine ORM** - Não usar SQL direto.

### Conexão PostgreSQL

- **Host**: localhost (ou `database` de dentro dos containers)
- **Porta**: 5432
- **Database**: vialum
- **Usuário**: vialum
- **Senha**: password

### Cliente GUI (opcional)

Você pode conectar com DBeaver, pgAdmin, TablePlus, etc usando as credenciais acima.

## 🎯 Desenvolvimento

### Criar uma nova entidade

```bash
# 1. Criar entidade
docker compose exec php bin/console make:entity User

# 2. Gerar migration
docker compose exec php bin/console make:migration

# 3. Executar migration
docker compose exec php bin/console doctrine:migrations:migrate
```

### Criar um controller

```bash
docker compose exec php bin/console make:controller UserController
```

## 🔧 Variáveis de Ambiente

Configure no arquivo `.env`:

```env
# Symfony
APP_ENV=dev
APP_SECRET=seu-secret-aqui

# PostgreSQL
POSTGRES_DB=vialum
POSTGRES_USER=vialum
POSTGRES_PASSWORD=password

# Database URL (Doctrine)
DATABASE_URL="postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@database:5432/${POSTGRES_DB}?serverVersion=15&charset=utf8"
```

## 🏗️ Stack Tecnológica

- **PHP**: 8.2-FPM
- **Framework**: Symfony 7.2
- **ORM**: Doctrine
- **Servidor Web**: Nginx
- **Banco de Dados**: PostgreSQL 15
- **Containerização**: Docker + Docker Compose

## 📖 Documentação

- [PLANNING.md](PLANNING.md) - Arquitetura e decisões de design
- [Symfony Docs](https://symfony.com/doc/current/index.html)
- [Doctrine Docs](https://www.doctrine-project.org/projects/doctrine-orm/en/current/index.html)

## 🐛 Troubleshooting

### Containers não iniciam

```bash
docker compose down -v
docker compose build --no-cache
./scripts/init.sh
```

### Erro de permissão em var/

```bash
docker compose exec php chmod -R 777 var/
```

### Limpar cache

```bash
docker compose exec php bin/console cache:clear
```

## 📝 Licença

Proprietária - Vialum
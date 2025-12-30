# Vialum

Sistema desenvolvido em PHP com Symfony 7.2

## 🚀 Começando

### Pré-requisitos

- Docker
- Docker Compose

### 🐳 Rodando com Docker

1. **Iniciar o ambiente:**
   ```bash
   ./docker-start.sh
   ```

   Ou manualmente:
   ```bash
   docker compose build
   docker compose run --rm php composer install
   docker compose up -d
   ```

2. **Acessar a aplicação:**
   - Frontend: http://localhost
   - PostgreSQL: localhost:5432

3. **Parar o ambiente:**
   ```bash
   ./docker-stop.sh
   ```

   Ou manualmente:
   ```bash
   docker compose down
   ```

## 📦 Estrutura do Projeto

```
Vialum/
├── bin/              # Scripts executáveis (console)
├── config/           # Configurações do Symfony
├── public/           # Arquivos públicos (index.php)
├── src/              # Código fonte da aplicação
│   ├── Controller/   # Controllers
│   ├── Entity/       # Entidades Doctrine
│   └── Kernel.php    # Kernel do Symfony
├── vendor/           # Dependências (gerado pelo Composer)
├── .env              # Variáveis de ambiente
├── composer.json     # Dependências PHP
├── Dockerfile        # Configuração Docker PHP-FPM
├── compose.yaml      # Orquestração Docker
└── Caddyfile         # Configuração do servidor web
```

## 🛠 Comandos Úteis

### Docker
```bash
# Ver logs
docker compose logs -f

# Ver logs de um serviço específico
docker compose logs -f php

# Acessar container PHP
docker compose exec php bash

# Rodar comandos Symfony
docker compose exec php bin/console [comando]

# Instalar dependências
docker compose run --rm php composer install

# Atualizar dependências
docker compose run --rm php composer update
```

### Symfony Console
```bash
# Limpar cache
docker compose exec php bin/console cache:clear

# Listar rotas
docker compose exec php bin/console debug:router

# Criar migration
docker compose exec php bin/console make:migration

# Executar migrations
docker compose exec php bin/console doctrine:migrations:migrate
```

## 🗄️ Banco de Dados

- **Tipo:** PostgreSQL 15
- **Host:** database (ou localhost:5432 do host)
- **Database:** vialum
- **Usuário:** vialum
- **Senha:** password

## 📝 Desenvolvimento

### Variáveis de Ambiente

Configure o arquivo `.env.local` para sobrescrever configurações locais:

```env
APP_ENV=dev
APP_SECRET=seu-secret-aqui
DATABASE_URL="postgresql://vialum:password@database:5432/vialum?serverVersion=15&charset=utf8"
```

## 🏗️ Stack

- **PHP:** 8.2-FPM
- **Framework:** Symfony 7.2
- **Servidor Web:** Caddy
- **Banco de Dados:** PostgreSQL 15
- **ORM:** Doctrine
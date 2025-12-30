# Vialum - Planejamento de Arquitetura

## 🎯 Objetivo

Criar uma API REST profissional usando Symfony 7.2 com arquitetura limpa, Docker e PostgreSQL.

## 🏗️ Arquitetura

### Stack Tecnológica

- **Backend Framework**: Symfony 7.2
- **Linguagem**: PHP 8.2
- **ORM**: Doctrine
- **Banco de Dados**: PostgreSQL 15
- **Servidor Web**: Nginx
- **Containerização**: Docker + Docker Compose

### Estrutura de Containers

```
┌─────────────────────────────────────────────────┐
│                    Docker                        │
├──────────────┬──────────────┬───────────────────┤
│   nginx      │   php-fpm    │   postgresql      │
│   (porta 80) │   (porta     │   (porta 5432)    │
│              │    9000)     │                   │
└──────────────┴──────────────┴───────────────────┘
```

**3 Containers Separados:**

1. **nginx**: Servidor web que recebe requests HTTP e encaminha para PHP-FPM
2. **php-fpm**: Processa PHP (Symfony API)
3. **postgresql**: Banco de dados isolado

### Por que containers separados?

- **Escalabilidade**: Pode escalar cada serviço independentemente
- **Manutenção**: Atualizar/reiniciar um serviço sem afetar outros
- **Segurança**: Isolamento entre camadas
- **Profissional**: Padrão de mercado para microserviços

## 📁 Estrutura de Diretórios

```
Vialum/
├── docker/
│   ├── nginx/
│   │   └── default.conf          # Configuração do Nginx
│   └── php/
│       └── Dockerfile             # Imagem PHP customizada
├── src/
│   ├── Controller/                # Controllers da API
│   ├── Entity/                    # Entidades Doctrine (Models)
│   ├── Repository/                # Repositories Doctrine
│   └── Kernel.php                 # Kernel Symfony
├── config/
│   ├── packages/                  # Configurações de bundles
│   ├── routes.yaml                # Rotas
│   └── services.yaml              # Container de serviços
├── public/
│   └── index.php                  # Entry point
├── var/                           # Cache e logs (gitignored)
├── vendor/                        # Dependências (gitignored)
├── .env                           # Variáveis de ambiente
├── composer.json                  # Dependências PHP
├── docker-compose.yml             # Orquestração Docker
└── README.md                      # Documentação
```

## 🔧 Configuração Docker

### docker-compose.yml

**Serviços:**

1. **nginx**
   - Imagem: `nginx:alpine`
   - Porta: `80:80`
   - Volume: configuração + public/
   - Depende de: php

2. **php**
   - Build: custom Dockerfile
   - Porta: `9000` (interna)
   - Volume: código fonte
   - Extensões: pdo_pgsql, intl, zip
   - Depende de: database

3. **database**
   - Imagem: `postgres:15-alpine`
   - Porta: `5432:5432`
   - Volume: dados persistentes
   - Credenciais via .env

### Dockerfile (PHP)

**Estratégia Simples:**
- Baseado em `php:8.2-fpm`
- Instala extensões necessárias
- Instala Composer
- **SEM entrypoint complexo**
- Dependências instaladas manualmente ou via script separado

## 🗄️ Banco de Dados

### PostgreSQL

**Um único banco é suficiente.**

Para desenvolvimento, usaremos:
- **Database**: `vialum`
- **User**: `vialum`
- **Password**: `password` (development only)

### Acesso via ORM Doctrine

**Nunca acessar banco diretamente.** Sempre usar:

```php
// ✅ CORRETO - Via Repository
$userRepository = $entityManager->getRepository(User::class);
$users = $userRepository->findAll();

// ❌ ERRADO - SQL direto
// Não fazer isso!
```

**Migrations Doctrine:**
- Criar entidades
- Gerar migrations automaticamente
- Executar migrations via console

## 🚀 Fluxo de Inicialização

### Primeira vez:

```bash
# 1. Build das imagens
docker compose build

# 2. Instalar dependências
docker compose run --rm php composer install

# 3. Subir containers
docker compose up -d

# 4. Criar banco de dados
docker compose exec php bin/console doctrine:database:create

# 5. Rodar migrations
docker compose exec php bin/console doctrine:migrations:migrate
```

### Próximas vezes:

```bash
docker compose up -d
```

## 📋 Endpoints da API

### Inicial (Healthcheck)

- `GET /` - Retorna status da API
- `GET /health` - Healthcheck com info do banco

### Futuros

- `GET /api/users` - Lista usuários
- `POST /api/users` - Cria usuário
- `GET /api/users/{id}` - Busca usuário
- etc...

## 🎯 Princípios

1. **Simplicidade**: Sem gambiarras, código limpo
2. **Separação de Responsabilidades**: Cada container uma função
3. **ORM Only**: Acesso ao banco sempre via Doctrine
4. **Migrations**: Controle de versão do schema
5. **Environment Variables**: Configurações sensíveis em .env
6. **Docker Best Practices**: Containers stateless, volumes para dados

## ✅ Checklist de Implementação

- [ ] Criar estrutura de diretórios
- [ ] Configurar docker-compose.yml limpo
- [ ] Criar Dockerfile PHP simples
- [ ] Configurar Nginx
- [ ] Configurar Symfony básico
- [ ] Configurar Doctrine
- [ ] Criar primeira entidade (User)
- [ ] Criar migration
- [ ] Criar controller de exemplo
- [ ] Testar API
- [ ] Documentar no README

## 🔍 Próximos Passos

Após setup básico funcionando:
1. Autenticação JWT
2. CRUD completo
3. Validação de dados
4. Testes automatizados
5. CI/CD

---

**Nota**: Este é um setup profissional e escalável, seguindo padrões de mercado.

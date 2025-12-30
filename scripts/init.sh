#!/bin/bash
set -e

echo "🚀 Inicializando Vialum..."

# Build das imagens
echo "📦 Building Docker images..."
docker compose build

# Instala dependências do Composer
echo "📚 Instalando dependências do Composer..."
docker compose run --rm php composer install --no-interaction --prefer-dist

# Sobe os containers
echo "🐳 Iniciando containers..."
docker compose up -d

# Aguarda o banco estar pronto
echo "⏳ Aguardando banco de dados..."
sleep 5

# Cria o banco de dados
echo "🗄️ Criando banco de dados..."
docker compose exec php bin/console doctrine:database:create --if-not-exists

echo ""
echo "✅ Vialum inicializado com sucesso!"
echo "🌐 Acesse: http://localhost"
echo ""
echo "📋 Próximos passos:"
echo "  - Criar entidades: docker compose exec php bin/console make:entity"
echo "  - Criar migrations: docker compose exec php bin/console make:migration"
echo "  - Rodar migrations: docker compose exec php bin/console doctrine:migrations:migrate"

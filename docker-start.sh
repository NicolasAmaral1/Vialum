#!/bin/bash

echo "🚀 Iniciando Vialum..."

# Verifica se Docker está instalado
if ! command -v docker &> /dev/null; then
    echo "❌ Docker não está instalado. Por favor, instale o Docker primeiro."
    exit 1
fi

# Build das imagens
echo "📦 Fazendo build das imagens Docker..."
docker compose build

# Inicia os containers (dependências serão instaladas automaticamente)
echo "🐳 Iniciando containers..."
docker compose up -d

echo "⏳ Aguardando containers iniciarem..."
sleep 5

echo ""
echo "✅ Vialum está rodando!"
echo "🌐 Acesse: http://localhost"
echo ""
echo "📋 Comandos úteis:"
echo "  docker compose logs -f     # Ver logs"
echo "  docker compose down        # Parar containers"
echo "  docker compose exec php bash  # Acessar container PHP"

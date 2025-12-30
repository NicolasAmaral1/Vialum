#!/bin/bash
set -e

echo "🚀 Iniciando Vialum..."

# Aguarda o composer.json estar disponível (montado via volume)
MAX_WAIT=30
WAITED=0
while [ ! -f "composer.json" ] && [ $WAITED -lt $MAX_WAIT ]; do
    echo "⏳ Aguardando composer.json... ($WAITED/$MAX_WAIT)"
    sleep 1
    WAITED=$((WAITED + 1))
done

if [ ! -f "composer.json" ]; then
    echo "❌ composer.json não encontrado após ${MAX_WAIT}s"
    exit 1
fi

echo "✅ composer.json encontrado!"

# Verifica se as dependências estão instaladas
if [ ! -d "vendor" ] || [ ! -f "vendor/autoload.php" ]; then
    echo "📦 Instalando dependências do Composer..."
    composer install --no-interaction --prefer-dist --optimize-autoloader
else
    echo "✅ Dependências já instaladas"
fi

# Cria diretórios necessários
mkdir -p var/cache var/log
chmod -R 777 var

echo "🎯 Iniciando PHP-FPM..."
exec php-fpm

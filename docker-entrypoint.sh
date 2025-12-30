#!/bin/bash
set -e

echo "🚀 Iniciando Vialum..."

# Verifica se as dependências estão instaladas
if [ ! -d "vendor" ]; then
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

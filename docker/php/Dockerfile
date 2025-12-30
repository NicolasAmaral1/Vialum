FROM php:8.2-fpm

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libicu-dev \
    libpq-dev \
    libzip-dev \
    && docker-php-ext-install \
    intl \
    pdo_pgsql \
    zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Define diretório de trabalho
WORKDIR /var/www/html

# Expõe porta 9000 para PHP-FPM
EXPOSE 9000

# Comando padrão
CMD ["php-fpm"]

# Use a imagem base do Node.js para construir o projeto
FROM node:14 AS build

# Crie o diretório de trabalho
WORKDIR /app

# Clone o repositório forkado
RUN git clone https://github.com/lucmorim/qrcodescan.in .

# Remova o package-lock.json (opcional, dependendo da compatibilidade)
RUN rm -f package-lock.json

# Instale as dependências do projeto
RUN npm install

# Instale o Rollup globalmente
RUN npm install -g rollup

# Build o projeto com Rollup
RUN npm run build

# Use a imagem base do Caddy para servir a aplicação
FROM caddy:2.4.6-alpine

# Copie os arquivos da build para o diretório de trabalho do Caddy
COPY --from=build /app/public /srv

# Copie o arquivo Caddyfile para o diretório de configuração do Caddy
COPY Caddyfile /etc/caddy/Caddyfile

# Exponha as portas 80 e 443
EXPOSE 80 443

# Comando para iniciar o Caddy
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]

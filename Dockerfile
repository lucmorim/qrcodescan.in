# Use a imagem oficial do Node.js como base
FROM node:14

# Defina o diretório de trabalho
WORKDIR /app

# Copie o package.json e o package-lock.json
COPY package*.json ./

# Instale as dependências
RUN npm install

# Copie o restante dos arquivos do aplicativo
COPY . .

# Construa o aplicativo para produção
RUN npm run build

# Exponha a porta que o aplicativo usará
EXPOSE 3000

# Comando para rodar o aplicativo
CMD ["npm", "start"]

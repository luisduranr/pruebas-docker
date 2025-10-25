# -----------------------------
# ETAPA 1: Construcción (builder)
# -----------------------------
FROM node:18-alpine AS builder

WORKDIR /app

# Instalar pnpm globalmente
RUN npm install -g pnpm

# Copiar archivos de dependencias primero (para aprovechar la caché)
COPY package.json pnpm-lock.yaml ./

# Instalar dependencias
RUN pnpm install --frozen-lockfile

# Copiar el resto del código
COPY . .

# Construir la aplicación Next.js (modo producción)
RUN pnpm build


# -----------------------------
# ETAPA 2: Ejecución (runner)
# -----------------------------
FROM node:18-alpine AS runner

WORKDIR /app

# Instalar pnpm globalmente
RUN npm install -g pnpm

# Copiar solo los archivos necesarios del build standalone de Next.js
COPY --from=builder /app/package.json ./
COPY --from=builder /app/pnpm-lock.yaml ./
COPY --from=builder /app/public ./public

# Establecer variable de entorno
ENV NODE_ENV=production
ENV PORT=3000

# Exponer el puerto
EXPOSE 3000

# Comando para iniciar la aplicación (modo standalone)
CMD ["node", "server.js"]

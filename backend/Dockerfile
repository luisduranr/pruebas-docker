# -----------------------------
# ETAPA 1: Construcción (builder)
# -----------------------------
FROM node:18-alpine AS builder

WORKDIR /app

# Instalar pnpm globalmente
RUN npm install -g pnpm

# Copiar solo archivos de dependencias primero (mejor uso de caché)
COPY package.json pnpm-lock.yaml ./

# Instalar dependencias (sin dependencias opcionales ni dev opcionales del sistema)
RUN pnpm install --frozen-lockfile

# Copiar el resto del código fuente
COPY . .

# Generar Prisma Client
RUN pnpm prisma generate

# Construir la aplicación (por ejemplo NestJS)
RUN pnpm build


# -----------------------------
# ETAPA 2: Ejecución (runtime)
# -----------------------------
FROM node:18-alpine AS runner

WORKDIR /app

# Instalar pnpm globalmente (para ejecutar el app)
RUN npm install -g pnpm

# Copiar solo los archivos necesarios desde el builder
COPY --from=builder /app/package.json ./
COPY --from=builder /app/pnpm-lock.yaml ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/prisma ./prisma

# Configurar variable de entorno (opcional)
ENV NODE_ENV=production

# Exponer el puerto
EXPOSE 3001

# Comando para iniciar la aplicación
CMD ["pnpm", "start:prod"]

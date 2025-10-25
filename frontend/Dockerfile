# ============================
# Etapa 1: Dependencias
# ============================
FROM node:18-alpine AS deps

WORKDIR /app

# Instalar pnpm globalmente
RUN npm install -g pnpm

# Copiar solo archivos de dependencias
COPY package.json pnpm-lock.yaml ./

# Instalar dependencias (sin ejecutar scripts)
RUN pnpm install --frozen-lockfile

# ============================
# Etapa 2: Build (compilación)
# ============================
FROM node:18-alpine AS builder

WORKDIR /app
RUN npm install -g pnpm

# Copiar dependencias ya instaladas
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Compilar el proyecto Next.js
RUN pnpm build

# ============================
# Etapa 3: Runtime (producción)
# ============================
FROM node:18-alpine AS runner

WORKDIR /app
ENV NODE_ENV=production
ENV PORT=3000

RUN npm install -g pnpm

# Copiar solo lo necesario para ejecutar
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

# Crear usuario no root
RUN addgroup --system --gid 1001 nodejs \
  && adduser --system --uid 1001 nextjs \
  && chown -R nextjs:nodejs /app

USER nextjs

EXPOSE 3000

# Iniciar la aplicación
CMD ["pnpm", "start"]

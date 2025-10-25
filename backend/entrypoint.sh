#!/bin/sh
set -e

echo "Running Prisma migrations..."
pnpm prisma db push

echo "Starting backend..."
pnpm start:prod
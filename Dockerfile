# Description: Dockerfile for Next.js app with Supabase
FROM node:18-alpine AS base

FROM base AS deps
RUN apk add --no-cache libc6-compat
WORKDIR /app

COPY package*.json ./
RUN npm ci

FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# ENV NEXT_TELEMETRY_DISABLED 1
# ENV NEXT_PUBLIC_SUPABASE_URL=https://yqwlisclxkqlmlflspea.supabase.co
# ENV NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlxd2xpc2NseGtxbG1sZmxzcGVhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjAwNDQ5NDYsImV4cCI6MjAzNTYyMDk0Nn0.h2ZXy5ORoXTfczgE6X_PpBkTYWflJ2V6uToTqyFxVYw
# ENV ANTHROPIC_API_KEY=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

# Build the application
RUN npm run build

FROM base AS runner
WORKDIR /app

ENV NODE_ENV production
ENV NEXT_TELEMETRY_DISABLED 1

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

# Copy the application files
COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

USER nextjs

EXPOSE 3000

ENV PORT 3000

CMD ["npm", "start"]
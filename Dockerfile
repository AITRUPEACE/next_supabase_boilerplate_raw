# Build stage
FROM node:18 AS builder
WORKDIR /app

# Define build arguments
ARG NEXT_PUBLIC_SUPABASE_URL
ARG NEXT_PUBLIC_SUPABASE_ANON_KEY

# Set environment variables
ENV NEXT_PUBLIC_SUPABASE_URL=$NEXT_PUBLIC_SUPABASE_URL
ENV NEXT_PUBLIC_SUPABASE_ANON_KEY=$NEXT_PUBLIC_SUPABASE_ANON_KEY

# remove for production!!!
RUN echo "NEXT_PUBLIC_SUPABASE_URL: $NEXT_PUBLIC_SUPABASE_URL"
RUN echo "NEXT_PUBLIC_SUPABASE_ANON_KEY: $NEXT_PUBLIC_SUPABASE_ANON_KEY"

COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Production stage
FROM node:18 AS runner
WORKDIR /app

ENV NODE_ENV production

# Copy necessary files
COPY --from=builder /app/next.config.mjs ./
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

# Optimize for production
RUN npm prune --production

EXPOSE 3000
ENV PORT 3000

# Start Next.js
CMD ["npm", "start"]
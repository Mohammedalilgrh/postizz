FROM node:20-alpine3.19

# Install only essential dependencies
RUN apk add --no-cache g++ make py3-pip

# Install pnpm globally
RUN npm install -g pnpm@10.6.1

WORKDIR /app

# Copy package files first for better caching
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY nx.json tsconfig.base.json tsconfig.json ./

# Copy app-specific package files
COPY apps/web/package.json ./apps/web/
COPY apps/api/package.json ./apps/api/
COPY packages/*/package.json ./packages/

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy the rest of the code
COPY . .

# Build with lower memory limit for Render free tier
RUN NODE_OPTIONS="--max-old-space-size=512" pnpm run build

# Expose port
EXPOSE 3000

# Start command (simpler without nginx for now)
CMD ["pnpm", "start"]

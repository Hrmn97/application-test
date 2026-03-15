# FROM node:22-alpine

# # Create app directory
# WORKDIR /app

# # Copy package files first (better Docker caching)
# COPY package*.json ./

# # Install dependencies
# RUN npm install

# # Copy project files
# COPY . .

# # Expose application port
# EXPOSE 3000

# # Start server
# CMD ["node", "server.js"]

FROM node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev

COPY server.js .

EXPOSE 3000

CMD ["node", "server.js"]
FROM node:20 AS builder
WORKDIR /app
COPY package*.json .
RUN npm install
COPY . .
RUN npx prisma generate && npm run build

FROM node:20 AS deps
WORKDIR /app
COPY package*.json .
RUN npm install --omit=dev

FROM node:20
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=deps /app/node_modules ./node_modules
COPY --from=builder /app/node_modules/.prisma ./node_modules/.prisma
CMD ["node", "dist/main.js"]

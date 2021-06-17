FROM node:14.17 as prod
WORKDIR /usr/app
COPY package*.json ./
RUN npm install --only=production

COPY . .

EXPOSE 7000
CMD ["sh", "-c", "npm start"]

FROM node:14.17 as debug
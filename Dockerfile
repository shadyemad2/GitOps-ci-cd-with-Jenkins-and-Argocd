FROM node:16

WORKDIR /app

#COPY package.json
COPY package*.json ./

#TO get dependencies
RUN npm install

#COPY all app code
COPY . .

#Expose port
EXPOSE 3000

#Start server
CMD ["npm", "start"]

# naming the result container of it as builder
FROM node:alpine as builder 
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#using the file system of builder to serve the app
#anything resides /usr/share/nginx/html can be seen to outside world
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

#docker run -p 80:80 <container_id>
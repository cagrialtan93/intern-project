# application build stage
FROM node:lts as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . . 
RUN npm run build

# nginx build stage
FROM nginx:stable-alpine as production-stage

# copy server config file
COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf

# copy ssl keys for https access
COPY ./ssl /etc/nginx/ssl

# clear default files of nginx
RUN rm -rf /usr/share/nginx/html

# copy application files 
COPY --from=build-stage /app/public /usr/share/nginx/html

EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
# application build stage
FROM node:lts-alpine as build-stage
COPY package*.json ./
RUN npm install
COPY . . 
RUN npm run build

# nginx build stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /public /usr/share/nginx/html
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
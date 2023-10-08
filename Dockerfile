FROM node:latest as node
WORKDIR /app
COPY ./ /app/
ARG URL-API
ENV URL=$URL-API
RUN sed -i 's/APIURL/'"$URL"'/g' ./src/enviroments/enviroments.ts
RUN npm install
RUN npm run build


FROM nginxinc/nginx-unprivileged
COPY --from=node /app/dist/prueba /usr/share/nginx/html

#### don't know what this is, but cool and techy
CMD ["nginx", "-g", "daemon off;"]
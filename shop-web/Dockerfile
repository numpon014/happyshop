# Dockerfile
FROM node:10
ARG BUILD_NUMBER=BUILD_NUMBER
ARG REVISION=REVISION

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY shop-web/package.json /usr/src/app/
RUN npm install

# Bundle app source
COPY shop-web /usr/src/app

# Build
RUN npm run build

# Create version.json
RUN sed -e "s;%DATE%;$(date);g" -e "s;%BUILD%;${BUILD_NUMBER};g" -e "s;%REVISION%;${REVISION};g" ./shop-web/version.template.json > ./shop-web/dist/version.json

EXPOSE 9000

# defined in package.json
CMD [ "npm", "run", "start" ]

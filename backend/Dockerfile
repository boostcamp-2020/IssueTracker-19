FROM node:12
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install

# 프로덕션을 위한 코드를 빌드하는 경우
# RUN npm ci --only=production

# 앱 소스 추가
COPY . .
EXPOSE 3000
CMD [ "npm", "run", "start:dev" ]
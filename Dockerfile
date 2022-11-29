FROM node:12-alpine
# Adding build tools to make yarn install work on Apple silicon / arm64 machines
RUN apk add --no-cache python2 g++ make
WORKDIR /naiveboom
COPY . .
RUN wget https://download.redis.io/redis-stable.tar.gz
RUN tar -xzvf redis-stable.tar.gz
RUN cd redis-stable && make && make install

RUN yarn install --production


CMD nohup sh -c 'redis-server --daemonize yes && node ./run.js'


FROM node:10

RUN cd / && git clone https://github.com/wikimedia/restbase.git && cd restbase && git checkout v0.19.2 && rm -rf .git/
WORKDIR /restbase

RUN npm install

EXPOSE 7231
CMD npm start

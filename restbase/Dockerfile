FROM node:10

RUN cd / && git clone https://github.com/wikimedia/restbase.git && cd restbase && rm -rf .git/
WORKDIR /restbase

RUN npm install

EXPOSE 7231
CMD npm start

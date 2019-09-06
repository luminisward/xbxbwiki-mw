FROM node:10

RUN cd / && git clone https://github.com/wikimedia/parsoid.git && cd parsoid && rm -rf .git/
WORKDIR /parsoid

RUN npm install

EXPOSE 8000
CMD npm start

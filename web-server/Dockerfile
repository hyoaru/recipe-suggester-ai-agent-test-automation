FROM nginx:1.27.3-alpine

RUN apk update && apk add vim curl bash

COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]

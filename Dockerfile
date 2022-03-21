FROM python:3.10-alpine3.14

RUN apk update
RUN apk add --no-cache git curl gcc musl-dev file bash
RUN pip install dotdrop

RUN mkdir -p /opt/app/dotfiles /opt/
COPY config.yaml dotdrop.sh version.sh /opt/app

COPY dotfiles ./dotfiles
CMD ["/opt/app/dotdrop.sh", "install", "-daD", "-p", "home"]

FROM alpine:latest

RUN apk add --no-cache openssh-client

RUN mkdir ~/.ssh && chmod 700 ~/.ssh
RUN touch ~/.ssh/known_hosts && chmod 644 ~/.ssh/known_hosts

COPY docker-entrypoint.sh /usr/local/bin

ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "/bin/sh" ]

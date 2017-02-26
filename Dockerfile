FROM alpine:edge
MAINTAINER Alvaro Lizama Molina <me@alvarolizama.net>
RUN apk --no-cache add -U musl musl-dev ncurses-libs
COPY ./_build/prod/rel /rel
WORKDIR /rel
EXPOSE 80
ENV PORT=80 MIX_ENV=prod REPLACE_OS_VARS=true
CMD /rel/app/bin/app foreground

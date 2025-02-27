# syntax=docker/dockerfile:1

FROM haskell:9.10.1-slim-bullseye as base
ENV NAME=words-containing

FROM base as build

WORKDIR /opt/${NAME}

RUN cabal update
COPY ./${NAME}.cabal /opt/${NAME}/${NAME}.cabal
RUN cabal build --only-dependencies -j4

COPY . /opt/${NAME}
RUN cabal install

COPY /root/.local/bin/${NAME} /usr/local/bin/
RUN chmod +x /usr/local/bin/${NAME}

ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser
USER appuser

EXPOSE 3001

ENTRYPOINT [ "words-containing" ]

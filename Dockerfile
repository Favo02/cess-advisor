FROM ocaml/opam:alpine-ocaml-5.0

WORKDIR /app

COPY backend .
COPY .env .
RUN mkdir logs

RUN sudo apk add gmp-dev libev-dev postgresql14-dev

ENV OPAMTIMEOUT=1200
ENV OPAMSOLVERTIMEOUT=1200
ENV ROOT_PATH=/app

RUN opam update && opam upgrade -y
RUN opam install dune
RUN opam install . --deps-only
RUN sudo chown -R opam:nogroup .
RUN opam exec -- dune build

EXPOSE 3000

CMD opam exec -- dune exec main server

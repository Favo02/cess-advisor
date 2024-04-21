FROM ocaml/opam:latest

WORKDIR /app

COPY backend .
COPY .env .
RUN sudo chown -R opam:nogroup .

RUN sudo apt-get update && sudo apt-get install -y libgmp-dev libev-dev libpq-dev pkg-config

ENV OPAMTIMEOUT=1800
ENV OPAMSOLVERTIMEOUT=1800
ENV ROOT_PATH=/app

RUN opam update && opam upgrade -y
RUN opam install dune
RUN opam install . --deps-only
RUN opam exec -- dune build

EXPOSE 3000

CMD opam exec -- dune exec main server

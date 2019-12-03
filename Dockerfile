FROM elixir:1.9.0-alpine

LABEL application="tickets"


ENV TERM=xterm-256color

# Set the locale
ENV LANG="en_US.utf8"
ENV LANGUAGE="en_US:"
ENV HOME=/opt/app
WORKDIR $HOME


RUN apk update
RUN apk add  bash curl nodejs npm inotify-tools postgresql-client



#install phoenix dependenices
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install --force hex phx_new 1.4.3


COPY . .

RUN apk add --no-cache git


RUN mix deps.get


EXPOSE 4000
RUN chmod +x ./run.sh
ENTRYPOINT [ "./run.sh" ]
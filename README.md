# place-elixir

place-elixir is a recreation of reddits /r/place in elixir as a side project.

## Development requirements

- docker
    https://docs.docker.com/docker-for-mac/install/
    https://docs.docker.com/docker-for-windows/install/

- elixir 1.4.2
    http://elixir-lang.org/install.html

- nodejs & npm 6+
    https://nodejs.org/en/download/

## Installing dependencies

The first time you start developing you'll need to install some dependencies.
You won't need to run these commands every time though.

```
npm install
mix deps.get
```

## Starting development server

To start postgres and the phoenix server run:

```
docker-compose up -d && mix phoenix.server
```

To stop developing, press `ctrl-c` and then `a` and then press `enter`.
And finally stop postgres with:

```
docker-compose down
```

## Postgres database files

The postgres database container will store its files in the folder `pgdata`. So if you want
to start completely from scratch make sure you also delete that folder.

## Deploying

We deploy for the time being to heroku: https://fast-ocean-12176.herokuapp.com/

Instructions todo
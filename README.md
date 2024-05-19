# Chamber

This is an echo chamber to air your grievances, celebrate, talk smack, or whatever. Kinda similar to that site with the bird.

## Ruby version

Current targeting `3.3.1` as specified in `.ruby-version`

## Local development

Hosting a development database and email is expensive, so test locally!

A convienent `compose.yml` is provided under `chamber-dev-db`.

* `cd chamber-dev-db && docker compose up -d`
* `cd .. && cp .env.local .env`
* `rails db:create db:migrate`

Access the email server at `localhost:9000`

Start dev server using `./bin/dev` - you may need to run `rbenv rehash` if you get a foreman error

## Production deployment

TODO lol

# Chamber

This is an echo chamber to air your grievances, celebrate, talk smack, or whatever. Kinda similar to that site with the bird.

## Ruby version

Current targeting `3.3.1` as specified in `.ruby-version`

## Local development

Use rbenv (or rvm) to set up a Ruby version and run `bundle install`

Hosting a development database and email is expensive, so test locally!

A convenient `compose.yml` is provided under `chamber-dev-db`.

* `cd chamber-dev-db && docker compose up -d`
* `cd .. && cp .env.local.template .env.local`
* `rails db:prepare`

Access the email server at `localhost:9000` or preview emails at `localhost:3000/rails/mailers/`

Start dev server using `rails server`.

The Dockerfile that is in the root of the folder is for deploying to production.

## Production deployment

TODO lol

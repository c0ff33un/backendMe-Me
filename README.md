# README ME-ME

## Ruby version: 2.5.3

## System dependencies

* None

## Configuration

### Notes

For development a .env file in root folder with DEVISE_JWT_SECRET_KEY defined is needed. It can be generated with:

	bundle exec rake secret

## Docs

### Auth using devise, jwt-devise and argon2:
* [quick devise and devise-jwt config](https://medium.com/@nandhae/2019-how-i-set-up-authentication-with-jwt-in-just-a-few-lines-of-code-with-rails-5-api-devise-9db7d3cee2c0)
* [basic devise config](https://github.com/plataformatec/devise)
* [setting up argon2 for devise](https://ankane.org/devise-argon2)
* [basic devise-jwt config step 1](https://github.com/waiting-for-dev/devise-jwt/wiki/Configuring-devise-for-APIs)
* [basic devise-jwt config step 2](https://github.com/waiting-for-dev/devise-jwt)
* [advanced custom devise controller](https://thinkster.io/tutorials/rails-json-api/setting-up-users-and-authentication-for-our-api)

### Mailer

* [sendgrid on production](https://stackoverflow.com/questions/44417596/action-mailer-production-rb-not-working-when-deployed-via-sendgrid-and-heroku)

## Database creation
To-do
## Database initialization
	
	rails db:migrate
	rails db:seed

## How to run the test suite
To-do
## Services (job queues, cache servers, search engines, etc.)
To-do
## Deployment instructions

### Pushing non master branch to heroku

First:

	git push heroku feature/<feature>:master

and then,

	git push -f heroku master:master

when you want to push again actual master.

### Recreating database on heroku

	db:schema:load
	db:structure:load or db:migraterake db:migrate

## Contributing

git clone https://github.com/c0ff33un/backendMe-Me.git

git flow feature start <feature_name>

...
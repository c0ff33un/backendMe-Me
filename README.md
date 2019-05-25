# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...



## Pushing non master branch to heroku

	git push heroku feature/<feature>:master

and

	git push -f heroku master:master

when you want to push again actual master


# Recreating database on heroku

	db:schema:load
	db:structure:load or db:migraterake db:migrate
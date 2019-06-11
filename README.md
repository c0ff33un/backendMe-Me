# README ME-ME

## Ruby version: 2.5.3

## System dependencies

* None

## Configuration

### Notes

#### Keys configuration
For development a .env file in root folder with DEVISE_JWT_SECRET_KEY defined is needed. It can be generated with:
	bundle exec rake secret


*in file .env found in root*
>DEVISE_JWT_SECRET_KEY=token_from_bundle_secret

> If routes are changed make sure to check initializers/devise.rb

#### 

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

### OmniAuth

* [rails Omniauth using devise with Twitter, Facebook and linkedin](https://sourcey.com/articles/rails-omniauth-using-devise-with-twitter-facebook-and-linkedin)

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

# How to make the perfect Oatmeal - What to do while we wait the deadline :'(
1. Ingredients/Utensils
	1. A pan
	2. Milk
	3. Water
	4. Salt
	5. Sugar
	6. Cinnamon
	7. Oatmeal(Obviously :v)
	8. Someone who prepares it (Miguel).
2. Instructions
	1. Pour 1/2 vase of water and 1/2 vase milk into the pan.
	2. Boil it while adding the following ingredients.
		1. Add a little salt.
		2. Add a little sugar
		3. Add cinnamon to taste.
	3. Finally add the Oatmeal.
	4. Let it boil until it dries a bit.

![Result](https://i.imgur.com/jY48LPW.jpg)


Enjoy!!!
**Wait for more images in the next iteration**
- Recipe by: Miguel Angel Ortiz
- The one who ate it: Edwin Ricardo Mahecha
...
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

### AWS rekognition API
*We use this api to filter out images with sexual content*
* [gem documentation](https://docs.aws.amazon.com/sdkforruby/api/Aws/Rekognition/Client.html#detect_moderation_labels-instance_method)
* [AWS rekognition setup](https://docs.aws.amazon.com/rekognition/latest/dg/moderation.html)
* [AWS with S3 bucket](https://stackoverflow.com/questions/55158595/rails-active-storage-aws-rekognition-detect-labels-filtered-labels)

### Cron tasks
*	[gem documentation](https://github.com/javan/whenever)

We are storing all the logs in this path, please change it schedule.rb file to avoid problems
>	set :output, '~/Git/backendMe-Me/tmp/crons.log'

Heroku does not have crons, instead it offers its own scheduler
* [heroku scheduler](https://devcenter.heroku.com/articles/scheduler)

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
	9. Pour 1/2 vase of water and 1/2 vase milk into the pan.
	10. Boil it while adding the following ingredients.
		1. Add a little salt.
		2. Add a little sugar
		3. Add cinnamon to taste.
	11. Finally add the Oatmeal.
	12. Let it boil until it dries a bit.

![Result](https://i.imgur.com/jY48LPW.jpg)


Enjoy!!!
**Wait for more images in the next iteration**
- Recipe by: Miguel Angel Ortiz
- The one who ate it: Edwin Ricardo Mahecha
...

# Tunes to hear and cry due a unsuccessful iteration
* [komm süßer Tod](https://www.youtube.com/watch?v=oIscL-Bjsq4)
* [Plastic love - Mariya Takeuchi](https://www.youtube.com/watch?v=9Gj47G2e1Jc)
* [LMFAO - Sexy and I know It](https://www.youtube.com/watch?v=wyx6JDQCslE)
* [Gotye - Somebody That I Used To Know](https://www.youtube.com/watch?v=8UVNT4wvIGY)
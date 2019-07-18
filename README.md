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

*Note: Remember to add the respective keys when using aws or another storage service*
#### 

## Docs

### Auth using devise, jwt-devise and argon2:
* [quick devise and devise-jwt config](https://medium.com/@nandhae/2019-how-i-set-up-authentication-with-jwt-in-just-a-few-lines-of-code-with-rails-5-api-devise-9db7d3cee2c0)
* [basic devise config](https://github.com/plataformatec/devise)
* [setting up argon2 for devise](https://ankane.org/devise-argon2)
* [basic devise-jwt config step 1](https://github.com/waiting-for-dev/devise-jwt/wiki/Configuring-devise-for-APIs)
* [basic devise-jwt config step 2](https://github.com/waiting-for-dev/devise-jwt)
* [advanced custom devise controller](https://thinkster.io/tutorials/rails-json-api/setting-up-users-and-authentication-for-our-api)

### PDFS
* [prawn](https://github.com/prawnpdf/prawn)
* [gruff, library to generate graphs](https://github.com/topfunky/gruff)
* [rmagick, we need it to use gruff](https://github.com/rmagick/rmagick)
* [Thread that explains how to use gruff alongside prawn](https://stackoverflow.com/questions/13071344/graphics-with-prawn)

*Note: it is necessary to satisfy some rmagick dependencies on the server, otherwise rmagick won't work*
### Mailer
* [sendgrid on production](https://stackoverflow.com/questions/44417596/action-mailer-production-rb-not-working-when-deployed-via-sendgrid-and-heroku)
* [letter_opener gem, preview emails](https://github.com/ryanb/letter_opener)
* [Templates for mailers](https://foundation.zurb.com/emails/getting-started.html)

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
Useful information:
* [getting started with minitest](https://blog.codeship.com/getting-started-with-minitest/)
*	[mocking in ruby with minitest](https://semaphoreci.com/community/tutorials/mocking-in-ruby-with-minitest)
*	[how to test rails models with minitest](https://semaphoreci.com/community/tutorials/how-to-test-rails-models-with-minitest)
* [active storage stubbing with mocha](https://stackoverflow.com/questions/51603388/how-to-stub-file-size-on-active-storage-test-testunit)

Gem for stubbing and mocking with minitest
*	[mocha gem](https://github.com/freerange/mocha)

## Oauth
Guide used loosely based on devise-oauth politics:
* [Stackoverflow](https://stackoverflow.com/questions/14812179/using-omniauth-for-facebook-login-with-only-access-token)

*Note that this is the flow we must follow in our case because we are developing a mobile app. For web applications it is better to use one of the devise-omniauth avialable politics.*


*Also remeber to add the dispatch in the devise.rb file in order to receive a jwt authorization token*

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
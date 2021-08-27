setup:
	bin/setup
	bin/rails db:fixtures:load

lint:
	bundle exec rubocop

test:
	bin/rails test

brake:
	bundle exec brakeman -q -w2

check: lint test brake

test-coverage:
	open coverage/index.html

webpack:
	bin/webpack-dev-server

clean:
	rake assets:clobber

start:
	bin/rails s

dbm:
	bin/rails db:migrate

console:
	bin/rails console

seed:
	bin/rails db:fixtures:load

push:
	git push -u origin master

deploy:
	git push heroku master

heroku-start:
	heroku local

heroku-dbm:
	heroku run rake db:migrate

heroku-console:
	heroku run rails console

heroku-seed:
	heroku run rake db:seed

heroku-logs:
	heroku logs --tail

annotate:
	bundle exec annotate --models --routes

.PHONY:	test

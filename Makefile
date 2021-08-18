setup:
	bin/setup
	bin/rails db:fixtures:load

lint:
	bundle exec rubocop

test:
	bin/rails test

brake:
	bundle exec brakeman -q -w2

check: lint test

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

heroku-start:
	heroku local

console:
	bin/rails console

seed:
	bin/rails db:fixtures:load

push:
	git push -u origin master

deploy:
	git push heroku master

heroku-console:
	heroku run rails console

heroku-logs:
	heroku logs --tail

.PHONY:	test

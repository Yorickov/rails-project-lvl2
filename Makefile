setup:
	bin/setup
	bin/rails db:fixtures:load

lint:
	bundle exec rubocop

test:
	bin/rails test

brake:
	bundle exec brakeman -q -w2

check: lint brake test

start:
	bin/rails s

console:
	bin/rails console

seed:
	bin/rails db:fixtures:load

push:
	git push -u origin master

deploy:
	git push heroku master

.PHONY:	test

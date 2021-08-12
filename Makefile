setup:
	bin/setup
	bin/rails db:fixtures:load

lint:
	bundle exec rubocop

test:
	bin/rails test

check: lint test

start:
	bin/rails s

console:
	bin/rails console

seed:
	bin/rails db:fixtures:load

push:
	git push -u origin master

.PHONY:	test

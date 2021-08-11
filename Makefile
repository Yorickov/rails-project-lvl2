setup:
	cp -n .env.example .env || true
	bin/setup
	bin/rails db:fixtures:load

lint:
	bundle exec rubocop

test:
	bin/rails test

check: lint test

ci-setup:
	cp -n .env.example .env || true
	yarn install
	bundle install --without production development
	RAILS_ENV=test bin/rails db:prepare
	# bin/rails db:fixtures:load

start:
	bin/rails s

c:
	bin/rails console

seed:
	bin/rails db:fixtures:load

push:
	git push -u origin master

.PHONY:	test

all: rspec cucumber

database:
	@echo "reset the database"
	@rake db:drop:all
	@rake db:create:all
	@rake db:migrate
	@rake db:test:clone
	@rake db:seed

rspec:
	@echo "run rspec specs"
	@bundle exec  rspec spec --drb --format progress

cucumber:
	@echo "run cucumber specs"
	@bundle exec  cucumber features --drb

cucumber-nojs:
	@echo "run cucumber specs without javascript"
	@bundle exec cucumber features --drb --tag ~@javascript

cucumber-js:
	@echo "run cucumber specs with javascript"
	@bundle exec  cucumber features --drb --tag @javascript

spork:
	@echo "start spork"
	@bundle exec spork cucumber & bundle exec spork


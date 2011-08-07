all: rspec cucumber

database:
	@echo "reset the database"
	@rake db:drop:all
	@rake db:create:all
	@rake db:migrate
	@rake db:test:clone

rspec:
	@echo "run rspec specs"
	@rspec spec --drb --format progress

cucumber:
	@echo "run cucumber specs"
	@cucumber features --drb

cucumber-nojs:
	@echo "run cucumber specs without javascript"
	@cucumber features --drb --tag ~@javascript

cucumber-js:
	@echo "run cucumber specs with javascript"
	@cucumber features --drb --tag @javascript

spork:
	@echo "start spork"
	@spork cucumber & spork


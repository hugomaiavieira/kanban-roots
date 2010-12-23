all: clear unit acceptance

acceptance: clear functional javascript

simple: clear unit functional

clear:
	@clear

unit:
	@echo ""
	@echo "=================="
	@echo "Running unit tests"
	@echo "=================="
	@echo ""
	@rspec spec --format progress

functional:
	@echo ""
	@echo "========================"
	@echo "Running functional tests"
	@echo "========================"
	@echo ""
	@cucumber features --tag ~@javascript --format progress

javascript:
	@echo ""
	@echo "========================"
	@echo "Running javascript tests"
	@echo "========================"
	@echo ""
	@cucumber features --tag @javascript --format progress


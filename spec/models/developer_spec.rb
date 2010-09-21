require 'spec_helper'

describe Developer do

  it "should have a name" do
    developer = Factory.build :developer, :name => ""
    developer.save.should be_false
  end

  it "should have a valid e-mail" do
    developer = Factory.build :developer, :email => ""
    developer.save.should be_false

    developer.email = "hugo@"
    developer.save.should be_false

    developer.email = "hugo@gmail.c"
    developer.save.should be_false

    developer.email = "hugo@gmail.com"
    developer.save.should be_true
  end

end


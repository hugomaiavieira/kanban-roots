require File.dirname(__FILE__) + '/../spec_helper'

describe Developer do

  it "should have a name" do
    developer = Factory.build :developer, :name => ""
    developer.save.should be_false
  end

  it "should have a valid e-mail" do
    developer = Factory.build :developer, :email => ""
    developer.save.should be_false

    developer = Factory.build :developer, :email => "hugo@"
    developer.save.should be_false
  end

end


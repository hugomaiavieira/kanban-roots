require 'spec_helper'

describe Contributor do
  should_validate_presence_of :name

  it "should have a valid e-mail" do
    contributor = Factory.build :contributor, :email => ""
    contributor.should_not be_valid

    contributor.email = "hugo@"
    contributor.should_not be_valid

    contributor.email = "hugo@gmail.c"
    contributor.should_not be_valid

    contributor.email = "hugo@gmail.com"
    contributor.should be_valid
  end
end


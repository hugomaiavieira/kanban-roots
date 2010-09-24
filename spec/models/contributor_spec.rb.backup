require 'spec_helper'

describe Contributor do

  it "should have a name" do
    contributor = Factory.build :contributor, :name => ""
    contributor.save.should be_false
  end

  it "should have a valid e-mail" do
    contributor = Factory.build :contributor, :email => ""
    contributor.save.should be_false

    contributor.email = "hugo@"
    contributor.save.should be_false

    contributor.email = "hugo@gmail.c"
    contributor.save.should be_false

    contributor.email = "hugo@gmail.com"
    contributor.save.should be_true
  end

end


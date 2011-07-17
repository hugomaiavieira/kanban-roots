require 'spec_helper'

describe Contributor do
  it 'should validate uniqueness of username' do
    Factory.create :contributor, :username => "johndoe"
    contributor = Factory.build :contributor, :username => "johndoe"
    contributor.save.should be_false
    contributor.errors.should include({:username=>["has already been taken"]})
  end

  it "should have a valid e-mail" do
    should have_valid(:email).when('hugo@gmail.com')
    should_not have_valid(:email).when('hugo@gmail.c', 'hugo@gmail', 'hugo@',
                                       '', nil)
  end

  it "should have a valid username" do
    should have_valid(:username).when('johndoe', 'john_doe', 'john5', '_john')
    should_not have_valid(:username).when('john doe', 'john@doe', '', nil)
  end
end


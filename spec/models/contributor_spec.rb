require 'spec_helper'

describe Contributor do
  should_validate_presence_of :name, :email, :username
  should_have_and_belong_to_many :tasks, :projects
  should_have_many :comments

  it 'should validate uniqueness of username' do
    Factory.create :contributor, :username => "johndoe"
    contributor = Factory.build :contributor, :username => "johndoe"
    contributor.save.should be_false
    contributor.errors.should include({:username=>["has already been taken"]})
  end

  it "should have a valid e-mail" do
    contributor = Factory.build :contributor, :email => ""
    contributor.should be_invalid

    contributor.email = "hugo@"
    contributor.should be_invalid

    contributor.email = "hugo@gmail.c"
    contributor.should be_invalid

    contributor.email = "hugo@gmail.com"
    contributor.should be_valid
  end

  it "should have a valid username" do
    contributor = Factory.build :contributor, :username => ""
    contributor.should be_invalid

    contributor.username = "john doe"
    contributor.should be_invalid

    contributor.username = "john@doe"
    contributor.should be_invalid

    contributor.username = "johndoe"
    contributor.should be_valid

    contributor.username = "johndoe25"
    contributor.should be_valid

    contributor.username = "_johndoe"
    contributor.should be_valid

    contributor.username = "john_doe"
    contributor.should be_valid
  end

end


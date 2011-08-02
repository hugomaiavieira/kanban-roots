require 'spec_helper'

describe Contributor do
  it 'should return all projects, including his own and others the he contribute' do
    hugo = Factory.create :contributor
    rodrigo = Factory.create :contributor
    my_project = Factory.create :project, :owner => hugo
    our_project = Factory.create :project, :owner => rodrigo, :contributors => [hugo]
    other_project = Factory.create :project, :owner => rodrigo
    hugo.projects.should include(my_project, our_project)
    hugo.projects.should_not include(other_project)
  end

  context 'validates' do
    it 'uniqueness of username' do
      Factory.create :contributor, :username => "johndoe"
      contributor = Factory.build :contributor, :username => "johndoe"
      contributor.save.should be_false
      contributor.errors.should include({:username=>["has already been taken"]})
    end

    it "e-mail" do
      should have_valid(:email).when('hugo@gmail.com')
      should_not have_valid(:email).when('hugo@gmail.c', 'hugo@gmail', 'hugo@',
                                         '', nil)
    end

    it "username" do
      should have_valid(:username).when('johndoe', 'john_doe', 'john5', '_john')
      should_not have_valid(:username).when('john doe', 'john@doe', '', nil)
    end
  end
end


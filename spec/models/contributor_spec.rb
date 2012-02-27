require 'spec_helper'

describe Contributor do
  it "remove all contributors' projects own" do
    contributor = Factory.create :contributor
    project_a = Factory.create :project, :owner => contributor
    project_b = Factory.create :project, :owner => contributor
    contributor.reload.destroy
    expect { project_a.reload }.to raise_error ActiveRecord::RecordNotFound
    expect { project_b.reload }.to raise_error ActiveRecord::RecordNotFound
  end

  it 'should return all projects, including his own and others the he contribute, ordered by update date' do
    hugo = Factory.create :contributor
    rodrigo = Factory.create :contributor
    my_project = Factory.create :project, :owner => hugo
    our_project = Factory.create :project, :owner => rodrigo, :contributors => [hugo]
    other_project = Factory.create :project, :owner => rodrigo

    hugo.reload.projects.should_not include(other_project)
    hugo.projects.should == [our_project, my_project]

    my_project.update_attribute(:name, 'Changed name')
    hugo.reload.projects.should == [my_project, our_project]
  end

  context 'validates' do
    it 'uniqueness of username' do
      Factory.create :contributor, :username => "johndoe"
      contributor = Factory.build :contributor, :username => "johndoe"
      contributor.save.should be_false
      contributor.errors.messages.should include({:username=>["has already been taken"]})
    end

    it "e-mail" do
      should have_valid(:email).when('hugo@gmail.com')
      should_not have_valid(:email).when('hugo@gmail.c', 'hugo@gmail', 'hugo@', '', nil)
    end

    it "username" do
      should have_valid(:username).when('johndoe', 'john_doe', 'john5', '_john')
      should_not have_valid(:username).when('john doe', 'john@doe', '', nil)
    end
  end
end
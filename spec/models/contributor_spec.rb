require 'spec_helper'

describe Contributor do
  should_validate_presence_of :name, :email
  should_have_and_belong_to_many :teams
  should_have_and_belong_to_many :tasks

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

  it "should know his projects" do
    project1 = Factory.create :project
    project2 = Factory.create :project
    project3 = Factory.create :project
    project4 = Factory.create :project

    contributor1 = Factory.create :contributor, :email => 'firt@test.com'
    contributor2 = Factory.create :contributor, :email => 'second@test.com'

    team1 = Factory.create :team,
                           :contributors => [contributor1],
                           :projects => [project1, project3]
    team2 = Factory.create :team,
                           :contributors => [contributor2],
                           :projects => [project2]
    team3 = Factory.create :team,
                           :contributors => [contributor1, contributor2],
                           :projects => [project4]

    contributor1.projects.should include project1, project3, project4
    contributor2.projects.should include project2, project4
  end
end


require 'spec_helper'

describe Task do
  should_validate_presence_of :title, :project
  should_belong_to :project
  should_have_and_belong_to_many :contributors
  should_have_many :comments

  it "default position should be Backlog" do
    task = Factory.build :task
    task.save
    task.position.should == 'Backlog'
  end
end


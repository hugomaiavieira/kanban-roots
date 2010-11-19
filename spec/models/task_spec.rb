require 'spec_helper'

describe Task do
  should_validate_presence_of :title

  it "default position should be Backlog" do
    task = Factory.build :task
    task.save
    task.position.should == 'Backlog'
  end

end


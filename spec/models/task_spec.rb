require 'spec_helper'

describe Task do

  it "should have a title" do
    task = Factory.build :task, :title => ''
    task.save.should be_false
  end

  it "default position should be Backlog" do
    task = Factory.build :task
    task.save
    task.position.should == 'Backlog'
  end

end


require 'spec_helper'

describe Task do

  it "should have a title" do
    task = Factory.build :task, :title => ""
    task.save.should be_false
  end

end


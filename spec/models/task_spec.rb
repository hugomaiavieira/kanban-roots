require 'spec_helper'

describe Task do
  should_validate_presence_of :title, :project
  should_belong_to :project
  should_belong_to :category
  should_have_and_belong_to_many :contributors
  should_have_many :comments

  it "default position should be Backlog" do
    task = Factory.build :task
    task.save
    task.position.should == 'Backlog'
  end

  it 'delete comments when the task is deleted' do
    project = Factory.create :project
    task = Factory.create :task, :project => project
    comments = []
    5.times { comments << (Factory.create :comment, :task => task) }

    task.destroy

    5.times do |i|
      lambda { comments[i].reload }.should raise_error(ActiveRecord::RecordNotFound)
    end
  end
end


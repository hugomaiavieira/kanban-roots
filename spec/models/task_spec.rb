require 'spec_helper'

describe Task do
  it { should_not have_valid(:project_id).when('', nil) }

  it 'should have a valide title' do
    should have_valid(:title).when('Use valid_attribute gem')
    should_not have_valid(:title).when('', nil)
  end

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

  it 'should return its author' do
    contributor = Factory.create :contributor
    project = Factory.create :project
    task = Factory.create :task, :project => project, :author_id => contributor.id
    task.author.should == contributor
  end
end


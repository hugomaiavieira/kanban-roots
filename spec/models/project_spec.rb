require 'spec_helper'

describe Project do
  should_validate_presence_of :name
  should_have_many :tasks
  should_have_many :categories
  should_have_and_belong_to_many :teams

  it 'returns all related tasks matching a given position' do
    tasks = [stub_model(Task, :position => 1),
             stub_model(Task, :position => 1),
             stub_model(Task, :position => 2),
             stub_model(Task, :position => 3),
             stub_model(Task, :position => 3)]
    project = Project.new
    project.tasks.<<(*tasks)

    project.should have(2).tasks_by_position(1)
    project.tasks_by_position(1).should include(*tasks[0..1])

    project.tasks_by_position(2).should == [tasks[2]]

    project.should have(2).tasks_by_position(3)
    project.tasks_by_position(3).should include(*tasks[3..4])

    project.tasks_by_position(4).should be_empty
  end

  it 'cleanup all Done tasks' do
    tasks = [stub_model(Task, :position => Board::DOING),
             stub_model(Task, :position => Board::DONE),
             stub_model(Task, :position => Board::DONE),
             stub_model(Task, :position => Board::DONE),
             stub_model(Task, :position => Board::DONE)]
    project = Project.new
    project.tasks.<<(*tasks)

    project.clean_up_done_tasks
    done_tasks = project.tasks.select {|item| item.position == Board::DONE }
    done_tasks.should be_empty

    out_tasks = project.tasks.select {|item| item.position == Board::OUT }
    out_tasks.should include(*tasks[1..4])
    out_tasks.should have(4).tasks
  end
end


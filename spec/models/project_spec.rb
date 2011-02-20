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

  it 'returns the task points sum for a given position of the board' do
    tasks = [stub_model(Task, :points => 1, :position => Board::DOING),
             stub_model(Task, :points => 2, :position => Board::DOING),
             stub_model(Task, :points => 8, :position => Board::TODO),
             stub_model(Task, :points => 3, :position => Board::DOING),
             stub_model(Task, :points => 5, :position => Board::TODO)]
    project = Project.new
    project.tasks.<<(*tasks)

    project.count_points(Board::TODO).should == 13
    project.count_points(Board::DOING).should == 6
    project.count_points(Board::DONE).should == 0
  end

  it 'should be sorted by name' do
    project_z = Factory.create :project, :name => 'Zoo'
    project_a = Factory.create :project, :name => 'Anything'
    project_b = Factory.create :project, :name => 'BatleField'

    projects = [project_b, project_z, project_a]
    projects.sort.should == [project_a, project_b, project_z]

    projects = [project_z, project_a, project_b]
    projects.sort.should == [project_a, project_b, project_z]
  end

end


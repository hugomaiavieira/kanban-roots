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
    tasks = [stub_model(Task, :position => Board::POSITIONS['doing']),
             stub_model(Task, :position => Board::POSITIONS['done']),
             stub_model(Task, :position => Board::POSITIONS['done']),
             stub_model(Task, :position => Board::POSITIONS['done']),
             stub_model(Task, :position => Board::POSITIONS['done'])]
    project = Project.new
    project.tasks.<<(*tasks)

    project.clean_up_done_tasks
    done_tasks = project.tasks.select {|item| item.position == Board::POSITIONS['done'] }
    done_tasks.should be_empty

    out_tasks = project.tasks.select {|item| item.position == Board::POSITIONS['out'] }
    out_tasks.should include(*tasks[1..4])
    out_tasks.should have(4).tasks
  end

  it 'returns the task points sum for a given position of the board' do
    tasks = [stub_model(Task, :points => 1, :position => Board::POSITIONS['doing']),
             stub_model(Task, :points => 2, :position => Board::POSITIONS['doing']),
             stub_model(Task, :points => 8, :position => Board::POSITIONS['todo']),
             stub_model(Task, :points => nil, :position => Board::POSITIONS['todo']),
             stub_model(Task, :points => 3, :position => Board::POSITIONS['doing']),
             stub_model(Task, :points => 5, :position => Board::POSITIONS['todo'])]
    project = Project.new
    project.tasks.<<(*tasks)

    project.count_points(Board::POSITIONS['todo']).should == 13
    project.count_points(Board::POSITIONS['doing']).should == 6
    project.count_points(Board::POSITIONS['done']).should == 0
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

  it "should know his contributors" do
    hugo = Factory.create :contributor, :email => 'hugo@email.com'
    dudu = Factory.create :contributor, :email => 'dudu@email.com'
    max = Factory.create :contributor, :email => 'max@email.com'
    rodrigo = Factory.create :contributor, :email => 'rodrigo@email.com'

    project1 = Factory.create :project
    project2 = Factory.create :project

    team1 = Factory.create :team,
                           :projects => [project1],
                           :contributors => [hugo, max]
    team2 = Factory.create :team,
                           :projects => [project2],
                           :contributors => [dudu]
    team3 = Factory.create :team,
                           :projects => [project1, project2],
                           :contributors => [rodrigo]

    project1.contributors.should include hugo, max, rodrigo
    project2.contributors.should include dudu, rodrigo
  end

  context 'contributors scores should be ordered by score' do

    it "should return a list of hashs {contributor, scores} ordered by scores" do
      dudu = Factory.create :contributor, :email => 'dudu@email.com'
      max = Factory.create :contributor, :email => 'max@email.com'
      hugo = Factory.create :contributor, :email => 'hugo@email.com'

      project = Factory.create :project
      Factory.create :team, :projects => [project], :contributors => [hugo, dudu, max]

      Factory.create :task, :project => project, :position => Board::POSITIONS['doing'], :contributors => [dudu], :points => 13
      Factory.create :task, :project => project, :position => Board::POSITIONS['todo'], :contributors => [hugo], :points => 5
      Factory.create :task, :project => project, :position => Board::POSITIONS['backlog'], :contributors => [max], :points => 8
      Factory.create :task, :project => project, :position => Board::POSITIONS['out'], :contributors => [dudu, hugo, max], :points => 1

      Factory.create :task, :project => project, :position => Board::POSITIONS['done'], :contributors => [dudu], :points => 1
      Factory.create :task, :project => project, :position => Board::POSITIONS['done'], :contributors => [hugo, dudu], :points => 3
      Factory.create :task, :project => project, :position => Board::POSITIONS['done'], :contributors => [max], :points => 2
      Factory.create :task, :project => project, :position => Board::POSITIONS['done'], :contributors => [hugo], :points => 5
      Factory.create :task, :project => project, :position => Board::POSITIONS['done'], :contributors => [dudu, max], :points => 3
      project.update_attribute(:tasks, Task.all)

      project.contributors_scores.should == [{ :contributor => hugo, :scores => 8 },
                                             { :contributor => dudu, :scores => 7 },
                                             { :contributor => max, :scores =>  5}]

      Factory.create :task, :project => project, :position => Board::POSITIONS['done'], :contributors => [max], :points => 13
      project.update_attribute(:tasks, Task.all)

      project.contributors_scores.should == [{ :contributor => max, :scores => 18 },
                                             { :contributor => hugo, :scores => 8 },
                                             { :contributor => dudu, :scores =>  7}]
    end

    it 'should ignore taks without points' do
      hugo = Factory.create :contributor, :email => 'hugo@email.com'

      project = Factory.create :project
      Factory.create :team, :projects => [project], :contributors => [hugo]

      Factory.create :task, :project => project, :position => Board::POSITIONS['done'], :contributors => [hugo], :points => nil
      Factory.create :task, :project => project, :position => Board::POSITIONS['done'], :contributors => [hugo], :points => 3
      project.update_attribute(:tasks, Task.all)

      project.contributors_scores.should == [{ :contributor => hugo, :scores => 3 }]
    end

    it 'should sum 0.1 for taks with 0 points' do
      hugo = Factory.create :contributor, :email => 'hugo@email.com'

      project = Factory.create :project
      Factory.create :team, :projects => [project], :contributors => [hugo]

      Factory.create :task, :project => project, :position => Board::POSITIONS['done'], :contributors => [hugo], :points => 0
      Factory.create :task, :project => project, :position => Board::POSITIONS['done'], :contributors => [hugo], :points => 3
      project.update_attribute(:tasks, Task.all)

      project.contributors_scores[0][:scores].should == 3.1

      Factory.create :task, :project => project, :position => Board::POSITIONS['done'], :contributors => [hugo], :points => 0
      project.update_attribute(:tasks, Task.all)

      project.contributors_scores[0][:scores].should == 3.2
    end

  end

end


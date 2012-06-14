require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def test_tasks_by_position
    project = Factory.create :project
    tasks = [Factory.create(:task, :project => project, :position => 1),
    Factory.create(:task, :project => project, :position => 1),
    Factory.create(:task, :project => project, :position => 2),
    Factory.create(:task, :project => project, :position => 3),
    Factory.create(:task, :project => project, :position => 3)]


    assert_equal(project.tasks_by_position(4), [])

    assert_equal(project.tasks_by_position(1).count, 2)
    tasks[0..1].each { |task| assert(project.tasks_by_position(1).include?(task)) }

    assert_equal(project.tasks_by_position(2), [tasks[2]])

    assert_equal(project.tasks_by_position("3").count, 2)
    tasks[3..4].each { |task| assert(project.tasks_by_position("3").include?(task)) }
  end
end

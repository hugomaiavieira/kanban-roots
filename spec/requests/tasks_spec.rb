require 'spec_helper'

describe "Tasks" do
  describe "GET /tasks" do
    it "works! (now write some real specs)" do
      project = Factory.create :project
      get project_tasks_path(project)
    end
  end
end


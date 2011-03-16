require "spec_helper"

describe TasksController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "projects/5/tasks" }.should route_to(:controller => "tasks", :action => "index", :project_id => "5" )
    end

    it "recognizes and generates #new" do
      { :get => "projects/5/tasks/new" }.should route_to(:controller => "tasks", :action => "new", :project_id => "5" )
    end

    it "recognizes and generates #show" do
      { :get => "projects/5/tasks/1" }.should route_to(:controller => "tasks", :action => "show", :id => "1", :project_id => "5")
    end

    it "recognizes and generates #edit" do
      { :get => "projects/5/tasks/1/edit" }.should route_to(:controller => "tasks", :action => "edit", :id => "1", :project_id => "5" )
    end

    it "recognizes and generates #create" do
      { :post => "projects/5/tasks" }.should route_to(:controller => "tasks", :action => "create", :project_id => "5" )
    end

    it "recognizes and generates #update" do
      { :put => "projects/5/tasks/1" }.should route_to(:controller => "tasks", :action => "update", :id => "1", :project_id => "5" )
    end

    it "recognizes and generates #destroy" do
      { :delete => "projects/5/tasks/1" }.should route_to(:controller => "tasks", :action => "destroy", :id => "1", :project_id => "5" )
    end

    it "recognizes and generates #update_position" do
      { :put => "tasks/1/update_position" }.should route_to(:controller => "tasks", :action => "update_position", :id => "1" )
    end

  end
end


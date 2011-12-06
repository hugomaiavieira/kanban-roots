require "spec_helper"

describe CommentsController do
  describe "routing" do
    it "recognizes and generates #edit" do
      { :get => "/projects/1/tasks/5/comments/2/edit" }.should route_to(
        :controller => "comments", :action => "edit", :project_id => "1", :task_id => "5", :id => "2")
    end

    it "recognizes and generates #create" do
      { :post => "/projects/1/tasks/5/comments" }.should route_to(
        :controller => "comments", :action => "create", :project_id => "1", :task_id => "5")
    end

    it "recognizes and generates #update" do
      { :put => "/projects/1/tasks/5/comments/1" }.should route_to(
        :controller => "comments", :action => "update", :id => "1", :project_id => "1", :task_id => "5")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/projects/1/tasks/5/comments/1" }.should route_to(
        :controller => "comments", :action => "destroy", :id => "1", :project_id => "1", :task_id => "5")
    end
  end
end


require "spec_helper"

describe CategoriesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "projects/5/categories" }.should route_to(:controller => "categories", :action => "index", :project_id => "5")
    end

    it "recognizes and generates #new" do
      { :get => "projects/5/categories/new" }.should route_to(:controller => "categories", :action => "new", :project_id => "5")
    end

    it "recognizes and generates #edit" do
      { :get => "projects/5/categories/1/edit" }.should route_to(:controller => "categories", :action => "edit", :id => "1", :project_id => "5")
    end

    it "recognizes and generates #create" do
      { :post => "projects/5/categories" }.should route_to(:controller => "categories", :action => "create", :project_id => "5")
    end

    it "recognizes and generates #update" do
      { :put => "projects/5/categories/1" }.should route_to(:controller => "categories", :action => "update", :id => "1", :project_id => "5")
    end

    it "recognizes and generates #destroy" do
      { :delete => "projects/5/categories/1" }.should route_to(:controller => "categories", :action => "destroy", :id => "1", :project_id => "5")
    end

  end
end


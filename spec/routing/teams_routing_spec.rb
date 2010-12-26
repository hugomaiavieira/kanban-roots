require "spec_helper"

describe TeamsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/teams" }.should route_to(:controller => "teams", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/teams/new" }.should route_to(:controller => "teams", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/teams/1" }.should route_to(:controller => "teams", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/teams/1/edit" }.should route_to(:controller => "teams", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/teams" }.should route_to(:controller => "teams", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/teams/1" }.should route_to(:controller => "teams", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/teams/1" }.should route_to(:controller => "teams", :action => "destroy", :id => "1")
    end

  end
end

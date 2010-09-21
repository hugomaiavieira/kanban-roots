require "spec_helper"

describe DevelopersController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/developers" }.should route_to(:controller => "developers", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/developers/new" }.should route_to(:controller => "developers", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/developers/1" }.should route_to(:controller => "developers", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/developers/1/edit" }.should route_to(:controller => "developers", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/developers" }.should route_to(:controller => "developers", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/developers/1" }.should route_to(:controller => "developers", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/developers/1" }.should route_to(:controller => "developers", :action => "destroy", :id => "1")
    end

  end
end

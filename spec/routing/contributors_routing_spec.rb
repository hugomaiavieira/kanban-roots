require "spec_helper"

describe ContributorsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/contributors" }.should route_to(:controller => "contributors", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/contributors/new" }.should route_to(:controller => "contributors", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/contributors/1" }.should route_to(:controller => "contributors", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/contributors/1/edit" }.should route_to(:controller => "contributors", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/contributors" }.should route_to(:controller => "contributors", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/contributors/1" }.should route_to(:controller => "contributors", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/contributors/1" }.should route_to(:controller => "contributors", :action => "destroy", :id => "1")
    end

  end
end

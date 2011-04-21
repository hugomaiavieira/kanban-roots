require "spec_helper"

describe ContributorsController do
  describe "routing" do

    it "recognizes and generates #show" do
      { :get => "/contributors/1" }.should route_to(:controller => "contributors", :action => "show", :id => "1")
    end

    it "recognizes and generates #dashboard" do
      { :get => "/" }.should route_to(:controller => "contributors", :action => "dashboard")
    end
  end
end


require "spec_helper"

describe TasksController do
  describe "routing" do

    it "recognizes and generates #update_position" do
      { :put => "board/update_position" }.should route_to(:controller => "boards", :action => "update_position" )
    end

    it "recognizes and generates #update_position" do
      { :put => "board/update_points" }.should route_to(:controller => "boards", :action => "update_points" )
    end

  end
end


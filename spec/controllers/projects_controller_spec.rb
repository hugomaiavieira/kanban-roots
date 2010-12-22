require 'spec_helper'

describe ProjectsController do
  it 'manage contributors' do
    Project.stub(:find).with(:foo).and_return(project_stub = stub_model(Project))
    get :manage_contributors, :id => :foo
    assigns[:project].should == project_stub
  end
end


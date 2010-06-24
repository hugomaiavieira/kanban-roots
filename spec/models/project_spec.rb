require 'spec_helper'

describe Project do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :description => "value for description",
      :start => Date.today,
      :end => Date.today
    }
  end

  it "should create a new instance given valid attributes" do
    Project.create!(@valid_attributes)
  end
end

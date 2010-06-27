require File.dirname(__FILE__) + '/../spec_helper'

describe Project do
  it "should be valid" do
    Project.new.should be_valid
  end
end

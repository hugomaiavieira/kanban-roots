require 'spec_helper'

describe Project do

  it 'should have a name' do
    project = Factory.build :project, :name => ''
    project.save.should be_false
  end

end


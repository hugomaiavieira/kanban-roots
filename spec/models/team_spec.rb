require 'spec_helper'

describe Team do
  it 'should have a name' do
    team = Factory.build :team, :name => ''
    team.save.should be_false
    team.name = "Owners"
    team.save.should be_true
  end
end


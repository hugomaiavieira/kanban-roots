require File.dirname(__FILE__) + '/../spec_helper'

describe ProjectsController do

  it 'should be an inherited_resource controller' do
    controller.should be_a_kind_of(InheritedResources::Base)
  end

end


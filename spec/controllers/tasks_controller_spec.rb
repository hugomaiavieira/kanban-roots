require 'spec_helper'

describe TasksController do

  include Devise::TestHelpers

  before(:each) do
    @contributor = Factory.create :contributor
    sign_in @contributor
  end

  it 'update position' do
    # TODO: Do this test
  end

end


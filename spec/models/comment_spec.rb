require 'spec_helper'

describe Comment do
  should_belong_to :task
  should_belong_to :contributor
end


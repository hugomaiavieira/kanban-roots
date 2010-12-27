require 'spec_helper'

describe Project do
  should_validate_presence_of :name
  should_have_many :tasks
  should_have_and_belong_to_many :teams
end


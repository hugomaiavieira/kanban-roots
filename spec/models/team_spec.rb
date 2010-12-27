require 'spec_helper'

describe Team do
  should_validate_presence_of :name
  should_have_and_belong_to_many :contributors
  should_have_and_belong_to_many :projects
end


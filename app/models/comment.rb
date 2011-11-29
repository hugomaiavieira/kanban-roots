class Comment < ActiveRecord::Base
  belongs_to :task, :touch => true # TODO: Test the touch
  belongs_to :contributor
end


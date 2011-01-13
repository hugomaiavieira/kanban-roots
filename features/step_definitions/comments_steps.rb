Then /^the comment should belongs to the task$/ do
  @comment = Comment.all.last
  @comment.task.should == @task
end

Then /^I am the coment's author$/ do
  @comment.contributor.should == @contributor
end

Given /^I write a comment for this task$/ do
  @comment = Factory.create :comment, :contributor => @contributor
  @task.update_attributes(:comments => [@comment])
end

Then /^The comment should no longer exist$/ do
  Comment.where(:id => @comment.id).should be_empty
end


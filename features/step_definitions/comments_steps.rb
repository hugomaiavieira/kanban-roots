Then /^the comment should belongs to the task$/ do
  @comment = Comment.all.last
  @comment.task.should == @task
end

Then /^I am the coment's author$/ do
  @comment.contributor.should == @contributor
end


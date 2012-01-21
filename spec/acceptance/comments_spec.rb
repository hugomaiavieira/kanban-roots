require 'spec_helper'

feature 'Show (or not) destroy and edit links of a comment' do
  background do
    @owner = Factory.create :contributor
    @other = Factory.create :contributor
    @project = Factory.create :project
    @task = Factory.create :task, :project => @project, :author => @owner
    @comment = Factory.create :comment, :task => @task, :contributor => @owner
  end

  scenario 'for some contributor other then the owner' do
    login(@other.email, @other.password)
    visit project_task_path(@project, @task)
    within('.comment-wrapper') do
      page.should_not have_content('Destroy')
      page.should_not have_content('Edit')
    end
  end

  scenario 'for its owner' do
    login(@owner.email, @owner.password)
    visit project_task_path(@project, @task)
    within('.comment-wrapper') do
      page.should have_content('Destroy')
      page.should have_content('Edit')
    end
  end
end

# This tests the same thing as one test at comments.feature. After my monography
# I will delete features/*
feature "Render comments with Markdown syntax" do
  background do
    @owner = Factory.create :contributor
    @project = Factory.create :project
    @task = Factory.create :task, :project => @project, :author => @owner
  end

  scenario "on tasks page" do
    login(@owner.email, @owner.password)
    visit project_task_path(@project, @task)
    fill_in "comment_content", :with => "# Some content [link](http://exemplo.com)"
    click_button "Comment"
    page.should have_xpath("//h1", :text => "Some content")
    page.should have_xpath("//a", :text => "link")
  end
end
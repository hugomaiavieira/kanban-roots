require 'spec_helper'

feature 'validates uniqueness of name for contributor' do
  background do
    @hugo = Factory.create :contributor
    @project = Factory.create :project, :name => 'kanban-roots', :owner => @hugo
  end

  scenario 'when edit' do
    login(@hugo.email, @hugo.password)
    visit edit_project_path(@project)
    click_button 'Save'
    page.should have_content 'Project was successfully updated.'
  end

  scenario 'when create' do
    login(@hugo.email, @hugo.password)
    visit new_project_path
    fill_in 'Name', :with => 'kanban-roots'
    click_button 'Save'
    page.should have_content 'you already have a project with this name'
    click_link 'Sign out'

    dudu = Factory.create :contributor
    login(dudu.email, dudu.password)
    visit new_project_path
    fill_in 'Name', :with => 'kanban-roots'
    click_button 'Save'
    page.should have_content 'Project was successfully created.'
  end
end


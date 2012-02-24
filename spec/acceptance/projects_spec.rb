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

feature 'manipulate projects' do
  context 'register a new project' do
    before do
      @contributor = Factory.create :contributor
      login @contributor.email, @contributor.password
    end

    it 'successfully' do
      visit new_project_path
      fill_in 'Name', :with => 'name-1'
      fill_in 'Description', :with => 'description 1'
      click_button 'Save'
      page.should have_content 'Project was successfully created.'
      project = Project.all.last
      project.owner.should == @contributor
      current_path.should == project_board_path(project)
      within('h1') do
        page.should have_content 'name-1 Board'
      end
    end

    it 'with errors' do
      visit new_project_path
      click_button 'Save'
      within('form > div[2]') do
        page.should have_content "can't be blank"
      end
      @contributor.projects.should be_empty
    end
  end

  it 'edit a project successfully' do
    contributor = Factory.create :contributor
    project = Factory.create :project, :owner => contributor
    login contributor.email, contributor.password
    visit edit_project_path(project)
    fill_in 'Name', :with => 'Some_name'
    fill_in 'Description', :with => 'Some description'
    click_button 'Save'
    page.should have_content 'Project was successfully updated.'
    current_path.should == project_board_path(project)
    within('h1') do
      page.should have_content 'some_name Board'
    end
  end

  it 'delete a project' do
    contributor = Factory.create :contributor
    projects = []
    5.times do |i|
      projects << (Factory.create :project, :owner => contributor,
                                :name => "name_#{i}", :description => "description #{i}")
    end
    login contributor.email, contributor.password

    visit project_board_path(projects[2])
    click_link 'Admin'
    click_link 'Destroy'
    page.should have_content projects[0].name
    page.should have_content projects[1].name
    page.should_not have_content projects[2].name
    page.should have_content projects[3].name
    page.should have_content projects[4].name
  end
end


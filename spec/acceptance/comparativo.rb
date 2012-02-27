require 'spec_helper'

feature 'Authentication' do
  it 'sign out' do
    contributor = Factory.create :contributor
    login(contributor.email, contributor.password)
    click_link 'Sign out'
    page.should have_content 'Sign in'
  end
end

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

feature 'Manage categories' do
  before do
    @project = Factory.create :project
    @contributor = Factory.create :contributor, :contributions => [@project]
    @project.update_attribute(:contributors, [@contributor])
    login @contributor.email, @contributor.password
  end

  context 'register a category' do
    it 'successfully' do
      visit project_categories_path(@project)
      click_link 'New Category'
      fill_in 'Name', :with => 'Feature'
      fill_in 'Color', :with => 'ffa5a5'
      click_button 'Save'
      page.should have_content 'Category was successfully created.'
      page.should have_content 'Feature'
      page.should have_content 'ffa5a5'
      @project.reload.categories.length.should == 1
    end

    context 'with error' do
      before do
        visit project_categories_path(@project)
        click_link 'New Category'
      end

      it 'blank fields' do
        fill_in 'Color', :with => ''
        click_button 'Save'
        within('form > div[2]') { page.should have_content "can't be blank" }
        within('form > div[3]') { page.should have_content "can't be blank" }
      end

      context 'uniq for project' do
        before do
          @category = Factory.create :category, :project => @project,
                                       :color => 'ffa5a5', :name => 'Bug'
        end

        it 'name' do
          fill_in 'Name', :with => 'Bug'
          fill_in 'Color', :with => 'a5d2ff'
          click_button 'Save'
          within('form > div[2]') { page.should have_content 'should be uniq for project' }
        end

        it 'color' do
          fill_in 'Name', :with => 'Feature'
          fill_in 'Color', :with => 'ffa5a5'
          click_button 'Save'
          within('form > div[3]') { page.should have_content 'should be uniq for project' }
        end
      end

      context 'invalid' do
        it 'name' do
          fill_in 'Name', :with => 'Bug 1'
          fill_in 'Color', :with => 'a5d2ff'
          click_button 'Save'
          within('form > div[2]') { page.should have_content 'is invalid' }
        end

        it 'color' do
          fill_in 'Name', :with => 'Bug'
          fill_in 'Color', :with => 'red'
          click_button 'Save'
          within('form > div[3]') { page.should have_content 'is invalid' }
        end
      end
    end
  end

  it 'edit a category' do
    category = Factory.create :category, :project => @project,
                                :name => 'Feature', :color => 'ffa5a5'
    visit edit_project_category_path(@project, category)
    fill_in 'Name', :with => 'New feature'
    click_button 'Save'
    page.should have_content 'New feature'
    page.should have_content 'Category was successfully updated.'
  end

  # it 'delete a category' do
  #   category = Factory.create :category, :project => @project,
  #                               :name => 'Feature', :color => 'ffa5a5'
  #   visit project_categories_path(@project)
  #   click_link 'Destroy'
  #   lambda { category.reload }.should raise_error ActiveRecord::RecordNotFound
  # end
end

feature 'Manipulate contributors' do
  context 'register a contributor' do
    it 'successfully' do
      visit new_contributor_registration_path
      fill_in 'Name', :with => 'Someone of Nothing'
      fill_in 'Username', :with => 'someone'
      fill_in 'E-mail', :with => 'someone@gmail.com'
      fill_in 'Password', :with => 'password'
      fill_in 'Password confirmation', :with => 'password'
      click_button 'Sign up'
      page.should have_content 'You have signed up successfully.'
    end

    context 'with errors' do
      it 'blank fields' do
        visit new_contributor_registration_path
        click_button 'Sign up'
        within('form > div[2]') { page.should have_content "can't be blank"}
        within('form > div[3]') { page.should have_content "can't be blank"}
        within('form > div[4]') { page.should have_content "can't be blank"}
        within('form > div[5]') { page.should have_content "can't be blank"}
      end

      it 'invalid' do
        visit new_contributor_registration_path
        fill_in 'E-mail', :with => 'someone@nothing'
        click_button 'Sign up'
        within('form > div[4]') { page.should have_content "is invalid"}
      end
    end
  end

  context 'edit a contributor' do
    before do
      @contributor = Factory.create :contributor
      login @contributor.email, @contributor.password
    end

    it 'successfully' do
      visit edit_contributor_registration_path
      fill_in 'Username', :with => 'hugomaiavieira'
      fill_in 'Current password', :with => '123456'
      click_button 'Save'
      page.should have_content 'hugomaiavieira'
    end

    it 'current password invalid' do
      visit edit_contributor_registration_path
      fill_in 'Username', :with => 'hugomaiavieira'
      fill_in 'Current password', :with => '123456789'
      click_button 'Save'
      within('form > div[7]') { page.should have_content 'is invalid' }
    end
  end
end

feature 'Sign in successfully' do
  it 'with username' do
    contributor = Factory.create :contributor, :username => 'someone'
    login contributor.username, contributor.password
    page.should have_content 'Signed in successfully.'
  end

  it 'with e-mail' do
    contributor = Factory.create :contributor, :email => 'someone@example.com'
    login contributor.email, contributor.password
    page.should have_content 'Signed in successfully.'
  end
end
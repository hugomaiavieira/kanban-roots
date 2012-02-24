require 'spec_helper'

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

  it 'delete a category' do
    category = Factory.create :category, :project => @project,
                                :name => 'Feature', :color => 'ffa5a5'
    visit project_categories_path(@project)
    click_link 'Destroy'
    lambda { category.reload }.should raise_error ActiveRecord::RecordNotFound
  end
end


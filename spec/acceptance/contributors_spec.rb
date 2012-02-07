require 'spec_helper'

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


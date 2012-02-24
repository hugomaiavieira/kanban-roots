require 'spec_helper'

feature 'Authentication' do
  it 'sign out' do
    contributor = Factory.create :contributor
    login(contributor.email, contributor.password)
    click_link 'Sign out'
    page.should have_content 'Sign in'
  end
end


require 'spec_helper'

describe Category do
  it { should_not have_valid(:project_id).when(nil, '') }

  it 'should validate format of name' do
    should have_valid(:name).when('Feature', 'New Feature', 'New-Feature_again',
                                  'New_Feature', 'Study/Research', 'bug')
    should_not have_valid(:name).when('Feature 1', '#Feature', '', nil)
  end

  it 'should validate format of color' do
    should have_valid(:color).when('ffa5a5', 'FFFFFF')
    should_not have_valid(:color).when('FFF', '#FFFFFF', 'red', '', nil)
  end

  it 'should validate uniqueness of name for project' do
    project = Factory.create :project

    saved = Factory.create :category, :project => project, :name => 'Feature'

    category = Factory.build :category, :project => project, :name => 'Feature'
    category.save.should be_false
    category.errors[:name].should include 'should be uniq for project'
  end

  it 'should validate uniqueness of color for project' do
    project = Factory.create :project

    saved = Factory.create :category, :project => project, :color => 'ffa5a5'
    saved.update_attributes!(:color => 'ffa5a5').should be_true

    category = Factory.build :category, :project => project, :color => 'ffa5a5'
    category.save.should be_false
    category.errors[:color].should include 'should be uniq for project'
  end

  it 'should return its name as a css class' do
    category = Factory.build :category, :name => 'Feature'
    category.name_as_css_class.should == 'feature'

    category.name = 'New Feature'
    category.name_as_css_class.should == 'new_feature'

    category.name = 'Other-New Feature'
    category.name_as_css_class.should == 'other_new_feature'

    category.name = 'Study/Research'
    category.name_as_css_class.should == 'study_research'
  end
end
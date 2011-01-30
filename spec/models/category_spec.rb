require 'spec_helper'

describe Category do

  before(:each) do
    @project = Factory.create :project
  end

  should_have_many :tasks
  should_belong_to :project
  should_validate_presence_of :project_id

  it 'should validate uniqueness of name for project' do
    saved = Factory.create :category, :project => @project, :name => 'Feature'
    saved.update_attributes!(:name => 'Feature').should be_true

    category = Factory.build :category, :project => @project, :name => 'Feature'
    category.save.should be_false
    # errors[:name].should == 'Name should be uniq for project'
  end

  it 'should validate uniqueness of color for project' do
    saved = Factory.create :category, :project => @project, :color => 'ffa5a5'
    saved.update_attributes!(:color => 'ffa5a5').should be_true

    category = Factory.build :category, :project => @project, :color => 'ffa5a5'
    category.save.should be_false
    # errors[:color].should == 'Color should be uniq for project'
  end

  it 'should validate format of name' do
    category = Factory.build :category, :project => @project, :name => 'Feature'
    category.save.should be_true

    category.update_attributes(:name => 'New Feature').should be_true
    category.update_attributes(:name => 'New_Feature').should be_true
    category.update_attributes(:name => 'New-Feature_again').should be_true

    category.update_attributes(:name => 'Feature 1').should be_false
    category.update_attributes(:name => '#Feature').should be_false
    # errors[:name].should == 'Name is invalid'
  end

  it 'should validate format of name' do
    category = Factory.build :category, :project => @project, :color => 'ffa5a5'
    category.save.should be_true

    category.update_attributes(:color => 'FFFFFF').should be_true

    category.update_attributes(:color => '#FFFFFF').should be_false
    category.update_attributes(:color => 'red').should be_false
    # errors[:name].should == 'Color is invalid'
  end

  it 'should return the name as a css class' do
    category = Factory.build :category, :name => 'Feature'
    category.to_class.should == 'feature'

    category.name = 'New Feature'
    category.to_class.should == 'new_feature'

    category.name = 'Other-New Feature'
    category.to_class.should == 'other_new_feature'
  end

end


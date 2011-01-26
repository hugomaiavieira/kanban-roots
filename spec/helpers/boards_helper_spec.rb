require 'spec_helper'

describe BoardsHelper do

  def stub_all(options = {})
    @project = stub
    @task = stub(:project => @project,
                 :title => options[:title] || '',
                 :points => options[:points],
                 :category => options[:category],
                 :contributors => options[:contributors] || [])
  end

  describe 'to_postit' do

    it "generates an enclosing div with 'postit' and category classes" do
      stub_all(:category => 'Bug')
      helper.to_postit(@task).should =~ /^<div class='postit bug'>/
      helper.to_postit(@task).should =~ /<\/div>$/

      stub_all(:category => nil)
      helper.to_postit(@task).should =~ /^<div class='postit'>/
      helper.to_postit(@task).should =~ /<\/div>$/
    end

    context 'with seted points' do
      it 'shows task points' do
        stub_all(:points => 10, :category => 'Feature')
        helper.to_postit(@task).should =~ /<p class='points'>\n {8}10\n {6}<\/p>/
      end
    end

    context 'without set points' do
      it "shows 'Set points' link" do
        stub_all(:points => nil, :category => 'Feature')
        helper.stub(:edit_project_task_path).with(@project, @task).and_return(path_stub = stub)
        helper.stub(:link_to).with('Set points', path_stub).and_return('<the points link>')
        helper.stub(:link_to).with('', anything, anything)
        helper.stub(:link_to).with('Set sponsor', path_stub)
        helper.to_postit(@task).should =~ /<the points link>/
      end
    end

    it 'shows task title as a link to task' do
      the_title = 'the title'
      stub_all(:title => the_title, :points => 0, :category => 'Feature')
      helper.stub(:project_task_path).with(@project, @task).and_return(path_stub = stub)
      helper.stub(:link_to).with(the_title, path_stub, {:class => :title}).and_return('<the link>')
      helper.stub(:link_to).with('Set sponsor', anything)
      helper.to_postit(@task).should =~ /<the link>/
    end

  end

  describe 'sponsors' do

    context 'for task without sponsors' do
      it "shows 'Set sponsor' link" do
        stub_all(:title => 'the title', :points => 0, :category => 'Feature')
        helper.stub(:link_to).with('the title', anything, anything)
        helper.stub(:edit_project_task_path).with(@project, @task).and_return(path_stub = stub)
        helper.stub(:link_to).with('Set sponsor', path_stub).and_return('<the sponsor link>')
        helper.sponsors(@task).should =~ /<the sponsor link>/
      end
    end

    context 'for task with contributors' do
      it 'shows contributors as sentence' do
        stub_all(:points => 0,
                 :category => 'Feature',
                 :contributors => [stub(:name => 'Hugo'),
                                   stub(:name => 'Rodrigo'),
                                   stub(:name => 'Max')])
        helper.sponsors(@task).should =~ /Hugo, Rodrigo, and Max/i
        helper.sponsors(@task).should_not =~ /Set sponsor/i
        helper.sponsors(@task).should_not =~ /title='Hugo, Rodrigo, and Max'/
      end

      it 'shows contributors as sentence concatenated for long sentence' do
        stub_all(:points => 0,
                 :category => 'Feature',
                 :contributors => [stub(:name => 'Hugo'),
                                   stub(:name => 'Rodrigo'),
                                   stub(:name => 'Max'),
                                   stub(:name => 'Eduardo')])
        helper.sponsors(@task).should =~ /title='Hugo, Rodrigo, Max, and Eduardo'/
        helper.sponsors(@task).should =~ /Hugo, Rodrigo, Max.../i
        helper.sponsors(@task).should_not =~ /Set sponsor/i
      end
    end
  end
end


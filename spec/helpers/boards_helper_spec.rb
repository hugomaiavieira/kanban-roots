require 'spec_helper'

describe BoardsHelper do
  describe 'to_postit' do
    def stub_all(options = {})
      @project = stub
      @task = stub(:title => options[:title] || '',
                   :points => options[:points] || nil,
                   :project => @project,
                   :contributors => options[:contributors] || [])
    end

    it "generates an enclosing div with 'postit' class" do
      stub_all
      helper.to_postit(@task).should =~ /^<div class='postit'>/
      helper.to_postit(@task).should =~ /<\/div>$/
    end

    context 'with seted points' do
      it 'shows task points' do
        stub_all(:points => 10)
        helper.to_postit(@task).should =~ /<p class='points'>\n    10\n  <\/p>/
      end
    end

    context 'without set points' do
      it "shows 'Set points' link" do
        stub_all(:points => nil)
        helper.stub(:edit_project_task_path).with(@project, @task).and_return(path_stub = stub)
        helper.stub(:link_to).with('Set points', path_stub).and_return('<the points link>')
        helper.stub(:link_to).with('', anything, anything)
        helper.stub(:link_to).with('Set sponsor', path_stub)
        helper.to_postit(@task).should =~ /<the points link>/
      end
    end

    it 'shows task title as a link to task' do
      the_title = 'the title'
      stub_all(:title => the_title, :points => 0)
      helper.stub(:project_task_path).with(@project, @task).and_return(path_stub = stub)
      helper.stub(:link_to).with(the_title, path_stub, {:class => :title}).and_return('<the link>')
      helper.stub(:link_to).with('Set sponsor', anything)
      helper.to_postit(@task).should =~ /<the link>/
    end

    context 'with no contributors' do
      it "shows 'Set sponsor' link" do
        stub_all(:title => 'the title', :points => 0)
        helper.stub(:link_to).with('the title', anything, anything)
        helper.stub(:edit_project_task_path).with(@project, @task).and_return(path_stub = stub)
        helper.stub(:link_to).with('Set sponsor', path_stub).and_return('<the sponsor link>')
        helper.to_postit(@task).should =~ /<the sponsor link>/
      end
    end

    context 'with contributors' do
      it 'shows contributors as sentence' do
        stub_all(:points => 0,
                 :contributors => [stub(:name => 'Hugo'),
                                   stub(:name => 'Eduardo'),
                                   stub(:name => 'Rodrigo')])
        helper.to_postit(@task).should =~ /Hugo, Eduardo, and Rodrigo/i
        helper.to_postit(@task).should_not =~ /Set sponsor/i
      end
    end
  end
end


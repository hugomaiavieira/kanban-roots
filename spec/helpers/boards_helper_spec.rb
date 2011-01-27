require 'spec_helper'

describe BoardsHelper do

  def stub_all(options = {})
    @project = stub
    @task = stub(:project => @project,
                 :title => options[:title] || '',
                 :points => options[:points],
                 :category => options[:category],
                 :contributors => options[:contributors] || [],
                 :comments => options[:comments] || [])
  end

  it "category_class generates the category class" do
    stub_all(:category => 'Bug')
    helper.category_class(@task).should == ' bug'

    stub_all(:category => nil)
    helper.category_class(@task).should == ''
  end

  it 'title returns the task title as a link to task' do
    the_title = 'the title'
    stub_all(:title => the_title, :points => 0, :category => 'Feature')
    helper.stub(:project_task_path).with(@project, @task).and_return(path_stub = stub)
    helper.stub(:link_to).with(the_title, path_stub, {:class => :title}).and_return('<the link>')
    helper.stub(:link_to).with('Set sponsor', anything)
    helper.title(@task).should =~ /<the link>/
  end

  describe 'comments' do

    context 'with 0 or >= 2 comments' do
      it "generates a span with the number of comments of a task and the word comment on plural" do
        stub_all()
        helper.comments(@task).should ==
          "<span class ='comments_number'>0 comments</span>"

        stub_all(:comments => [stub])
        helper.comments(@task).should ==
          "<span class ='comments_number'>1 comment</span>"

        stub_all(:comments => [stub, stub])
        helper.comments(@task).should ==
          "<span class ='comments_number'>2 comments</span>"
      end
    end

    context 'with 1 comment' do
      it "generates a span with the number of comments of a task and the word comment on singular" do
        stub_all(:comments => [stub])
        helper.comments(@task).should ==
          "<span class ='comments_number'>1 comment</span>"
      end
    end

  end

  describe  'points' do

    context 'with seted points' do
      it 'shows task points' do
        stub_all(:points => 10, :category => 'Feature')
        helper.points(@task).should == 10
      end
    end

    context 'without set points' do
      it "shows 'Set points' link" do
        stub_all(:points => nil, :category => 'Feature')
        helper.stub(:edit_project_task_path).with(@project, @task).and_return(path_stub = stub)
        helper.stub(:link_to).with('Set points', path_stub).and_return('<the points link>')
        helper.stub(:link_to).with('', anything, anything)
        helper.stub(:link_to).with('Set sponsor', path_stub)
        helper.points(@task).should =~ /<the points link>/
      end
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
      it 'shows contributors as sentence without title and help cursor for tiny sentence' do
        stub_all(:points => 0,
                 :category => 'Feature',
                 :contributors => [stub(:name => 'Hugo'),
                                   stub(:name => 'Rodrigo'),
                                   stub(:name => 'Max')])
        helper.sponsors(@task).should =~ /Hugo, Rodrigo, and Max/i
        helper.sponsors(@task).should_not =~ /Set sponsor/i
        helper.sponsors(@task).should_not =~ /title='Hugo, Rodrigo, and Max'/
        helper.sponsors(@task).should=~ /class='sponsor'/
        helper.sponsors(@task).should_not =~ /class='sponsor help_cursor'/
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


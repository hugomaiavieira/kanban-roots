require 'spec_helper'

describe BoardsHelper do

  def stub_all(options = {})
    @project = stub
    @task = stub(:project => @project,
                 :title => options[:title] || '',
                 :points => options[:points],
                 :category => options[:category] || nil,
                 :contributors => options[:contributors] || [],
                 :comments => options[:comments] || [])
  end

  it "category_class generates the category class" do
    category = stub(:name => 'Bug', :to_class => 'bug')
    stub_all(:category => category)
    helper.category_class(@task).should == ' bug'

    stub_all(:category => nil)
    helper.category_class(@task).should == ''
  end

  describe 'title' do

    it 'returns the task title as a link to task with title and help cursor for long title' do
      the_title = 'this title has more than forty five characteres'
      stub_all(:title => the_title, :points => 0)
      helper.stub(:project_task_path).with(@project, @task).and_return(path_stub = stub)
      helper.stub(:link_to).with(
        'this title has more than forty five charactere...',
        path_stub,
        {:class => 'title help_cursor',
         :title => the_title})
    end

    it 'returns the task title as a link to task without title and help cursor for tiny title' do
      the_title = 'this title has just forty five characteresss'
      stub_all(:title => the_title, :points => 0)
      helper.stub(:project_task_path).with(@project, @task).and_return(path_stub = stub)
      helper.stub(:link_to).with(the_title, path_stub, {:class => 'title'})
    end

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
        stub_all(:points => 10)
        helper.points(@task).should == 10
      end
    end

    context 'without set points' do
      it "shows a dash" do
        stub_all(:points => nil)
        helper.points(@task).should == '-'
      end
    end

    context 'select for' do

      it 'generates an select tag for the task points' do
        stub_all(:points => nil)
        helper.select_for_points(@task).should =~ /<select class='points_select'>/
        helper.select_for_points(@task).should =~ /<option value='-'>-<\/option>/
        helper.select_for_points(@task).should =~ /<option value='1'>1<\/option>/
        helper.select_for_points(@task).should =~ /<option value='2'>2<\/option>/
        helper.select_for_points(@task).should =~ /<option value='3'>3<\/option>/
        helper.select_for_points(@task).should =~ /<option value='5'>5<\/option>/
        helper.select_for_points(@task).should =~ /<option value='8'>8<\/option>/
        helper.select_for_points(@task).should =~ /<option value='13'>13<\/option>/
        helper.select_for_points(@task).should =~ /<\/select>/
      end

      it 'set the selected option' do
        stub_all(:points => 5)
        helper.select_for_points(@task).should =~ /<option selected='selected' value='5'>5<\/option>/

        stub_all(:points => 8)
        helper.select_for_points(@task).should =~ /<option selected='selected' value='8'>8<\/option>/
      end

    end

  end

  describe 'assignees' do

    context 'for task without assignees' do
      it "shows a dash" do
        stub_all(:points => 0)
        helper.assignees(@task).should =~ /<span class='show_assignees'>-<\/span>/
      end
    end

    context 'for task with contributors' do
      it 'shows contributors as sentence without title and help cursor for tiny sentence' do
        stub_all(:points => 0,
                 :contributors => [stub(:username => 'hugo'),
                                   stub(:username => 'rodrigo'),
                                   stub(:username => 'max')])
        helper.assignees(@task).should =~ /hugo, rodrigo, and max/i
        helper.assignees(@task).should_not =~ /<span class='show_assignees'>-<\/span>/
        helper.assignees(@task).should_not =~ /title='.*'/
        helper.assignees(@task).should =~ /class='show_assignees'/
        helper.assignees(@task).should_not =~ /help_cursor/
      end

      it 'shows contributors as sentence concatenated with title and help cursor for long sentence' do
        stub_all(:points => 0,
                 :contributors => [stub(:username => 'hugo'),
                                   stub(:username => 'rodrigo'),
                                   stub(:username => 'max'),
                                   stub(:username => 'eduardo')])
        helper.assignees(@task).should =~ /title='hugo, rodrigo, max, and eduardo'/
        helper.assignees(@task).should =~ /hugo, rodrigo, max.../i
        helper.assignees(@task).should_not =~ /-/
      end
    end

    context 'form for' do

      it 'generates an multiple select and an buttom for the task assignees' do
        hugo = stub(:username => 'hugo', :id => 1)
        rodrigo = stub(:username => 'rodrigo', :id => 2)
        max = stub(:username => 'max', :id => 3)
        stub_all(:points => nil)
        @project.stub(:contributors).and_return([hugo, rodrigo, max])
        helper.form_for_assignees(@task).should =~ /<select multiple='multiple' size='5'>/
        helper.form_for_assignees(@task).should =~ /<option value='-'>-<\/option>/
        helper.form_for_assignees(@task).should =~ /<option value='1'>hugo<\/option>/
        helper.form_for_assignees(@task).should =~ /<option value='2'>rodrigo<\/option>/
        helper.form_for_assignees(@task).should =~ /<option value='3'>max<\/option>/
        helper.form_for_assignees(@task).should =~ /<\/select>/
        helper.form_for_assignees(@task).should =~ /<input type='submit' value='ok' \/>/
      end

      it 'set the selected options' do
        hugo = stub(:username => 'hugo', :id => 1)
        rodrigo = stub(:username => 'rodrigo', :id => 2)
        max = stub(:username => 'max', :id => 3)
        stub_all(:points => nil, :contributors => [hugo])
        @project.stub(:contributors).and_return([hugo])
        helper.form_for_assignees(@task).should =~ /<option selected='selected' value='1'>hugo<\/option>/

        stub_all(:points => nil, :contributors => [hugo, rodrigo, max])
        @project.stub(:contributors).and_return([hugo, rodrigo, max])
        helper.form_for_assignees(@task).should =~ /<option selected='selected' value='\d+'>hugo<\/option>/
        helper.form_for_assignees(@task).should =~ /<option selected='selected' value='\d+'>rodrigo<\/option>/
        helper.form_for_assignees(@task).should =~ /<option selected='selected' value='\d+'>max<\/option>/
      end

    end

  end
end


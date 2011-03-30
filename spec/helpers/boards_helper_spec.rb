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

  describe 'sponsors' do

    context 'for task without sponsors' do
      it "shows a dash" do
        stub_all(:points => 0)
        helper.sponsors(@task).should =~ /<span class='show_sponsors'>-<\/span>/
      end
    end

    context 'for task with contributors' do
      it 'shows contributors as sentence without title and help cursor for tiny sentence' do
        stub_all(:points => 0,
                 :contributors => [stub(:name => 'Hugo'),
                                   stub(:name => 'Rodrigo'),
                                   stub(:name => 'Max')])
        helper.sponsors(@task).should =~ /Hugo, Rodrigo, and Max/i
        helper.sponsors(@task).should_not =~ /<span class='show_sponsors'>-<\/span>/
        helper.sponsors(@task).should_not =~ /title='.*'/
        helper.sponsors(@task).should =~ /class='show_sponsors'/
        helper.sponsors(@task).should_not =~ /help_cursor/
      end

      it 'shows contributors as sentence concatenated with title and help cursor for long sentence' do
        stub_all(:points => 0,
                 :contributors => [stub(:name => 'Hugo'),
                                   stub(:name => 'Rodrigo'),
                                   stub(:name => 'Max'),
                                   stub(:name => 'Eduardo')])
        helper.sponsors(@task).should =~ /title='Hugo, Rodrigo, Max, and Eduardo'/
        helper.sponsors(@task).should =~ /Hugo, Rodrigo, Max.../i
        helper.sponsors(@task).should_not =~ /Set sponsor/i
      end
    end

    context 'form for' do

      it 'generates an multiple select and an buttom for the task sponsors' do
        hugo = stub(:name => 'Hugo', :id => 1)
        rodrigo = stub(:name => 'Rodrigo', :id => 2)
        max = stub(:name => 'Max', :id => 3)
        stub_all(:points => nil)
        @project.stub(:contributors).and_return([hugo, rodrigo, max])
        helper.form_for_sponsors(@task).should =~ /<select multiple='multiple' size='5'>/
        helper.form_for_sponsors(@task).should =~ /<option value='-'>-<\/option>/
        helper.form_for_sponsors(@task).should =~ /<option value='1'>Hugo<\/option>/
        helper.form_for_sponsors(@task).should =~ /<option value='2'>Rodrigo<\/option>/
        helper.form_for_sponsors(@task).should =~ /<option value='3'>Max<\/option>/
        helper.form_for_sponsors(@task).should =~ /<\/select>/
        helper.form_for_sponsors(@task).should =~ /<input type='submit' value='ok' \/>/
      end

      it 'set the selected options' do
        hugo = stub(:name => 'Hugo', :id => 1)
        rodrigo = stub(:name => 'Rodrigo', :id => 2)
        max = stub(:name => 'Max', :id => 3)
        stub_all(:points => nil, :contributors => [hugo])
        @project.stub(:contributors).and_return([hugo])
        helper.form_for_sponsors(@task).should =~ /<option selected='selected' value='1'>Hugo<\/option>/

        stub_all(:points => nil, :contributors => [hugo, rodrigo, max])
        @project.stub(:contributors).and_return([hugo, rodrigo, max])
        helper.form_for_sponsors(@task).should =~ /<option selected='selected' value='\d+'>Hugo<\/option>/
        helper.form_for_sponsors(@task).should =~ /<option selected='selected' value='\d+'>Rodrigo<\/option>/
        helper.form_for_sponsors(@task).should =~ /<option selected='selected' value='\d+'>Max<\/option>/
      end

    end

  end
end

